From: Puthikorn Voravootivat <puthik@chromium.org>
Subject: [PATCH] dw-mmc: enable trim in eMMC device
Date: Fri,  7 Feb 2014 10:39:58 -0800
Message-ID: <1391798398-24634-1-git-send-email-puthik@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f73.google.com ([209.85.219.73]:52987 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbaBGSkC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Feb 2014 13:40:02 -0500
Received: by mail-oa0-f73.google.com with SMTP id i7so866317oag.2
        for <linux-mmc@vger.kernel.org>; Fri, 07 Feb 2014 10:40:01 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>
Cc: MMC list <linux-mmc@vger.kernel.org>, Gwendal Grignou <gwendal@chromium.org>, Grant Grundler <grundler@chromium.org>, Puthikorn Voravootivat <puthik@chromium.org>

Force host to have erase capacity to enable trim or
discard feature in supported eMMC device.

Signed-off-by: Puthikorn Voravootivat <puthik@chromium.org>
---
In mmc_init_queue() before setting up the discard function, mmc driver
will call mmc_can_erase() which will always return 0 because the host
erase capacity is not set anywhere. So to enable discard function, we
need to add erase capacity to the host.

 drivers/mmc/host/dw_mmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 55cd110..f47f1c1 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -55,6 +55,8 @@
 #define DW_MCI_FREQ_MAX	200000000	/* unit: HZ */
 #define DW_MCI_FREQ_MIN	400000		/* unit: HZ */
 
+#define DW_MCI_DEFAULT_CAPS (MMC_CAP_ERASE)
+
 #ifdef CONFIG_MMC_DW_IDMAC
 #define IDMAC_INT_CLR		(SDMMC_IDMAC_INT_AI | SDMMC_IDMAC_INT_NI | \
 				 SDMMC_IDMAC_INT_CES | SDMMC_IDMAC_INT_DU | \
@@ -2371,6 +2373,8 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 		return ERR_PTR(-ENOMEM);
 	}
 
+	pdata->caps |= DW_MCI_DEFAULT_CAPS;
+
 	/* find out number of slots supported */
 	if (of_property_read_u32(dev->of_node, "num-slots",
 				&pdata->num_slots)) {
-- 
1.9.0.rc1.175.g0b1dcb5

