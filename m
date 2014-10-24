From: Johan Rudholm <johan.rudholm@axis.com>
Subject: [PATCH 4/4] mmc: sd: add power_reset callback
Date: Fri, 24 Oct 2014 14:46:30 +0200
Message-ID: <1414154790-20893-5-git-send-email-johanru@axis.com>
References: <1414154790-20893-1-git-send-email-johanru@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:49536 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756438AbaJXMrV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 24 Oct 2014 08:47:21 -0400
In-Reply-To: <1414154790-20893-1-git-send-email-johanru@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>, Johan Rudholm <johanru@axis.com>

Enable power cycle and re-initialization of SD cards via the mmc_reset
function. Power cycling a buggy SD card sometimes helps it get back on
track.

Signed-off-by: Johan Rudholm <johanru@axis.com>
---
 drivers/mmc/core/sd.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 0c44510..9ad46b2 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1177,6 +1177,21 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
 	return 0;
 }
 
+static int mmc_sd_power_reset(struct mmc_host *host, int test)
+{
+	struct mmc_card *card = host->card;
+
+	if (!card)
+		return -EINVAL;
+
+	if (test == MMC_POWER_RESET_TEST)
+		return 0;
+
+	mmc_power_cycle(host, card->ocr);
+
+	return 0;
+}
+
 static int mmc_sd_power_restore(struct mmc_host *host)
 {
 	int ret;
@@ -1196,6 +1211,7 @@ static const struct mmc_bus_ops mmc_sd_ops = {
 	.suspend = mmc_sd_suspend,
 	.resume = mmc_sd_resume,
 	.power_restore = mmc_sd_power_restore,
+	.power_reset = mmc_sd_power_reset,
 	.alive = mmc_sd_alive,
 	.shutdown = mmc_sd_suspend,
 };
-- 
1.7.2.5

