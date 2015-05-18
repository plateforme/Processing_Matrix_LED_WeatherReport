import javax.swing.*; 
import processing.video.*;
import com.heroicrobot.dropbit.registry.*;
import com.heroicrobot.dropbit.devices.pixelpusher.Pixel;
import com.heroicrobot.dropbit.devices.pixelpusher.Strip;
import java.util.*;
import com.onformative.yahooweather.*;
DeviceRegistry registry;
PusherObserver observer;

YahooWeather weather;
int updateIntervallMillis = 30000; 
float timer; 

void setup() {
  size(1080,1920);
  fill(255, 255, 255);
  textFont(createFont("Digitalix", 250));






  // 2442047 = the WOEID of Berlin
  // use this site to find out about your WOEID : http://sigizmund.info/woeidinfo/
  weather = new YahooWeather(this, 12697160, "c", updateIntervallMillis);


  registry = new DeviceRegistry();
  observer = new PusherObserver();
  registry.addObserver(observer);
  registry.setAntiLog(true);
}

void draw() {
  weather.update();
  rotate(radians(90));

  background(255,0,251);

  timer += .0175;




  if (timer >= 0 && timer <= 5) { 
    textSize(250); 
    // Has five seconds passed?

    //text("City: "+weather.getCityName()+"; Region: "+weather.getRegionName()+"; Country: "+weather.getCountryName()+"; Last updated: "+weather.getLastUpdated(),0, -50);
    text(weather.getCityName(), 0, -400);




    //text("Lon: "+weather.getLongitude()+" Lat: "+weather.getLatitude(), 20, -50);
    //textSize(300); 
    //text("TEMP ", 0, -500);
  }

  if (timer >= 5 && timer <= 10) {
    background(0);
    textSize(300); 
    text(weather.getTemperature(), 0, -100);
    textSize(200); 
    text("DEGRÉ", 600, -100);
    textSize(250); 
    text("HUMIDITY "+(weather.getHumidity()+"%"), 0, -700);
  }





  if (timer >= 10 && timer <= 15) {



    int s = second();  // Values from 0 - 59
    int m = minute();  // Values from 0 - 59
    int h = hour();    // Values from 0 - 23
    textSize(300); 
    text(s, 1300, -400);
    text(m, 700, -400);
    text(h, 100, -400);
  }

  if (timer >= 15) { 
    timer =0;
  } 




  scrape();
}

public void keyPressed() {
  if (key == 'q') {
    weather.setWOEID(638242);
  }
  if (key == 'r') {
    weather.setWOEID(44418);
  }
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}

