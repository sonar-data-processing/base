#ifndef Plot_hpp
#define Plot_hpp

#include <vector>
#include <gnuplot-iostream.h>

namespace base {

class Plot {

public:
    void operator()(std::vector<double > data);
    void operator()(std::vector<std::pair<double, double> > data);
};

}

#endif /* end of include guard: Plot_hpp */
