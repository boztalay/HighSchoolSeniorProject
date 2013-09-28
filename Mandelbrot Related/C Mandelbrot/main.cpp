#include <allegro.h>

int main()
{     
    BITMAP* buffer;      

    allegro_init();
    install_mouse();
    install_keyboard();
    set_color_depth(16);
    set_gfx_mode( GFX_AUTODETECT_WINDOWED, 640, 480, 0, 0);
    
    buffer = create_bitmap(640, 480);

    clear_to_color( screen, makecol( 255, 255, 255));

    double X = -2.0;
    double Y = 2.0;
    double cX, cY, zX, zY, tempX, tempY = 0.0;
    double deltaX = (4.0 / 640.0);
    double deltaY = (4.0 / 480.0);
    int iterations = 0;
    double zAbs = 0.0;
    int pX = 0;
    int pY = 0; 
    int red, green, blue = 0;
    double render_X_end = 2.0;
    double render_Y_end = -2.0;
    double render_width = 4.0;
    double centerX = 0.0;
    double centerY = 0.0;
    int cursorX = 0;
    int cursorY = 0;
    
    while(!key[KEY_ESC])
    {                
        while (Y > render_Y_end)
        {
              X = centerX - (render_width / 2);
              pX = 0;
              while (X < render_X_end)
              {
                    cX = X;
                    cY = Y;
                    zX = 0.0;
                    zY = 0.0;
                    iterations = 0;
                    zAbs = 0.0;
                    while ((iterations < 256) && (zAbs < 4.0))
                    {
                          tempY = (2.0 * zX * zY) + cY;
                          tempX = ((zX * zX) - (zY * zY)) + cX;
                          zX = tempX;
                          zY = tempY;
                          zAbs = ((zX * zX) + (zY * zY));
                          iterations++;
                    }
                    
                    red = (iterations % 32) * 7;
                    blue = (iterations % 16) * 14;
                    green = (iterations % 128) * 2;
                    
                    putpixel(buffer, pX, pY, makecol(red, green, blue));
                    X = X + deltaX;
                    pX++;
              }
              Y = Y - deltaY;
              pY++;
        }        
        show_mouse(buffer);
        
        acquire_screen();
        draw_sprite(screen, buffer, 0, 0);
        release_screen();
        
        if (mouse_b & 1)
        {
             cursorX = mouse_x;
             cursorY = mouse_y;
             
             centerX = (centerX - (render_width / 2)) + (deltaX * cursorX);
             centerY = (centerY + (render_width / 2)) - (deltaY * cursorY);
             
             render_width = (render_width / 2.0);
             
             deltaX = (deltaX / 2.0);
             deltaY = (deltaY / 2.0);
             
             render_X_end = centerX + (render_width / 2.0);
             render_Y_end = centerY - (render_width / 2.0);
             
             Y = centerY + (render_width / 2);
             pY = 0;
             
             buffer = create_bitmap(640, 480);
        }
        if (mouse_b & 2)
        {             
             cursorX = mouse_x;
             cursorY = mouse_y;
             
             centerX = (centerX - (render_width / 2)) + (deltaX * cursorX);
             centerY = (centerY + (render_width / 2)) - (deltaY * cursorY);
             
             render_width = (render_width * 2.0);
             
             deltaX = (deltaX * 2.0);
             deltaY = (deltaY * 2.0);
             
             render_X_end = centerX + (render_width / 2.0);
             render_Y_end = centerY - (render_width / 2.0);
             
             Y = centerY + (render_width / 2);
             pY = 0;
             
             buffer = create_bitmap(640, 480);
        }
    }
    
    return 0;
    
}   
END_OF_MAIN();
