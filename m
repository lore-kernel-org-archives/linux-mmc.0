From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 08/14] mmc: dw_mmc: control card read threshold
Date: Wed, 21 Aug 2013 22:50:50 +0900
Message-ID: <002d01ce9e75$72443d00$56ccb700$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:44177 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816Ab3HUNuv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Aug 2013 09:50:51 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MRV00AQKVSQBOD0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 21 Aug 2013 22:50:50 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Alim Akhtar' <alim.akhtar@samsung.com>

>From 1b6f8985c0e77ac0022f86d80408cbc7b5b01ae1 Mon Sep 17 00:00:00 2001
From: Seungwon Jeon <tgih.jun@samsung.com>
Date: Tue, 13 Aug 2013 16:03:18 +0900
Subject: [PATCH 08/14] mmc: dw_mmc: control card read threshold

Card Read Threshold should be ensured that the card clock does
not stop in the middle of a block of data being transferred
from the card to the Host. Specially, clock stop is allowed
in fast transfer such as HS200 or SDR104 mode. And so, it
should be enabled.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c  |   38 ++++++++++++++++++++++++++++++++++++--
 drivers/mmc/host/dw_mmc.h  |    3 +++
 include/linux/mmc/dw_mmc.h |    1 +
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b8ba707..486024c 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -570,6 +570,37 @@ done:
 #endif
 }
 
+static void dw_mci_ctrl_rd_thld(struct dw_mci *host, struct mmc_data *data)
+{
+	unsigned int blksz = data->blksz;
+	u32 blksz_depth, fifo_depth;
+	u16 thld_size;
+
+	WARN_ON(!(data->flags & MMC_DATA_READ));
+
+	if (host->timing != MMC_TIMING_MMC_HS200 &&
+	    host->timing != MMC_TIMING_UHS_SDR104)
+		goto disable;
+
+	blksz_depth = blksz / (1 << host->data_shift);
+	fifo_depth = host->fifo_depth;
+
+	if (blksz_depth > fifo_depth)
+		goto disable;
+
+	/*
+	 * If (blksz_depth) >= (fifo_depth >> 1), should be 'thld_size <= blksz'
+	 * If (blksz_depth) <  (fifo_depth >> 1), should be thld_size = blksz
+	 * Currently just choose blksz.
+	 */
+	thld_size = blksz;
+	mci_writel(host, CDTHRCTL, SDMMC_SET_RD_THLD(thld_size, 1));
+	return;
+
+disable:
+	mci_writel(host, CDTHRCTL, SDMMC_SET_RD_THLD(0, 0));
+}
+
 static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
 {
 	int sg_len;
@@ -627,10 +658,12 @@ static void dw_mci_submit_data(struct dw_mci *host, struct mmc_data *data)
 	host->sg = NULL;
 	host->data = data;
 
-	if (data->flags & MMC_DATA_READ)
+	if (data->flags & MMC_DATA_READ) {
 		host->dir_status = DW_MCI_RECV_STATUS;
-	else
+		dw_mci_ctrl_rd_thld(host, data);
+	} else {
 		host->dir_status = DW_MCI_SEND_STATUS;
+	}
 
 	if (dw_mci_submit_data_dma(host, data)) {
 		int flags = SG_MITER_ATOMIC;
@@ -867,6 +900,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		regs &= ~((0x1 << slot->id) << 16);
 
 	mci_writel(slot->host, UHS_REG, regs);
+	slot->host->timing = ios->timing;
 
 	if (ios->clock) {
 		/*
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 4002c84..4b8e19d 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -53,6 +53,7 @@
 #define SDMMC_IDINTEN		0x090
 #define SDMMC_DSCADDR		0x094
 #define SDMMC_BUFADDR		0x098
+#define SDMMC_CDTHRCTL		0x100
 #define SDMMC_DATA(x)		(x)
 
 /*
@@ -146,6 +147,8 @@
 #define SDMMC_IDMAC_SWRESET		BIT(0)
 /* Version ID register define */
 #define SDMMC_GET_VERID(x)		((x) & 0xFFFF)
+/* Card read threshold */
+#define SDMMC_SET_RD_THLD(v, x)		(((v) & 0x1FFF) << 16 | (x))
 
 /* Register access macros */
 #define mci_readl(dev, reg)			\
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 4ec9dcc..a829f7e 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -130,6 +130,7 @@ struct dw_mci {
 	struct mmc_command	*cmd;
 	struct mmc_data		*data;
 	unsigned int		prev_blksz;
+	unsigned char		timing;
 	struct workqueue_struct	*card_workqueue;
 
 	/* DMA interface members*/
-- 
1.7.4.1


