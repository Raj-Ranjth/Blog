using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time.Gregorian as Calendar;
using Toybox.Sensor as Snsr;
using Toybox.Application as App;
using Toybox.Position as GPS;

class App07View extends Ui.View {

    var _posInfo = null;
    var _hrData;
    var HR_graph;
            
    function setSensor(sensorInfo) {
    	_hrData = sensorInfo.heartRate;
    	
    	//Add value to graph
        HR_graph.addItem(_hrData);
    	
    	Ui.requestUpdate();
    }

    function onLayout(dc) {
    }

    function onHide() {
    }

    function onShow() {
    	HR_graph = new LineGraph( 20, 10, Gfx.COLOR_RED );
    }

    function onUpdate(dc) {
        var string;

        dc.setColor( Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK );
        dc.clear();
        dc.setColor( Gfx.COLOR_PURPLE , Gfx.COLOR_TRANSPARENT );
        string = "El Bruno - Sensors";
        dc.drawText( (dc.getWidth() / 2), ((dc.getHeight() / 2) - 60), Gfx.FONT_MEDIUM , string, Gfx.TEXT_JUSTIFY_CENTER );
        if( _posInfo != null && _hrData != null) {
	        dc.setColor( Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT );
            string = "HR: " + _hrData + " Bpm";
            dc.drawText( (dc.getWidth() / 2), ((dc.getHeight() / 2) + 20), Gfx.FONT_TINY, string, Gfx.TEXT_JUSTIFY_CENTER );
	        dc.setColor( Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT );
            string = "Lat = " + _posInfo.position.toDegrees()[0].toString();
            dc.drawText( (dc.getWidth() / 2), ((dc.getHeight() / 2) + 35), Gfx.FONT_TINY, string, Gfx.TEXT_JUSTIFY_CENTER );
            string = "Long = " + _posInfo.position.toDegrees()[1].toString();
            dc.drawText( (dc.getWidth() / 2), ((dc.getHeight() / 2) + 50), Gfx.FONT_TINY, string, Gfx.TEXT_JUSTIFY_CENTER );
            
            // draw HR chart
            HR_graph.draw( dc, [5,30], [220,129] );
            
        }
        else {
	        dc.setColor( Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT );
            dc.drawText( (dc.getWidth() / 2), (dc.getHeight() / 2), Gfx.FONT_SMALL, "No info available", Gfx.TEXT_JUSTIFY_CENTER );
        }
    }

    function setPosition(info) {
        _posInfo = info;
        Ui.requestUpdate();
    }
}