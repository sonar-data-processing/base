#ifndef Plot_hpp
#define Plot_hpp

#include <vector>
#include <gnuplot-iostream.h>

namespace base {

class Plot {

public:
    Plot();
    ~Plot();

    void operator()(std::vector<double> data);
    void operator()(std::vector<std::pair<double, double> > data);
    void operator()(std::vector<float> data);
    void operator()(std::vector<float> data, float t);
    void operator()();

    void reset() {
        data_.clear();
    }

    void operator<<(std::vector<float> data) {
        data_.push_back(std::vector<double>(data.begin(), data.end()));
    }

    void operator<<(std::vector<double> data) {
        data_.push_back(std::vector<double>(data.begin(), data.end()));
    }

    void push_data(std::vector<float> data);

    Gnuplot gp;

private:

    std::vector<std::vector<double> > data_;
};

}

#endif /* end of include guard: Plot_hpp */
