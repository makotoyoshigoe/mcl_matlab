classdef common
    methods(Static)
        function p = cmd_vel_to_pose(nu, omega, s_t, now_p)
            if omega == 0.0
                p(1) = now_p(1)+nu*cos(now_p(3))*s_t;
                p(2) = now_p(2)+nu*sin(now_p(3))*s_t;
            else
                theta_tmp = now_p(3) + omega*s_t;
                p(1) = now_p(1)+nu/omega*(sin(theta_tmp)-sin(now_p(3)));
                p(2) = now_p(2)+nu/omega*(-cos(theta_tmp)+cos(now_p(3)));
            end
            p(3) = now_p(3)+omega*s_t;
            while p(3) >= pi
                p(3) = p(3) - 2*pi;
            end
            while p(3) < -pi
                p(3) = p(3) + 2*pi;
            end
        end
        function z = polar_position(l_p, p)
            diff_x = l_p(1) - p(1);
            diff_y = l_p(2) - p(2);
            z = [sqrt(power(diff_x, 2)+power(diff_y, 2)) ...
                 atan2(diff_y, diff_x)-p(3)];
        end
    end
end