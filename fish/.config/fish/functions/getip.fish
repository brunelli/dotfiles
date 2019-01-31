function getip
    ip route get 8.8.8.8 | sed -n 's/.*src *\([^\/[:space:]]\+\).*/\1/p'
end
