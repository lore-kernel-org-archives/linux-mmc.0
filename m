From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] dw_mmc: support send_auto_stop
Date: Wed, 30 Mar 2011 14:55:30 +0900
Message-ID: <4D92C5D2.2000004@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:9773 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967Ab1C3F4o (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2011 01:56:44 -0400
Received: from epmmp2 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LIU00APTWIHP480@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 30 Mar 2011 14:56:41 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LIU00IZGWII73@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 30 Mar 2011 14:56:42 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: will.newton@imgtec.com, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

This patch is set the send_auto_stop bit in CMD register.
If use DW_MCI_QUIRK_SEND_AUTO_STOP, helps to send an exact
number of data bytes.


Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c  |   10 ++++++++++
 include/linux/mmc/dw_mmc.h |    2 ++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 87e1f57..6c4cb46 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -229,6 +229,8 @@ static void dw_mci_set_timeout(struct dw_mci *host)
 
 static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 {
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct dw_mci *host = slot->host;
 	struct mmc_data	*data;
 	u32 cmdr;
 	cmd->error = -EINPROGRESS;
@@ -257,6 +259,9 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 			cmdr |= SDMMC_CMD_STRM_MODE;
 		if (data->flags & MMC_DATA_WRITE)
 			cmdr |= SDMMC_CMD_DAT_WR;
+		if ((host->quirks & DW_MCI_QUIRK_SEND_AUTO_STOP) &&
+				(data->blocks > 1))
+			cmdr |= SDMMC_CMD_SEND_STOP;
 	}
 
 	return cmdr;
@@ -656,6 +661,11 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		return;
 	}
 
+	if ((host->quirks & DW_MCI_QUIRK_SEND_AUTO_STOP) && mrq->stop) {
+		mrq->data->stop = NULL;
+		mrq->stop = NULL;
+	}
+
 	/* We don't support multiple blocks of weird lengths. */
 	dw_mci_queue_request(host, slot, mrq);
 }
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index c0207a7..b98aafa 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -176,6 +176,8 @@ struct dw_mci_dma_ops {
 #define DW_MCI_QUIRK_HIGHSPEED			BIT(2)
 /* Unreliable card detection */
 #define DW_MCI_QUIRK_BROKEN_CARD_DETECTION	BIT(3)
+/* Use Auto_Send_Stop Command */
+#define DW_MCI_QUIRK_SEND_AUTO_STOP		BIT(4)
 
 
 struct dma_pdata;
