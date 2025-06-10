---@class AudioAccessor
---@class HWND
---@class IReaperControlSurface
---@class KbdSectionInfo
---@class MediaItem
---@class MediaItem_Take
---@class MediaTrack
---@class PCM_source
---@class ReaProject
---@class TrackEnvelope
---@class identifier
---@class joystick_device

---@class reaper
reaper = {}

---@param tr MediaTrack
---@return MediaItem
--- creates a new media item.
function reaper.AddMediaItemToTrack(tr) end

---@param proj ReaProject
---@param isrgn boolean
---@param pos number
---@param rgnend number
---@param name string
---@param wantidx integer
---@return integer
--- Returns the index of the created marker/region, or -1 on failure. Supply wantidx>=0 if you want a particular index number, but you'll get a different index number a region and wantidx is already in use.
function reaper.AddProjectMarker(proj, isrgn, pos, rgnend, name, wantidx) end

---@param proj ReaProject
---@param isrgn boolean
---@param pos number
---@param rgnend number
---@param name string
---@param wantidx integer
---@param color integer
---@return integer
--- Returns the index of the created marker/region, or -1 on failure. Supply wantidx>=0 if you want a particular index number, but you'll get a different index number a region and wantidx is already in use. color should be 0 (default color), or ColorToNative(r,g,b)|0x1000000
function reaper.AddProjectMarker2(proj, isrgn, pos, rgnend, name, wantidx, color) end

---@param add boolean
---@param sectionID integer
---@param scriptfn string
---@param commit boolean
---@return integer
--- Add a ReaScript (return the new command ID, or 0 if failed) or remove a ReaScript (return >0 on success). Use commit==true when adding/removing a single script. When bulk adding/removing n scripts, you can optimize the n-1 first calls with commit==false and commit==true for the last call.
function reaper.AddRemoveReaScript(add, sectionID, scriptfn, commit) end

---@param item MediaItem
---@return MediaItem_Take
--- creates a new take in an item
function reaper.AddTakeToMediaItem(item) end

---@param proj ReaProject
---@param timepos number
---@param bpm number
---@param timesig_num integer
---@param timesig_denom integer
---@param lineartempochange boolean
---@return boolean
--- Deprecated. Use SetTempoTimeSigMarker with ptidx=-1.
function reaper.AddTempoTimeSigMarker(proj, timepos, bpm, timesig_num, timesig_denom, lineartempochange) end

---@param amt number
---@param forceset integer
---@param doupd boolean
---@param centermode integer
--- forceset=0,doupd=true,centermode=-1 for default
function reaper.adjustZoom(amt, forceset, doupd, centermode) end

---@param proj ReaProject
---@return boolean
function reaper.AnyTrackSolo(proj) end

---@param function_name string
---@return boolean
--- Returns true if function_name exists in the REAPER API
function reaper.APIExists(function_name) end

--- Displays a message window if the API was successfully called.
function reaper.APITest() end

---@param project ReaProject
---@param nudgeflag integer
---@param nudgewhat integer
---@param nudgeunits integer
---@param value number
---@param reverse boolean
---@param copies integer
---@return boolean
--- nudgeflag: &1=set to value (otherwise nudge by value), &2=snap
function reaper.ApplyNudge(project, nudgeflag, nudgewhat, nudgeunits, value, reverse, copies) end

---@param cmd integer
---@param sectionname string
--- arms a command (or disarms if 0 passed) in section sectionname (empty string for main)
function reaper.ArmCommand(cmd, sectionname) end

--- open all audio and MIDI devices, if not open
function reaper.Audio_Init() end

---@return integer
--- is in pre-buffer? threadsafe
function reaper.Audio_IsPreBuffer() end

---@return integer
--- is audio running at all? threadsafe
function reaper.Audio_IsRunning() end

--- close all audio and MIDI devices, if open
function reaper.Audio_Quit() end

---@param accessor AudioAccessor
---@return boolean
--- Returns true if the underlying samples (track or media item take) have changed, but does not update the audio accessor, so the user can selectively call AudioAccessorValidateState only when needed. See
function reaper.AudioAccessorStateChanged(accessor) end

---@param accessor AudioAccessor
--- Force the accessor to reload its state from the underlying track or media item take. See
function reaper.AudioAccessorUpdate(accessor) end

---@param accessor AudioAccessor
---@return boolean
--- Validates the current state of the audio accessor -- must ONLY call this from the main thread. Returns true if the state changed.
function reaper.AudioAccessorValidateState(accessor) end

---@param bypass integer
--- -1 = bypass all if not all bypassed,otherwise unbypass all
function reaper.BypassFxAllTracks(bypass) end

---@param mediasource PCM_source
---@return integer
--- Calculates loudness statistics of media via dry run render. Statistics will be displayed to the user; call GetSetProjectInfo_String("RENDER_STATS") to retrieve via API. Returns 1 if loudness was calculated successfully, -1 if user canceled the dry run render.
function reaper.CalcMediaSrcLoudness(mediasource) end

---@param source PCM_source
---@param normalizeTo integer
---@param normalizeTarget number
---@param normalizeStart number
---@param normalizeEnd number
---@return number
--- Calculate normalize adjustment for source media. normalizeTo: 0=LUFS-I, 1=RMS-I, 2=peak, 3=true peak, 4=LUFS-M max, 5=LUFS-S max. normalizeTarget: dBFS or LUFS value. normalizeStart, normalizeEnd: time bounds within source media for normalization calculation. If normalizationStart=0 and normalizationEnd=0, the full duration of the media will be used for the calculation.
function reaper.CalculateNormalization(source, normalizeTo, normalizeTarget, normalizeStart, normalizeEnd) end

function reaper.ClearAllRecArmed() end

--- Clear the ReaScript console. See
function reaper.ClearConsole() end

--- resets the global peak caches
function reaper.ClearPeakCache() end

---@param col integer
---@return integer, integer, integer
--- Extract RGB values from an OS dependent color. See
function reaper.ColorFromNative(col) end

---@param r integer
---@param g integer
---@param b integer
---@return integer
--- Make an OS dependent color from RGB values (e.g. RGB() macro on Windows). r,g and b are in [0..255]. See
function reaper.ColorToNative(r, g, b) end

---@param section KbdSectionInfo
---@param cmdID integer
---@return integer
--- Returns the number of shortcuts that exist for the given command ID.
function reaper.CountActionShortcuts(section, cmdID) end

---@param env TrackEnvelope
---@return integer
--- Returns the number of automation items on this envelope. See
function reaper.CountAutomationItems(env) end

---@param envelope TrackEnvelope
---@return integer
--- Returns the number of points in the envelope. See
function reaper.CountEnvelopePoints(envelope) end

---@param envelope TrackEnvelope
---@param autoitem_idx integer
---@return integer
--- Returns the number of points in the envelope.
function reaper.CountEnvelopePointsEx(envelope, autoitem_idx) end

---@param proj ReaProject
---@return integer
--- count the number of items in the project (proj=0 for active project)
function reaper.CountMediaItems(proj) end

---@param proj ReaProject
---@return integer, integer, integer
--- num_markersOut and num_regionsOut may be NULL.
function reaper.CountProjectMarkers(proj) end

---@param proj ReaProject
---@return integer
--- Discouraged, because GetSelectedMediaItem can be inefficient if media items are added, rearranged, or deleted in between calls. Instead see
function reaper.CountSelectedMediaItems(proj) end

---@param proj ReaProject
---@return integer
--- Count the number of selected tracks in the project (proj=0 for active project). This function ignores the master track, see
function reaper.CountSelectedTracks(proj) end

---@param proj ReaProject
---@param wantmaster boolean
---@return integer
--- Count the number of selected tracks in the project (proj=0 for active project).
function reaper.CountSelectedTracks2(proj, wantmaster) end

---@param take MediaItem_Take
---@return integer
function reaper.CountTakeEnvelopes(take) end

---@param item MediaItem
---@return integer
--- count the number of takes in the item
function reaper.CountTakes(item) end

---@param project ReaProject
---@param track MediaTrack
---@return integer
--- Count the number of FX parameter knobs displayed on the track control panel.
function reaper.CountTCPFXParms(project, track) end

---@param proj ReaProject
---@return integer
--- Count the number of tempo/time signature markers in the project. See
function reaper.CountTempoTimeSigMarkers(proj) end

---@param track MediaTrack
---@return integer
--- GetTrackEnvelope
function reaper.CountTrackEnvelopes(track) end

---@param track MediaTrack
---@return integer
--- count the number of items in the track
function reaper.CountTrackMediaItems(track) end

---@param proj ReaProject
---@return integer
--- count the number of tracks in the project (proj=0 for active project)
function reaper.CountTracks(proj) end

---@param track MediaTrack
---@param starttime number
---@param endtime number
---@param qnIn optional boolean
---@return MediaItem
--- Create a new MIDI media item, containing no MIDI events. Time is in seconds unless qn is set.
function reaper.CreateNewMIDIItemInProj(track, starttime, endtime, qnIn) end

---@param take MediaItem_Take
---@return AudioAccessor
--- Create an audio accessor object for this take. Must only call from the main thread. See
function reaper.CreateTakeAudioAccessor(take) end

---@param track MediaTrack
---@return AudioAccessor
--- Create an audio accessor object for this track. Must only call from the main thread. See
function reaper.CreateTrackAudioAccessor(track) end

---@param tr MediaTrack
---@param desttrIn MediaTrack
---@return integer
--- Create a send/receive (desttrInOptional!=NULL), or a hardware output (desttrInOptional==NULL) with default properties, return >=0 on success (== new send/receive index). See
function reaper.CreateTrackSend(tr, desttrIn) end

---@param force boolean
--- call this to force flushing of the undo states after using CSurf_On*Change()
function reaper.CSurf_FlushUndo(force) end

---@param trackid MediaTrack
---@param isPan integer
---@return boolean
function reaper.CSurf_GetTouchState(trackid, isPan) end

function reaper.CSurf_GoEnd() end

function reaper.CSurf_GoStart() end

---@param mcpView boolean
---@return integer
function reaper.CSurf_NumTracks(mcpView) end

---@param whichdir integer
---@param wantzoom boolean
function reaper.CSurf_OnArrow(whichdir, wantzoom) end

---@param seekplay integer
function reaper.CSurf_OnFwd(seekplay) end

---@param trackid MediaTrack
---@param en integer
---@return boolean
function reaper.CSurf_OnFXChange(trackid, en) end

---@param trackid MediaTrack
---@param monitor integer
---@return integer
function reaper.CSurf_OnInputMonitorChange(trackid, monitor) end

---@param trackid MediaTrack
---@param monitor integer
---@param allowgang boolean
---@return integer
function reaper.CSurf_OnInputMonitorChangeEx(trackid, monitor, allowgang) end

---@param trackid MediaTrack
---@param mute integer
---@return boolean
function reaper.CSurf_OnMuteChange(trackid, mute) end

---@param trackid MediaTrack
---@param mute integer
---@param allowgang boolean
---@return boolean
function reaper.CSurf_OnMuteChangeEx(trackid, mute, allowgang) end

---@param trackid MediaTrack
---@param pan number
---@param relative boolean
---@return number
function reaper.CSurf_OnPanChange(trackid, pan, relative) end

---@param trackid MediaTrack
---@param pan number
---@param relative boolean
---@param allowGang boolean
---@return number
function reaper.CSurf_OnPanChangeEx(trackid, pan, relative, allowGang) end

function reaper.CSurf_OnPause() end

function reaper.CSurf_OnPlay() end

---@param playrate number
function reaper.CSurf_OnPlayRateChange(playrate) end

---@param trackid MediaTrack
---@param recarm integer
---@return boolean
function reaper.CSurf_OnRecArmChange(trackid, recarm) end

---@param trackid MediaTrack
---@param recarm integer
---@param allowgang boolean
---@return boolean
function reaper.CSurf_OnRecArmChangeEx(trackid, recarm, allowgang) end

function reaper.CSurf_OnRecord() end

---@param trackid MediaTrack
---@param recv_index integer
---@param pan number
---@param relative boolean
---@return number
function reaper.CSurf_OnRecvPanChange(trackid, recv_index, pan, relative) end

---@param trackid MediaTrack
---@param recv_index integer
---@param volume number
---@param relative boolean
---@return number
function reaper.CSurf_OnRecvVolumeChange(trackid, recv_index, volume, relative) end

---@param seekplay integer
function reaper.CSurf_OnRew(seekplay) end

---@param seekplay integer
---@param dir integer
function reaper.CSurf_OnRewFwd(seekplay, dir) end

---@param xdir integer
---@param ydir integer
function reaper.CSurf_OnScroll(xdir, ydir) end

---@param trackid MediaTrack
---@param selected integer
---@return boolean
function reaper.CSurf_OnSelectedChange(trackid, selected) end

---@param trackid MediaTrack
---@param send_index integer
---@param pan number
---@param relative boolean
---@return number
function reaper.CSurf_OnSendPanChange(trackid, send_index, pan, relative) end

---@param trackid MediaTrack
---@param send_index integer
---@param volume number
---@param relative boolean
---@return number
function reaper.CSurf_OnSendVolumeChange(trackid, send_index, volume, relative) end

---@param trackid MediaTrack
---@param solo integer
---@return boolean
function reaper.CSurf_OnSoloChange(trackid, solo) end

---@param trackid MediaTrack
---@param solo integer
---@param allowgang boolean
---@return boolean
function reaper.CSurf_OnSoloChangeEx(trackid, solo, allowgang) end

function reaper.CSurf_OnStop() end

---@param bpm number
function reaper.CSurf_OnTempoChange(bpm) end

---@param trackid MediaTrack
function reaper.CSurf_OnTrackSelection(trackid) end

---@param trackid MediaTrack
---@param volume number
---@param relative boolean
---@return number
function reaper.CSurf_OnVolumeChange(trackid, volume, relative) end

---@param trackid MediaTrack
---@param volume number
---@param relative boolean
---@param allowGang boolean
---@return number
function reaper.CSurf_OnVolumeChangeEx(trackid, volume, relative, allowGang) end

---@param trackid MediaTrack
---@param width number
---@param relative boolean
---@return number
function reaper.CSurf_OnWidthChange(trackid, width, relative) end

---@param trackid MediaTrack
---@param width number
---@param relative boolean
---@param allowGang boolean
---@return number
function reaper.CSurf_OnWidthChangeEx(trackid, width, relative, allowGang) end

---@param xdir integer
---@param ydir integer
function reaper.CSurf_OnZoom(xdir, ydir) end

function reaper.CSurf_ResetAllCachedVolPanStates() end

---@param amt number
function reaper.CSurf_ScrubAmt(amt) end

---@param mode integer
---@param ignoresurf IReaperControlSurface
function reaper.CSurf_SetAutoMode(mode, ignoresurf) end

---@param play boolean
---@param pause boolean
---@param rec boolean
---@param ignoresurf IReaperControlSurface
function reaper.CSurf_SetPlayState(play, pause, rec, ignoresurf) end

---@param rep boolean
---@param ignoresurf IReaperControlSurface
function reaper.CSurf_SetRepeatState(rep, ignoresurf) end

---@param trackid MediaTrack
---@param mute boolean
---@param ignoresurf IReaperControlSurface
function reaper.CSurf_SetSurfaceMute(trackid, mute, ignoresurf) end

---@param trackid MediaTrack
---@param pan number
---@param ignoresurf IReaperControlSurface
function reaper.CSurf_SetSurfacePan(trackid, pan, ignoresurf) end

---@param trackid MediaTrack
---@param recarm boolean
---@param ignoresurf IReaperControlSurface
function reaper.CSurf_SetSurfaceRecArm(trackid, recarm, ignoresurf) end

---@param trackid MediaTrack
---@param selected boolean
---@param ignoresurf IReaperControlSurface
function reaper.CSurf_SetSurfaceSelected(trackid, selected, ignoresurf) end

---@param trackid MediaTrack
---@param solo boolean
---@param ignoresurf IReaperControlSurface
function reaper.CSurf_SetSurfaceSolo(trackid, solo, ignoresurf) end

---@param trackid MediaTrack
---@param volume number
---@param ignoresurf IReaperControlSurface
function reaper.CSurf_SetSurfaceVolume(trackid, volume, ignoresurf) end

function reaper.CSurf_SetTrackListChange() end

---@param idx integer
---@param mcpView boolean
---@return MediaTrack
function reaper.CSurf_TrackFromID(idx, mcpView) end

---@param track MediaTrack
---@param mcpView boolean
---@return integer
function reaper.CSurf_TrackToID(track, mcpView) end

---@param x number
---@return number
function reaper.DB2SLIDER(x) end

---@param section KbdSectionInfo
---@param cmdID integer
---@param shortcutidx integer
---@return boolean
--- Delete the specific shortcut for the given command ID.
function reaper.DeleteActionShortcut(section, cmdID, shortcutidx) end

---@param envelope TrackEnvelope
---@param autoitem_idx integer
---@param ptidx integer
---@return boolean
--- Delete an envelope point. If setting multiple points at once, set noSort=true, and call Envelope_SortPoints when done.
function reaper.DeleteEnvelopePointEx(envelope, autoitem_idx, ptidx) end

---@param envelope TrackEnvelope
---@param time_start number
---@param time_end number
---@return boolean
--- Delete a range of envelope points. See
function reaper.DeleteEnvelopePointRange(envelope, time_start, time_end) end

---@param envelope TrackEnvelope
---@param autoitem_idx integer
---@param time_start number
---@param time_end number
---@return boolean
--- Delete a range of envelope points. autoitem_idx=-1 for the underlying envelope, 0 for the first automation item on the envelope, etc.
function reaper.DeleteEnvelopePointRangeEx(envelope, autoitem_idx, time_start, time_end) end

---@param section string
---@param key string
---@param persist boolean
--- Delete the extended state value for a specific section and key. persist=true means the value should remain deleted the next time REAPER is opened. See
function reaper.DeleteExtState(section, key, persist) end

---@param proj ReaProject
---@param markrgnindexnumber integer
---@param isrgn boolean
---@return boolean
--- Delete a marker. proj==NULL for the active project.
function reaper.DeleteProjectMarker(proj, markrgnindexnumber, isrgn) end

---@param proj ReaProject
---@param markrgnidx integer
---@return boolean
--- Differs from DeleteProjectMarker only in that markrgnidx is 0 for the first marker/region, 1 for the next, etc (see
function reaper.DeleteProjectMarkerByIndex(proj, markrgnidx) end

---@param take MediaItem_Take
---@param idx integer
---@return boolean
--- Delete a take marker. Note that idx will change for all following take markers. See
function reaper.DeleteTakeMarker(take, idx) end

---@param take MediaItem_Take
---@param idx integer
---@param countIn optional integer
---@return integer
--- Deletes one or more stretch markers. Returns number of stretch markers deleted.
function reaper.DeleteTakeStretchMarkers(take, idx, countIn) end

---@param project ReaProject
---@param markerindex integer
---@return boolean
--- Delete a tempo/time signature marker.
function reaper.DeleteTempoTimeSigMarker(project, markerindex) end

---@param tr MediaTrack
function reaper.DeleteTrack(tr) end

---@param tr MediaTrack
---@param it MediaItem
---@return boolean
function reaper.DeleteTrackMediaItem(tr, it) end

---@param accessor AudioAccessor
--- Destroy an audio accessor. Must only call from the main thread. See
function reaper.DestroyAudioAccessor(accessor) end

---@param hwnd HWND
---@param section KbdSectionInfo
---@param cmdID integer
---@param shortcutidx integer
---@return boolean
--- Open the action shortcut dialog to edit or add a shortcut for the given command ID. If (shortcutidx >= 0 && shortcutidx < CountActionShortcuts()), that specific shortcut will be replaced, otherwise a new shortcut will be added.
function reaper.DoActionShortcutDialog(hwnd, section, cmdID, shortcutidx) end

---@param ident_str string
---@param whichDock integer
--- updates preference for docker window ident_str to be in dock whichDock on next open
function reaper.Dock_UpdateDockID(ident_str, whichDock) end

---@param whichDock integer
---@return integer
--- -1=not found, 0=bottom, 1=left, 2=top, 3=right, 4=floating
function reaper.DockGetPosition(whichDock) end

---@param hwnd HWND
---@return integer, boolean
--- returns dock index that contains hwnd, or -1
function reaper.DockIsChildOfDock(hwnd) end

---@param hwnd HWND
function reaper.DockWindowActivate(hwnd) end

---@param hwnd HWND
---@param name string
---@param pos integer
---@param allowShow boolean
function reaper.DockWindowAdd(hwnd, name, pos, allowShow) end

---@param hwnd HWND
---@param name string
---@param identstr string
---@param allowShow boolean
function reaper.DockWindowAddEx(hwnd, name, identstr, allowShow) end

function reaper.DockWindowRefresh() end

---@param hwnd HWND
function reaper.DockWindowRefreshForHWND(hwnd) end

---@param hwnd HWND
function reaper.DockWindowRemove(hwnd) end

---@param project ReaProject
---@param markerindex integer
---@return boolean
--- Open the tempo/time signature marker editor dialog.
function reaper.EditTempoTimeSigMarker(project, markerindex) end

---@return integerr.left, integerr.top, integerr.right, integerr.bot
--- call with a saved window rect for your window and it'll correct any positioning info.
function reaper.EnsureNotCompletelyOffscreen() end

---@param path string
---@param fileindex integer
---@return string
--- List the files in the "path" directory. Returns NULL/nil when all files have been listed. Use fileindex = -1 to force re-read of directory (invalidate cache). See
function reaper.EnumerateFiles(path, fileindex) end

---@param path string
---@param subdirindex integer
---@return string
--- List the subdirectories in the "path" directory. Use subdirindex = -1 to force re-read of directory (invalidate cache). Returns NULL/nil when all subdirectories have been listed. See
function reaper.EnumerateSubdirectories(path, subdirindex) end

---@param index integer
---@return boolean, string, string
--- Enumerates installed FX. Returns true if successful, sets nameOut and identOut to name and ident of FX at index.
function reaper.EnumInstalledFX(index) end

---@param mode integer
---@return boolean, string
--- Start querying modes at 0, returns FALSE when no more modes possible, sets strOut to NULL if a mode is currently unsupported
function reaper.EnumPitchShiftModes(mode) end

---@param mode integer
---@param submode integer
---@return string
--- Returns submode name, or NULL
function reaper.EnumPitchShiftSubModes(mode, submode) end

---@param idx integer
---@return integer, boolean, number, number, string, integer
function reaper.EnumProjectMarkers(idx) end

---@param proj ReaProject
---@param idx integer
---@return integer, boolean, number, number, string, integer
function reaper.EnumProjectMarkers2(proj, idx) end

---@param proj ReaProject
---@param idx integer
---@return integer, boolean, number, number, string, integer, integer
function reaper.EnumProjectMarkers3(proj, idx) end

---@param idx integer
---@return ReaProject, string
--- idx=-1 for current project,projfn can be NULL if not interested in filename. use idx 0x40000000 for currently rendering project, if any.
function reaper.EnumProjects(idx) end

---@param proj ReaProject
---@param extname string
---@param idx integer
---@return boolean, string, string
--- Enumerate the data stored with the project for a specific extname. Returns false when there is no more data. See
function reaper.EnumProjExtState(proj, extname, idx) end

---@param proj ReaProject
---@param regionindex integer
---@param rendertrack integer
---@return MediaTrack
--- Enumerate which tracks will be rendered within this region when using the region render matrix. When called with rendertrack==0, the function returns the first track that will be rendered (which may be the master track); rendertrack==1 will return the next track rendered, and so on. The function returns NULL when there are no more tracks that will be rendered within this region.
function reaper.EnumRegionRenderMatrix(proj, regionindex, rendertrack) end

---@param track integer
---@param programNumber integer
---@param programName string
---@return boolean, string
--- returns false if there are no plugins on the track that support MIDI programs,or if all programs have been enumerated
function reaper.EnumTrackMIDIProgramNames(track, programNumber, programName) end

---@param proj ReaProject
---@param track MediaTrack
---@param programNumber integer
---@param programName string
---@return boolean, string
--- returns false if there are no plugins on the track that support MIDI programs,or if all programs have been enumerated
function reaper.EnumTrackMIDIProgramNamesEx(proj, track, programNumber, programName) end

---@param envelope TrackEnvelope
---@param time number
---@param samplerate number
---@param samplesRequested integer
---@return integer, number, number, number, number
--- Get the effective envelope value at a given time position. samplesRequested is how long the caller expects until the next call to Envelope_Evaluate (often, the buffer block size). The return value is how many samples beyond that time position that the returned values are valid. dVdS is the change in value per sample (first derivative), ddVdS is the second derivative, dddVdS is the third derivative. See
function reaper.Envelope_Evaluate(envelope, time, samplerate, samplesRequested) end

---@param env TrackEnvelope
---@param value number
---@return string
--- Formats the value of an envelope to a user-readable form
function reaper.Envelope_FormatValue(env, value) end

---@param env TrackEnvelope
---@return MediaItem_Take, integer, integer
--- If take envelope, gets the take from the envelope. If FX, indexOut set to FX index, index2Out set to parameter index, otherwise -1.
function reaper.Envelope_GetParentTake(env) end

---@param env TrackEnvelope
---@return MediaTrack, integer, integer
--- If track envelope, gets the track from the envelope. If FX, indexOut set to FX index, index2Out set to parameter index, otherwise -1.
function reaper.Envelope_GetParentTrack(env) end

---@param envelope TrackEnvelope
---@return boolean
--- Sort envelope points by time. See
function reaper.Envelope_SortPoints(envelope) end

---@param envelope TrackEnvelope
---@param autoitem_idx integer
---@return boolean
--- Sort envelope points by time. autoitem_idx=-1 for the underlying envelope, 0 for the first automation item on the envelope, etc. See
function reaper.Envelope_SortPointsEx(envelope, autoitem_idx) end

---@param cmdline string
---@param timeoutmsec integer
---@return string
--- Executes command line, returns NULL on total failure, otherwise the return value, a newline, and then the output of the command. If timeoutmsec is 0, command will be allowed to run indefinitely (recommended for large amounts of returned output). timeoutmsec is -1 for no wait/terminate, -2 for no wait and minimize
function reaper.ExecProcess(cmdline, timeoutmsec) end

---@param path string
---@return boolean
--- returns true if path points to a valid, readable file
function reaper.file_exists(path) end

---@param project ReaProject
---@param time number
---@return integer
--- Find the tempo/time signature marker that falls at or before this time position (the marker that is in effect as of this time position).
function reaper.FindTempoTimeSigMarker(project, time) end

---@param tpos number
---@param buf string
---@return string
--- Format tpos (which is time in seconds) as hh:mm:ss.sss. See
function reaper.format_timestr(tpos, buf) end

---@param tpos number
---@param buf string
---@param offset number
---@param modeoverride integer
---@return string
--- time formatting mode overrides: -1=proj default.
function reaper.format_timestr_len(tpos, buf, offset, modeoverride) end

---@param tpos number
---@param buf string
---@param modeoverride integer
---@return string
--- time formatting mode overrides: -1=proj default.
function reaper.format_timestr_pos(tpos, buf, modeoverride) end

---@param gGUID string
---@return string
function reaper.genGuid(gGUID) end

---@param name string
---@return boolean, string
--- gets ini configuration variable value as string
function reaper.get_config_var_string(name) end

---@return string
--- Get reaper.ini full filename.
function reaper.get_ini_file() end

---@param section KbdSectionInfo
---@param cmdID integer
---@param shortcutidx integer
---@return boolean, string
--- Get the text description of a specific shortcut for the given command ID.
function reaper.GetActionShortcutDesc(section, cmdID, shortcutidx) end

---@param item MediaItem
---@return MediaItem_Take
--- get the active take in this item
function reaper.GetActiveTake(item) end

---@param ignoreProject ReaProject
---@return integer
--- returns the bitwise OR of all project play states (1=playing, 2=pause, 4=recording)
function reaper.GetAllProjectPlayStates(ignoreProject) end

---@return string
--- Returns app version which may include an OS/arch signifier, such as: "6.17" (windows 32-bit), "6.17/x64" (windows 64-bit), "6.17/OSX64" (macOS 64-bit Intel), "6.17/OSX" (macOS 32-bit), "6.17/macOS-arm64", "6.17/linux-x86_64", "6.17/linux-i686", "6.17/linux-aarch64", "6.17/linux-armv7l", etc
function reaper.GetAppVersion() end

---@return integer, string
--- gets the currently armed command and section name (returns 0 if nothing armed). section name is empty-string for main section.
function reaper.GetArmedCommand() end

---@param accessor AudioAccessor
---@return number
--- Get the end time of the audio that can be returned from this accessor. See
function reaper.GetAudioAccessorEndTime(accessor) end

---@param accessor AudioAccessor
---@param hashNeed128 string
---@return string
--- AudioAccessorStateChanged
function reaper.GetAudioAccessorHash(accessor, hashNeed128) end

---@param accessor AudioAccessor
---@param samplerate integer
---@param numchannels integer
---@param starttime_sec number
---@param numsamplesperchannel integer
---@param samplebuffer reaper.array
---@return integer
--- Get a block of samples from the audio accessor. Samples are extracted immediately pre-FX, and returned interleaved (first sample of first channel, first sample of second channel...). Returns 0 if no audio, 1 if audio, -1 on error. See
function reaper.GetAudioAccessorSamples(accessor, samplerate, numchannels, starttime_sec, numsamplesperchannel, samplebuffer) end

---@param accessor AudioAccessor
---@return number
--- Get the start time of the audio that can be returned from this accessor. See
function reaper.GetAudioAccessorStartTime(accessor) end

---@param attribute string
---@return boolean, string
--- get information about the currently open audio device. attribute can be MODE, IDENT_IN, IDENT_OUT, BSIZE, SRATE, BPS. returns false if unknown attribute or device not open.
function reaper.GetAudioDeviceInfo(attribute) end

---@param ident_str string
---@return integer
--- gets the dock ID desired by ident_str, if any
function reaper.GetConfigWantsDock(ident_str) end

---@return ReaProject
--- returns current project if in load/save (usually only used from project_config_extension_t)
function reaper.GetCurrentProjectInLoadSave() end

---@return integer
--- return the current cursor context: 0 if track panels, 1 if items, 2 if envelopes, otherwise unknown
function reaper.GetCursorContext() end

---@param want_last_valid boolean
---@return integer
--- 0 if track panels, 1 if items, 2 if envelopes, otherwise unknown (unlikely when want_last_valid is true)
function reaper.GetCursorContext2(want_last_valid) end

---@return number
--- edit cursor position
function reaper.GetCursorPosition() end

---@param proj ReaProject
---@return number
--- edit cursor position
function reaper.GetCursorPositionEx(proj) end

---@param item MediaItem
---@return integer
--- GetDisplayedMediaItemColor2
function reaper.GetDisplayedMediaItemColor(item) end

---@param item MediaItem
---@param take MediaItem_Take
---@return integer
--- Returns the custom take, item, or track color that is used (according to the user preference) to color the media item. The returned color is OS dependent|0x01000000 (i.e. ColorToNative(r,g,b)|0x01000000), so a return of zero means "no color", not black.
function reaper.GetDisplayedMediaItemColor2(item, take) end

---@param env TrackEnvelope
---@param parmname string
---@return number
--- Gets an envelope numerical-value attribute:
function reaper.GetEnvelopeInfo_Value(env, parmname) end

---@param env TrackEnvelope
---@return boolean, string
function reaper.GetEnvelopeName(env) end

---@param envelope TrackEnvelope
---@param ptidx integer
---@return boolean, number, number, integer, number, boolean
--- Get the attributes of an envelope point. See
function reaper.GetEnvelopePoint(envelope, ptidx) end

---@param envelope TrackEnvelope
---@param time number
---@return integer
--- Returns the envelope point at or immediately prior to the given time position. See
function reaper.GetEnvelopePointByTime(envelope, time) end

---@param envelope TrackEnvelope
---@param autoitem_idx integer
---@param time number
---@return integer
--- Returns the envelope point at or immediately prior to the given time position.
function reaper.GetEnvelopePointByTimeEx(envelope, autoitem_idx, time) end

---@param envelope TrackEnvelope
---@param autoitem_idx integer
---@param ptidx integer
---@return boolean, number, number, integer, number, boolean
--- Get the attributes of an envelope point.
function reaper.GetEnvelopePointEx(envelope, autoitem_idx, ptidx) end

---@param env TrackEnvelope
---@return integer
--- Returns the envelope scaling mode: 0=no scaling, 1=fader scaling. All API functions deal with raw envelope point values, to convert raw from/to scaled values see
function reaper.GetEnvelopeScalingMode(env) end

---@param env TrackEnvelope
---@param str string
---@param isundo boolean
---@return boolean, string
--- Gets the RPPXML state of an envelope, returns true if successful. Undo flag is a performance/caching hint.
function reaper.GetEnvelopeStateChunk(env, str, isundo) end

---@param env TrackEnvelope
---@return integer
--- gets information on the UI state of an envelope: returns &1 if automation/modulation is playing back, &2 if automation is being actively written, &4 if the envelope recently had an effective automation mode change
function reaper.GetEnvelopeUIState(env) end

---@return string
--- returns path of REAPER.exe (not including EXE), i.e. C:\Program Files\REAPER
function reaper.GetExePath() end

---@param section string
---@param key string
---@return string
--- Get the extended state value for a specific section and key. See
function reaper.GetExtState(section, key) end

---@return integer, integer, integer, integer
--- This function is deprecated (returns GetFocusedFX2()&3), see
function reaper.GetFocusedFX() end

---@return integer, integer, integer, integer
--- Return value has 1 set if track FX, 2 if take/item FX, 4 set if FX is no longer focused but still open. tracknumber==0 means the master track, 1 means track 1, etc. itemnumber is zero-based (or -1 if not an item). For interpretation of fxnumber, see
function reaper.GetFocusedFX2() end

---@param proj ReaProject
---@param pathidx integer
---@return integer
--- returns free disk space in megabytes, pathIdx 0 for normal, 1 for alternate.
function reaper.GetFreeDiskSpaceForRecordPath(proj, pathidx) end

---@param track MediaTrack
---@param fxindex integer
---@param parameterindex integer
---@param create boolean
---@return TrackEnvelope
--- Returns the FX parameter envelope. If the envelope does not exist and create=true, the envelope will be created. If the envelope already exists and is bypassed and create=true, then the envelope will be unbypassed.
function reaper.GetFXEnvelope(track, fxindex, parameterindex, create) end

---@return integer
--- return -1=no override, 0=trim/read, 1=read, 2=touch, 3=write, 4=latch, 5=bypass
function reaper.GetGlobalAutomationOverride() end

---@return number
--- returns pixels/second
function reaper.GetHZoomLevel() end

---@param input_id integer
---@return number
--- returns approximate input level if available, 0-511 mono inputs, |1024 for stereo pairs, 4096+devidx*32 for MIDI devices
function reaper.GetInputActivityLevel(input_id) end

---@param channelIndex integer
---@return string
function reaper.GetInputChannelName(channelIndex) end

---@return integer, integer
--- Gets the audio device input/output latency in samples
function reaper.GetInputOutputLatency() end

---@return number, PCM_source, integer
--- returns time of relevant edit, set which_item to the pcm_source (if applicable), flags (if specified) will be set to 1 for edge resizing, 2 for fade change, 4 for item move, 8 for item slip edit (edit cursor time or start of item)
function reaper.GetItemEditingTime2() end

---@param screen_x integer
---@param screen_y integer
---@param allow_locked boolean
---@return MediaItem, MediaItem_Take
--- Returns the first item at the screen coordinates specified. If allow_locked is false, locked items are ignored. If takeOutOptional specified, returns the take hit. See
function reaper.GetItemFromPoint(screen_x, screen_y, allow_locked) end

---@param item MediaItem
---@return ReaProject
function reaper.GetItemProjectContext(item) end

---@param item MediaItem
---@param str string
---@param isundo boolean
---@return boolean, string
--- Gets the RPPXML state of an item, returns true if successful. Undo flag is a performance/caching hint.
function reaper.GetItemStateChunk(item, str, isundo) end

---@return string
function reaper.GetLastColorThemeFile() end

---@param proj ReaProject
---@param time number
---@return integer, integer
--- Get the last project marker before time, and/or the project region that includes time. markeridx and regionidx are returned not necessarily as the displayed marker/region index, but as the index that can be passed to EnumProjectMarkers. Either or both of markeridx and regionidx may be NULL. See
function reaper.GetLastMarkerAndCurRegion(proj, time) end

---@return boolean, integer, integer, integer
--- Returns true if the last touched FX parameter is valid, false otherwise. The low word of tracknumber is the 1-based track index -- 0 means the master track, 1 means track 1, etc. If the high word of tracknumber is nonzero, it refers to the 1-based item index (1 is the first item on the track, etc). For track FX, the low 24 bits of fxnumber refer to the FX index in the chain, and if the next 8 bits are 01, then the FX is record FX. For item FX, the low word defines the FX index in the chain, and the high word defines the take number. Deprecated, see
function reaper.GetLastTouchedFX() end

---@return MediaTrack
function reaper.GetLastTouchedTrack() end

---@return HWND
function reaper.GetMainHwnd() end

---@return integer
--- &1=master mute,&2=master solo. This is deprecated as you can just query the master track as well.
function reaper.GetMasterMuteSoloFlags() end

---@param proj ReaProject
---@return MediaTrack
function reaper.GetMasterTrack(proj) end

---@return integer
--- returns &1 if the master track is visible in the TCP, &2 if NOT visible in the mixer. See
function reaper.GetMasterTrackVisibility() end

---@return integer
--- returns max dev for midi inputs/outputs
function reaper.GetMaxMidiInputs() end

---@return integer
function reaper.GetMaxMidiOutputs() end

---@param mediaSource PCM_source
---@param identifier string
---@return integer, string
--- Get text-based metadata from a media file for a given identifier. Call with identifier="" to list all identifiers contained in the file, separated by newlines. May return "[Binary data]" for metadata that REAPER doesn't handle.
function reaper.GetMediaFileMetadata(mediaSource, identifier) end

---@param proj ReaProject
---@param itemidx integer
---@return MediaItem
--- get an item from a project by item count (zero-based) (proj=0 for active project)
function reaper.GetMediaItem(proj, itemidx) end

---@param item MediaItem
---@return MediaTrack
--- Get parent track of media item
function reaper.GetMediaItem_Track(item) end

---@param item MediaItem
---@param parmname string
---@return number
--- Get media item numerical-value attributes.
function reaper.GetMediaItemInfo_Value(item, parmname) end

---@param item MediaItem
---@return integer
function reaper.GetMediaItemNumTakes(item) end

---@param item MediaItem
---@param tk integer
---@return MediaItem_Take
function reaper.GetMediaItemTake(item, tk) end

---@param take MediaItem_Take
---@return MediaItem
--- Get parent item of media item take
function reaper.GetMediaItemTake_Item(take) end

---@param take MediaItem_Take
---@param peakrate number
---@param starttime number
---@param numchannels integer
---@param numsamplesperchannel integer
---@param want_extra_type integer
---@param buf reaper.array
---@return integer
--- Gets block of peak samples to buf. Note that the peak samples are interleaved, but in two or three blocks (maximums, then minimums, then extra). Return value has 20 bits of returned sample count, then 4 bits of output_mode (0xf00000), then a bit to signify whether extra_type was available (0x1000000). extra_type can be 115 ('s') for spectral information, which will return peak samples as integers with the low 15 bits frequency, next 14 bits tonality.
function reaper.GetMediaItemTake_Peaks(take, peakrate, starttime, numchannels, numsamplesperchannel, want_extra_type, buf) end

---@param take MediaItem_Take
---@return PCM_source
--- Get media source of media item take
function reaper.GetMediaItemTake_Source(take) end

---@param take MediaItem_Take
---@return MediaTrack
--- Get parent track of media item take
function reaper.GetMediaItemTake_Track(take) end

---@param project ReaProject
---@param guidGUID string
---@return MediaItem_Take
function reaper.GetMediaItemTakeByGUID(project, guidGUID) end

---@param take MediaItem_Take
---@param parmname string
---@return number
--- Get media item take numerical-value attributes.
function reaper.GetMediaItemTakeInfo_Value(take, parmname) end

---@param item MediaItem
---@return MediaTrack
function reaper.GetMediaItemTrack(item) end

---@param source PCM_source
---@return string
--- Copies the media source filename to filenamebuf. Note that in-project MIDI media sources have no associated filename. See
function reaper.GetMediaSourceFileName(source) end

---@param source PCM_source
---@return number, boolean
--- Returns the length of the source media. If the media source is beat-based, the length will be in quarter notes, otherwise it will be in seconds.
function reaper.GetMediaSourceLength(source) end

---@param source PCM_source
---@return integer
--- Returns the number of channels in the source media.
function reaper.GetMediaSourceNumChannels(source) end

---@param src PCM_source
---@return PCM_source
--- Returns the parent source, or NULL if src is the root source. This can be used to retrieve the parent properties of sections or reversed sources for example.
function reaper.GetMediaSourceParent(src) end

---@param source PCM_source
---@return integer
--- Returns the sample rate. MIDI source media will return zero.
function reaper.GetMediaSourceSampleRate(source) end

---@param source PCM_source
---@return string
--- copies the media source type ("WAV", "MIDI", etc) to typebuf
function reaper.GetMediaSourceType(source) end

---@param tr MediaTrack
---@param parmname string
---@return number
--- Get track numerical-value attributes.
function reaper.GetMediaTrackInfo_Value(tr, parmname) end

---@param dev integer
---@param nameout string
---@return boolean, string
--- returns true if device present
function reaper.GetMIDIInputName(dev, nameout) end

---@param dev integer
---@param nameout string
---@return boolean, string
--- returns true if device present
function reaper.GetMIDIOutputName(dev, nameout) end

---@return MediaTrack
--- Get the leftmost track visible in the mixer
function reaper.GetMixerScroll() end

---@param context string
---@param modifier_flag integer
---@return string
--- Get the current mouse modifier assignment for a specific modifier key assignment, in a specific context.
function reaper.GetMouseModifier(context, modifier_flag) end

---@return integer, integer
--- get mouse position in screen coordinates
function reaper.GetMousePosition() end

---@return integer
--- Return number of normal audio hardware inputs available
function reaper.GetNumAudioInputs() end

---@return integer
--- Return number of normal audio hardware outputs available
function reaper.GetNumAudioOutputs() end

---@return integer
--- returns max number of real midi hardware inputs
function reaper.GetNumMIDIInputs() end

---@return integer
--- returns max number of real midi hardware outputs
function reaper.GetNumMIDIOutputs() end

---@param take MediaItem_Take
---@return integer
--- Returns number of take markers. See
function reaper.GetNumTakeMarkers(take) end

---@return integer
--- Returns number of tracks in current project, see
function reaper.GetNumTracks() end

---@return string
--- Returns "Win32", "Win64", "OSX32", "OSX64", "macOS-arm64", or "Other".
function reaper.GetOS() end

---@param channelIndex integer
---@return string
function reaper.GetOutputChannelName(channelIndex) end

---@return number
--- returns output latency in seconds
function reaper.GetOutputLatency() end

---@param track MediaTrack
---@return MediaTrack
function reaper.GetParentTrack(track) end

---@param fn string
---@return string
--- get the peak file name for a given file (can be either filename.reapeaks,or a hashed filename in another path)
function reaper.GetPeakFileName(fn) end

---@param fn string
---@param buf string
---@param forWrite boolean
---@return string
--- get the peak file name for a given file (can be either filename.reapeaks,or a hashed filename in another path)
function reaper.GetPeakFileNameEx(fn, buf, forWrite) end

---@param fn string
---@param buf string
---@param forWrite boolean
---@param peaksfileextension string
---@return string
--- Like GetPeakFileNameEx, but you can specify peaksfileextension such as ".reapeaks"
function reaper.GetPeakFileNameEx2(fn, buf, forWrite, peaksfileextension) end

---@return number
--- returns latency-compensated actual-what-you-hear position
function reaper.GetPlayPosition() end

---@return number
--- returns position of next audio block being processed
function reaper.GetPlayPosition2() end

---@param proj ReaProject
---@return number
--- returns position of next audio block being processed
function reaper.GetPlayPosition2Ex(proj) end

---@param proj ReaProject
---@return number
--- returns latency-compensated actual-what-you-hear position
function reaper.GetPlayPositionEx(proj) end

---@return integer
--- &1=playing, &2=paused, &4=is recording
function reaper.GetPlayState() end

---@param proj ReaProject
---@return integer
--- &1=playing, &2=paused, &4=is recording
function reaper.GetPlayStateEx(proj) end

---@param proj ReaProject
---@return number
--- returns length of project (maximum of end of media item, markers, end of regions, tempo map
function reaper.GetProjectLength(proj) end

---@param proj ReaProject
---@return string
function reaper.GetProjectName(proj) end

---@return string
--- Get the project recording path.
function reaper.GetProjectPath() end

---@param proj ReaProject
---@return string
--- Get the project recording path.
function reaper.GetProjectPathEx(proj) end

---@param proj ReaProject
---@return integer
--- returns an integer that changes when the project state changes
function reaper.GetProjectStateChangeCount(proj) end

---@param proj ReaProject
---@param rndframe boolean
---@return number
--- Gets project time offset in seconds (project settings - project start time). If rndframe is true, the offset is rounded to a multiple of the project frame size.
function reaper.GetProjectTimeOffset(proj, rndframe) end

---@return number, number
function reaper.GetProjectTimeSignature() end

---@param proj ReaProject
---@return number, number
--- Gets basic time signature (beats per minute, numerator of time signature in bpi)
function reaper.GetProjectTimeSignature2(proj) end

---@param proj ReaProject
---@param extname string
---@param key string
---@return integer, string
--- Get the value previously associated with this extname and key, the last time the project was saved. See
function reaper.GetProjExtState(proj, extname, key) end

---@return string
--- returns path where ini files are stored, other things are in subdirectories.
function reaper.GetResourcePath() end

---@param proj ReaProject
---@return TrackEnvelope
--- get the currently selected envelope, returns NULL/nil if no envelope is selected
function reaper.GetSelectedEnvelope(proj) end

---@param proj ReaProject
---@param selitem integer
---@return MediaItem
--- Discouraged, because GetSelectedMediaItem can be inefficient if media items are added, rearranged, or deleted in between calls. Instead see
function reaper.GetSelectedMediaItem(proj, selitem) end

---@param proj ReaProject
---@param seltrackidx integer
---@return MediaTrack
--- Get a selected track from a project (proj=0 for active project) by selected track count (zero-based). This function ignores the master track, see
function reaper.GetSelectedTrack(proj, seltrackidx) end

---@param proj ReaProject
---@param seltrackidx integer
---@param wantmaster boolean
---@return MediaTrack
--- Get a selected track from a project (proj=0 for active project) by selected track count (zero-based).
function reaper.GetSelectedTrack2(proj, seltrackidx, wantmaster) end

---@param proj ReaProject
---@return TrackEnvelope
--- get the currently selected track envelope, returns NULL/nil if no envelope is selected
function reaper.GetSelectedTrackEnvelope(proj) end

---@param proj ReaProject
---@param isSet boolean
---@param screen_x_start integer
---@param screen_x_end integer
---@param start_time number
---@param end_time number
---@return number, number
--- Gets or sets the arrange view start/end time for screen coordinates. use screen_x_start=screen_x_end=0 to use the full arrange view's start/end time
function reaper.GetSet_ArrangeView2(proj, isSet, screen_x_start, screen_x_end, start_time, end_time) end

---@param isSet boolean
---@param isLoop boolean
---@param start number
---@param end_ number
---@param allowautoseek boolean
---@return number, number
function reaper.GetSet_LoopTimeRange(isSet, isLoop, start, end_, allowautoseek) end

---@param proj ReaProject
---@param isSet boolean
---@param isLoop boolean
---@param start number
---@param end_ number
---@param allowautoseek boolean
---@return number, number
function reaper.GetSet_LoopTimeRange2(proj, isSet, isLoop, start, end_, allowautoseek) end

---@param env TrackEnvelope
---@param autoitem_idx integer
---@param desc string
---@param value number
---@param is_set boolean
---@return number
--- Get or set automation item information. autoitem_idx=0 for the first automation item on an envelope, 1 for the second item, etc. desc can be any of the following:
function reaper.GetSetAutomationItemInfo(env, autoitem_idx, desc, value, is_set) end

---@param env TrackEnvelope
---@param autoitem_idx integer
---@param desc string
---@param valuestrNeedBig string
---@param is_set boolean
---@return boolean, string
--- Get or set automation item information. autoitem_idx=0 for the first automation item on an envelope, 1 for the second item, etc. returns true on success. desc can be any of the following:
function reaper.GetSetAutomationItemInfo_String(env, autoitem_idx, desc, valuestrNeedBig, is_set) end

---@param env TrackEnvelope
---@param parmname string
---@param stringNeedBig string
---@param setNewValue boolean
---@return boolean, string
--- Gets/sets an attribute string:
function reaper.GetSetEnvelopeInfo_String(env, parmname, stringNeedBig, setNewValue) end

---@param env TrackEnvelope
---@param str string
---@return boolean, string
--- deprecated -- see
function reaper.GetSetEnvelopeState(env, str) end

---@param env TrackEnvelope
---@param str string
---@param isundo boolean
---@return boolean, string
--- deprecated -- see
function reaper.GetSetEnvelopeState2(env, str, isundo) end

---@param item MediaItem
---@param str string
---@return boolean, string
--- deprecated -- see
function reaper.GetSetItemState(item, str) end

---@param item MediaItem
---@param str string
---@param isundo boolean
---@return boolean, string
--- deprecated -- see
function reaper.GetSetItemState2(item, str, isundo) end

---@param item MediaItem
---@param parmname string
---@param stringNeedBig string
---@param setNewValue boolean
---@return boolean, string
--- Gets/sets an item attribute string:
function reaper.GetSetMediaItemInfo_String(item, parmname, stringNeedBig, setNewValue) end

---@param tk MediaItem_Take
---@param parmname string
---@param stringNeedBig string
---@param setNewValue boolean
---@return boolean, string
--- Gets/sets a take attribute string:
function reaper.GetSetMediaItemTakeInfo_String(tk, parmname, stringNeedBig, setNewValue) end

---@param tr MediaTrack
---@param parmname string
---@param stringNeedBig string
---@param setNewValue boolean
---@return boolean, string
--- Get or set track string attributes.
function reaper.GetSetMediaTrackInfo_String(tr, parmname, stringNeedBig, setNewValue) end

---@param proj ReaProject
---@param set boolean
---@param author string
---@return string
--- GetSetProjectInfo_String
function reaper.GetSetProjectAuthor(proj, set, author) end

---@param project ReaProject
---@param set boolean
---@param division optional number
---@param swingmode optional integer
---@param swingamt optional number
---@return integer, number, integer, number
--- Get or set the arrange view grid division. 0.25=quarter note, 1.0/3.0=half note triplet, etc. swingmode can be 1 for swing enabled, swingamt is -1..1. swingmode can be 3 for measure-grid. Returns grid configuration flags
function reaper.GetSetProjectGrid(project, set, division, swingmode, swingamt) end

---@param project ReaProject
---@param desc string
---@param value number
---@param is_set boolean
---@return number
--- Get or set project information.
function reaper.GetSetProjectInfo(project, desc, value, is_set) end

---@param project ReaProject
---@param desc string
---@param valuestrNeedBig string
---@param is_set boolean
---@return boolean, string
--- Get or set project information.
function reaper.GetSetProjectInfo_String(project, desc, valuestrNeedBig, is_set) end

---@param proj ReaProject
---@param set boolean
---@param notes string
---@return string
--- gets or sets project notes, notesNeedBig_sz is ignored when setting
function reaper.GetSetProjectNotes(proj, set, notes) end

---@param val integer
---@return integer
--- -1 == query,0=clear,1=set,>1=toggle . returns new value
function reaper.GetSetRepeat(val) end

---@param proj ReaProject
---@param val integer
---@return integer
--- -1 == query,0=clear,1=set,>1=toggle . returns new value
function reaper.GetSetRepeatEx(proj, val) end

---@param project ReaProject
---@param point_index integer
---@param flag integer
---@param is_set boolean
---@return integer
--- Gets or sets the attribute flag of a tempo/time signature marker. flag &1=sets time signature and starts new measure, &2=does not set tempo, &4=allow previous partial measure if starting new measure, &8=set new metronome pattern if starting new measure, &16=reset ruler grid if starting new measure
function reaper.GetSetTempoTimeSigMarkerFlag(project, point_index, flag, is_set) end

---@param tr MediaTrack
---@param groupname string
---@param setmask integer
---@param setvalue integer
---@return integer
--- Gets or modifies the group membership for a track. Returns group state prior to call (each bit represents one of the 32 group numbers). if setmask has bits set, those bits in setvalue will be applied to group. Group can be one of:
function reaper.GetSetTrackGroupMembership(tr, groupname, setmask, setvalue) end

---@param tr MediaTrack
---@param groupname string
---@param offset integer
---@param setmask integer
---@param setvalue integer
---@return integer
--- Gets or modifies 32 bits (at offset, where 0 is the low 32 bits of the grouping) of the group membership for a track. Returns group state prior to call. if setmask has bits set, those bits in setvalue will be applied to group. Group can be one of:
function reaper.GetSetTrackGroupMembershipEx(tr, groupname, offset, setmask, setvalue) end

---@param tr MediaTrack
---@param groupname string
---@param setmask integer
---@param setvalue integer
---@return integer
--- Gets or modifies the group membership for a track. Returns group state prior to call (each bit represents one of the high 32 group numbers). if setmask has bits set, those bits in setvalue will be applied to group. Group can be one of:
function reaper.GetSetTrackGroupMembershipHigh(tr, groupname, setmask, setvalue) end

---@param tr MediaTrack
---@param category integer
---@param sendidx integer
---@param parmname string
---@param stringNeedBig string
---@param setNewValue boolean
---@return boolean, string
--- Gets/sets a send attribute string:
function reaper.GetSetTrackSendInfo_String(tr, category, sendidx, parmname, stringNeedBig, setNewValue) end

---@param track MediaTrack
---@param str string
---@return boolean, string
--- deprecated -- see
function reaper.GetSetTrackState(track, str) end

---@param track MediaTrack
---@param str string
---@param isundo boolean
---@return boolean, string
--- deprecated -- see
function reaper.GetSetTrackState2(track, str, isundo) end

---@param src PCM_source
---@return ReaProject
function reaper.GetSubProjectFromSource(src) end

---@param item MediaItem
---@param takeidx integer
---@return MediaItem_Take
--- get a take from an item by take count (zero-based)
function reaper.GetTake(item, takeidx) end

---@param take MediaItem_Take
---@param envidx integer
---@return TrackEnvelope
function reaper.GetTakeEnvelope(take, envidx) end

---@param take MediaItem_Take
---@param envname string
---@return TrackEnvelope
function reaper.GetTakeEnvelopeByName(take, envname) end

---@param take MediaItem_Take
---@param idx integer
---@return number, string, integer
--- Get information about a take marker. Returns the position in media item source time, or -1 if the take marker does not exist. See
function reaper.GetTakeMarker(take, idx) end

---@param take MediaItem_Take
---@return string
--- returns NULL if the take is not valid
function reaper.GetTakeName(take) end

---@param take MediaItem_Take
---@return integer
--- Returns number of stretch markers in take
function reaper.GetTakeNumStretchMarkers(take) end

---@param take MediaItem_Take
---@param idx integer
---@return integer, number, number
--- Gets information on a stretch marker, idx is 0..n. Returns -1 if stretch marker not valid. posOut will be set to position in item, srcposOutOptional will be set to source media position. Returns index. if input index is -1, the following marker is found using position (or source position if position is -1). If position/source position are used to find marker position, their values are not updated.
function reaper.GetTakeStretchMarker(take, idx) end

---@param take MediaItem_Take
---@param idx integer
---@return number
--- SetTakeStretchMarkerSlope
function reaper.GetTakeStretchMarkerSlope(take, idx) end

---@param project ReaProject
---@param track MediaTrack
---@param index integer
---@return boolean, integer, integer
--- Get information about a specific FX parameter knob (see
function reaper.GetTCPFXParm(project, track, index) end

---@param source PCM_source
---@param srcscale number
---@param position number
---@param mult number
---@return boolean, number, number
--- finds the playrate and target length to insert this item stretched to a round power-of-2 number of bars, between 1/8 and 256
function reaper.GetTempoMatchPlayRate(source, srcscale, position, mult) end

---@param proj ReaProject
---@param ptidx integer
---@return boolean, number, integer, number, number, integer, integer, boolean
--- Get information about a tempo/time signature marker. See
function reaper.GetTempoTimeSigMarker(proj, ptidx) end

---@param ini_key string
---@param flags integer
---@return integer
--- Returns the theme color specified, or -1 on failure. If the low bit of flags is set, the color as originally specified by the theme (before any transformations) is returned, otherwise the current (possibly transformed and modified) color is returned. See
function reaper.GetThemeColor(ini_key, flags) end

---@param screen_x integer
---@param screen_y integer
---@return MediaTrack, string
--- Hit tests a point in screen coordinates. Updates infoOut with information such as "arrange", "fx_chain", "fx_0" (first FX in chain, floating), "spacer_0" (spacer before first track). If a track panel is hit, string will begin with "tcp" or "mcp" or "tcp.mute" etc (future versions may append additional information). May return NULL with valid info string to indicate non-track thing.
function reaper.GetThingFromPoint(screen_x, screen_y) end

---@param command_id integer
---@return integer
--- GetToggleCommandStateEx
function reaper.GetToggleCommandState(command_id) end

---@param section_id integer
---@param command_id integer
---@return integer
--- For the main action context, the MIDI editor, or the media explorer, returns the toggle state of the action. 0=off, 1=on, -1=NA because the action does not have on/off states. For the MIDI editor, the action state for the most recently focused window will be returned.
function reaper.GetToggleCommandStateEx(section_id, command_id) end

---@return HWND
--- gets a tooltip window,in case you want to ask it for font information. Can return NULL.
function reaper.GetTooltipWindow() end

---@param mode integer
---@return boolean, integer, integer, integer, integer, integer
--- mode can be 0 to query last touched parameter, or 1 to query currently focused FX. Returns false if failed. If successful, trackIdxOut will be track index (-1 is master track, 0 is first track). itemidxOut will be 0-based item index if an item, or -1 if not an item. takeidxOut will be 0-based take index. fxidxOut will be FX index, potentially with 0x2000000 set to signify container-addressing, or with 0x1000000 set to signify record-input FX. parmOut will be set to the parameter index if querying last-touched. parmOut will have 1 set if querying focused state and FX is no longer focused but still open.
function reaper.GetTouchedOrFocusedFX(mode) end

---@param proj ReaProject
---@param trackidx integer
---@return MediaTrack
--- get a track from a project by track count (zero-based) (proj=0 for active project)
function reaper.GetTrack(proj, trackidx) end

---@param tr MediaTrack
---@return integer
--- return the track mode, regardless of global override
function reaper.GetTrackAutomationMode(tr) end

---@param track MediaTrack
---@return integer
--- Returns the track custom color as OS dependent color|0x1000000 (i.e. ColorToNative(r,g,b)|0x1000000). Black is returned as 0x1000000, no color setting is returned as 0.
function reaper.GetTrackColor(track) end

---@param track MediaTrack
---@return integer
function reaper.GetTrackDepth(track) end

---@param track MediaTrack
---@param envidx integer
---@return TrackEnvelope
function reaper.GetTrackEnvelope(track, envidx) end

---@param tr MediaTrack
---@param cfgchunkname_or_guid string
---@return TrackEnvelope
--- Gets a built-in track envelope by configuration chunk name, like "<VOLENV", or GUID string, like "{B577250D-146F-B544-9B34-F24FBE488F1F}".
function reaper.GetTrackEnvelopeByChunkName(tr, cfgchunkname_or_guid) end

---@param track MediaTrack
---@param envname string
---@return TrackEnvelope
function reaper.GetTrackEnvelopeByName(track, envname) end

---@param screen_x integer
---@param screen_y integer
---@return MediaTrack, integer
--- Returns the track from the screen coordinates specified. If the screen coordinates refer to a window associated to the track (such as FX), the track will be returned. infoOutOptional will be set to 1 if it is likely an envelope, 2 if it is likely a track FX. For a free item positioning or fixed lane track, the second byte of infoOutOptional will be set to the (approximate, for fipm tracks) item lane underneath the mouse. See
function reaper.GetTrackFromPoint(screen_x, screen_y) end

---@param tr MediaTrack
---@return string
function reaper.GetTrackGUID(tr) end

---@param tr MediaTrack
---@param itemidx integer
---@return MediaItem
function reaper.GetTrackMediaItem(tr, itemidx) end

---@param track MediaTrack
---@param flag integer
---@return boolean, string
--- Get all MIDI lyrics on the track. Lyrics will be returned as one string with tabs between each word. flag&1: double tabs at the end of each measure and triple tabs when skipping measures, flag&2: each lyric is preceded by its beat position in the project (example with flag=2: "1.1.2\tLyric for measure 1 beat 2\t2.1.1\tLyric for measure 2 beat 1 "). See
function reaper.GetTrackMIDILyrics(track, flag) end

---@param track integer
---@param pitch integer
---@param chan integer
---@return string
--- GetTrackMIDINoteNameEx
function reaper.GetTrackMIDINoteName(track, pitch, chan) end

---@param proj ReaProject
---@param track MediaTrack
---@param pitch integer
---@param chan integer
---@return string
--- Get note/CC name. pitch 128 for CC0 name, 129 for CC1 name, etc. See
function reaper.GetTrackMIDINoteNameEx(proj, track, pitch, chan) end

---@param proj ReaProject
---@param track MediaTrack
---@return integer, integer
function reaper.GetTrackMIDINoteRange(proj, track) end

---@param track MediaTrack
---@return boolean, string
--- Returns "MASTER" for master track, "Track N" if track has no name.
function reaper.GetTrackName(track) end

---@param tr MediaTrack
---@return integer
function reaper.GetTrackNumMediaItems(tr) end

---@param tr MediaTrack
---@param category integer
---@return integer
--- returns number of sends/receives/hardware outputs - category is 0 for hardware outputs
function reaper.GetTrackNumSends(tr, category) end

---@param track MediaTrack
---@param recv_index integer
---@return boolean, string
--- GetTrackSendName
function reaper.GetTrackReceiveName(track, recv_index) end

---@param track MediaTrack
---@param recv_index integer
---@return boolean, boolean
--- GetTrackSendUIMute
function reaper.GetTrackReceiveUIMute(track, recv_index) end

---@param track MediaTrack
---@param recv_index integer
---@return boolean, number, number
--- GetTrackSendUIVolPan
function reaper.GetTrackReceiveUIVolPan(track, recv_index) end

---@param tr MediaTrack
---@param category integer
---@param sendidx integer
---@param parmname string
---@return number
--- Get send/receive/hardware output numerical-value attributes.
function reaper.GetTrackSendInfo_Value(tr, category, sendidx, parmname) end

---@param track MediaTrack
---@param send_index integer
---@return boolean, string
--- send_idx>=0 for hw ouputs, >=nb_of_hw_ouputs for sends. See
function reaper.GetTrackSendName(track, send_index) end

---@param track MediaTrack
---@param send_index integer
---@return boolean, boolean
--- send_idx>=0 for hw ouputs, >=nb_of_hw_ouputs for sends. See
function reaper.GetTrackSendUIMute(track, send_index) end

---@param track MediaTrack
---@param send_index integer
---@return boolean, number, number
--- send_idx>=0 for hw ouputs, >=nb_of_hw_ouputs for sends. See
function reaper.GetTrackSendUIVolPan(track, send_index) end

---@param track MediaTrack
---@return string, integer
--- Gets track state, returns track name.
function reaper.GetTrackState(track) end

---@param track MediaTrack
---@param str string
---@param isundo boolean
---@return boolean, string
--- Gets the RPPXML state of a track, returns true if successful. Undo flag is a performance/caching hint.
function reaper.GetTrackStateChunk(track, str, isundo) end

---@param track MediaTrack
---@return boolean, boolean
function reaper.GetTrackUIMute(track) end

---@param track MediaTrack
---@return boolean, number, number, integer
function reaper.GetTrackUIPan(track) end

---@param track MediaTrack
---@return boolean, number, number
function reaper.GetTrackUIVolPan(track) end

---@return integer, integer, integer
--- retrieves the last timestamps of audio xrun (yellow-flash, if available), media xrun (red-flash), and the current time stamp (all milliseconds)
function reaper.GetUnderrunTime() end

---@param filenameNeed4096 string
---@param title string
---@param defext string
---@return boolean, string
--- returns true if the user selected a valid file, false if the user canceled the dialog
function reaper.GetUserFileNameForRead(filenameNeed4096, title, defext) end

---@param title string
---@param num_inputs integer
---@param captions_csv string
---@param retvals_csv string
---@return boolean, string
--- Get values from the user.
function reaper.GetUserInputs(title, num_inputs, captions_csv, retvals_csv) end

---@param proj ReaProject
---@param marker_index integer
---@param use_timeline_order boolean
--- Go to marker. If use_timeline_order==true, marker_index 1 refers to the first marker on the timeline. If use_timeline_order==false, marker_index 1 refers to the first marker with the user-editable index of 1.
function reaper.GoToMarker(proj, marker_index, use_timeline_order) end

---@param proj ReaProject
---@param region_index integer
---@param use_timeline_order boolean
--- Seek to region after current region finishes playing (smooth seek). If use_timeline_order==true, region_index 1 refers to the first region on the timeline. If use_timeline_order==false, region_index 1 refers to the first region with the user-editable index of 1.
function reaper.GoToRegion(proj, region_index, use_timeline_order) end

---@param hwnd HWND
---@return integer, integer
--- Runs the system color chooser dialog. Returns 0 if the user cancels the dialog.
function reaper.GR_SelectColor(hwnd) end

---@param t integer
---@return integer
--- this is just like win32 GetSysColor() but can have overrides.
function reaper.GSC_mainwnd(t) end

---@param gGUID string
---@param destNeed64 string
---@return string
--- dest should be at least 64 chars long to be safe
function reaper.guidToString(gGUID, destNeed64) end

---@param section string
---@param key string
---@return boolean
--- Returns true if there exists an extended state value for a specific section and key. See
function reaper.HasExtState(section, key) end

---@param track integer
---@return string
--- returns name of track plugin that is supplying MIDI programs,or NULL if there is none
function reaper.HasTrackMIDIPrograms(track) end

---@param proj ReaProject
---@param track MediaTrack
---@return string
--- returns name of track plugin that is supplying MIDI programs,or NULL if there is none
function reaper.HasTrackMIDIProgramsEx(proj, track) end

---@param helpstring string
---@param is_temporary_help boolean
function reaper.Help_Set(helpstring, is_temporary_help) end

---@param in_ string
---@param out string
---@return string
function reaper.image_resolve_fn(in_, out) end

---@param env TrackEnvelope
---@param pool_id integer
---@param position number
---@param length number
---@return integer
--- Insert a new automation item. pool_id = 0 the automation item will be a new instance of that pool (which will be created as an empty instance if it does not exist). Returns the index of the item, suitable for passing to other automation item API functions. See
function reaper.InsertAutomationItem(env, pool_id, position, length) end

---@param envelope TrackEnvelope
---@param time number
---@param value number
---@param shape integer
---@param tension number
---@param selected boolean
---@param noSortIn optional boolean
---@return boolean
--- Insert an envelope point. If setting multiple points at once, set noSort=true, and call Envelope_SortPoints when done. See
function reaper.InsertEnvelopePoint(envelope, time, value, shape, tension, selected, noSortIn) end

---@param envelope TrackEnvelope
---@param autoitem_idx integer
---@param time number
---@param value number
---@param shape integer
---@param tension number
---@param selected boolean
---@param noSortIn optional boolean
---@return boolean
--- Insert an envelope point. If setting multiple points at once, set noSort=true, and call Envelope_SortPoints when done.
function reaper.InsertEnvelopePointEx(envelope, autoitem_idx, time, value, shape, tension, selected, noSortIn) end

---@param file string
---@param mode integer
---@return integer
--- mode: 0=add to current track, 1=add new track, 3=add to selected items as takes, &4=stretch/loop to fit time sel, &8=try to match tempo 1x, &16=try to match tempo 0.5x, &32=try to match tempo 2x, &64=don't preserve pitch when matching tempo, &128=no loop/section if startpct/endpct set, &256=force loop regardless of global preference for looping imported items, &512=use high word as absolute track index if mode&3==0 or mode&2048, &1024=insert into reasamplomatic on a new track (add 1 to insert on last selected track), &2048=insert into open reasamplomatic instance (add 512 to use high word as absolute track index), &4096=move to source preferred position (BWF start offset), &8192=reverse. &16384=apply ripple according to project setting
function reaper.InsertMedia(file, mode) end

---@param file string
---@param mode integer
---@param startpct number
---@param endpct number
---@param pitchshift number
---@return integer
function reaper.InsertMediaSection(file, mode, startpct, endpct, pitchshift) end

---@param idx integer
---@param wantDefaults boolean
--- inserts a track at idx,of course this will be clamped to 0..GetNumTracks(). wantDefaults=TRUE for default envelopes/FX,otherwise no enabled fx/env. Superseded, see
function reaper.InsertTrackAtIndex(idx, wantDefaults) end

---@param proj ReaProject
---@param idx integer
---@param flags integer
--- inserts a track in project proj at idx, this will be clamped to 0..CountTracks(proj). flags&1 for default envelopes/FX, otherwise no enabled fx/envelopes will be added.
function reaper.InsertTrackInProject(proj, idx, flags) end

---@param ext string
---@param wantOthers boolean
---@return boolean
--- Tests a file extension (i.e. "wav" or "mid") to see if it's a media extension.
function reaper.IsMediaExtension(ext, wantOthers) end

---@param item MediaItem
---@return boolean
function reaper.IsMediaItemSelected(item) end

---@param proj ReaProject
---@return integer
--- Is the project dirty (needing save)? Always returns 0 if 'undo/prompt to save' is disabled in preferences.
function reaper.IsProjectDirty(proj) end

---@param track MediaTrack
---@return boolean
function reaper.IsTrackSelected(track) end

---@param track MediaTrack
---@param mixer boolean
---@return boolean
--- If mixer==true, returns true if the track is visible in the mixer. If mixer==false, returns true if the track is visible in the track control panel.
function reaper.IsTrackVisible(track, mixer) end

---@param guidGUID string
---@return joystick_device
--- creates a joystick device
function reaper.joystick_create(guidGUID) end

---@param device joystick_device
--- destroys a joystick device
function reaper.joystick_destroy(device) end

---@param index integer
---@return string, string
--- enumerates installed devices, returns GUID as a string
function reaper.joystick_enum(index) end

---@param dev joystick_device
---@param axis integer
---@return number
--- returns axis value (-1..1)
function reaper.joystick_getaxis(dev, axis) end

---@param dev joystick_device
---@return integer
--- returns button pressed mask, 1=first button, 2=second...
function reaper.joystick_getbuttonmask(dev) end

---@param dev joystick_device
---@return integer, integer, integer
--- returns button count
function reaper.joystick_getinfo(dev) end

---@param dev joystick_device
---@param pov integer
---@return number
--- returns POV value (usually 0..655.35, or 655.35 on error)
function reaper.joystick_getpov(dev, pov) end

---@param dev joystick_device
---@return boolean
--- Updates joystick state from hardware, returns true if successful (joystick_get* will not be valid until joystick_update() is called successfully)
function reaper.joystick_update(dev) end

---@param section KbdSectionInfo
---@param idx integer
---@return integer, string
function reaper.kbd_enumerateActions(section, idx) end

---@param cmd integer
---@param section KbdSectionInfo
---@return string
function reaper.kbd_getTextFromCmd(cmd, section) end

---@param pX1 integer
---@param pY1 integer
---@param pX2 integer
---@param pY2 integer
---@param xLo integer
---@param yLo integer
---@param xHi integer
---@param yHi integer
---@return boolean, integer, integer, integer, integer
--- Returns false if the line is entirely offscreen.
function reaper.LICE_ClipLine(pX1, pY1, pX2, pY2, xLo, yLo, xHi, yHi) end

---@param src_string string
---@param section string
---@param flags integer
---@return string
--- Returns a localized version of src_string, in section section. flags can have 1 set to only localize if sprintf-style formatting matches the original.
function reaper.LocalizeString(src_string, section, flags) end

---@param project ReaProject
---@param direction integer
---@return boolean
--- Move the loop selection left or right. Returns true if snap is enabled.
function reaper.Loop_OnArrow(project, direction) end

---@param command integer
---@param flag integer
--- Main_OnCommandEx
function reaper.Main_OnCommand(command, flag) end

---@param command integer
---@param flag integer
---@param proj ReaProject
--- Performs an action belonging to the main action section. To perform non-native actions (ReaScripts, custom or extension plugins' actions) safely, see
function reaper.Main_OnCommandEx(command, flag, proj) end

---@param name string
--- opens a project. will prompt the user to save unless name is prefixed with 'noprompt:'. If name is prefixed with 'template:', project file will be loaded as a template.
function reaper.Main_openProject(name) end

---@param proj ReaProject
---@param forceSaveAsIn boolean
--- Save the project.
function reaper.Main_SaveProject(proj, forceSaveAsIn) end

---@param proj ReaProject
---@param filename string
---@param options integer
--- Save the project. options: &1=save selected tracks as track template, &2=include media with track template, &4=include envelopes with track template, &8=if not saving template, set as the new project filename for this ReaProject. See
function reaper.Main_SaveProjectEx(proj, filename, options) end

---@param ignoremask integer
function reaper.Main_UpdateLoopInfo(ignoremask) end

---@param proj ReaProject
--- Marks project as dirty (needing save) if 'undo/prompt to save' is enabled in preferences.
function reaper.MarkProjectDirty(proj) end

---@param track MediaTrack
---@param item MediaItem
--- If track is supplied, item is ignored
function reaper.MarkTrackItemsDirty(track, item) end

---@param project ReaProject
---@return number
function reaper.Master_GetPlayRate(project) end

---@param time_s number
---@param proj ReaProject
---@return number
function reaper.Master_GetPlayRateAtTime(time_s, proj) end

---@return number
function reaper.Master_GetTempo() end

---@param playrate number
---@param isnormalized boolean
---@return number
--- Convert play rate to/from a value between 0 and 1, representing the position on the project playrate slider.
function reaper.Master_NormalizePlayRate(playrate, isnormalized) end

---@param bpm number
---@param isnormalized boolean
---@return number
--- Convert the tempo to/from a value between 0 and 1, representing bpm in the range of 40-296 bpm.
function reaper.Master_NormalizeTempo(bpm, isnormalized) end

---@param msg string
---@param title string
---@param type integer
---@return integer
--- type 0=OK,1=OKCANCEL,2=ABORTRETRYIGNORE,3=YESNOCANCEL,4=YESNO,5=RETRYCANCEL : ret 1=OK,2=CANCEL,3=ABORT,4=RETRY,5=IGNORE,6=YES,7=NO
function reaper.MB(msg, title, type) end

---@return boolean, string, integer, number, number, number, number, number, number, string
--- Get information about the most recently previewed Media Explorer file. filename: last played file name. filemode: &1:insert on new track, &2:insert into sampler, &8:tempo sync 1x, &16:tempo sync 0.5x, &32:tempo sync 2x, &64:do not preserve pitch when changing playrate, &128:loop selection exists, &256:time selection exists, &512:apply pitch/rate adjustment on insert, &1024:apply volume adjustment on insert, &2048:apply normalization on insert, &8192:reverse preview. startpct/endpct: time selection in [0.0, 1.0]. pitchshift/voladj/rateadj: current pitch/volume/playrate preview adjustments. srcbpm: source media tempo. extrainfo: currently unused.
function reaper.MediaExplorerGetLastPlayedFileInfo() end

---@param item MediaItem
---@param track MediaTrack
---@return integer
--- Returns 1 if the track holds the item, 2 if the track is a folder containing the track that holds the item, etc.
function reaper.MediaItemDescendsFromTrack(item, track) end

---@param menuname string
---@param flag integer
---@return boolean, string
--- Get a string that only changes when menu/toolbar entries are added or removed (not re-ordered). Can be used to determine if a customized menu/toolbar differs from the default, or if the default changed after a menu/toolbar was customized. flag==0: current default menu/toolbar; flag==1: current customized menu/toolbar; flag==2: default menu/toolbar at the time the current menu/toolbar was most recently customized, if it was customized in REAPER v7.08 or later.
function reaper.Menu_GetHash(menuname, flag) end

---@param take MediaItem_Take
---@return integer, integer, integer, integer
--- Count the number of notes, CC events, and text/sysex events in a given MIDI item.
function reaper.MIDI_CountEvts(take) end

---@param take MediaItem_Take
---@param ccidx integer
---@return boolean
--- Delete a MIDI CC event.
function reaper.MIDI_DeleteCC(take, ccidx) end

---@param take MediaItem_Take
---@param evtidx integer
---@return boolean
--- Delete a MIDI event.
function reaper.MIDI_DeleteEvt(take, evtidx) end

---@param take MediaItem_Take
---@param noteidx integer
---@return boolean
--- Delete a MIDI note.
function reaper.MIDI_DeleteNote(take, noteidx) end

---@param take MediaItem_Take
---@param textsyxevtidx integer
---@return boolean
--- Delete a MIDI text or sysex event.
function reaper.MIDI_DeleteTextSysexEvt(take, textsyxevtidx) end

---@param take MediaItem_Take
--- Disable sorting for all MIDI insert, delete, get and set functions, until MIDI_Sort is called.
function reaper.MIDI_DisableSort(take) end

---@param take MediaItem_Take
---@param ccidx integer
---@return integer
--- Returns the index of the next selected MIDI CC event after ccidx (-1 if there are no more selected events).
function reaper.MIDI_EnumSelCC(take, ccidx) end

---@param take MediaItem_Take
---@param evtidx integer
---@return integer
--- Returns the index of the next selected MIDI event after evtidx (-1 if there are no more selected events).
function reaper.MIDI_EnumSelEvts(take, evtidx) end

---@param take MediaItem_Take
---@param noteidx integer
---@return integer
--- Returns the index of the next selected MIDI note after noteidx (-1 if there are no more selected events).
function reaper.MIDI_EnumSelNotes(take, noteidx) end

---@param take MediaItem_Take
---@param textsyxidx integer
---@return integer
--- Returns the index of the next selected MIDI text/sysex event after textsyxidx (-1 if there are no more selected events).
function reaper.MIDI_EnumSelTextSysexEvts(take, textsyxidx) end

---@param take MediaItem_Take
---@return boolean, string
--- Get all MIDI data. MIDI buffer is returned as a list of { int offset, char flag, int msglen, unsigned char msg[] }.
function reaper.MIDI_GetAllEvts(take) end

---@param take MediaItem_Take
---@param ccidx integer
---@return boolean, boolean, boolean, number, integer, integer, integer, integer
--- Get MIDI CC event properties.
function reaper.MIDI_GetCC(take, ccidx) end

---@param take MediaItem_Take
---@param ccidx integer
---@return boolean, integer, number
--- Get CC shape and bezier tension. See
function reaper.MIDI_GetCCShape(take, ccidx) end

---@param take MediaItem_Take
---@param evtidx integer
---@return boolean, boolean, boolean, number, string
--- Get MIDI event properties.
function reaper.MIDI_GetEvt(take, evtidx) end

---@param take MediaItem_Take
---@return number, number, number
--- Returns the most recent MIDI editor grid size for this MIDI take, in QN. Swing is between 0 and 1. Note length is 0 if it follows the grid size.
function reaper.MIDI_GetGrid(take) end

---@param take MediaItem_Take
---@param notesonly boolean
---@return boolean, string
--- Get a string that only changes when the MIDI data changes. If notesonly==true, then the string changes only when the MIDI notes change. See
function reaper.MIDI_GetHash(take, notesonly) end

---@param take MediaItem_Take
---@param noteidx integer
---@return boolean, boolean, boolean, number, number, integer, integer, integer
--- Get MIDI note properties.
function reaper.MIDI_GetNote(take, noteidx) end

---@param take MediaItem_Take
---@param ppqpos number
---@return number
--- Returns the MIDI tick (ppq) position corresponding to the end of the measure.
function reaper.MIDI_GetPPQPos_EndOfMeasure(take, ppqpos) end

---@param take MediaItem_Take
---@param ppqpos number
---@return number
--- Returns the MIDI tick (ppq) position corresponding to the start of the measure.
function reaper.MIDI_GetPPQPos_StartOfMeasure(take, ppqpos) end

---@param take MediaItem_Take
---@param projqn number
---@return number
--- Returns the MIDI tick (ppq) position corresponding to a specific project time in quarter notes.
function reaper.MIDI_GetPPQPosFromProjQN(take, projqn) end

---@param take MediaItem_Take
---@param projtime number
---@return number
--- Returns the MIDI tick (ppq) position corresponding to a specific project time in seconds.
function reaper.MIDI_GetPPQPosFromProjTime(take, projtime) end

---@param take MediaItem_Take
---@param ppqpos number
---@return number
--- Returns the project time in quarter notes corresponding to a specific MIDI tick (ppq) position.
function reaper.MIDI_GetProjQNFromPPQPos(take, ppqpos) end

---@param take MediaItem_Take
---@param ppqpos number
---@return number
--- Returns the project time in seconds corresponding to a specific MIDI tick (ppq) position.
function reaper.MIDI_GetProjTimeFromPPQPos(take, ppqpos) end

---@param idx integer
---@return integer, string, integer, integer, number, integer
--- Gets a recent MIDI input event from the global history. idx=0 for the most recent event, which also latches to the latest MIDI event state (to get a more recent list, calling with idx=0 is necessary). idx=1 next most recent event, returns a non-zero sequence number for the event, or zero if no more events. tsOut will be set to the timestamp in samples relative to the current position (0 is current, -48000 is one second ago, etc). devIdxOut will have the low 16 bits set to the input device index, and 0x10000 will be set if device was enabled only for control. projPosOut will be set to project position in seconds if project was playing back at time of event, otherwise -1. Large SysEx events will not be included in this event list.
function reaper.MIDI_GetRecentInputEvent(idx) end

---@param take MediaItem_Take
---@return boolean, integer, integer, string
--- Get the active scale in the media source, if any. root 0=C, 1=C#, etc. scale &0x1=root, &0x2=minor 2nd, &0x4=major 2nd, &0x8=minor 3rd, &0xF=fourth, etc.
function reaper.MIDI_GetScale(take) end

---@param take MediaItem_Take
---@param textsyxevtidx integer
---@param selected optional boolean
---@param muted optional boolean
---@param ppqpos optional number
---@param type optional integer
---@param msg optional string
---@return boolean, boolean, boolean, number, integer, string
--- Get MIDI meta-event properties. Allowable types are -1:sysex (msg should not include bounding F0..F7), 1-14:MIDI text event types, 15=REAPER notation event. For all other meta-messages, type is returned as -2 and msg returned as all zeroes. See
function reaper.MIDI_GetTextSysexEvt(take, textsyxevtidx, selected, muted, ppqpos, type, msg) end

---@param track MediaTrack
---@param notesonly boolean
---@return boolean, string
--- Get a string that only changes when the MIDI data changes. If notesonly==true, then the string changes only when the MIDI notes change. See
function reaper.MIDI_GetTrackHash(track, notesonly) end

---@param force_reinit_input integer
---@param force_reinit_output integer
--- Opens MIDI devices as configured in preferences. force_reinit_input and force_reinit_output force a particular device index to close/re-open (pass -1 to not force any devices to reopen).
function reaper.midi_init(force_reinit_input, force_reinit_output) end

---@param take MediaItem_Take
---@param selected boolean
---@param muted boolean
---@param ppqpos number
---@param chanmsg integer
---@param chan integer
---@param msg2 integer
---@param msg3 integer
---@return boolean
--- Insert a new MIDI CC event.
function reaper.MIDI_InsertCC(take, selected, muted, ppqpos, chanmsg, chan, msg2, msg3) end

---@param take MediaItem_Take
---@param selected boolean
---@param muted boolean
---@param ppqpos number
---@param bytestr string
---@return boolean
--- Insert a new MIDI event.
function reaper.MIDI_InsertEvt(take, selected, muted, ppqpos, bytestr) end

---@param take MediaItem_Take
---@param selected boolean
---@param muted boolean
---@param startppqpos number
---@param endppqpos number
---@param chan integer
---@param pitch integer
---@param vel integer
---@param noSortIn optional boolean
---@return boolean
--- Insert a new MIDI note. Set noSort if inserting multiple events, then call MIDI_Sort when done.
function reaper.MIDI_InsertNote(take, selected, muted, startppqpos, endppqpos, chan, pitch, vel, noSortIn) end

---@param take MediaItem_Take
---@param selected boolean
---@param muted boolean
---@param ppqpos number
---@param type integer
---@param bytestr string
---@return boolean
--- Insert a new MIDI text or sysex event. Allowable types are -1:sysex (msg should not include bounding F0..F7), 1-14:MIDI text event types, 15=REAPER notation event.
function reaper.MIDI_InsertTextSysexEvt(take, selected, muted, ppqpos, type, bytestr) end

---@param tk MediaItem_Take
--- Synchronously updates any open MIDI editors for MIDI take
function reaper.MIDI_RefreshEditors(tk) end

--- Reset (close and re-open) all MIDI devices
function reaper.midi_reinit() end

---@param take MediaItem_Take
---@param select boolean
--- Select or deselect all MIDI content.
function reaper.MIDI_SelectAll(take, select) end

---@param take MediaItem_Take
---@param buf string
---@return boolean
--- Set all MIDI data. MIDI buffer is passed in as a list of { int offset, char flag, int msglen, unsigned char msg[] }.
function reaper.MIDI_SetAllEvts(take, buf) end

---@param take MediaItem_Take
---@param ccidx integer
---@param selectedIn optional boolean
---@param mutedIn optional boolean
---@param ppqposIn optional number
---@param chanmsgIn optional integer
---@param chanIn optional integer
---@param msg2In optional integer
---@param msg3In optional integer
---@param noSortIn optional boolean
---@return boolean
--- Set MIDI CC event properties. Properties passed as NULL will not be set. set noSort if setting multiple events, then call MIDI_Sort when done.
function reaper.MIDI_SetCC(take, ccidx, selectedIn, mutedIn, ppqposIn, chanmsgIn, chanIn, msg2In, msg3In, noSortIn) end

---@param take MediaItem_Take
---@param ccidx integer
---@param shape integer
---@param beztension number
---@param noSortIn optional boolean
---@return boolean
--- Set CC shape and bezier tension. set noSort if setting multiple events, then call MIDI_Sort when done. See
function reaper.MIDI_SetCCShape(take, ccidx, shape, beztension, noSortIn) end

---@param take MediaItem_Take
---@param evtidx integer
---@param selectedIn optional boolean
---@param mutedIn optional boolean
---@param ppqposIn optional number
---@param msg optional string
---@param noSortIn optional boolean
---@return boolean
--- Set MIDI event properties. Properties passed as NULL will not be set. set noSort if setting multiple events, then call MIDI_Sort when done.
function reaper.MIDI_SetEvt(take, evtidx, selectedIn, mutedIn, ppqposIn, msg, noSortIn) end

---@param item MediaItem
---@param startQN number
---@param endQN number
---@return boolean
--- Set the start/end positions of a media item that contains a MIDI take.
function reaper.MIDI_SetItemExtents(item, startQN, endQN) end

---@param take MediaItem_Take
---@param noteidx integer
---@param selectedIn optional boolean
---@param mutedIn optional boolean
---@param startppqposIn optional number
---@param endppqposIn optional number
---@param chanIn optional integer
---@param pitchIn optional integer
---@param velIn optional integer
---@param noSortIn optional boolean
---@return boolean
--- Set MIDI note properties. Properties passed as NULL (or negative values) will not be set. Set noSort if setting multiple events, then call MIDI_Sort when done. Setting multiple note start positions at once is done more safely by deleting and re-inserting the notes.
function reaper.MIDI_SetNote(take, noteidx, selectedIn, mutedIn, startppqposIn, endppqposIn, chanIn, pitchIn, velIn, noSortIn) end

---@param take MediaItem_Take
---@param textsyxevtidx integer
---@param selectedIn optional boolean
---@param mutedIn optional boolean
---@param ppqposIn optional number
---@param typeIn optional integer
---@param msg optional string
---@param noSortIn optional boolean
---@return boolean
--- Set MIDI text or sysex event properties. Properties passed as NULL will not be set. Allowable types are -1:sysex (msg should not include bounding F0..F7), 1-14:MIDI text event types, 15=REAPER notation event. set noSort if setting multiple events, then call MIDI_Sort when done.
function reaper.MIDI_SetTextSysexEvt(take, textsyxevtidx, selectedIn, mutedIn, ppqposIn, typeIn, msg, noSortIn) end

---@param take MediaItem_Take
--- Sort MIDI events after multiple calls to MIDI_SetNote, MIDI_SetCC, etc.
function reaper.MIDI_Sort(take) end

---@param midieditor HWND
---@param takeindex integer
---@param editable_only boolean
---@return MediaItem_Take
--- list the takes that are currently being edited in this MIDI editor, starting with the active take. See
function reaper.MIDIEditor_EnumTakes(midieditor, takeindex, editable_only) end

---@return HWND
--- get a pointer to the focused MIDI editor window
function reaper.MIDIEditor_GetActive() end

---@param midieditor HWND
---@return integer
--- get the mode of a MIDI editor (0=piano roll, 1=event list, -1=invalid editor)
function reaper.MIDIEditor_GetMode(midieditor) end

---@param midieditor HWND
---@param setting_desc string
---@return integer
--- Get settings from a MIDI editor. setting_desc can be:
function reaper.MIDIEditor_GetSetting_int(midieditor, setting_desc) end

---@param midieditor HWND
---@param setting_desc string
---@return boolean, string
--- Get settings from a MIDI editor. setting_desc can be:
function reaper.MIDIEditor_GetSetting_str(midieditor, setting_desc) end

---@param midieditor HWND
---@return MediaItem_Take
--- get the take that is currently being edited in this MIDI editor. see
function reaper.MIDIEditor_GetTake(midieditor) end

---@param command_id integer
---@param islistviewcommand boolean
---@return boolean
--- Send an action command to the last focused MIDI editor. Returns false if there is no MIDI editor open, or if the view mode (piano roll or event list) does not match the input.
function reaper.MIDIEditor_LastFocused_OnCommand(command_id, islistviewcommand) end

---@param midieditor HWND
---@param command_id integer
---@return boolean
--- Send an action command to a MIDI editor. Returns false if the supplied MIDI editor pointer is not valid (not an open MIDI editor).
function reaper.MIDIEditor_OnCommand(midieditor, command_id) end

---@param midieditor HWND
---@param setting_desc string
---@param setting integer
---@return boolean
--- Set settings for a MIDI editor. setting_desc can be:
function reaper.MIDIEditor_SetSetting_int(midieditor, setting_desc, setting) end

---@param track MediaTrack
---@param pitchwheelrange integer
---@param flags integer
---@param is_set boolean
---@return integer, integer
--- Get or set MIDI editor settings for this track. pitchwheelrange: semitones up or down. flags &1: snap pitch lane edits to semitones if pitchwheel range is defined.
function reaper.MIDIEditorFlagsForTrack(track, pitchwheelrange, flags, is_set) end

---@param strNeed64 string
---@param pan number
---@return string
function reaper.mkpanstr(strNeed64, pan) end

---@param strNeed64 string
---@param vol number
---@param pan number
---@return string
function reaper.mkvolpanstr(strNeed64, vol, pan) end

---@param strNeed64 string
---@param vol number
---@return string
function reaper.mkvolstr(strNeed64, vol) end

---@param adjamt number
---@param dosel boolean
function reaper.MoveEditCursor(adjamt, dosel) end

---@param item MediaItem
---@param desttr MediaTrack
---@return boolean
--- returns TRUE if move succeeded
function reaper.MoveMediaItemToTrack(item, desttr) end

---@param mute boolean
function reaper.MuteAllTracks(mute) end

---@param wantWorkArea boolean
function reaper.my_getViewport(wantWorkArea) end

---@param command_name string
---@return integer
--- Get the command ID number for named command that was registered by an extension such as "_SWS_ABOUT" or "_113088d11ae641c193a2b7ede3041ad5" for a ReaScript or a custom action.
function reaper.NamedCommandLookup(command_name) end

--- direct way to simulate pause button hit
function reaper.OnPauseButton() end

---@param proj ReaProject
--- direct way to simulate pause button hit
function reaper.OnPauseButtonEx(proj) end

--- direct way to simulate play button hit
function reaper.OnPlayButton() end

---@param proj ReaProject
--- direct way to simulate play button hit
function reaper.OnPlayButtonEx(proj) end

--- direct way to simulate stop button hit
function reaper.OnStopButton() end

---@param proj ReaProject
--- direct way to simulate stop button hit
function reaper.OnStopButtonEx(proj) end

---@param fn string
---@return boolean
function reaper.OpenColorThemeFile(fn) end

---@param mediafn string
---@param play boolean
---@return HWND
--- Opens mediafn in the Media Explorer, play=true will play the file immediately (or toggle playback if mediafn was already open), =false will just select it.
function reaper.OpenMediaExplorer(mediafn, play) end

---@param message string
---@param valueIn optional number
--- Send an OSC message directly to REAPER. The value argument may be NULL. The message will be matched against the default OSC patterns.
function reaper.OscLocalMessageToHost(message, valueIn) end

---@param buf string
---@return number
--- Parse hh:mm:ss.sss time string, return time in seconds (or 0.0 on error). See
function reaper.parse_timestr(buf) end

---@param buf string
---@param offset number
---@param modeoverride integer
---@return number
--- time formatting mode overrides: -1=proj default.
function reaper.parse_timestr_len(buf, offset, modeoverride) end

---@param buf string
---@param modeoverride integer
---@return number
--- Parse time string, time formatting mode overrides: -1=proj default.
function reaper.parse_timestr_pos(buf, modeoverride) end

---@param str string
---@return number
function reaper.parsepanstr(str) end

---@param idx integer
---@return integer, string
function reaper.PCM_Sink_Enum(idx) end

---@param data string
---@return string
function reaper.PCM_Sink_GetExtension(data) end

---@param cfg string
---@param hwndParent HWND
---@return HWND
function reaper.PCM_Sink_ShowConfig(cfg, hwndParent) end

---@param src PCM_source
---@param mode integer
---@return integer
--- Calls and returns PCM_source::PeaksBuild_Begin() if mode=0, PeaksBuild_Run() if mode=1, and PeaksBuild_Finish() if mode=2. Normal use is to call PCM_Source_BuildPeaks(src,0), and if that returns nonzero, call PCM_Source_BuildPeaks(src,1) periodically until it returns zero (it returns the percentage of the file remaining), then call PCM_Source_BuildPeaks(src,2) to finalize. If PCM_Source_BuildPeaks(src,0) returns zero, then no further action is necessary.
function reaper.PCM_Source_BuildPeaks(src, mode) end

---@param filename string
---@return PCM_source
--- PCM_Source_CreateFromFileEx
function reaper.PCM_Source_CreateFromFile(filename) end

---@param filename string
---@param forcenoMidiImp boolean
---@return PCM_source
--- Create a PCM_source from filename, and override pref of MIDI files being imported as in-project MIDI events.
function reaper.PCM_Source_CreateFromFileEx(filename, forcenoMidiImp) end

---@param sourcetype string
---@return PCM_source
--- Create a PCM_source from a "type" (use this if you're going to load its state via LoadState/ProjectStateContext).
function reaper.PCM_Source_CreateFromType(sourcetype) end

---@param src PCM_source
--- Deletes a PCM_source -- be sure that you remove any project reference before deleting a source
function reaper.PCM_Source_Destroy(src) end

---@param src PCM_source
---@param peakrate number
---@param starttime number
---@param numchannels integer
---@param numsamplesperchannel integer
---@param want_extra_type integer
---@param buf reaper.array
---@return integer
--- Gets block of peak samples to buf. Note that the peak samples are interleaved, but in two or three blocks (maximums, then minimums, then extra). Return value has 20 bits of returned sample count, then 4 bits of output_mode (0xf00000), then a bit to signify whether extra_type was available (0x1000000). extra_type can be 115 ('s') for spectral information, which will return peak samples as integers with the low 15 bits frequency, next 14 bits tonality.
function reaper.PCM_Source_GetPeaks(src, peakrate, starttime, numchannels, numsamplesperchannel, want_extra_type, buf) end

---@param src PCM_source
---@return boolean, number, number, boolean
--- If a section/reverse block, retrieves offset/len/reverse. return true if success
function reaper.PCM_Source_GetSectionInfo(src) end

---@param amt integer
function reaper.PluginWantsAlwaysRunFx(amt) end

---@param prevent_count integer
--- adds prevent_count to the UI refresh prevention state; always add then remove the same amount, or major disfunction will occur
function reaper.PreventUIRefresh(prevent_count) end

---@param session_mode integer
---@param init_id integer
---@param section_id integer
---@return integer
--- Uses the action list to choose an action. Call with session_mode=1 to create a session (init_id will be the initial action to select, or 0), then poll with session_mode=0, checking return value for user-selected action (will return 0 if no action selected yet, or -1 if the action window is no longer available). When finished, call with session_mode=-1.
function reaper.PromptForAction(session_mode, init_id, section_id) end

---@param errmsg string
--- Causes REAPER to display the error message after the current ReaScript finishes. If called within a Lua context and errmsg has a ! prefix, script execution will be terminated.
function reaper.ReaScriptError(errmsg) end

---@param path string
---@param ignored integer
---@return integer
--- returns positive value on success, 0 on failure.
function reaper.RecursiveCreateDirectory(path, ignored) end

---@param flags integer
---@return integer
--- garbage-collects extra open files and closes them. if flags has 1 set, this is done incrementally (call this from a regular timer, if desired). if flags has 2 set, files are aggressively closed (they may need to be re-opened very soon). returns number of files closed by this call.
function reaper.reduce_open_files(flags) end

---@param command_id integer
function reaper.RefreshToolbar(command_id) end

---@param section_id integer
---@param command_id integer
--- Refresh the toolbar button states of a toggle action.
function reaper.RefreshToolbar2(section_id, command_id) end

---@param in_ string
---@param out string
---@return string
--- Makes a filename "in" relative to the current project, if any.
function reaper.relative_fn(in_, out) end

---@param tr MediaTrack
---@param category integer
---@param sendidx integer
---@return boolean
--- Remove a send/receive/hardware output, return true on success. category is 0 for hardware outputs. See
function reaper.RemoveTrackSend(tr, category, sendidx) end

---@param source_filename string
---@param target_filename string
---@param start_percent number
---@param end_percent number
---@param playrate number
---@return boolean
--- Not available while playing back.
function reaper.RenderFileSection(source_filename, target_filename, start_percent, end_percent, playrate) end

---@param beforeTrackIdx integer
---@param makePrevFolder integer
---@return boolean
--- Moves all selected tracks to immediately above track specified by index beforeTrackIdx, returns false if no tracks were selected. makePrevFolder=0 for normal, 1 = as child of track preceding track specified by beforeTrackIdx, 2 = if track preceding track specified by beforeTrackIdx is last track in folder, extend folder
function reaper.ReorderSelectedTracks(beforeTrackIdx, makePrevFolder) end

---@param mode integer
---@return string
function reaper.Resample_EnumModes(mode) end

---@param in_ string
---@param out string
---@return string
function reaper.resolve_fn(in_, out) end

---@param in_ string
---@param out string
---@param checkSubDir optional string
---@return string
--- Resolves a filename "in" by using project settings etc. If no file found, out will be a copy of in.
function reaper.resolve_fn2(in_, out, checkSubDir) end

---@param project ReaProject
---@param timePosition number
---@param wildcards string
---@param resolvedString string
---@return string
--- Resolve a wildcard string. Any wildcards that are valid in the Big Clock can be resolved using this function. Pass in timePosition=-1 to use the current project playback position.
function reaper.ResolveWildcards(project, timePosition, wildcards, resolvedString) end

---@param command_id integer
---@return string
--- Get the named command for the given command ID. The returned string will not start with '_' (e.g. it will return "SWS_ABOUT"), it will be NULL if command_id is a native action.
function reaper.ReverseNamedCommandLookup(command_id) end

---@param scaling_mode integer
---@param val number
---@return number
--- GetEnvelopeScalingMode
function reaper.ScaleFromEnvelopeMode(scaling_mode, val) end

---@param scaling_mode integer
---@param val number
---@return number
--- GetEnvelopeScalingMode
function reaper.ScaleToEnvelopeMode(scaling_mode, val) end

---@param uniqueID integer
---@return KbdSectionInfo
function reaper.SectionFromUniqueID(uniqueID) end

---@param proj ReaProject
---@param selected boolean
function reaper.SelectAllMediaItems(proj, selected) end

---@param proj ReaProject
function reaper.SelectProjectInstance(proj) end

---@param output integer
---@param msg string
--- Sends a MIDI message to output device specified by output. Message is sent in immediate mode. Lua example of how to pack the message string:
function reaper.SendMIDIMessageToHardware(output, msg) end

---@param take MediaItem_Take
--- set this take active in this media item
function reaper.SetActiveTake(take) end

---@param mode integer
---@param onlySel boolean
--- sets all or selected tracks to mode.
function reaper.SetAutomationMode(mode, onlySel) end

---@param __proj ReaProject
---@param bpm number
---@param wantUndo boolean
--- set current BPM in project, set wantUndo=true to add undo point
function reaper.SetCurrentBPM(__proj, bpm, wantUndo) end

---@param mode integer
---@param envIn TrackEnvelope
--- You must use this to change the focus programmatically. mode=0 to focus track panels, 1 to focus the arrange window, 2 to focus the arrange window and select env (or env==NULL to clear the current track/take envelope selection)
function reaper.SetCursorContext(mode, envIn) end

---@param time number
---@param moveview boolean
---@param seekplay boolean
function reaper.SetEditCurPos(time, moveview, seekplay) end

---@param proj ReaProject
---@param time number
---@param moveview boolean
---@param seekplay boolean
function reaper.SetEditCurPos2(proj, time, moveview, seekplay) end

---@param envelope TrackEnvelope
---@param ptidx integer
---@param timeIn optional number
---@param valueIn optional number
---@param shapeIn optional integer
---@param tensionIn optional number
---@param selectedIn optional boolean
---@param noSortIn optional boolean
---@return boolean
--- Set attributes of an envelope point. Values that are not supplied will be ignored. If setting multiple points at once, set noSort=true, and call Envelope_SortPoints when done. See
function reaper.SetEnvelopePoint(envelope, ptidx, timeIn, valueIn, shapeIn, tensionIn, selectedIn, noSortIn) end

---@param envelope TrackEnvelope
---@param autoitem_idx integer
---@param ptidx integer
---@param timeIn optional number
---@param valueIn optional number
---@param shapeIn optional integer
---@param tensionIn optional number
---@param selectedIn optional boolean
---@param noSortIn optional boolean
---@return boolean
--- Set attributes of an envelope point. Values that are not supplied will be ignored. If setting multiple points at once, set noSort=true, and call Envelope_SortPoints when done.
function reaper.SetEnvelopePointEx(envelope, autoitem_idx, ptidx, timeIn, valueIn, shapeIn, tensionIn, selectedIn, noSortIn) end

---@param env TrackEnvelope
---@param str string
---@param isundo boolean
---@return boolean
--- Sets the RPPXML state of an envelope, returns true if successful. Undo flag is a performance/caching hint.
function reaper.SetEnvelopeStateChunk(env, str, isundo) end

---@param section string
---@param key string
---@param value string
---@param persist boolean
--- Set the extended state value for a specific section and key. persist=true means the value should be stored and reloaded the next time REAPER is opened. See
function reaper.SetExtState(section, key, value, persist) end

---@param mode integer
--- GetGlobalAutomationOverride
function reaper.SetGlobalAutomationOverride(mode) end

---@param item MediaItem
---@param str string
---@param isundo boolean
---@return boolean
--- Sets the RPPXML state of an item, returns true if successful. Undo flag is a performance/caching hint.
function reaper.SetItemStateChunk(item, str, isundo) end

---@param flag integer
---@return integer
--- set &1 to show the master track in the TCP, &2 to HIDE in the mixer. Returns the previous visibility state. See
function reaper.SetMasterTrackVisibility(flag) end

---@param item MediaItem
---@param parmname string
---@param newvalue number
---@return boolean
--- Set media item numerical-value attributes.
function reaper.SetMediaItemInfo_Value(item, parmname, newvalue) end

---@param item MediaItem
---@param length number
---@param refreshUI boolean
---@return boolean
--- Redraws the screen only if refreshUI == true.
function reaper.SetMediaItemLength(item, length, refreshUI) end

---@param item MediaItem
---@param position number
---@param refreshUI boolean
---@return boolean
--- Redraws the screen only if refreshUI == true.
function reaper.SetMediaItemPosition(item, position, refreshUI) end

---@param item MediaItem
---@param selected boolean
function reaper.SetMediaItemSelected(item, selected) end

---@param take MediaItem_Take
---@param source PCM_source
---@return boolean
--- Set media source of media item take. The old source will not be destroyed, it is the caller's responsibility to retrieve it and destroy it after. If source already exists in any project, it will be duplicated before being set. C/C++ code should not use this and instead use GetSetMediaItemTakeInfo() with P_SOURCE to manage ownership directly.
function reaper.SetMediaItemTake_Source(take, source) end

---@param take MediaItem_Take
---@param parmname string
---@param newvalue number
---@return boolean
--- Set media item take numerical-value attributes.
function reaper.SetMediaItemTakeInfo_Value(take, parmname, newvalue) end

---@param tr MediaTrack
---@param parmname string
---@param newvalue number
---@return boolean
--- Set track numerical-value attributes.
function reaper.SetMediaTrackInfo_Value(tr, parmname, newvalue) end

---@param project ReaProject
---@param division number
--- Set the MIDI editor grid division. 0.25=quarter note, 1.0/3.0=half note tripet, etc.
function reaper.SetMIDIEditorGrid(project, division) end

---@param leftmosttrack MediaTrack
---@return MediaTrack
--- Scroll the mixer so that leftmosttrack is the leftmost visible track. Returns the leftmost track after scrolling, which may be different from the passed-in track if there are not enough tracks to its right.
function reaper.SetMixerScroll(leftmosttrack) end

---@param context string
---@param modifier_flag integer
---@param action string
--- Set the mouse modifier assignment for a specific modifier key assignment, in a specific context.
function reaper.SetMouseModifier(context, modifier_flag, action) end

---@param track MediaTrack
--- Set exactly one track selected, deselect all others
function reaper.SetOnlyTrackSelected(track) end

---@param project ReaProject
---@param division number
--- Set the arrange view grid division. 0.25=quarter note, 1.0/3.0=half note triplet, etc.
function reaper.SetProjectGrid(project, division) end

---@param markrgnindexnumber integer
---@param isrgn boolean
---@param pos number
---@param rgnend number
---@param name string
---@return boolean
--- Note: this function can't clear a marker's name (an empty string will leave the name unchanged), see
function reaper.SetProjectMarker(markrgnindexnumber, isrgn, pos, rgnend, name) end

---@param proj ReaProject
---@param markrgnindexnumber integer
---@param isrgn boolean
---@param pos number
---@param rgnend number
---@param name string
---@return boolean
--- Note: this function can't clear a marker's name (an empty string will leave the name unchanged), see
function reaper.SetProjectMarker2(proj, markrgnindexnumber, isrgn, pos, rgnend, name) end

---@param proj ReaProject
---@param markrgnindexnumber integer
---@param isrgn boolean
---@param pos number
---@param rgnend number
---@param name string
---@param color integer
---@return boolean
--- Note: this function can't clear a marker's name (an empty string will leave the name unchanged), see
function reaper.SetProjectMarker3(proj, markrgnindexnumber, isrgn, pos, rgnend, name, color) end

---@param proj ReaProject
---@param markrgnindexnumber integer
---@param isrgn boolean
---@param pos number
---@param rgnend number
---@param name string
---@param color integer
---@param flags integer
---@return boolean
--- color should be 0 to not change, or ColorToNative(r,g,b)|0x1000000, flags&1 to clear name
function reaper.SetProjectMarker4(proj, markrgnindexnumber, isrgn, pos, rgnend, name, color, flags) end

---@param proj ReaProject
---@param markrgnidx integer
---@param isrgn boolean
---@param pos number
---@param rgnend number
---@param IDnumber integer
---@param name string
---@param color integer
---@return boolean
--- SetProjectMarkerByIndex2
function reaper.SetProjectMarkerByIndex(proj, markrgnidx, isrgn, pos, rgnend, IDnumber, name, color) end

---@param proj ReaProject
---@param markrgnidx integer
---@param isrgn boolean
---@param pos number
---@param rgnend number
---@param IDnumber integer
---@param name string
---@param color integer
---@param flags integer
---@return boolean
--- Differs from SetProjectMarker4 in that markrgnidx is 0 for the first marker/region, 1 for the next, etc (see
function reaper.SetProjectMarkerByIndex2(proj, markrgnidx, isrgn, pos, rgnend, IDnumber, name, color, flags) end

---@param proj ReaProject
---@param extname string
---@param key string
---@param value string
---@return integer
--- Save a key/value pair for a specific extension, to be restored the next time this specific project is loaded. Typically extname will be the name of a reascript or extension section. If key is NULL or "", all extended data for that extname will be deleted. If val is NULL or "", the data previously associated with that key will be deleted. Returns the size of the state for this extname. See
function reaper.SetProjExtState(proj, extname, key, value) end

---@param proj ReaProject
---@param regionindex integer
---@param track MediaTrack
---@param flag integer
--- Add (flag > 0) or remove (flag < 0) a track from this region when using the region render matrix. If adding, flag==2 means force mono, flag==4 means force stereo, flag==N means force N/2 channels.
function reaper.SetRegionRenderMatrix(proj, regionindex, track, flag) end

---@param take MediaItem_Take
---@param idx integer
---@param nameIn string
---@param srcposIn optional number
---@param colorIn optional integer
---@return integer
--- Inserts or updates a take marker. If idx<0, a take marker will be added, otherwise an existing take marker will be updated. Returns the index of the new or updated take marker (which may change if srcPos is updated). See
function reaper.SetTakeMarker(take, idx, nameIn, srcposIn, colorIn) end

---@param take MediaItem_Take
---@param idx integer
---@param pos number
---@param srcposIn optional number
---@return integer
--- Adds or updates a stretch marker. If idx=0, stretch marker will be updated. When adding, if srcposInOptional is omitted, source position will be auto-calculated. When updating a stretch marker, if srcposInOptional is omitted, srcpos will not be modified. Position/srcposition values will be constrained to nearby stretch markers. Returns index of stretch marker, or -1 if did not insert (or marker already existed at time).
function reaper.SetTakeStretchMarker(take, idx, pos, srcposIn) end

---@param take MediaItem_Take
---@param idx integer
---@param slope number
---@return boolean
--- GetTakeStretchMarkerSlope
function reaper.SetTakeStretchMarkerSlope(take, idx, slope) end

---@param proj ReaProject
---@param ptidx integer
---@param timepos number
---@param measurepos integer
---@param beatpos number
---@param bpm number
---@param timesig_num integer
---@param timesig_denom integer
---@param lineartempo boolean
---@return boolean
--- Set parameters of a tempo/time signature marker. Provide either timepos (with measurepos=-1, beatpos=-1), or measurepos and beatpos (with timepos=-1). If timesig_num and timesig_denom are zero, the previous time signature will be used. ptidx=-1 will insert a new tempo/time signature marker. See
function reaper.SetTempoTimeSigMarker(proj, ptidx, timepos, measurepos, beatpos, bpm, timesig_num, timesig_denom, lineartempo) end

---@param ini_key string
---@param color integer
---@param flags integer
---@return integer
--- Temporarily updates the theme color to the color specified (or the theme default color if -1 is specified). Returns -1 on failure, otherwise returns the color (or transformed-color). Note that the UI is not updated by this, the caller should call UpdateArrange() etc as necessary. If the low bit of flags is set, any color transformations are bypassed. To read a value see
function reaper.SetThemeColor(ini_key, color, flags) end

---@param section_id integer
---@param command_id integer
---@param state integer
---@return boolean
--- Updates the toggle state of an action, returns true if succeeded. Only ReaScripts can have their toggle states changed programmatically. See
function reaper.SetToggleCommandState(section_id, command_id, state) end

---@param tr MediaTrack
---@param mode integer
function reaper.SetTrackAutomationMode(tr, mode) end

---@param track MediaTrack
---@param color integer
--- Set the custom track color, color is OS dependent (i.e. ColorToNative(r,g,b). To unset the track color, see
function reaper.SetTrackColor(track, color) end

---@param track MediaTrack
---@param flag integer
---@param str string
---@return boolean
--- Set all MIDI lyrics on the track. Lyrics will be stuffed into any MIDI items found in range. Flag is unused at present. str is passed in as beat position, tab, text, tab (example with flag=2: "1.1.2\tLyric for measure 1 beat 2\t2.1.1\tLyric for measure 2 beat 1 "). See
function reaper.SetTrackMIDILyrics(track, flag, str) end

---@param track integer
---@param pitch integer
---@param chan integer
---@param name string
---@return boolean
--- channel < 0 assigns these note names to all channels.
function reaper.SetTrackMIDINoteName(track, pitch, chan, name) end

---@param proj ReaProject
---@param track MediaTrack
---@param pitch integer
---@param chan integer
---@param name string
---@return boolean
--- channel < 0 assigns note name to all channels. pitch 128 assigns name for CC0, pitch 129 for CC1, etc.
function reaper.SetTrackMIDINoteNameEx(proj, track, pitch, chan, name) end

---@param track MediaTrack
---@param selected boolean
function reaper.SetTrackSelected(track, selected) end

---@param tr MediaTrack
---@param category integer
---@param sendidx integer
---@param parmname string
---@param newvalue number
---@return boolean
--- Set send/receive/hardware output numerical-value attributes, return true on success.
function reaper.SetTrackSendInfo_Value(tr, category, sendidx, parmname, newvalue) end

---@param track MediaTrack
---@param send_idx integer
---@param pan number
---@param isend integer
---@return boolean
--- send_idx=0 for hw ouputs, >=nb_of_hw_ouputs for sends. isend=1 for end of edit, -1 for an instant edit (such as reset), 0 for normal tweak.
function reaper.SetTrackSendUIPan(track, send_idx, pan, isend) end

---@param track MediaTrack
---@param send_idx integer
---@param vol number
---@param isend integer
---@return boolean
--- send_idx=0 for hw ouputs, >=nb_of_hw_ouputs for sends. isend=1 for end of edit, -1 for an instant edit (such as reset), 0 for normal tweak.
function reaper.SetTrackSendUIVol(track, send_idx, vol, isend) end

---@param track MediaTrack
---@param str string
---@param isundo boolean
---@return boolean
--- Sets the RPPXML state of a track, returns true if successful. Undo flag is a performance/caching hint.
function reaper.SetTrackStateChunk(track, str, isundo) end

---@param track MediaTrack
---@param monitor integer
---@param igngroupflags integer
---@return integer
--- monitor: 0=no monitoring, 1=monitoring, 2=auto-monitoring. returns new value or -1 if error. igngroupflags: &1 to prevent track grouping, &2 to prevent selection ganging
function reaper.SetTrackUIInputMonitor(track, monitor, igngroupflags) end

---@param track MediaTrack
---@param mute integer
---@param igngroupflags integer
---@return integer
--- mute: 0 sets mute, 0=unsets mute. returns new value or -1 if error. igngroupflags: &1 to prevent track grouping, &2 to prevent selection ganging
function reaper.SetTrackUIMute(track, mute, igngroupflags) end

---@param track MediaTrack
---@param pan number
---@param relative boolean
---@param done boolean
---@param igngroupflags integer
---@return number
--- igngroupflags: &1 to prevent track grouping, &2 to prevent selection ganging
function reaper.SetTrackUIPan(track, pan, relative, done, igngroupflags) end

---@param track MediaTrack
---@param polarity integer
---@param igngroupflags integer
---@return integer
--- polarity (AKA phase): 0=inverted. returns new value or -1 if error.igngroupflags: &1 to prevent track grouping, &2 to prevent selection ganging
function reaper.SetTrackUIPolarity(track, polarity, igngroupflags) end

---@param track MediaTrack
---@param recarm integer
---@param igngroupflags integer
---@return integer
--- recarm: 0 sets recarm, 0=unsets recarm. returns new value or -1 if error. igngroupflags: &1 to prevent track grouping, &2 to prevent selection ganging
function reaper.SetTrackUIRecArm(track, recarm, igngroupflags) end

---@param track MediaTrack
---@param solo integer
---@param igngroupflags integer
---@return integer
--- solo: <0 toggles, 1 sets solo (default mode), 0=unsets solo, 2 sets solo (non-SIP), 4 sets solo (SIP). returns new value or -1 if error. igngroupflags: &1 to prevent track grouping, &2 to prevent selection ganging
function reaper.SetTrackUISolo(track, solo, igngroupflags) end

---@param track MediaTrack
---@param volume number
---@param relative boolean
---@param done boolean
---@param igngroupflags integer
---@return number
--- igngroupflags: &1 to prevent track grouping, &2 to prevent selection ganging
function reaper.SetTrackUIVolume(track, volume, relative, done, igngroupflags) end

---@param track MediaTrack
---@param width number
---@param relative boolean
---@param done boolean
---@param igngroupflags integer
---@return number
--- igngroupflags: &1 to prevent track grouping, &2 to prevent selection ganging
function reaper.SetTrackUIWidth(track, width, relative, done, igngroupflags) end

---@param section KbdSectionInfo
---@param callerWnd HWND
function reaper.ShowActionList(section, callerWnd) end

---@param msg string
--- Show a message to the user (also useful for debugging). Send "\n" for newline, "" to clear the console. Prefix string with "!SHOW:" and text will be added to console without opening the window. See
function reaper.ShowConsoleMsg(msg) end

---@param msg string
---@param title string
---@param type integer
---@return integer
--- type 0=OK,1=OKCANCEL,2=ABORTRETRYIGNORE,3=YESNOCANCEL,4=YESNO,5=RETRYCANCEL : ret 1=OK,2=CANCEL,3=ABORT,4=RETRY,5=IGNORE,6=YES,7=NO
function reaper.ShowMessageBox(msg, title, type) end

---@param name string
---@param x integer
---@param y integer
---@param hwndParent HWND
---@param ctx identifier
---@param ctx2 integer
---@param ctx3 integer
--- shows a context menu, valid names include: track_input, track_panel, track_area, track_routing, item, ruler, envelope, envelope_point, envelope_item. ctxOptional can be a track pointer for track_*, item pointer for item* (but is optional). for envelope_point, ctx2Optional has point index, ctx3Optional has item index (0=main envelope, 1=first AI). for envelope_item, ctx2Optional has AI index (1=first AI)
function reaper.ShowPopupMenu(name, x, y, hwndParent, ctx, ctx2, ctx3) end

---@param y number
---@return number
function reaper.SLIDER2DB(y) end

---@param project ReaProject
---@param time_pos number
---@return number
function reaper.SnapToGrid(project, time_pos) end

---@param solo integer
function reaper.SoloAllTracks(solo) end

---@return HWND
--- gets the splash window, in case you want to display a message over it. Returns NULL when the splash window is not displayed.
function reaper.Splash_GetWnd() end

---@param item MediaItem
---@param position number
---@return MediaItem
--- the original item becomes the left-hand split, the function returns the right-hand split (or NULL if the split failed)
function reaper.SplitMediaItem(item, position) end

---@param str string
---@param gGUID string
---@return string
function reaper.stringToGuid(str, gGUID) end

---@param mode integer
---@param msg1 integer
---@param msg2 integer
---@param msg3 integer
--- Stuffs a 3 byte MIDI message into either the Virtual MIDI Keyboard queue, or the MIDI-as-control input queue, or sends to a MIDI hardware output. mode=0 for VKB, 1 for control (actions map etc), 2 for VKB-on-current-channel; 16 for external MIDI device 0, 17 for external MIDI device 1, etc; see
function reaper.StuffMIDIMessage(mode, msg1, msg2, msg3) end

---@param take MediaItem_Take
---@param fxname string
---@param instantiate integer
---@return integer
--- Adds or queries the position of a named FX in a take. See
function reaper.TakeFX_AddByName(take, fxname, instantiate) end

---@param src_take MediaItem_Take
---@param src_fx integer
---@param dest_take MediaItem_Take
---@param dest_fx integer
---@param is_move boolean
--- Copies (or moves) FX from src_take to dest_take. Can be used with src_take=dest_take to reorder. FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_CopyToTake(src_take, src_fx, dest_take, dest_fx, is_move) end

---@param src_take MediaItem_Take
---@param src_fx integer
---@param dest_track MediaTrack
---@param dest_fx integer
---@param is_move boolean
--- Copies (or moves) FX from src_take to dest_track. dest_fx can have 0x1000000 set to reference input FX. FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_CopyToTrack(src_take, src_fx, dest_track, dest_fx, is_move) end

---@param take MediaItem_Take
---@param fx integer
---@return boolean
--- Remove a FX from take chain (returns true on success) FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_Delete(take, fx) end

---@param take MediaItem_Take
---@param fx integer
---@param param integer
---@return boolean
--- FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_EndParamEdit(take, fx, param) end

---@param take MediaItem_Take
---@param fx integer
---@param param integer
---@param val number
---@return boolean, string
--- Note: only works with FX that support Cockos VST extensions. FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_FormatParamValue(take, fx, param, val) end

---@param take MediaItem_Take
---@param fx integer
---@param param integer
---@param value number
---@param buf string
---@return boolean, string
--- Note: only works with FX that support Cockos VST extensions. FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_FormatParamValueNormalized(take, fx, param, value, buf) end

---@param take MediaItem_Take
---@return integer
--- returns index of effect visible in chain, or -1 for chain hidden, or -2 for chain visible but no effect selected
function reaper.TakeFX_GetChainVisible(take) end

---@param take MediaItem_Take
---@return integer
function reaper.TakeFX_GetCount(take) end

---@param take MediaItem_Take
---@param fx integer
---@return boolean
--- TakeFX_SetEnabled
function reaper.TakeFX_GetEnabled(take, fx) end

---@param take MediaItem_Take
---@param fxindex integer
---@param parameterindex integer
---@param create boolean
---@return TrackEnvelope
--- Returns the FX parameter envelope. If the envelope does not exist and create=true, the envelope will be created. If the envelope already exists and is bypassed and create=true, then the envelope will be unbypassed. FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_GetEnvelope(take, fxindex, parameterindex, create) end

---@param take MediaItem_Take
---@param index integer
---@return HWND
--- returns HWND of floating window for effect index, if any FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_GetFloatingWindow(take, index) end

---@param take MediaItem_Take
---@param fx integer
---@param param integer
---@return boolean, string
--- FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_GetFormattedParamValue(take, fx, param) end

---@param take MediaItem_Take
---@param fx integer
---@return string
--- FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_GetFXGUID(take, fx) end

---@param take MediaItem_Take
---@param fx integer
---@return boolean, string
--- FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_GetFXName(take, fx) end

---@param take MediaItem_Take
---@param fx integer
---@return integer, integer, integer
--- Gets the number of input/output pins for FX if available, returns plug-in type or -1 on error FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_GetIOSize(take, fx) end

---@param take MediaItem_Take
---@param fx integer
---@param parmname string
---@return boolean, string
--- gets plug-in specific named configuration value (returns true on success). see
function reaper.TakeFX_GetNamedConfigParm(take, fx, parmname) end

---@param take MediaItem_Take
---@param fx integer
---@return integer
--- FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_GetNumParams(take, fx) end

---@param take MediaItem_Take
---@param fx integer
---@return boolean
--- TakeFX_SetOffline
function reaper.TakeFX_GetOffline(take, fx) end

---@param take MediaItem_Take
---@param fx integer
---@return boolean
--- Returns true if this FX UI is open in the FX chain window or a floating window. See
function reaper.TakeFX_GetOpen(take, fx) end

---@param take MediaItem_Take
---@param fx integer
---@param param integer
---@return number, number, number
--- FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_GetParam(take, fx, param) end

---@param take MediaItem_Take
---@param fx integer
---@param param integer
---@return boolean, number, number, number, boolean
--- FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_GetParameterStepSizes(take, fx, param) end

---@param take MediaItem_Take
---@param fx integer
---@param param integer
---@return number, number, number, number
--- FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_GetParamEx(take, fx, param) end

---@param take MediaItem_Take
---@param fx integer
---@param ident_str string
---@return integer
--- gets the parameter index from an identifying string (:wet, :bypass, or a string returned from GetParamIdent), or -1 if unknown. FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_GetParamFromIdent(take, fx, ident_str) end

---@param take MediaItem_Take
---@param fx integer
---@param param integer
---@return boolean, string
--- gets an identifying string for the parameter FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_GetParamIdent(take, fx, param) end

---@param take MediaItem_Take
---@param fx integer
---@param param integer
---@return boolean, string
--- FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_GetParamName(take, fx, param) end

---@param take MediaItem_Take
---@param fx integer
---@param param integer
---@return number
--- FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_GetParamNormalized(take, fx, param) end

---@param take MediaItem_Take
---@param fx integer
---@param isoutput integer
---@param pin integer
---@return integer, integer
--- gets the effective channel mapping bitmask for a particular pin. high32Out will be set to the high 32 bits. Add 0x1000000 to pin index in order to access the second 64 bits of mappings independent of the first 64 bits. FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_GetPinMappings(take, fx, isoutput, pin) end

---@param take MediaItem_Take
---@param fx integer
---@return boolean, string
--- Get the name of the preset currently showing in the REAPER dropdown, or the full path to a factory preset file for VST3 plug-ins (.vstpreset). See
function reaper.TakeFX_GetPreset(take, fx) end

---@param take MediaItem_Take
---@param fx integer
---@return integer, integer
--- Returns current preset index, or -1 if error. numberOfPresetsOut will be set to total number of presets available. See
function reaper.TakeFX_GetPresetIndex(take, fx) end

---@param take MediaItem_Take
---@param fx integer
---@return string
--- FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_GetUserPresetFilename(take, fx) end

---@param take MediaItem_Take
---@param fx integer
---@param presetmove integer
---@return boolean
--- presetmove==1 activates the next preset, presetmove==-1 activates the previous preset, etc. FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_NavigatePresets(take, fx, presetmove) end

---@param take MediaItem_Take
---@param fx integer
---@param enabled boolean
--- TakeFX_GetEnabled
function reaper.TakeFX_SetEnabled(take, fx, enabled) end

---@param take MediaItem_Take
---@param fx integer
---@param parmname string
---@param value string
---@return boolean
--- gets plug-in specific named configuration value (returns true on success). see
function reaper.TakeFX_SetNamedConfigParm(take, fx, parmname, value) end

---@param take MediaItem_Take
---@param fx integer
---@param offline boolean
--- TakeFX_GetOffline
function reaper.TakeFX_SetOffline(take, fx, offline) end

---@param take MediaItem_Take
---@param fx integer
---@param open boolean
--- Open this FX UI. See
function reaper.TakeFX_SetOpen(take, fx, open) end

---@param take MediaItem_Take
---@param fx integer
---@param param integer
---@param val number
---@return boolean
--- FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_SetParam(take, fx, param, val) end

---@param take MediaItem_Take
---@param fx integer
---@param param integer
---@param value number
---@return boolean
--- FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_SetParamNormalized(take, fx, param, value) end

---@param take MediaItem_Take
---@param fx integer
---@param isoutput integer
---@param pin integer
---@param low32bits integer
---@param hi32bits integer
---@return boolean
--- sets the channel mapping bitmask for a particular pin. returns false if unsupported (not all types of plug-ins support this capability). Add 0x1000000 to pin index in order to access the second 64 bits of mappings independent of the first 64 bits. FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_SetPinMappings(take, fx, isoutput, pin, low32bits, hi32bits) end

---@param take MediaItem_Take
---@param fx integer
---@param presetname string
---@return boolean
--- Activate a preset with the name shown in the REAPER dropdown. Full paths to .vstpreset files are also supported for VST3 plug-ins. See
function reaper.TakeFX_SetPreset(take, fx, presetname) end

---@param take MediaItem_Take
---@param fx integer
---@param idx integer
---@return boolean
--- Sets the preset idx, or the factory preset (idx==-2), or the default user preset (idx==-1). Returns true on success. See
function reaper.TakeFX_SetPresetByIndex(take, fx, idx) end

---@param take MediaItem_Take
---@param index integer
---@param showFlag integer
--- showflag=0 for hidechain, =1 for show chain(index valid), =2 for hide floating window(index valid), =3 for show floating window (index valid) FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TakeFX_Show(take, index, showFlag) end

---@param take MediaItem_Take
---@return boolean
--- Returns true if the active take contains MIDI.
function reaper.TakeIsMIDI(take) end

---@param section string
---@param idx integer
---@return boolean, string
--- Gets theme layout information. section can be 'global' for global layout override, 'seclist' to enumerate a list of layout sections, otherwise a layout section such as 'mcp', 'tcp', 'trans', etc. idx can be -1 to query the current value, -2 to get the description of the section (if not global), -3 will return the current context DPI-scaling (256=normal, 512=retina, etc), or 0..x. returns false if failed.
function reaper.ThemeLayout_GetLayout(section, idx) end

---@param wp integer
---@return string, string, integer, integer, integer, integer
--- returns theme layout parameter. return value is cfg-name, or nil/empty if out of range.
function reaper.ThemeLayout_GetParameter(wp) end

--- Refreshes all layouts
function reaper.ThemeLayout_RefreshAll() end

---@param section string
---@param layout string
---@return boolean
--- Sets theme layout override for a particular section -- section can be 'global' or 'mcp' etc. If setting global layout, prefix a ! to the layout string to clear any per-layout overrides. Returns false if failed.
function reaper.ThemeLayout_SetLayout(section, layout) end

---@param wp integer
---@param value integer
---@param persist boolean
---@return boolean
--- sets theme layout parameter to value. persist=true in order to have change loaded on next theme load. note that the caller should update layouts via ??? to make changes visible.
function reaper.ThemeLayout_SetParameter(wp, value, persist) end

---@return number
--- Gets a precise system timestamp in seconds
function reaper.time_precise() end

---@param proj ReaProject
---@param tpos number
---@param measuresIn optional integer
---@return number
--- convert a beat position (or optionally a beats+measures if measures is non-NULL) to time.
function reaper.TimeMap2_beatsToTime(proj, tpos, measuresIn) end

---@param proj ReaProject
---@param time number
---@return number
--- get the effective BPM at the time (seconds) position (i.e. 2x in /8 signatures)
function reaper.TimeMap2_GetDividedBpmAtTime(proj, time) end

---@param proj ReaProject
---@param time number
---@return number
--- when does the next time map (tempo or time sig) change occur
function reaper.TimeMap2_GetNextChangeTime(proj, time) end

---@param proj ReaProject
---@param qn number
---@return number
--- converts project QN position to time.
function reaper.TimeMap2_QNToTime(proj, qn) end

---@param proj ReaProject
---@param tpos number
---@return number, integer, integer, number, integer
--- convert a time into beats.
function reaper.TimeMap2_timeToBeats(proj, tpos) end

---@param proj ReaProject
---@param tpos number
---@return number
--- converts project time position to QN position.
function reaper.TimeMap2_timeToQN(proj, tpos) end

---@param proj ReaProject
---@return number, boolean
--- Gets project framerate, and optionally whether it is drop-frame timecode
function reaper.TimeMap_curFrameRate(proj) end

---@param time number
---@return number
--- get the effective BPM at the time (seconds) position (i.e. 2x in /8 signatures)
function reaper.TimeMap_GetDividedBpmAtTime(time) end

---@param proj ReaProject
---@param measure integer
---@return number, number, number, integer, integer, number
--- Get the QN position and time signature information for the start of a measure. Return the time in seconds of the measure start.
function reaper.TimeMap_GetMeasureInfo(proj, measure) end

---@param proj ReaProject
---@param time number
---@param pattern string
---@return integer, string
--- Fills in a string representing the active metronome pattern. For example, in a 7/8 measure divided 3+4, the pattern might be "ABCABCD". For backwards compatibility, by default the function will return 1 for each primary beat and 2 for each non-primary beat, so "1221222" in this example, and does not support triplets. If buf is set to "EXTENDED", the function will return the full string as displayed in the pattern editor, including all beat types and triplet representations. Pass in "SET:string" with a correctly formed pattern string matching the current time signature numerator to set the click pattern. The time signature numerator can be deduced from the returned string, and the function returns the time signature denominator.
function reaper.TimeMap_GetMetronomePattern(proj, time, pattern) end

---@param proj ReaProject
---@param time number
---@return integer, integer, number
--- get the effective time signature and tempo
function reaper.TimeMap_GetTimeSigAtTime(proj, time) end

---@param proj ReaProject
---@param qn number
---@return integer, number, number
--- Find which measure the given QN position falls in.
function reaper.TimeMap_QNToMeasures(proj, qn) end

---@param qn number
---@return number
--- converts project QN position to time.
function reaper.TimeMap_QNToTime(qn) end

---@param proj ReaProject
---@param qn number
---@return number
--- Converts project quarter note count (QN) to time. QN is counted from the start of the project, regardless of any partial measures. See
function reaper.TimeMap_QNToTime_abs(proj, qn) end

---@param tpos number
---@return number
--- converts project QN position to time.
function reaper.TimeMap_timeToQN(tpos) end

---@param proj ReaProject
---@param tpos number
---@return number
--- Converts project time position to quarter note count (QN). QN is counted from the start of the project, regardless of any partial measures. See
function reaper.TimeMap_timeToQN_abs(proj, tpos) end

---@param track MediaTrack
---@param send_idx integer
---@return boolean
--- send_idx=0 for hw ouputs, >=nb_of_hw_ouputs for sends.
function reaper.ToggleTrackSendUIMute(track, send_idx) end

---@param track MediaTrack
---@param channel integer
---@param clear boolean
---@return number
--- Returns meter hold state, in dB*0.01 (0 = +0dB, -0.01 = -1dB, 0.02 = +2dB, etc). If clear is set, clears the meter hold. If channel==1024 or channel==1025, returns loudness values if this is the master track or this track's VU meters are set to display loudness.
function reaper.Track_GetPeakHoldDB(track, channel, clear) end

---@param track MediaTrack
---@param channel integer
---@return number
--- Returns peak meter value (1.0=+0dB, 0.0=-inf) for channel. If channel==1024 or channel==1025, returns loudness values if this is the master track or this track's VU meters are set to display loudness.
function reaper.Track_GetPeakInfo(track, channel) end

---@param fmt string
---@param xpos integer
---@param ypos integer
---@param topmost boolean
--- displays tooltip at location, or removes if empty string
function reaper.TrackCtl_SetToolTip(fmt, xpos, ypos, topmost) end

---@param track MediaTrack
---@param fxname string
---@param recFX boolean
---@param instantiate integer
---@return integer
--- Adds or queries the position of a named FX from the track FX chain (recFX=false) or record input FX/monitoring FX (recFX=true, monitoring FX are on master track). Specify a negative value for instantiate to always create a new effect, 0 to only query the first instance of an effect, or a positive value to add an instance if one is not found. If instantiate is <= -1000, it is used for the insertion position (-1000 is first item in chain, -1001 is second, etc). fxname can have prefix to specify type: VST3:,VST2:,VST:,AU:,JS:, or DX:, or FXADD: which adds selected items from the currently-open FX browser, FXADD:2 to limit to 2 FX added, or FXADD:2e to only succeed if exactly 2 FX are selected. Returns -1 on failure or the new position in chain on success. FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_AddByName(track, fxname, recFX, instantiate) end

---@param src_track MediaTrack
---@param src_fx integer
---@param dest_take MediaItem_Take
---@param dest_fx integer
---@param is_move boolean
--- Copies (or moves) FX from src_track to dest_take. src_fx can have 0x1000000 set to reference input FX. FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_CopyToTake(src_track, src_fx, dest_take, dest_fx, is_move) end

---@param src_track MediaTrack
---@param src_fx integer
---@param dest_track MediaTrack
---@param dest_fx integer
---@param is_move boolean
--- Copies (or moves) FX from src_track to dest_track. Can be used with src_track=dest_track to reorder, FX indices have 0x1000000 set to reference input FX. FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_CopyToTrack(src_track, src_fx, dest_track, dest_fx, is_move) end

---@param track MediaTrack
---@param fx integer
---@return boolean
--- Remove a FX from track chain (returns true on success) FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_Delete(track, fx) end

---@param track MediaTrack
---@param fx integer
---@param param integer
---@return boolean
--- FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_EndParamEdit(track, fx, param) end

---@param track MediaTrack
---@param fx integer
---@param param integer
---@param val number
---@return boolean, string
--- Note: only works with FX that support Cockos VST extensions. FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_FormatParamValue(track, fx, param, val) end

---@param track MediaTrack
---@param fx integer
---@param param integer
---@param value number
---@param buf string
---@return boolean, string
--- Note: only works with FX that support Cockos VST extensions. FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_FormatParamValueNormalized(track, fx, param, value, buf) end

---@param track MediaTrack
---@param fxname string
---@param instantiate boolean
---@return integer
--- Get the index of the first track FX insert that matches fxname. If the FX is not in the chain and instantiate is true, it will be inserted. See
function reaper.TrackFX_GetByName(track, fxname, instantiate) end

---@param track MediaTrack
---@return integer
--- returns index of effect visible in chain, or -1 for chain hidden, or -2 for chain visible but no effect selected
function reaper.TrackFX_GetChainVisible(track) end

---@param track MediaTrack
---@return integer
function reaper.TrackFX_GetCount(track) end

---@param track MediaTrack
---@param fx integer
---@return boolean
--- TrackFX_SetEnabled
function reaper.TrackFX_GetEnabled(track, fx) end

---@param track MediaTrack
---@param instantiate boolean
---@return integer
--- Get the index of ReaEQ in the track FX chain. If ReaEQ is not in the chain and instantiate is true, it will be inserted. See
function reaper.TrackFX_GetEQ(track, instantiate) end

---@param track MediaTrack
---@param fxidx integer
---@param bandtype integer
---@param bandidx integer
---@return boolean
--- Returns true if the EQ band is enabled.
function reaper.TrackFX_GetEQBandEnabled(track, fxidx, bandtype, bandidx) end

---@param track MediaTrack
---@param fxidx integer
---@param paramidx integer
---@return boolean, integer, integer, integer, number
--- Returns false if track/fxidx is not ReaEQ.
function reaper.TrackFX_GetEQParam(track, fxidx, paramidx) end

---@param track MediaTrack
---@param index integer
---@return HWND
--- returns HWND of floating window for effect index, if any FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_GetFloatingWindow(track, index) end

---@param track MediaTrack
---@param fx integer
---@param param integer
---@return boolean, string
--- FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_GetFormattedParamValue(track, fx, param) end

---@param track MediaTrack
---@param fx integer
---@return string
--- FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_GetFXGUID(track, fx) end

---@param track MediaTrack
---@param fx integer
---@return boolean, string
--- FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_GetFXName(track, fx) end

---@param track MediaTrack
---@return integer
--- Get the index of the first track FX insert that is a virtual instrument, or -1 if none. See
function reaper.TrackFX_GetInstrument(track) end

---@param track MediaTrack
---@param fx integer
---@return integer, integer, integer
--- Gets the number of input/output pins for FX if available, returns plug-in type or -1 on error FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_GetIOSize(track, fx) end

---@param track MediaTrack
---@param fx integer
---@param parmname string
---@return boolean, string
--- gets plug-in specific named configuration value (returns true on success).
function reaper.TrackFX_GetNamedConfigParm(track, fx, parmname) end

---@param track MediaTrack
---@param fx integer
---@return integer
--- FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_GetNumParams(track, fx) end

---@param track MediaTrack
---@param fx integer
---@return boolean
--- TrackFX_SetOffline
function reaper.TrackFX_GetOffline(track, fx) end

---@param track MediaTrack
---@param fx integer
---@return boolean
--- Returns true if this FX UI is open in the FX chain window or a floating window. See
function reaper.TrackFX_GetOpen(track, fx) end

---@param track MediaTrack
---@param fx integer
---@param param integer
---@return number, number, number
--- FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_GetParam(track, fx, param) end

---@param track MediaTrack
---@param fx integer
---@param param integer
---@return boolean, number, number, number, boolean
--- FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_GetParameterStepSizes(track, fx, param) end

---@param track MediaTrack
---@param fx integer
---@param param integer
---@return number, number, number, number
--- FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_GetParamEx(track, fx, param) end

---@param track MediaTrack
---@param fx integer
---@param ident_str string
---@return integer
--- gets the parameter index from an identifying string (:wet, :bypass, :delta, or a string returned from GetParamIdent), or -1 if unknown. FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_GetParamFromIdent(track, fx, ident_str) end

---@param track MediaTrack
---@param fx integer
---@param param integer
---@return boolean, string
--- gets an identifying string for the parameter FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_GetParamIdent(track, fx, param) end

---@param track MediaTrack
---@param fx integer
---@param param integer
---@return boolean, string
--- FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_GetParamName(track, fx, param) end

---@param track MediaTrack
---@param fx integer
---@param param integer
---@return number
--- FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_GetParamNormalized(track, fx, param) end

---@param tr MediaTrack
---@param fx integer
---@param isoutput integer
---@param pin integer
---@return integer, integer
--- gets the effective channel mapping bitmask for a particular pin. high32Out will be set to the high 32 bits. Add 0x1000000 to pin index in order to access the second 64 bits of mappings independent of the first 64 bits. FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_GetPinMappings(tr, fx, isoutput, pin) end

---@param track MediaTrack
---@param fx integer
---@return boolean, string
--- Get the name of the preset currently showing in the REAPER dropdown, or the full path to a factory preset file for VST3 plug-ins (.vstpreset). See
function reaper.TrackFX_GetPreset(track, fx) end

---@param track MediaTrack
---@param fx integer
---@return integer, integer
--- Returns current preset index, or -1 if error. numberOfPresetsOut will be set to total number of presets available. See
function reaper.TrackFX_GetPresetIndex(track, fx) end

---@param track MediaTrack
---@return integer
--- returns index of effect visible in record input chain, or -1 for chain hidden, or -2 for chain visible but no effect selected
function reaper.TrackFX_GetRecChainVisible(track) end

---@param track MediaTrack
---@return integer
--- returns count of record input FX. To access record input FX, use a FX indices [0x1000000..0x1000000+n). On the master track, this accesses monitoring FX rather than record input FX.
function reaper.TrackFX_GetRecCount(track) end

---@param track MediaTrack
---@param fx integer
---@return string
--- FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_GetUserPresetFilename(track, fx) end

---@param track MediaTrack
---@param fx integer
---@param presetmove integer
---@return boolean
--- presetmove==1 activates the next preset, presetmove==-1 activates the previous preset, etc. FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_NavigatePresets(track, fx, presetmove) end

---@param track MediaTrack
---@param fx integer
---@param enabled boolean
--- TrackFX_GetEnabled
function reaper.TrackFX_SetEnabled(track, fx, enabled) end

---@param track MediaTrack
---@param fxidx integer
---@param bandtype integer
---@param bandidx integer
---@param enable boolean
---@return boolean
--- Enable or disable a ReaEQ band.
function reaper.TrackFX_SetEQBandEnabled(track, fxidx, bandtype, bandidx, enable) end

---@param track MediaTrack
---@param fxidx integer
---@param bandtype integer
---@param bandidx integer
---@param paramtype integer
---@param val number
---@param isnorm boolean
---@return boolean
--- Returns false if track/fxidx is not ReaEQ. Targets a band matching bandtype.
function reaper.TrackFX_SetEQParam(track, fxidx, bandtype, bandidx, paramtype, val, isnorm) end

---@param track MediaTrack
---@param fx integer
---@param parmname string
---@param value string
---@return boolean
--- sets plug-in specific named configuration value (returns true on success).
function reaper.TrackFX_SetNamedConfigParm(track, fx, parmname, value) end

---@param track MediaTrack
---@param fx integer
---@param offline boolean
--- TrackFX_GetOffline
function reaper.TrackFX_SetOffline(track, fx, offline) end

---@param track MediaTrack
---@param fx integer
---@param open boolean
--- Open this FX UI. See
function reaper.TrackFX_SetOpen(track, fx, open) end

---@param track MediaTrack
---@param fx integer
---@param param integer
---@param val number
---@return boolean
--- FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_SetParam(track, fx, param, val) end

---@param track MediaTrack
---@param fx integer
---@param param integer
---@param value number
---@return boolean
--- FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_SetParamNormalized(track, fx, param, value) end

---@param tr MediaTrack
---@param fx integer
---@param isoutput integer
---@param pin integer
---@param low32bits integer
---@param hi32bits integer
---@return boolean
--- sets the channel mapping bitmask for a particular pin. returns false if unsupported (not all types of plug-ins support this capability). Add 0x1000000 to pin index in order to access the second 64 bits of mappings independent of the first 64 bits. FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_SetPinMappings(tr, fx, isoutput, pin, low32bits, hi32bits) end

---@param track MediaTrack
---@param fx integer
---@param presetname string
---@return boolean
--- Activate a preset with the name shown in the REAPER dropdown. Full paths to .vstpreset files are also supported for VST3 plug-ins. See
function reaper.TrackFX_SetPreset(track, fx, presetname) end

---@param track MediaTrack
---@param fx integer
---@param idx integer
---@return boolean
--- Sets the preset idx, or the factory preset (idx==-2), or the default user preset (idx==-1). Returns true on success. See
function reaper.TrackFX_SetPresetByIndex(track, fx, idx) end

---@param track MediaTrack
---@param index integer
---@param showFlag integer
--- showflag=0 for hidechain, =1 for show chain(index valid), =2 for hide floating window(index valid), =3 for show floating window (index valid) FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see
function reaper.TrackFX_Show(track, index, showFlag) end

---@param isMinor boolean
function reaper.TrackList_AdjustWindows(isMinor) end

function reaper.TrackList_UpdateAllExternalSurfaces() end

--- call to start a new block
function reaper.Undo_BeginBlock() end

---@param proj ReaProject
--- call to start a new block
function reaper.Undo_BeginBlock2(proj) end

---@param proj ReaProject
---@return string
--- returns string of next action,if able,NULL if not
function reaper.Undo_CanRedo2(proj) end

---@param proj ReaProject
---@return string
--- returns string of last action,if able,NULL if not
function reaper.Undo_CanUndo2(proj) end

---@param proj ReaProject
---@return integer
--- nonzero if success
function reaper.Undo_DoRedo2(proj) end

---@param proj ReaProject
---@return integer
--- nonzero if success
function reaper.Undo_DoUndo2(proj) end

---@param descchange string
---@param extraflags integer
--- call to end the block,with extra flags if any,and a description
function reaper.Undo_EndBlock(descchange, extraflags) end

---@param proj ReaProject
---@param descchange string
---@param extraflags integer
--- call to end the block,with extra flags if any,and a description
function reaper.Undo_EndBlock2(proj, descchange, extraflags) end

---@param descchange string
--- limited state change to items
function reaper.Undo_OnStateChange(descchange) end

---@param proj ReaProject
---@param descchange string
--- limited state change to items
function reaper.Undo_OnStateChange2(proj, descchange) end

---@param proj ReaProject
---@param name string
---@param item MediaItem
function reaper.Undo_OnStateChange_Item(proj, name, item) end

---@param descchange string
---@param whichStates integer
---@param trackparm integer
--- trackparm=-1 by default,or if updating one fx chain,you can specify track index
function reaper.Undo_OnStateChangeEx(descchange, whichStates, trackparm) end

---@param proj ReaProject
---@param descchange string
---@param whichStates integer
---@param trackparm integer
--- trackparm=-1 by default,or if updating one fx chain,you can specify track index
function reaper.Undo_OnStateChangeEx2(proj, descchange, whichStates, trackparm) end

--- Redraw the arrange view
function reaper.UpdateArrange() end

---@param item MediaItem
function reaper.UpdateItemInProject(item) end

---@param proj ReaProject
---@return boolean
--- Recalculate lane arrangement for fixed lane tracks, including auto-removing empty lanes at the bottom of the track
function reaper.UpdateItemLanes(proj) end

--- Redraw the arrange view and ruler
function reaper.UpdateTimeline() end

---@param pointer identifier
---@param ctypename string
---@return boolean
function reaper.ValidatePtr(pointer, ctypename) end

---@param proj ReaProject
---@param pointer identifier
---@param ctypename string
---@return boolean
--- Return true if the pointer is a valid object of the right type in proj (proj is ignored if pointer is itself a project). Supported types are: ReaProject*, MediaTrack*, MediaItem*, MediaItem_Take*, TrackEnvelope* and PCM_source*.
function reaper.ValidatePtr2(proj, pointer, ctypename) end

---@param page integer
---@param pageByName string
--- Opens the prefs to a page, use pageByName if page is 0.
function reaper.ViewPrefs(page, pageByName) end

