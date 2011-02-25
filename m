From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 3/3] dw_mmc: add quirks unreliable detect and capabilities
Date: Fri, 25 Feb 2011 11:08:15 +0900
Message-ID: <4D670F0F.6050003@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:37823 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756448Ab1BYCI7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Feb 2011 21:08:59 -0500
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LH500EP9HXS3RA0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 25 Feb 2011 11:08:16 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LH500H5UHXSLD@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 25 Feb 2011 11:08:16 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: will.newton@imgtec.com, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

This patch added quirks and capabilities in platdata.

Some card didn't use the CDn pin. In that case, We assume card inserted,
then the card initialized or not.
And Some board need other capabilities. So added capabilities in board platdata.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c  |   10 ++++++++--
 include/linux/mmc/dw_mmc.h |   10 +++++++---
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 338fedc..6c01b1e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -730,7 +730,9 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 	struct dw_mci_board *brd = slot->host->pdata;
 
 	/* Use platform get_cd function, else try onboard card detect */
-	if (brd->get_cd)
+	if (brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
+		present = 1;
+	else if (brd->get_cd)
 		present = !brd->get_cd(slot->id);
 	else
 		present = (mci_readl(slot->host, CDETECT) & (1 << slot->id))
@@ -1408,7 +1410,11 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (host->pdata->setpower)
 		host->pdata->setpower(id, 0);
 
-	mmc->caps = 0;
+	if (host->pdata->caps)
+		mmc->caps = host->pdata->caps;
+	else
+		mmc->caps = 0;
+
 	if (host->pdata->get_bus_wd)
 		if (host->pdata->get_bus_wd(slot->id) >= 4)
 			mmc->caps |= MMC_CAP_4_BIT_DATA;
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index a39c497..45b9298 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -168,11 +168,13 @@ struct dw_mci_dma_ops {
 
 /* IP Quirks/flags. */
 /* DTO fix for command transmission with IDMAC configured */
-#define DW_MCI_QUIRK_IDMAC_DTO		BIT(0)
+#define DW_MCI_QUIRK_IDMAC_DTO			BIT(0)
 /* delay needed between retries on some 2.11a implementations */
-#define DW_MCI_QUIRK_RETRY_DELAY	BIT(1)
+#define DW_MCI_QUIRK_RETRY_DELAY		BIT(1)
 /* High Speed Capable - Supports HS cards (upto 50MHz) */
-#define DW_MCI_QUIRK_HIGHSPEED		BIT(2)
+#define DW_MCI_QUIRK_HIGHSPEED			BIT(2)
+/* Unreliable card detection */
+#define DW_MCI_QUIRK_BROKEN_CARD_DETECTION	BIT(3)
 
 
 struct dma_pdata;
@@ -192,6 +194,8 @@ struct dw_mci_board {
 	u32 quirks; /* Workaround / Quirk flags */
 	unsigned int bus_hz; /* Bus speed */
 
+	unsigned int caps;	/* Capabilities */
+
 	/* delay in mS before detecting cards after interrupt */
 	u32 detect_delay_ms;
 
