class Crew {
  
  PImage crew_icon, crew_icon_dead;
  
  // Crew settings
  color crewCurrentHealthColor = color(0, 255, 0);  
  float crewNameX, crewNameY;
  float crewIconX, crewIconY;
  
  // Crew stats
  String crewName, crewRole;
  float crewHealth = 100;
  float crewCurrentHealth = 100;
  int INT, STR, CHAR, DEX;
  boolean alive = true;
  boolean stat_increase = false;
  
  // Crew UI object
  UI crewInfo;  
  
  Crew(String _crewName, String _crewRole, float _crewIconX, float _crewIconY, float _crewNameX, float _crewNameY) {
    
    crewName = _crewName;
    crewRole = _crewRole;
    crewIconX = _crewIconX;
    crewIconY = _crewIconY;
    crewNameX = _crewNameX;
    crewNameY = _crewNameY;
    
    // Assign random starting stats for each crew member
    INT = (int)random(1, 6);
    STR = (int)random(1, 6);
    CHAR = (int)random(1, 6);
    DEX = (int)random(1, 6);
    
    crew_icon = loadImage("assets/ui/crew_icon.png");
    crew_icon_dead = loadImage("assets/ui/crew_icon_dead.png");
    
    crewInfo = new UI(crewNameX, crewNameY, color(255));
  }
  
  void icon(float x, float y) {
    // Display the crew icon image
    imageMode(CORNER);
    image(crew_icon, x, y);
  }

  void status() {
    // Status method which checks for updates to crew health/stats
    if(crewCurrentHealth > 50) {
      crewCurrentHealthColor = mainGame.goodHP;
    }
    if(crewCurrentHealth <= 50) {
      crewCurrentHealthColor = mainGame.lowHP;
    }
    if(crewCurrentHealth <= 25) {
      crewCurrentHealthColor = mainGame.verylowHP;
    }
    if(crewCurrentHealth <= 0) {
      crewCurrentHealth = 0;
      crewHealth = 0;
    }
    // Increment stats for characters every 2 planets
    if(mainGame.planet.planetCount % 2 == 0 && stat_increase) {
      int stat_incr = (int)random(0, 4);
      switch(stat_incr) {
        case 0: INT++;
        case 1: STR++;
        case 2: CHAR++;
        case 3: DEX++;
      }
      stat_increase = false;
    }
  }
  
  void draw_crew() {
    // Draw the crew in the main game
    check_crew();
    icon(crewIconX, crewIconY);
    crewInfo.text_string(crewInfo.x, crewInfo.y, crewName, 16, crewInfo.c, LEFT, crewInfo.font);
    // Check the status of crew members
    status();
    // Draw the health bar for crew members/ change crew icon image if they are dead
    crewInfo.bar(crewNameX, crewNameY+4, crewCurrentHealth * 0.5, 2, crewCurrentHealthColor, 0);
    if(alive == false) {
      crew_icon = crew_icon_dead;
      crewInfo.c = color(255, 0, 0);
      crewCurrentHealth = 0;
    }
  }

  void check_crew() {
    // Display rect on crew hover
    if(rectHover(crewIconX, crewIconY, 50, 50) && mainGame.eventOpen == false && alive == true) {
      stroke(114, 188, 212);
      fill(51, 51, 51);
      rect(crewIconX, crewIconY, 50, 50);
      if(mousePressed) {
        // If mouse is pressed draw a detailed crew panel as well
        draw_crew_detailed();
      }
    }
  }

  void changeHealth(int amount) {
   // Crew method to change the health of a crew member
   println("[INFO] Changing health of " + this.getClass().getCanonicalName() + " by " + amount);
   if(!(crewCurrentHealth + amount >= crewHealth)) {
     crewCurrentHealth += amount;
   }
   if(crewCurrentHealth + amount <= 0) {
     alive = false;
   }
  }
  
  void draw_crew_detailed() {
    // Draw UI elements on screen, showing more information about a crew member
    rect(crewIconX+25, crewIconY+50, 150, 200);
    crewInfo.text_string(crewIconX+30, crewIconY+65, "Name: " + crewName, 20, color(255), LEFT, crewInfo.font);
    crewInfo.text_string(crewIconX+30, crewIconY+80, "HP: " + (int)crewCurrentHealth + "%", 20, crewCurrentHealthColor, LEFT, crewInfo.font);
    crewInfo.text_string(crewIconX+30, crewIconY+95, "Role: " + crewRole, 20, color(255), LEFT, crewInfo.font);
    line(crewIconX+30, crewIconY+105, crewIconX+170, crewIconY+105);
    crewInfo.text_string(crewIconX+30, crewIconY+125, "INT: " + INT, 20, color(255), LEFT, crewInfo.font);
    crewInfo.text_string(crewIconX+30, crewIconY+140, "STR: " + STR, 20, color(255), LEFT, crewInfo.font);
    crewInfo.text_string(crewIconX+30, crewIconY+155, "CHAR: " + CHAR, 20, color(255), LEFT, crewInfo.font);
    crewInfo.text_string(crewIconX+30, crewIconY+170, "DEX: " + DEX, 20, color(255), LEFT, crewInfo.font);
  }
  
}