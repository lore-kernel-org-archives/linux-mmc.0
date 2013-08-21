From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 13/14] mmc: dw_mmc: amend use of idmac sw reset
Date: Wed, 21 Aug 2013 22:51:40 +0900
Message-ID: <003201ce9e75$90a44510$b1eccf30$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:37954 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619Ab3HUNvm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Aug 2013 09:51:42 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MRV007IOVU52720@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 21 Aug 2013 22:51:41 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Alim Akhtar' <alim.akhtar@samsung.com>

First, compiling warning along with previous change is removed.
[drivers/mmc/host/dw_mmc.c:1890:7: warning: unused variable 'ctrl']
And with the recommendation in manual, IDMAC software reset is followed
by dma-reset of the CTRL register in order to terminate the transfer.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index e4ee6e5..8c1926f 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -372,6 +372,14 @@ static void dw_mci_dma_cleanup(struct dw_mci *host)
 				     dw_mci_get_dma_dir(data));
 }
 
+static void dw_mci_idmac_reset(struct dw_mci *host)
+{
+	u32 bmod = mci_readl(host, BMOD);
+	/* Software reset of DMA */
+	bmod |= SDMMC_IDMAC_SWRESET;
+	mci_writel(host, BMOD, bmod);
+}
+
 static void dw_mci_idmac_stop_dma(struct dw_mci *host)
 {
 	u32 temp;
@@ -385,6 +393,7 @@ static void dw_mci_idmac_stop_dma(struct dw_mci *host)
 	/* Stop the IDMAC running */
 	temp = mci_readl(host, BMOD);
 	temp &= ~(SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB);
+	temp |= SDMMC_IDMAC_SWRESET;
 	mci_writel(host, BMOD, temp);
 }
 
@@ -476,7 +485,7 @@ static int dw_mci_idmac_init(struct dw_mci *host)
 	p->des3 = host->sg_dma;
 	p->des0 = IDMAC_DES0_ER;
 
-	mci_writel(host, BMOD, SDMMC_IDMAC_SWRESET);
+	dw_mci_idmac_reset(host);
 
 	/* Mask out interrupts - get Tx & Rx complete only */
 	mci_writel(host, IDSTS, IDMAC_INT_CLR);
@@ -1899,7 +1908,6 @@ static void dw_mci_work_routine_card(struct work_struct *work)
 		struct mmc_host *mmc = slot->mmc;
 		struct mmc_request *mrq;
 		int present;
-		u32 ctrl;
 
 		present = dw_mci_get_cd(mmc);
 		while (present != slot->last_detect_state) {
@@ -1967,10 +1975,7 @@ static void dw_mci_work_routine_card(struct work_struct *work)
 				/* Clear down the FIFO */
 				dw_mci_fifo_reset(host);
 #ifdef CONFIG_MMC_DW_IDMAC
-				ctrl = mci_readl(host, BMOD);
-				/* Software reset of DMA */
-				ctrl |= SDMMC_IDMAC_SWRESET;
-				mci_writel(host, BMOD, ctrl);
+				dw_mci_idmac_reset(host);
 #endif
 
 			}
-- 
1.7.4.1


