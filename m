From: Kyoungil Kim <ki0351.kim@samsung.com>
Subject: [PATCH] mmc: dw_mmc: Fixed sdio interrupt mask bit setting bug
Date: Mon, 14 May 2012 17:38:48 +0900
Message-ID: <002901cd31ac$fb410250$f1c306f0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:36519 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331Ab2ENIit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 May 2012 04:38:49 -0400
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Kyoungil Kim' <ki0351.kim@samsung.com>, 'Kukjin Kim' <kgene.kim@samsung.com>

The sdio interrupt mask bits are arranged in [31:16].
(1 << SDMMC_INT_SDIO(slot->id))) does 16 bits left shift twice.
So this patch changes to do 16 bits left shift only one time.

Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1532357..9bbf45f 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -857,10 +857,10 @@ static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
 	int_mask = mci_readl(host, INTMASK);
 	if (enb) {
 		mci_writel(host, INTMASK,
-			   (int_mask | (1 << SDMMC_INT_SDIO(slot->id))));
+			   (int_mask | SDMMC_INT_SDIO(slot->id)));
 	} else {
 		mci_writel(host, INTMASK,
-			   (int_mask & ~(1 << SDMMC_INT_SDIO(slot->id))));
+			   (int_mask & ~SDMMC_INT_SDIO(slot->id)));
 	}
 }
 
-- 
1.7.1

