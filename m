From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH v4 3/5] OMAP4 HSMMC: Enable HSMMC support
Date: Sat, 15 May 2010 23:51:36 +0530 (IST)
Message-ID: <22509.10.24.255.17.1273947696.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, madhu.cr@ti.com, jarkko.lavinen@nokia.com, rmk@arm.linux.org.uk, paul@pwsan.com, santosh.shilimkar@ti.com
List-Id: linux-mmc@vger.kernel.org

Enables HSMMC support for OMAP4430 defconfig

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/configs/omap_4430sdp_defconfig |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
index 25e8d04..1fb0456 100644
--- a/arch/arm/configs/omap_4430sdp_defconfig
+++ b/arch/arm/configs/omap_4430sdp_defconfig
@@ -810,7 +810,24 @@ CONFIG_DUMMY_CONSOLE=y
 # CONFIG_SOUND is not set
 # CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
-# CONFIG_MMC is not set
+CONFIG_MMC=y
+# CONFIG_MMC_DEBUG is not set
+# CONFIG_MMC_UNSAFE_RESUME is not set
+
+#
+# MMC/SD/SDIO Card Drivers
+#
+CONFIG_MMC_BLOCK=y
+CONFIG_MMC_BLOCK_BOUNCE=y
+# CONFIG_SDIO_UART is not set
+# CONFIG_MMC_TEST is not set
+
+#
+# MMC/SD/SDIO Host Controller Drivers
+#
+# CONFIG_MMC_SDHCI is not set
+# CONFIG_MMC_OMAP is not set
+CONFIG_MMC_OMAP_HS=y
 # CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
 # CONFIG_ACCESSIBILITY is not set
-- 
1.6.3.3


