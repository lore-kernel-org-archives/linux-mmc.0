From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] mmc: mmci: Set actual clock for debug purpose
Date: Mon, 13 May 2013 16:18:39 +0200
Message-ID: <1368454719-16420-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:35734 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751071Ab3EMOTU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 May 2013 10:19:20 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>

From: Ulf Hansson <ulf.hansson@linaro.org>

Update cclk to the acutal used value and copy it to the actual_clock
variable in the mmc host for debug purpose.

Signed-off-by: Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index f4f3038..1170c9c 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -196,6 +196,9 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 	struct variant_data *variant = host->variant;
 	u32 clk = variant->clkreg;
 
+	/* Make sure cclk reflects the current calculated clock */
+	host->cclk = 0;
+
 	if (desired) {
 		if (desired >= host->mclk) {
 			clk = MCI_CLK_BYPASS;
@@ -230,6 +233,9 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 		/* clk |= MCI_CLK_PWRSAVE; */
 	}
 
+	/* Set actual clock for debug */
+	host->mmc->actual_clock = host->cclk;
+
 	if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_4)
 		clk |= MCI_4BIT_BUS;
 	if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_8)
-- 
1.7.10

