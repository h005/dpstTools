function vl_slic_show(image, segments)

[sx, sy] = vl_grad(double(segments), 'type', 'forward');
s = find(sx | sy);
size(find(sx | sy))
im = image;
im([s, s + numel(image(:,:,1)), s + 2 * numel(image(:,:,1))]) = 0;

imshow(im)
