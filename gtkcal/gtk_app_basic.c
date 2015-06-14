#include <gtk/gtk.h>

void draw_brush (GtkWidget *widget, gdouble x, gdouble y,gdouble sx, gdouble sy);
void draw_box(GtkWidget *widget, gdouble x, gdouble y, gdouble sx, gdouble sy);
void draw_day_headers(GtkWidget *widget, gdouble x, gdouble y, gdouble sx, gdouble sy);
void draw_side_frame (GtkWidget *widget, gdouble x, gdouble y, gdouble sx, gdouble sy);
void clear_surface (void);
gboolean configure_event_cb (GtkWidget  *widget, GdkEventConfigure *event, gpointer data);
gboolean draw_cb (GtkWidget *widget, cairo_t   *cr, gpointer data);
void kill_surface();
gboolean if_surface();
void printf_localtime();

/* Handle button press events by either drawing a rectangle
 * or clearing the surface, depending on which button was pressed.
 * The ::button-press signal handler receives a GdkEventButton
 * struct which contains this information.
 */
static gboolean button_press_event_cb (GtkWidget *widget, GdkEventButton *event, gpointer data)
{
  /* paranoia check, in case we haven't gotten a configure event */
  if (if_surface() == FALSE) return FALSE;
  
  if (event->button == GDK_BUTTON_PRIMARY)
    {
      draw_brush (widget, event->x, event->y, 3, 3);
    }
  else if (event->button == GDK_BUTTON_SECONDARY) {
    clear_surface ();
    gtk_widget_queue_draw (widget);
  }

  /* We've handled the event, stop processing */
  return TRUE;
}

/* Handle motion events by continuing to draw if button 1 is
 * still held down. The ::motion-notify signal handler receives
 * a GdkEventMotion struct which contains this information.
 */
static gboolean motion_notify_event_cb (GtkWidget      *widget,
                        GdkEventMotion *event,
                        gpointer        data)
{
  /* paranoia check, in case we haven't gotten a configure event */
  //if (surface == NULL) return FALSE;
  if (if_surface() == FALSE) return FALSE;
  
  if (event->state & GDK_BUTTON1_MASK)
    draw_brush (widget, event->x, event->y, 3, 3);

  /* We've handled it, stop processing */
  return TRUE;
}

static void close_window (void)
{
  if (if_surface() == TRUE)
    kill_surface();
  gtk_main_quit ();
}

static void activate (GtkApplication *app,
          gpointer        user_data)
{
  GtkWidget *window;
  GtkWidget *frame;
  GtkWidget *drawing_area;

  window = gtk_application_window_new (app);
  gtk_window_set_title (GTK_WINDOW (window), "Calendar");

  g_signal_connect (window, "destroy", G_CALLBACK (close_window), NULL);

  gtk_container_set_border_width (GTK_CONTAINER (window), 0);

  frame = gtk_frame_new (NULL);
  gtk_frame_set_shadow_type (GTK_FRAME (frame), GTK_SHADOW_IN);
  gtk_container_add (GTK_CONTAINER (window), frame);

  drawing_area = gtk_drawing_area_new ();
  /* set a minimum size */
  gtk_widget_set_size_request(drawing_area, 640, 480);
  gtk_container_add (GTK_CONTAINER (frame), drawing_area);

  /* Signals used to handle the backing surface */
  g_signal_connect (drawing_area, "draw", G_CALLBACK (draw_cb), NULL);
  g_signal_connect (drawing_area,"configure-event", G_CALLBACK (configure_event_cb), NULL);
  /* Event signals */
  g_signal_connect (drawing_area, "motion-notify-event", G_CALLBACK (motion_notify_event_cb), NULL);
  g_signal_connect (drawing_area, "button-press-event", G_CALLBACK (button_press_event_cb), NULL);

  /* Ask to receive events the drawing area doesn't normally
   * subscribe to. In particular, we need to ask for the
   * button press and motion notify events that want to handle.
   */
  gtk_widget_set_events (drawing_area, gtk_widget_get_events (drawing_area)
                                     | GDK_BUTTON_PRESS_MASK
                                     | GDK_POINTER_MOTION_MASK);
  gtk_widget_show_all (window);
  
}

int main (int argc, char **argv)
{
  GtkApplication *app;
  int status;
  printf_localtime();
  app = gtk_application_new ("org.gtk.example", G_APPLICATION_FLAGS_NONE);
  g_signal_connect (app, "activate", G_CALLBACK (activate), NULL);
  status = g_application_run (G_APPLICATION (app), argc, argv);
  g_object_unref (app);

  return status;
}

//gcc `pkg-config --cflags gtk+-3.0` -o example-0 example-0.c `pkg-config --libs gtk+-3.0`
