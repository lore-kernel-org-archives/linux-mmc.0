From: <a-bindra@ti.com>
Subject: [PATCH v2] mmc: omap_hsmmc: use the generic config for omap2plus devices
Date: Wed, 10 Jul 2013 21:36:24 +0530
Message-ID: <1373472384-13067-1-git-send-email-a-bindra@ti.com>
References: <1372422894-23729-1-git-send-email-a-bindra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60761 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753735Ab3GJQGx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 10 Jul 2013 12:06:53 -0400
In-Reply-To: <1372422894-23729-1-git-send-email-a-bindra@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>, Amarinder Bindra <a-bindra@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Felipe Balbi <balbi@ti.com>, Nishanth Menon <nm@ti.com>

From: Amarinder Bindra <a-bindra@ti.com>

OMAP's hs_mmc driver is used for MMC controller operation on many
omap2plus SoCs (OMAP2430, OMAP3, 4, 5 and AM335x).

Considering that the device tree entries are already present for these,
allow the driver to be built using the config ARCH_OMAP2PLUS rather
than individually adding a config for each SoC to enable the
support.

Use COMPILE_TEST to enable the build for other platforms.

Signed-off-by: Amarinder Bindra <a-bindra@ti.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Nishanth Menon <nm@ti.com>
---
Changes in v2:
- Use the config ARCH_OMAP2PLUS to enable the driver
- Use COMPILE_TEST
- Update the commit message

v1: https://patchwork.kernel.org/patch/2824632/ 

 drivers/mmc/host/Kconfig |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 009dabd..48f6fe7 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -254,11 +254,11 @@ config MMC_OMAP
 
 config MMC_OMAP_HS
 	tristate "TI OMAP High Speed Multimedia Card Interface support"
-	depends on SOC_OMAP2430 || ARCH_OMAP3 || ARCH_OMAP4
+	depends on ARCH_OMAP2PLUS || COMPILE_TEST
 	help
 	  This selects the TI OMAP High Speed Multimedia card Interface.
-	  If you have an OMAP2430 or OMAP3 board or OMAP4 board with a
-	  Multimedia Card slot, say Y or M here.
+	  If you have an omap2plus board with a Multimedia Card slot,
+	  say Y or M here.
 
 	  If unsure, say N.
 
-- 
1.7.9.5

