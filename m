From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] dw_mmc: support DDR mode
Date: Thu, 24 Feb 2011 13:46:11 +0900
Message-ID: <4D65E293.2040008@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:14974 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751Ab1BXFAb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Feb 2011 00:00:31 -0500
Received: from epmmp1 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LH300GNCUL07400@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 24 Feb 2011 13:46:13 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LH300AZNUL08O@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 24 Feb 2011 13:46:12 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: will.newton@imgtec.com, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

This patch is applied DDR mode in dw_mmc.

DW_MMC is supported DDR mode. 
If set any bit in UHS_REG bit[16:31], the card of that slot is supported DDR mode.
For example, if UHS_REG[16] is set, card number 0 is DDR mode.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    8 ++++++++
 drivers/mmc/host/dw_mmc.h |    2 +-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 62c8440..58476c1 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -662,6 +662,7 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct dw_mci_slot *slot = mmc_priv(mmc);
+	u32 regs;
 
 	/* set default 1 bit mode */
 	slot->ctype = SDMMC_CTYPE_1BIT;
@@ -678,6 +679,13 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	}
 
+	/* DDR mode set */
+	if (ios->ddr) {
+		regs = mci_readl(slot->host, UHS_REG);
+		regs |= (0x1 << slot->id) << 16;
+		mci_writel(slot->host, UHS_REG, regs);
+	}
+
 	if (ios->clock) {
 		/*
 		 * Use mirror of ios->clock to prevent race with mmc
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 5dd55a7..23c662a 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -43,6 +43,7 @@
 #define SDMMC_USRID		0x068
 #define SDMMC_VERID		0x06c
 #define SDMMC_HCON		0x070
+#define SDMMC_UHS_REG		0x074
 #define SDMMC_BMOD		0x080
 #define SDMMC_PLDMND		0x084
 #define SDMMC_DBADDR		0x088
@@ -51,7 +52,6 @@
 #define SDMMC_DSCADDR		0x094
 #define SDMMC_BUFADDR		0x098
 #define SDMMC_DATA		0x100
-#define SDMMC_DATA_ADR		0x100
 
 /* shift bit field */
 #define _SBF(f, v)		((v) << (f))
