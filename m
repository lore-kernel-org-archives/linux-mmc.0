From: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
Subject: [PATCH] mmc: sdhci-pxa: Check pdata before using its members
Date: Wed, 14 Sep 2011 11:29:02 +0530
Message-ID: <1315979942-4050-1-git-send-email-tanmay.upadhyay@einfochips.com>
References: <no>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ahm.einfochips.com ([203.76.128.206]:10752 "EHLO
	ahm.einfochips.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612Ab1INGIy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Sep 2011 02:08:54 -0400
In-Reply-To: <no>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei.gao@marvell.com, dwang4@marvell.com, njun@marvell.com, wuqm@marvell.com, prakity@marvell.com
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>

Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
---
 drivers/mmc/host/sdhci-pxav2.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 38f5899..1114fe2 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -59,7 +59,7 @@ static void pxav2_set_private_registers(struct sdhci_host *host, u8 mask)
 		 * tune timing of read data/command when crc error happen
 		 * no performance impact
 		 */
-		if (pdata->clk_delay_sel == 1) {
+		if (pdata && pdata->clk_delay_sel == 1) {
 			tmp = readw(host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
 
 			tmp &= ~(SDCLK_DELAY_MASK << SDCLK_DELAY_SHIFT);
@@ -71,7 +71,7 @@ static void pxav2_set_private_registers(struct sdhci_host *host, u8 mask)
 			writew(tmp, host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
 		}
 
-		if (pdata->flags & PXA_FLAG_ENABLE_CLOCK_GATING) {
+		if (pdata && (pdata->flags & PXA_FLAG_ENABLE_CLOCK_GATING)) {
 			tmp = readw(host->ioaddr + SD_FIFO_PARAM);
 			tmp &= ~CLK_GATE_SETTING_BITS;
 			writew(tmp, host->ioaddr + SD_FIFO_PARAM);
-- 
1.7.0.4

