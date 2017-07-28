#include "Plot.hpp"

namespace base {

Plot::Plot() {
    gp.set_auto_close(true);
}

Plot::~Plot() {
}

void Plot::operator()(std::vector<double> data) {
    gp << "plot '-' with lines notitle\n";
	gp.send1d(data);
    gp.flush();
}

void Plot::operator()(std::vector<std::pair<double, double> > data) {
    gp << "plot '-' with lines notitle\n";
	gp.send1d(data);
    gp.flush();
}

void Plot::operator()(std::vector<float> data) {
    std::vector<double> data_vecd(data.begin(), data.end());
    gp << "plot '-' with lines notitle\n";
	gp.send1d(data_vecd);
    gp.flush();
}

void Plot::operator()(std::vector<float> data, float thresh) {
    std::vector<double> thresh_vec(data.size(), thresh);
    gp << "plot '-' with lines notitle, '-' with lines notitle\n";
	gp.send1d(std::vector<double>(data.begin(), data.end()));
    gp.send1d(thresh_vec);
    gp.flush();

}

void Plot::operator()() {
    if (!data_.empty()) {
        std::string gnuplot_cmd = "plot ";
        for (size_t i = 0; i < data_.size(); i++) {
            gnuplot_cmd += "'-' with lines notitle";
            gnuplot_cmd += (i < data_.size() - 1)  ? "," : "\n";
        }

        gp << gnuplot_cmd;
        for (std::vector<std::vector<double> >::iterator it = data_.begin();
             it < data_.end(); it++) {
            gp.send1d(*it);        
        }
        data_.clear();
    }
}

}
