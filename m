From: Johan Rudholm <johan.rudholm@axis.com>
Subject: [PATCH v4 2/2] mmc: sd: add hw_reset callback
Date: Mon, 24 Nov 2014 12:06:38 +0100
Message-ID: <1416827198-29820-3-git-send-email-johanru@axis.com>
References: <1416827198-29820-1-git-send-email-johanru@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:38356 "EHLO
	bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbaKXLGv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Nov 2014 06:06:51 -0500
In-Reply-To: <1416827198-29820-1-git-send-email-johanru@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>, Johan Rudholm <johanru@axis.com>

Enable power cycle and re-initialization of SD cards via the hw_reset
bus_ops. Power cycling a buggy SD card sometimes helps it get back on
track.

Signed-off-by: Johan Rudholm <johanru@axis.com>
---
 drivers/mmc/core/sd.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index d90a6de..a7fa124 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1180,6 +1180,18 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
 	return 0;
 }
 
+static int mmc_sd_hw_reset(struct mmc_host *host, int test)
+{
+	struct mmc_card *card = host->card;
+
+	if (test == MMC_HW_RESET_TEST || test == MMC_HW_RESET_TEST_CARD)
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
@@ -1201,6 +1213,7 @@ static const struct mmc_bus_ops mmc_sd_ops = {
 	.power_restore = mmc_sd_power_restore,
 	.alive = mmc_sd_alive,
 	.shutdown = mmc_sd_suspend,
+	.hw_reset = mmc_sd_hw_reset,
 };
 
 /*
-- 
1.7.2.5

