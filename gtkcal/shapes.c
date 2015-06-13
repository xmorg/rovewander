#include <gtk/gtk.h>

/* Surface to store current scribbles */
static cairo_surface_t *surface = NULL;


void draw_brush (GtkWidget *widget, gdouble x, gdouble y,gdouble sx, gdouble sy);
void draw_box(GtkWidget *widget, gdouble x, gdouble y, gdouble sx, gdouble sy);
void draw_day_headers(GtkWidget *widget, gdouble x, gdouble y, gdouble sx, gdouble sy);
void draw_side_frame (GtkWidget *widget, gdouble x, gdouble y, gdouble sx, gdouble sy);
void clear_surface (void);
gboolean configure_event_cb (GtkWidget  *widget, GdkEventConfigure *event, gpointer data);
gboolean draw_cb (GtkWidget *widget, cairo_t   *cr, gpointer data);
gboolean if_surface();
void kill_surface();

void kill_surface()
{
  cairo_surface_destroy (surface);
}

gboolean if_surface()
{
  if (surface == NULL) return FALSE;
  else return TRUE;
}

void draw_day_headers(GtkWidget *widget, gdouble x, gdouble y, gdouble sx, gdouble sy)
{
  cairo_t *cr;
  /* Paint to the surface, where we store our state */
  cr = cairo_create (surface);
  cairo_set_source_rgb (cr, 0, 1, 0);
  cairo_rectangle (cr, x , y, sx, sy);
  cairo_fill (cr);
  cairo_destroy (cr);
  /* Now invalidate the affected region of the drawing area. */
  gtk_widget_queue_draw_area (widget, x - 3, y - 3, 6, 6);
}

void draw_box(GtkWidget *widget, gdouble x, gdouble y, gdouble sx, gdouble sy)
{
  cairo_t *cr;
  /* Paint to the surface, where we store our state */
  cr = cairo_create (surface);
  cairo_set_source_rgb (cr, 1, 1, 1);
  cairo_rectangle (cr, x , y, sx, sy);
  cairo_fill (cr);
  cairo_destroy (cr);
  /* Now invalidate the affected region of the drawing area. */
  gtk_widget_queue_draw_area (widget, x - 3, y - 3, 6, 6);
}

void draw_side_frame (GtkWidget *widget, gdouble x, gdouble y,
			gdouble sx, gdouble sy)
{
  cairo_t *cr;
  /* Paint to the surface, where we store our state */
  cr = cairo_create (surface);
  cairo_set_source_rgb (cr, 0, 1, 0);
  cairo_rectangle (cr, x , y, sx, sy);
  cairo_fill (cr);
  cairo_destroy (cr);
  /* Now invalidate the affected region of the drawing area. */
  gtk_widget_queue_draw_area (widget, x - 3, y - 3, 6, 6);
}

/* Draw a rectangle on the surface at the given position */
void draw_brush (GtkWidget *widget, gdouble x, gdouble y,
			gdouble sx, gdouble sy)
{
  cairo_t *cr;
  /* Paint to the surface, where we store our state */
  cr = cairo_create (surface);
  cairo_set_source_rgb (cr, 0, 1, 0);
  cairo_rectangle (cr, x , y, sx, sy);
  cairo_fill (cr);
  cairo_destroy (cr);
  /* Now invalidate the affected region of the drawing area. */
  gtk_widget_queue_draw_area (widget, x - 3, y - 3, 6, 6);
}


void clear_surface (void)
{
  cairo_t *cr;
  cr = cairo_create (surface);
  cairo_set_source_rgb (cr, 0.5, 0.5, 0.5);
  cairo_paint (cr);
  cairo_destroy (cr);
}

/* Create a new surface of the appropriate size to store our scribbles */
gboolean configure_event_cb (GtkWidget  *widget,
                    GdkEventConfigure *event,
                    gpointer           data)
{
  int header_spacing;
  int box_width, box_height;
  int i, x, y;
  cairo_t *cr; cr = cairo_create (surface);
  if (surface)  cairo_surface_destroy (surface);
  surface = gdk_window_create_similar_surface (gtk_widget_get_window (widget),
                                               CAIRO_CONTENT_COLOR,
                                               gtk_widget_get_allocated_width (widget),
                                               gtk_widget_get_allocated_height (widget));

  header_spacing = 22;

  
  box_width = gtk_widget_get_allocated_width (widget) / 7; // 640 / 7;
  box_height = gtk_widget_get_allocated_width (widget) / 5 -22; //480 / 5 -22;
 
  
  /* Initialize the surface to black */
  clear_surface ();
  //draw_side_frame(widget, 1, 1, 100, 480); //side frame

  for (i=0; i < 7; i++) {
    draw_day_headers(widget, (i*box_width)+i, 1, box_width, 20); //side frame
  }

  for (y=0; y < 5; y++) {
    for(x=0; x < 7; x++) {
      draw_box(widget, (x*box_width)+x,
	       header_spacing+(y*box_height)+y,
	       box_width, box_height); //side frame
    }
  }
  /* We've handled the configure event, no need for further processing. */
  return TRUE;
}

/* Redraw the screen from the surface. Note that the ::draw
 * signal receives a ready-to-be-used cairo_t that is already
 * clipped to only draw the exposed areas of the widget
 */
gboolean draw_cb (GtkWidget *widget, cairo_t   *cr, gpointer data)
{
  cairo_set_source_surface (cr, surface, 0, 0);  
  cairo_paint (cr);
  return FALSE;
}
