From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] mmc: mmci: Support for DDR mode
Date: Wed, 12 Dec 2012 15:59:08 +0100
Message-ID: <1355324348-11481-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:46436 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754535Ab2LLO7n (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Dec 2012 09:59:43 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

Add support for DDR mode which may be used for the ux500v2 variant.
Corresponding capabilities to enable the DDR support must be set in
the platform struct to enable the functionality.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index aa04b42..4e4f5f1 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -202,6 +202,9 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 	if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_8)
 		clk |= MCI_ST_8BIT_BUS;
 
+	if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50)
+		clk |= MCI_ST_UX500_NEG_EDGE;
+
 	mmci_write_clkreg(host, clk);
 }
 
@@ -680,6 +683,9 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 			mmci_write_clkreg(host, clk);
 		}
 
+	if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50)
+		datactrl |= MCI_ST_DPSM_DDRMODE;
+
 	/*
 	 * Attempt to use DMA operation mode, if this
 	 * should fail, fall back to PIO mode
-- 
1.7.10

