From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 16/22] mmc: dw_mmc: control card read threshold
Date: Sat, 31 Aug 2013 00:13:55 +0900
Message-ID: <001301cea593$8b01f560$a105e020$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:20278 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756321Ab3H3PN4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Aug 2013 11:13:56 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSC00HI7NN7WSA0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 31 Aug 2013 00:13:55 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>

Card Read Threshold should be ensured that the card clock does
not stop in the middle of a block of data being transferred
from the card to the Host. Specially, clock stop is allowed
in fast transfer such as HS200 or SDR104 mode. And so, it
should be enabled.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/mmc/host/dw_mmc.c  |   38 ++++++++++++++++++++++++++++++++++++--
 drivers/mmc/host/dw_mmc.h  |    3 +++
 include/linux/mmc/dw_mmc.h |    1 +
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index ac4abf9..23c4c3c 100644
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
@@ -877,6 +910,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		regs &= ~((0x1 << slot->id) << 16);
 
 	mci_writel(slot->host, UHS_REG, regs);
+	slot->host->timing = ios->timing;
 
 	/*
 	 * Use mirror of ios->clock to prevent race with mmc
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index a0f2f8d..6bf24ab 100644
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
1.7.0.4


