package com.sqlstream.utilities.geo;

import com.google.gson.*;

public class Polygon {
    
    /**
     * Return true if the given point is contained inside the boundary.
     * See: http://www.ecse.rpi.edu/Homepages/wrf/Research/Short_Notes/pnpoly.html
     * @param test The point to check
     * @return true if the point is inside the boundary, false otherwise
     *
     */
    public static boolean polygonContains(String polygon, double lon, double lat) {

        // Polygon provided as JSON array '[[long, lat],[long, lat], ... [long, lat]]''
        // final point = first point
        //double lat=dlat.doubleValue();
        //double lon=dlon.doubleValue();


        JsonElement jelement = new JsonParser().parse(polygon);
        JsonArray jarray = jelement.getAsJsonArray();
        double[][] points = new double[jarray.size()][2];

        for (int i = 0; i < jarray.size(); i++ ) {
            JsonArray coordpair = jarray.get(i).getAsJsonArray();
            for (int j = 0; j < 2; j++) {
               points[i][j] = coordpair.get(j).getAsDouble();
            }
        }
      
        // now take each edge and see if a horizontal line from the lat,lon pair crosses it (lon=x=[0], lat=y=[1])
        // if count of crossings is odd, then point is within polygon
/*
        for (i = 0, j = points.length - 1; i < points.length; j = i++) {
            if ((points[i].y > test.y) != (points[j].y > test.y) &&
                (test.x < (points[j].x - points[i].x) * (test.y - points[i].y) / (points[j].y-points[i].y) + points[i].x)) {
              result = !result;
             }
          }
*/
        boolean result = false;
        for (int i = 0, j = points.length - 1; i < points.length; j = i++) {
            if ((points[i][1] > lat) != (points[j][1] > lat) &&
                    (lon < (points[j][0] - points[i][0]) * (lat - points[i][1]) / (points[j][1]-points[i][1]) + points[i][0])) {
                result = !result;
            }
        }

        return result;
    }
}
