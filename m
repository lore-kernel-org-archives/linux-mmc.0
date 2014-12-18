From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/7] mmc: mvsdio: Remove redundant use of mmc_gpio_free_cd|ro()
Date: Thu, 18 Dec 2014 15:44:30 +0100
Message-ID: <1418913876-13937-2-git-send-email-ulf.hansson@linaro.org>
References: <1418913876-13937-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:35196 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbaLROos (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Dec 2014 09:44:48 -0500
Received: by mail-wg0-f52.google.com with SMTP id x12so1805225wgg.25
        for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2014 06:44:47 -0800 (PST)
In-Reply-To: <1418913876-13937-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: Nicolas Pitre <nico@fluxnic.net>

The MMC core makes use of the devm_* functions while requesting the
CD/WP GPIOs, let's rely on that.

Cc: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mvsdio.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 4f8618f..b6ec91f 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -828,8 +828,6 @@ static int mvsd_probe(struct platform_device *pdev)
 
 out:
 	if (mmc) {
-		mmc_gpio_free_cd(mmc);
-		mmc_gpio_free_ro(mmc);
 		if (!IS_ERR(host->clk))
 			clk_disable_unprepare(host->clk);
 		mmc_free_host(mmc);
@@ -844,8 +842,6 @@ static int mvsd_remove(struct platform_device *pdev)
 
 	struct mvsd_host *host = mmc_priv(mmc);
 
-	mmc_gpio_free_cd(mmc);
-	mmc_gpio_free_ro(mmc);
 	mmc_remove_host(mmc);
 	del_timer_sync(&host->timer);
 	mvsd_power_down(host);
-- 
1.9.1

