#include <ogdf/basic/Graph.h>
#include <ogdf/basic/GraphAttributes.h>
#include <ogdf/basic/geometry.h>
#include <ogdf/basic/graph_generators.h>
#include <ogdf/fileformats/GraphIO.h>
#include <ogdf/layered/DfsAcyclicSubgraph.h>
#include <ogdf/tree/TreeLayout.h>

#include <algorithm>
#include <string>
#include <vector>

#include "gmock/gmock.h"
#include "gtest/gtest.h"
#include "spdlog/spdlog.h"
#include "testdata/test_data.hpp"

TEST(mvp_ogdf, dot)
{
    ogdf::Graph g;
    ogdf::GraphAttributes ga(g, ogdf::GraphAttributes::nodeGraphics | ogdf::GraphAttributes::edgeGraphics | ogdf::GraphAttributes::nodeLabel);
    ogdf::node root = g.newNode();
    ogdf::node left = g.newNode();
    ogdf::node right = g.newNode();
    ga.label(root) = "Root";
    ga.label(left) = "Left";
    ga.label(right) = "Right";

    g.newEdge(root, left);
    g.newEdge(root, right);

    ogdf::TreeLayout layout;
    layout.levelDistance(70.0);
    layout.call(ga);
#if 0
    ogdf::GraphIO::write(ga, "xxxxx.dot", ogdf::GraphIO::writeDOT);
#endif
}

TEST(mvp_ogdf_examples_basic, gen_acyclic_graph)
{
    ogdf::Graph G;
    ogdf::randomSimpleGraph(G, 10, 20);

    ogdf::DfsAcyclicSubgraph DAS;
    DAS.callAndReverse(G);
#if 0
    ogdf::GraphIO::write(G, "output-acyclic-graph.gml", ogdf::GraphIO::writeGML);
    ogdf::GraphIO::write(G, "output-acyclic-graph.dot", ogdf::GraphIO::writeDOT);
#endif
}

TEST(mvp_ogdf_examples_basic, manual)
{
    ogdf::Graph g;
    ogdf::GraphAttributes ga(g, ogdf::GraphAttributes::nodeGraphics | ogdf::GraphAttributes::edgeGraphics);
    const int LEN = 11;
    for (int i = 1; i < LEN; i++)
    {
        ogdf::node left = g.newNode();
        ga.x(left) = -5 * (i + 1);
        ga.y(left) = -20 * i;
        ga.width(left) = 10 * (i + 1);
        ga.height(left) = 15;

        ogdf::node bottom = g.newNode();
        ga.x(bottom) = 20 * (LEN - i);
        ga.y(bottom) = 5 * (LEN + 1 - i);
        ga.width(bottom) = 15;
        ga.height(bottom) = 10 * (LEN + 1 - i);

        ogdf::edge e = g.newEdge(left, bottom);
        ogdf::DPolyline& p = ga.bends(e);
        p.pushBack(ogdf::DPoint(10, -20 * i));
        p.pushBack(ogdf::DPoint(20 * (LEN - i), -10));
    }
#if 0
    ogdf::GraphIO::write(ga, fmt::format("{}/{}", ::testing::TempDir(), "output-manual.gml"), ogdf::GraphIO::writeGML);
    ogdf::GraphIO::write(ga, fmt::format("{}/{}", ::testing::TempDir(), "output-manual.svg"), ogdf::GraphIO::drawSVG);
#endif
}
