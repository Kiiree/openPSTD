//////////////////////////////////////////////////////////////////////////
// This file is part of openPSTD.                                       //
//                                                                      //
// openPSTD is free software: you can redistribute it and/or modify     //
// it under the terms of the GNU General Public License as published by //
// the Free Software Foundation, either version 3 of the License, or    //
// (at your option) any later version.                                  //
//                                                                      //
// openPSTD is distributed in the hope that it will be useful,          //
// but WITHOUT ANY WARRANTY; without even the implied warranty of       //
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        //
// GNU General Public License for more details.                         //
//                                                                      //
// You should have received a copy of the GNU General Public License    //
// along with openPSTD.  If not, see <http://www.gnu.org/licenses/>.    //
//                                                                      //
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
//
// Date: 26-8-2015
//
//
// Authors: M. R. Fortuin
//
//
// Purpose:
//
//
//////////////////////////////////////////////////////////////////////////

#ifndef OPENPSTD_SCENELAYER_H
#define OPENPSTD_SCENELAYER_H

#include "GUI/Viewer2D.h"
#include <vector>
#include <tuple>
#include "GUI/Edges.h"

namespace OpenPSTD
{
    namespace GUI
    {

        class SceneLayer : public Layer
        {
        private:
            struct DimensionText
            {
            public:
                QVector2D position;
                std::string text;
                TextHorizontalAlignment hAlign;
                TextVerticalAlignment vAlign;

                DimensionText(QVector2D position, std::string text, TextHorizontalAlignment hAlign,
                              TextVerticalAlignment vAlign):
                        position(position),
                        text(text),
                        hAlign(hAlign),
                        vAlign(vAlign)
                {}
            };

            std::unique_ptr<QOpenGLShaderProgram> program;
            unsigned int positionsBuffer;
            unsigned int valuesBuffer;
            int lines;
            float lineWidth;
            QMatrix4x4 viewMatrix;

            std::unique_ptr<std::vector<Edge>> GetAllEdges(std::shared_ptr<Model> const &m);
            std::unique_ptr<std::vector<DimensionText>> GetAllEdgeText(std::shared_ptr<Model> const &m);

            std::unique_ptr<std::vector<Edge>> RemoveDuplicateEdges(std::unique_ptr<std::vector<Edge>> edges);

            std::unique_ptr<std::vector<DimensionText>> dimensions;
        public:
            SceneLayer();

            virtual void InitializeGL(QObject *context, std::unique_ptr<QOpenGLFunctions, void (*)(void *)> const &f);

            virtual void PaintGL(QObject *context, std::unique_ptr<QOpenGLFunctions, void (*)(void *)> const &f);

            virtual void UpdateScene(std::shared_ptr<Model> const &m,
                                     std::unique_ptr<QOpenGLFunctions, void (*)(void *)> const &f);

            virtual MinMaxValue GetMinMax();
        };

    }
}

#endif //OPENPSTD_SCENELAYER_H
