From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 15/16] video: fbdev: pxafb: use new match_string() helper/macro
Date: Wed, 8 May 2019 14:28:41 +0300
Message-ID: <20190508112842.11654-17-alexandru.ardelean@analog.com>
References: <20190508112842.11654-1-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190508112842.11654-1-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org, linux-usb@vger.kernel.org, kvm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-mtd@lists.infradead.org, cgroups@vger.kernel.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org
Cc: gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com, Alexandru Ardelean <alexandru.ardelean@analog.com>
List-Id: linux-mmc@vger.kernel.org

The `lcd_types` array is a static array of strings.
Using match_string() (which computes the array size via ARRAY_SIZE())
is possible.

This reduces the array by 1 element, since the NULL (at the end of the
array) is no longer needed.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/video/fbdev/pxafb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 0025781e6e1e..e657a04f5b1d 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2114,7 +2114,7 @@ static void pxafb_check_options(struct device *dev, struct pxafb_mach_info *inf)
 #if defined(CONFIG_OF)
 static const char * const lcd_types[] = {
 	"unknown", "mono-stn", "mono-dstn", "color-stn", "color-dstn",
-	"color-tft", "smart-panel", NULL
+	"color-tft", "smart-panel"
 };
 
 static int of_get_pxafb_display(struct device *dev, struct device_node *disp,
@@ -2129,7 +2129,7 @@ static int of_get_pxafb_display(struct device *dev, struct device_node *disp,
 	if (ret)
 		s = "color-tft";
 
-	i = __match_string(lcd_types, -1, s);
+	i = match_string(lcd_types, s);
 	if (i < 0) {
 		dev_err(dev, "lcd-type %s is unknown\n", s);
 		return i;
-- 
2.17.1
