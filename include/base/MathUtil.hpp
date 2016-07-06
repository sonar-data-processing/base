#ifndef MathUtil_hpp
#define MathUtil_hpp

#include <iostream>
#include <cmath>
#include <opencv2/opencv.hpp>

namespace base {

class MathUtil {
public:

    static cv::Point to_cartesian(float theta, float radius) {
        return cv::Point(round(cos(theta) * radius), round(sin(theta) * radius));
    }

    static cv::Rect arc_bounding_box(float theta0, float theta1, float radius0, float radius1, cv::Point origin) {

        cv::Point pts[4];

        pts[0] = to_cartesian(theta0, radius0) + origin;
        pts[1] = to_cartesian(theta1, radius0) + origin;
        pts[2] = to_cartesian(theta0, radius1) + origin;
        pts[3] = to_cartesian(theta1, radius1) + origin;

        cv::Point pt0 = pts[0];
        cv::Point pt1 = pts[0];

        for (int i = 1; i < 4; i++) {
            pt0.x = std::min(pt0.x, pts[i].x);
            pt0.y = std::min(pt0.y, pts[i].y);
            pt1.x = std::max(pt1.x, pts[i].x);
            pt1.y = std::max(pt1.y, pts[i].y);
        }

        return cv::Rect(pt0, pt1);
    }

    static int  aspect_ratio_width(float angle, int height) {
        return height * cos(angle - M_PI_2) * 2.0;
    }
    
    static int percentage(int value, int max_value) {
        return 100.0f * value / max_value;
    }

private:

    MathUtil() {
    }

    ~MathUtil(){
    }

};

} /* namespace base */

#endif /* MathUtil_hpp */
