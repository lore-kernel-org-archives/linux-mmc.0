From: Johan Rudholm <johan.rudholm@axis.com>
Subject: [PATCH v7 3/3] mmc: sd: add reset bus_ops callback
Date: Mon, 12 Jan 2015 15:38:06 +0100
Message-ID: <1421073486-10903-4-git-send-email-johanru@axis.com>
References: <1421073486-10903-1-git-send-email-johanru@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:45506 "EHLO
	bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742AbbALOiT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Jan 2015 09:38:19 -0500
In-Reply-To: <1421073486-10903-1-git-send-email-johanru@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>, Johan Rudholm <johanru@axis.com>

Enable power cycle and re-initialization of SD cards via the reset
bus_ops. Power cycling a buggy SD card sometimes helps it get back on
track.

Signed-off-by: Johan Rudholm <johanru@axis.com>
---
 drivers/mmc/core/sd.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 29fccdc..36d5333 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1197,6 +1197,12 @@ static int mmc_sd_power_restore(struct mmc_host *host)
 	return ret;
 }
 
+static int mmc_sd_reset(struct mmc_host *host)
+{
+	mmc_power_cycle(host, host->card->ocr);
+	return mmc_sd_power_restore(host);
+}
+
 static const struct mmc_bus_ops mmc_sd_ops = {
 	.remove = mmc_sd_remove,
 	.detect = mmc_sd_detect,
@@ -1207,6 +1213,7 @@ static const struct mmc_bus_ops mmc_sd_ops = {
 	.power_restore = mmc_sd_power_restore,
 	.alive = mmc_sd_alive,
 	.shutdown = mmc_sd_suspend,
+	.reset = mmc_sd_reset,
 };
 
 /*
-- 
1.7.2.5

