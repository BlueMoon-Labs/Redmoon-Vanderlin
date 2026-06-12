"""Generate erp_prefs.png / erp_prefs_hover.png for character UI themes."""
from pathlib import Path

from PIL import Image

BASE = Path(__file__).resolve().parents[1] / "html" / "character_ui"
THEMES = ("dusty", "grimshart", "paper", "parchment")
TEXT = "ERP PREFS"
TEXT_X = 3


GLYPHS = {
    " ": [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]],
    "E": [[1, 1, 1], [1, 0, 0], [1, 1, 0], [1, 0, 0], [1, 1, 1]],
    "R": [[1, 1, 0], [1, 0, 1], [1, 1, 0], [1, 0, 1], [1, 0, 1]],
    "P": [[1, 1, 1], [1, 0, 1], [1, 1, 1], [1, 0, 0], [1, 0, 0]],
    "F": [[1, 1, 1], [1, 0, 0], [1, 1, 0], [1, 0, 0], [1, 0, 0]],
    "S": [[0, 1, 1], [1, 0, 0], [0, 1, 0], [0, 0, 1], [1, 1, 0]],
}


def sample_text_color(img: Image.Image) -> tuple:
    px = img.load()
    width, height = img.size
    for x in range(2, width - 6):
        for y in range(height):
            color = px[x, y]
            if len(color) == 4 and color[3] == 0:
                continue
            if sum(color[:3]) < 500:
                return color
    return (0, 0, 0, 255)


def clear_text_area(img: Image.Image) -> None:
    px = img.load()
    width, height = img.size
    bg = px[1, height // 2]
    for x in range(1, width - 5):
        for y in range(height):
            px[x, y] = bg


def draw_text(img: Image.Image, text: str, x: int, y: int, fg) -> None:
    px = img.load()
    cx = x
    for ch in text:
        glyph = GLYPHS.get(ch, GLYPHS[" "])
        for row in range(5):
            for col in range(3):
                if not glyph[row][col]:
                    continue
                px[cx + col, y + row] = fg
        cx += 4


def make_button(src_path: Path, dst_path: Path, hover: bool) -> None:
    img = Image.open(src_path).convert("RGBA")
    clear_text_area(img)
    if hover:
        fg = (255, 255, 255, 255)
    else:
        fg = sample_text_color(Image.open(src_path).convert("RGBA"))
    draw_text(img, TEXT, TEXT_X, 2, fg)
    img.save(dst_path)


def main() -> None:
    for theme in THEMES:
        family_dir = BASE / theme / "family"
        family_dir.mkdir(parents=True, exist_ok=True)
        src = BASE / theme / "flavour" / "flavour_foodprefs.png"
        make_button(src, family_dir / "erp_prefs.png", hover=False)
        make_button(src, family_dir / "erp_prefs_hover.png", hover=True)
        print(f"Generated {theme}")


if __name__ == "__main__":
    main()
