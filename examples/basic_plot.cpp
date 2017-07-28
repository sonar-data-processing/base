#include "Plot.hpp"

int main(int argc, char const *argv[]) {

	std::vector<double> y_pts;
	for(int i=0; i<1000; i++) {
		double y = (i/500.0-1) * (i/500.0-1);
		y_pts.push_back(y);
	}

	std::vector<std::pair<double, double> > xy_pts;
	for(double x=-2; x<2; x+=0.01) {
		double y = x*x*x;
		xy_pts.push_back(std::make_pair(x, y));
	}

    base::Plot plot;
    plot(y_pts);
    plot(xy_pts);
    return 0;
}
