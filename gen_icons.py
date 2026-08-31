from PIL import Image, ImageDraw, ImageFont
import os

OUT = r"D:\01. Productivity\Personal\muse spark 1.2 free\duitku\android\app\src\main\res"

# sizes per density
SIZES = {
    "mipmap-mdpi": 48,
    "mipmap-hdpi": 72,
    "mipmap-xhdpi": 96,
    "mipmap-xxhdpi": 144,
    "mipmap-xxxhdpi": 192,
}

def draw(size):
    im = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw2 = ImageDraw.Draw(im)

    # Gradient background
    for y in range(size):
        ratio = y / size
        r = int(15 + (4 - 15) * ratio)
        g = int(157 + (71 - 157) * ratio)
        b = int(88 + (58 - 88) * ratio)
        draw2.rectangle([0, y, size, y + 1], fill=(r, g, b, 255))

    # White circle
    pad = int(size * 0.1)
    draw2.ellipse(
        [pad, pad, size - pad, size - pad],
        fill=(255, 255, 255, 255),
        outline=None
    )

    # Rp text
    try:
        font_size = max(int(size * 0.22), 8)
        font = ImageFont.truetype(r"C:\Windows\Fonts\segoeui.ttf", font_size)
    except:
        font = ImageFont.load_default()

    text = "Rp"
    bbox = draw2.textbbox((0, 0), text, font=font)
    tw = bbox[2] - bbox[0]
    th = bbox[3] - bbox[1]
    tx = (size - tw) // 2
    ty = (size - th) // 2 - int(size * 0.02)
    draw2.text((tx, ty), text, fill=(15, 157, 88, 255), font=font)

    return im

def save(size, folder):
    path = os.path.join(OUT, folder)
    os.makedirs(path, exist_ok=True)
    im = draw(size)
    im.save(os.path.join(path, "ic_launcher.png"), "PNG")
    print(f"  {folder}/ic_launcher.png ({size}x{size}) OK")

# Splash/icon 512 for Play Store
def splash512():
    path = os.path.join(OUT, "mipmap-xxxhdpi")
    os.makedirs(path, exist_ok=True)
    im = draw(512)
    # Add shadow
    shadow = im.copy()
    shadow_img = Image.new("RGBA", (540, 540), (0, 0, 0, 0))
    shadow_img.paste(shadow, (14, 14))
    im_full = Image.new("RGBA", (512, 512), (255, 255, 255, 255))
    im_full.paste(shadow_img, (0, 0), shadow_img)
    im_full.save(os.path.join(path, "ic_launcher.png"), "PNG")
    print(f"  512x512 icon OK (as ic_launcher.png in xxxhdpi)")

for folder, size in SIZES.items():
    save(size, folder)

splash512()
print("All icons generated!")
