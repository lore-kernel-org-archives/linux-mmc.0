From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 2/5] mmc: core: move some sdio IDs out of quirks file
Date: Wed, 15 Feb 2017 16:35:29 +0800
Message-ID: <1487147732-81724-3-git-send-email-shawn.lin@rock-chips.com>
References: <1487147732-81724-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:46658 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdBOIiE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 03:38:04 -0500
In-Reply-To: <1487147732-81724-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

Consolidate all the sdio devices' IDs into sdio_ids.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 drivers/mmc/core/quirks.h    | 20 --------------------
 include/linux/mmc/sdio_ids.h |  7 +++++++
 2 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 1e56ec4..0749404 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -13,26 +13,6 @@
 
 #include "card.h"
 
-#ifndef SDIO_VENDOR_ID_TI
-#define SDIO_VENDOR_ID_TI		0x0097
-#endif
-
-#ifndef SDIO_DEVICE_ID_TI_WL1271
-#define SDIO_DEVICE_ID_TI_WL1271	0x4076
-#endif
-
-#ifndef SDIO_VENDOR_ID_STE
-#define SDIO_VENDOR_ID_STE		0x0020
-#endif
-
-#ifndef SDIO_DEVICE_ID_STE_CW1200
-#define SDIO_DEVICE_ID_STE_CW1200	0x2280
-#endif
-
-#ifndef SDIO_DEVICE_ID_MARVELL_8797_F0
-#define SDIO_DEVICE_ID_MARVELL_8797_F0	0x9128
-#endif
-
 static const struct mmc_fixup mmc_fixup_methods[] = {
 	SDIO_FIXUP(SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
 		   add_quirk, MMC_QUIRK_NONSTD_FUNC_IF),
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 71b113e..b733eb4 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -52,6 +52,7 @@
 #define SDIO_DEVICE_ID_MARVELL_LIBERTAS		0x9103
 #define SDIO_DEVICE_ID_MARVELL_8688WLAN		0x9104
 #define SDIO_DEVICE_ID_MARVELL_8688BT		0x9105
+#define SDIO_DEVICE_ID_MARVELL_8797_F0		0x9128
 
 #define SDIO_VENDOR_ID_SIANO			0x039a
 #define SDIO_DEVICE_ID_SIANO_NOVA_B0		0x0201
@@ -61,4 +62,10 @@
 #define SDIO_DEVICE_ID_SIANO_NOVA_A0		0x1100
 #define SDIO_DEVICE_ID_SIANO_STELLAR 		0x5347
 
+#define SDIO_VENDOR_ID_TI			0x0097
+#define SDIO_DEVICE_ID_TI_WL1271		0x4076
+
+#define SDIO_VENDOR_ID_STE			0x0020
+#define SDIO_DEVICE_ID_STE_CW1200		0x2280
+
 #endif /* LINUX_MMC_SDIO_IDS_H */
-- 
1.9.1


