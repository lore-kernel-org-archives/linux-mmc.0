From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 02/14] ARM: omap2plus_defconfig: Enable CONFIG_MMC_SDHCI_OMAP
Date: Thu, 14 Dec 2017 19:10:42 +0530
Message-ID: <20171214134054.7749-3-kishon@ti.com>
References: <20171214134054.7749-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171214134054.7749-1-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Enable CONFIG_MMC_SDHCI_OMAP so that TI's dra7 based SoC's
can use sdhci-omap driver for eMMC/SD/SDIO controller.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 arch/arm/configs/omap2plus_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 7b97200c1d64..c70a00e1ff6a 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -423,8 +423,11 @@ CONFIG_USB_ZERO=m
 CONFIG_USB_G_NOKIA=m
 CONFIG_MMC=y
 CONFIG_SDIO_UART=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_OMAP=y
 CONFIG_MMC_OMAP_HS=y
+CONFIG_MMC_SDHCI_OMAP=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=m
 CONFIG_LEDS_CPCAP=m
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
