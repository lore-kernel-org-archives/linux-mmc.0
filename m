From: Arend van Spriel <arend@broadcom.com>
Subject: [PATCH] mmc: add SDIO identifiers for Broadcom WLAN devices
Date: Mon, 23 Dec 2013 22:37:01 +0100
Message-ID: <1387834621-4813-1-git-send-email-arend@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:28540 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757898Ab3LWVhF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Dec 2013 16:37:05 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Arend van Spriel <arend@broadcom.com>

The SDIO identifier for Broadcom WLAN devices were defined in the
brcmfmac SDIO driver. Moving the definitions in MMC header file
seems common sense.

Reviewed-by: Hante Meuleman <meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieterpg@broadcom.com>
Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
Moved vendor and device definitions in sdio_ids.h. Can split up in
two patches but they are clearly related.

Regards,
Arend
---
 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh_sdmmc.c |    2 --
 drivers/net/wireless/brcm80211/brcmfmac/sdio_chip.c    |    1 +
 drivers/net/wireless/brcm80211/brcmfmac/sdio_chip.h    |    8 --------
 include/linux/mmc/sdio_ids.h                           |   10 ++++++++++
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/brcm80211/brcmfmac/bcmsdh_sdmmc.c b/drivers/net/wireless/brcm80211/brcmfmac/bcmsdh_sdmmc.c
index 905704e..2274c64 100644
--- a/drivers/net/wireless/brcm80211/brcmfmac/bcmsdh_sdmmc.c
+++ b/drivers/net/wireless/brcm80211/brcmfmac/bcmsdh_sdmmc.c
@@ -39,8 +39,6 @@
 #include "dhd_dbg.h"
 #include "dhd_bus.h"
 
-#define SDIO_VENDOR_ID_BROADCOM		0x02d0
-
 #define DMA_ALIGN_MASK	0x03
 
 #define SDIO_FUNC1_BLOCKSIZE		64
diff --git a/drivers/net/wireless/brcm80211/brcmfmac/sdio_chip.c b/drivers/net/wireless/brcm80211/brcmfmac/sdio_chip.c
index 2096a14..a119808 100644
--- a/drivers/net/wireless/brcm80211/brcmfmac/sdio_chip.c
+++ b/drivers/net/wireless/brcm80211/brcmfmac/sdio_chip.c
@@ -19,6 +19,7 @@
 #include <linux/netdevice.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/sdio_func.h>
+#include <linux/mmc/sdio_ids.h>
 #include <linux/ssb/ssb_regs.h>
 #include <linux/bcma/bcma.h>
 
diff --git a/drivers/net/wireless/brcm80211/brcmfmac/sdio_chip.h b/drivers/net/wireless/brcm80211/brcmfmac/sdio_chip.h
index 507c61c..f0780ee 100644
--- a/drivers/net/wireless/brcm80211/brcmfmac/sdio_chip.h
+++ b/drivers/net/wireless/brcm80211/brcmfmac/sdio_chip.h
@@ -54,14 +54,6 @@
 
 #define BRCMF_MAX_CORENUM	6
 
-/* SDIO device ID */
-#define SDIO_DEVICE_ID_BROADCOM_43143		43143
-#define SDIO_DEVICE_ID_BROADCOM_43241		0x4324
-#define SDIO_DEVICE_ID_BROADCOM_4329		0x4329
-#define SDIO_DEVICE_ID_BROADCOM_4330		0x4330
-#define SDIO_DEVICE_ID_BROADCOM_4334		0x4334
-#define SDIO_DEVICE_ID_BROADCOM_4335_4339	0x4335
-
 struct chip_core_info {
 	u16 id;
 	u16 rev;
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 9f03fee..0f01fe0 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -23,6 +23,16 @@
 /*
  * Vendors and devices.  Sort key: vendor first, device next.
  */
+#define SDIO_VENDOR_ID_BROADCOM			0x02d0
+#define SDIO_DEVICE_ID_BROADCOM_43143		43143
+#define SDIO_DEVICE_ID_BROADCOM_43241		0x4324
+#define SDIO_DEVICE_ID_BROADCOM_4329		0x4329
+#define SDIO_DEVICE_ID_BROADCOM_4330		0x4330
+#define SDIO_DEVICE_ID_BROADCOM_4334		0x4334
+#define SDIO_DEVICE_ID_BROADCOM_4335_4339	0x4335
+#define SDIO_DEVICE_ID_BROADCOM_43362		43362
+#define SDIO_DEVICE_ID_BROADCOM_4354		0x4354
+
 #define SDIO_VENDOR_ID_INTEL			0x0089
 #define SDIO_DEVICE_ID_INTEL_IWMC3200WIMAX	0x1402
 #define SDIO_DEVICE_ID_INTEL_IWMC3200WIFI	0x1403
-- 
1.7.10.4

