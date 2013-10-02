From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 7/7] mmc: sh_mmcif: Extend clock gating routine for runtime suspend
Date: Wed,  2 Oct 2013 10:30:51 +0200
Message-ID: <1380702651-13389-8-git-send-email-ulf.hansson@linaro.org>
References: <1380702651-13389-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:50788 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151Ab3JBIbR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Oct 2013 04:31:17 -0400
Received: by mail-lb0-f178.google.com with SMTP id z5so472765lbh.9
        for <linux-mmc@vger.kernel.org>; Wed, 02 Oct 2013 01:31:16 -0700 (PDT)
In-Reply-To: <1380702651-13389-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

At request inactivity, we don't want to rely on gating the clock only
through the clock API since this will depend on the clock tree and the
clients using the clocks.

To make sure the clock is fully gated towards the card in runtime
suspend, we perform clock gating using the internal registers of the
controller.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sh_mmcif.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 0c3a5cf..4e9dbd6 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -230,6 +230,7 @@ struct sh_mmcif_host {
 	struct platform_device *pd;
 	struct clk *hclk;
 	unsigned int clk;
+	unsigned int clk_cache;
 	int bus_width;
 	unsigned char timing;
 	bool sd_error;
@@ -1007,6 +1008,7 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	sh_mmcif_clock_control(host, ios->clock);
 
+	host->clk_cache = ios->clock;
 	host->timing = ios->timing;
 	host->bus_width = ios->bus_width;
 	host->state = STATE_IDLE;
@@ -1545,6 +1547,9 @@ static int sh_mmcif_runtime_suspend(struct device *dev)
 {
 	struct sh_mmcif_host *host = dev_get_drvdata(dev);
 
+	if (host->clk_cache)
+		sh_mmcif_clock_control(host, 0);
+
 	clk_disable_unprepare(host->hclk);
 	return 0;
 }
@@ -1554,6 +1559,12 @@ static int sh_mmcif_runtime_resume(struct device *dev)
 	struct sh_mmcif_host *host = dev_get_drvdata(dev);
 
 	clk_prepare_enable(host->hclk);
+
+	if (host->clk_cache) {
+		sh_mmcif_sync_reset(host);
+		sh_mmcif_clock_control(host, host->clk_cache);
+	}
+
 	return 0;
 }
 #endif
-- 
1.7.9.5

