//////////////////////////////////////////////////////////////////////////
//                                                                      //
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
#version 330

layout(points) in;
layout(triangle_strip, max_vertices = 48) out;

uniform mat4 u_view;

in vec4 v_color[];
out vec4 f_Color;

const float PI = 3.1415926;

void main()
{
    float SizeCircle = 0.1;
    int PointsInCircle = 16;

    f_Color = vec4(v_color[0].rgb, 0.35);

    for (int i = 0; i <= PointsInCircle; i++)
    {
        // Angle between each side in radians
        float ang = PI * 2.0 / PointsInCircle * i;
        float ang2 = PI * 2.0 / PointsInCircle * (i+1);

        // Offset from center of point (0.3 to accomodate for aspect ratio)
        vec4 offset = vec4(cos(ang) * SizeCircle, -sin(ang) * SizeCircle, 0.0, 0.0);
        vec4 offset2 = vec4(cos(ang2) * SizeCircle, -sin(ang2) * SizeCircle, 0.0, 0.0);

        gl_Position = u_view * (gl_in[0].gl_Position);
        EmitVertex();
        gl_Position = u_view * (gl_in[0].gl_Position + offset);
        EmitVertex();
        gl_Position = u_view * (gl_in[0].gl_Position + offset2);
        EmitVertex();

        EndPrimitive();
    }
}
