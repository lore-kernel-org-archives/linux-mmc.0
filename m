From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH v2] mmc: dw_mmc: clear IDSTS register when initialize IDMAC
Date: Fri, 26 Apr 2013 15:35:22 +0900
Message-ID: <1366958122-14869-1-git-send-email-jy0922.shim@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:38335 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096Ab3DZGfZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Apr 2013 02:35:25 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MLU007R3NLZE9R0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 26 Apr 2013 15:35:23 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: jh80.chung@samsung.com, tgih.jun@samsung.com, cjb@laptop.org, will.newton@gmail.com

If pending interrupt for IDMAC exists when initialize IDMAC, it will
call interrupt handler unnecessarily.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
Changes from previous patch v1:
- Change subject and contents of commit
- Define IDMAC_INT_CLR macro to clear IDSTS register
- It moved to clear IDSTS register in dw_mci_idmac_init()

 drivers/mmc/host/dw_mmc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index bc3a1bc..4abb3f8 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -51,6 +51,11 @@
 #define DW_MCI_DMA_THRESHOLD	16
 
 #ifdef CONFIG_MMC_DW_IDMAC
+#define IDMAC_INT_CLR		(SDMMC_IDMAC_INT_AI | SDMMC_IDMAC_INT_NI | \
+				 SDMMC_IDMAC_INT_CES | SDMMC_IDMAC_INT_DU | \
+				 SDMMC_IDMAC_INT_FBE | SDMMC_IDMAC_INT_RI | \
+				 SDMMC_IDMAC_INT_TI)
+
 struct idmac_desc {
 	u32		des0;	/* Control Descriptor */
 #define IDMAC_DES0_DIC	BIT(1)
@@ -433,6 +438,7 @@ static int dw_mci_idmac_init(struct dw_mci *host)
 	mci_writel(host, BMOD, SDMMC_IDMAC_SWRESET);
 
 	/* Mask out interrupts - get Tx & Rx complete only */
+	mci_writel(host, IDSTS, IDMAC_INT_CLR);
 	mci_writel(host, IDINTEN, SDMMC_IDMAC_INT_NI | SDMMC_IDMAC_INT_RI |
 		   SDMMC_IDMAC_INT_TI);
 
-- 
1.8.1.2

