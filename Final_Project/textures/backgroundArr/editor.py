from PIL import Image, ImageEnhance

img = Image.open("original.jpg").convert("RGB")

img_enhancer = ImageEnhance.Brightness(img)

high = 1.2
low = 0.5
frames = 50
rate_of_increase = (high - low) / (frames - 1) 
# 0.5 to 1.5
# 3
# 0.5
# 1
# 1.5

# 1 to 4
# 4
# 1
# 2
# 3 
# 4
for i in range(frames):
    factor = low + rate_of_increase * i
    enhanced_output = img_enhancer.enhance(factor)
    enhanced_output.save(str(i) + ".png")
#0.5 to 1.3
#factor = 1.3

