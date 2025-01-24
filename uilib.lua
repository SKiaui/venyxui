local HitPercentages = {
    Perfect = 0;
    Great = 0;
    Okay = 0;
    Miss = 0;
    Combined = 0;
}

local HeldNotes = {}

local Bounds = {
    Perfect = -20;
    Great = -50;
    Okay = -100;
    Miss = -500;
}

local RELEASE_TRACK = 'release_track_index';
local PRESS_TRACK = 'press_track_index';
local TEST_HIT = 'get_delta_time_from_hit_time';
local TEST_RELEASE = 'get_delta_time_from_release_time';
visit_webnpc = nil
WebNPCManager = nil

function GetHitPercentage(a) 
    return HitPercentages[a] 
end

function Calculate(a, b, c, d)
    local Total = a + b + c + d
    if Total > 0 then
        return a / Total * 100, b / Total * 100, c / Total * 100, d / Total * 100
    end
    return 0, 0, 0, 0
end

Utilities = {

    get_target_delay_from_noteresult = function(noteresult)
        return Bounds[noteresult]
    end;
    
    get_noteresult = function()

        local P, G, O, M = Calculate(GetHitPercentage("Perfect"), GetHitPercentage("Great"), GetHitPercentage("Okay"), GetHitPercentage("Miss"))
        local Target = P + G + O + M
        local Total = 0
        
        local ChanceTBL = {}
        local chs = {"Miss", "Okay", "Great", "Perfect"}

        for i,v in next, {M, O, G, P} do 
            if v > 0 then 
                ChanceTBL[chs[i]] = v
            end
        end

        local Entries = {}
        for i,v in next, ChanceTBL do
            Entries[i] = {Min = Total, Max = Total + v}
            Total = Total + v
        end
        
        local Number = math.random(0, math.floor(Target));

        for i,v in next, Entries do
            if v.Min <= Number and v.Max >= Number then
                return i
            end
        end
    end;

    updatehitpct = function()
        local P, G, O, M = GetHitPercentage('Perfect'), GetHitPercentage('Great'), GetHitPercentage('Okay'), GetHitPercentage('Miss')
        HitPercentages.Combined = P + G + O + M
    end;

    determine = function(key, constants)
        local finding
    
        if (key == RELEASE_TRACK) then
            finding = 'release'
        elseif (key == PRESS_TRACK) then
            finding = 'press'
        elseif (key == TEST_HIT) then
            finding = 'get_delta_time_from_hit_time'
        elseif (key == TEST_RELEASE) then
            finding = 'get_delta_time_from_release_time'
        end
    
        if finding == nil then return false end
    
        if table.find(constants, finding) then 
            return true 
        end
        
        return false
    end;
    
    get_notes = function(tracksystem)
        for i,v in next, tracksystem do 
            if type(v) == "function" then 
                local c = getconstants(v)
                if table.find(c, "do_remove") and table.find(c, "clear") then
                    return getupvalue(v, 1)
                end 
            end 
        end
    end;
    
    get_tracksystems = function(_game)
        for i,v in next, _game do
            if (type(v) == 'function') then
                local obj = getupvalue(v, 1)
                if (type(obj) == 'table' and rawget(obj, '_table') and rawget(obj, 'count')) then
                    if (obj:count() <= 4) then
                        return obj
                    end
                end
            end
        end
    end;
    
    get_func = function(parent, func)
        for i,v in next, parent do
            local consts = type(v) == 'function' and getconstants(v) or {}
            if (type(v) == 'function' and Utilities.determine(func, consts)) then
                return v
            end
        end
    end;
};

Database = nil
local AllSongs;
Applying = {}
StoredSongs = {}

local function Apply(as,db)
    local MNM = db:name_to_key('MondayNightMonsters1')

    local old_new = as.new
    
    as.new = function(...)
        local as_self = old_new(...)
        local old_skp = as_self.on_songkey_pressed;
        as_self.on_songkey_pressed = function(self, song)
            
            local actual = tonumber(song);
            
            if UnlockAllSongs then
                song = MNM
            end
            
            local song_name = db:key_to_name(song)
            local actual_name = db:key_to_name(actual)
            local title = db:get_title_for_key(actual)
            local data = StoredSongs[title]
            
            local all = getupvalue(db.add_key_to_data, 1);

            all:add(song, data);
            data.__key = song;
            
            setupvalue(db.add_key_to_data, 1, all)
             
            return old_skp(self, song)
        end
        
        return as_self
    end
end

colors = {
    [1] = Color3.fromRGB(255, 0, 0);
    [2] = Color3.fromRGB(255, 0, 0);
    [3] = Color3.fromRGB(255, 0, 0);
    [4] = Color3.fromRGB(255, 0, 0);
}

TrackSystem = nil
get_local_elements_folder = nil
vip = nil
WebNPCManager = nil
visit_webnpc = nil
SongSpeedValue = 1000

loadstring([[for i,v in next, getgc(true) do
    if type(v) == 'table' then
        if rawget(v, 'key_has_combineinfo') then
            Database = v;
        end
        if rawget(v, "input_began") then 
            local input_began = v.input_began
            v.input_began = function(_, input) 
                if type(input) ~= "number" and BlockInput then 
                    return
                end 
                return input_began(_, input)
            end
        end
        if rawget(v, "visit_webnpc") then
            visit_webnpc = v.visit_webnpc
        end 
        if rawget(v, "webnpcid_should_trigger_reward") then 
            WebNPCManager = v
        end
        if rawget(v, 'playerblob_has_vip_for_current_day') then
            vip = v
        end
        if type(rawget(v, 'new')) == 'function' and islclosure(v.new) then
            local new = v.new
            local finding = {"get_default_base_color_list", "get_default_fever_color_list"};
            local found = 0;
            for _,bruh in next, getconstants(new) do
                if (bruh == 'on_songkey_pressed') then
                    table.insert(Applying, #Applying+1, v)
                end
                if (table.find(finding, bruh)) then
                    found = found + 1
                end
            end
            if (found >= #finding) and not TrackSystem then
                TrackSystem = v;
            end
        end	
        if rawget(v, "TimescaleToDeltaTime") then 
            local OldTTDT = v.TimescaleToDeltaTime
            v.TimescaleToDeltaTime = function(...)
                local args = {...}
                args[2] = args[2] * (SongSpeedValue / 1000)
                return OldTTDT(unpack(args))
            end
        end
        if rawget(v, 'color3_for_slot') then 
            local old = v.color3_for_slot
            v.color3_for_slot = function(self, ...)
                local orig = old(self, ...)
                if not NoteColors then 
                    return orig 
                end
                return colors[self:get_track_index()] or orig
            end
        end
        if rawget(v, 'get_local_elements_folder') then 
            get_local_elements_folder = v.get_local_elements_folder 
        end
        if rawget(v, 'HitObjects') then 
            StoredSongs[v.AudioFilename] = v
        end
    end
end]])()

for _,AllSongs in next, Applying do
    Apply(AllSongs, Database)
end

local playerblob_has_vip_for_current_day = vip.playerblob_has_vip_for_current_day

Autoplayer = true

vip.playerblob_has_vip_for_current_day = function()
            return true 
        end 

function update_autoplayer(_game, target_delay)
    local localSlot = getupvalue(_game.set_local_game_slot, 1)
    local trackSystem = Utilities.get_tracksystems(_game)._table[localSlot]
    local Notes = Utilities.get_notes(trackSystem)
    local Target = -math.abs(target_delay)
    local current_song = get_local_elements_folder():FindFirstChildWhichIsA("Sound")

    if current_song then 
        current_song.PlaybackSpeed = SongSpeedValue / 1000
    end

    for Index = 1, Notes:count() do
        local Note = Notes:get(Index)
        if Note then
            local NoteTrack = Note:get_track_index(Index)
            if HeldNotes[NoteTrack] and Utilities.get_func(Note, TEST_RELEASE) then
                local released, result, delay = Utilities.get_func(Note, TEST_RELEASE)(Note, _game, 0)
                if (released and delay >= Target) then
                    HeldNotes[NoteTrack] = nil
                    Utilities.get_func(trackSystem, RELEASE_TRACK)(trackSystem, _game, NoteTrack)
                    return true
                end
            elseif (Autoplayer and Utilities.get_func(Note, TEST_HIT)) then
                local hit, result, delay = Utilities.get_func(Note, TEST_HIT)(Note, _game, 0)
                if hit and delay >= Target then
                    Utilities.get_func(trackSystem, PRESS_TRACK)(trackSystem, _game, NoteTrack)
                    _game:debug_any_press()
    
                    if (type(Note.get_time_to_end) == 'nil') then
                        HeldNotes[NoteTrack] = true
                    else
                        wait(0.05)
                        Utilities.get_func(trackSystem, RELEASE_TRACK)(trackSystem, _game, NoteTrack)
                    end
                end
            end
        end
    end
end

local old_new = TrackSystem.new;
TrackSystem.new = function(...)
    local self = old_new(...)
    local old_update
    for i,v in next, self do 
        if type(v) == "function" then 
            local c = getconstants(v)
            if table.find(c, "do_remove") and table.find(c, "remove_at") then 
                old_update = v
                rawset(self, getinfo(v).name, function(shit, slot, _game)
                    if Autoplayer then
                        local delay = Utilities.get_target_delay_from_noteresult(Utilities.get_noteresult()) or 25
                        coroutine.wrap(update_autoplayer)(_game, delay)
                    end
                    return old_update(self, slot, _game)
                end)
                break
            end
        end 
    end
    return self;
end

if false then 
    vip.playerblob_has_vip_for_current_day = function()
        return true 
    end 
else 
    vip.playerblob_has_vip_for_current_day = playerblob_has_vip_for_current_day
end
