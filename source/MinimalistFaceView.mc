import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.Time.Gregorian;

class MinimalistFaceView extends WatchUi.WatchFace {

    private const COLOR_BG = 0x000000;
    private var isSleeping = false; 

    function initialize() {
        WatchFace.initialize();
    }

    // 1. Inflate and bind the XML layout resource tree structure
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    function onShow() as Void {}

    function onEnterSleep() as Void {
        isSleeping = true;
        WatchUi.requestUpdate(); 
    }

    function onExitSleep() as Void {
        isSleeping = false;
        WatchUi.requestUpdate(); 
    }

    function onHide() as Void {}

    // 2. Main execution loop using the Layout tree
    function onUpdate(dc as Dc) as Void {
        // Background - Clear display to solid black
        dc.setColor(COLOR_BG, COLOR_BG);
        dc.clear();

        // ── SLEEP MODE CHECK ─────────────────────────────────
        // Returns empty, bypassing text population if sleeping
        if (isSleeping) {
            return; 
        }

        // ── AWAKE DATA CALCULATIONS ──────────────────────────
        var clockTime = System.getClockTime();
        var now       = Time.now();

        // Calculate Time
        var is24Hour = System.getDeviceSettings().is24Hour;
        var hours = clockTime.hour;
        if (!is24Hour) {
            hours = hours % 12;
            hours = (hours == 0) ? 12 : hours;
        }
        var timeStr = hours.format("%02d") + ":" + clockTime.min.format("%02d");

        // Calculate Date
        var greg = Gregorian.info(now, Time.FORMAT_MEDIUM);
        var dayOfWeekStr = (greg.day_of_week instanceof Lang.String) ? greg.day_of_week.toUpper() : greg.day_of_week;
        var monthStr = (greg.month instanceof Lang.String) ? greg.month.toUpper() : greg.month;
        var dateStr = Lang.format("$1$ $2$ $3$", [dayOfWeekStr, greg.day.format("%02d"), monthStr]);

        // Calculate Battery
        var sysStats = System.getSystemStats();
        var batStr   = sysStats.battery.toNumber().format("%d") + "%";

        // ── BIND STRINGS TO LAYOUT LABELS ─────────────────────
        // Fetch labels by their unique XML element ID and inject computed values
        var timeLabel    = View.findDrawableById("HoursAndMinutes") as Text;
        var dateLabel    = View.findDrawableById("Date") as Text;
        var batteryLabel = View.findDrawableById("Battery") as Text;

        if (timeLabel != null) {    timeLabel.setText(timeStr); }
        if (dateLabel != null) {    dateLabel.setText(dateStr); }
        if (batteryLabel != null) { batteryLabel.setText(batStr); }

        // ── EXECUTE LAYOUT RENDER ────────────────────────────
        // Calls parent framework to draw XML labels with specified alignments automatically
        View.onUpdate(dc);
    }
}