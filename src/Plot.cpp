#include "base/Plot.hpp"

namespace base {

void Plot::operator()(std::vector<double > data) {
    Gnuplot gp;
	gp << "plot '-' with lines notitle\n";
	gp.send1d(data);
}

void Plot::operator()(std::vector<std::pair<double, double> > data) {
	Gnuplot gp;
	gp << "plot '-' with lines notitle\n";
	gp.send1d(data);
}

}
