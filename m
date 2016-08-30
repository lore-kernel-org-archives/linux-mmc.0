From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v5 03/11] mmc: tmio: Add hw reset support
Date: Tue, 30 Aug 2016 23:09:51 +0200
Message-ID: <1472591399-13907-4-git-send-email-horms+renesas@verge.net.au>
References: <1472591399-13907-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:45906 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758615AbcH3VK0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Aug 2016 17:10:26 -0400
In-Reply-To: <1472591399-13907-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ai Kyuse <ai.kyuse.uw@renesas.com>, Simon Horman <horms+renesas@verge.net.au>

From: Ai Kyuse <ai.kyuse.uw@renesas.com>

Add hw reset support.

Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
This is required by tuning support which will
be introduced by follow-up patches.

v5 [Simon Horman]
* As suggested by Ulf Hansson
  - Broke out of a larger patch
---
 drivers/mmc/host/tmio_mmc.h     |  1 +
 drivers/mmc/host/tmio_mmc_pio.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 4b36cb5c2d9c..4b71f31fba63 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -164,6 +164,7 @@ struct tmio_mmc_host {
 	int (*start_signal_voltage_switch)(struct mmc_host *mmc,
 					   struct mmc_ios *ios);
 	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
+	void (*hw_reset)(struct tmio_mmc_host *host);
 };
 
 struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev);
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 806308ac93e7..90758647bae6 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -756,6 +756,17 @@ static int tmio_mmc_start_data(struct tmio_mmc_host *host,
 	return 0;
 }
 
+static void tmio_mmc_hw_reset(struct mmc_host *mmc)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+
+	if (host->hw_reset)
+		host->hw_reset(host);
+
+	mmc_retune_timer_stop(host->mmc);
+	mmc_retune_needed(host->mmc);
+}
+
 /* Process requests from the MMC layer */
 static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
@@ -970,6 +981,7 @@ static struct mmc_host_ops tmio_mmc_ops = {
 	.get_cd		= mmc_gpio_get_cd,
 	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
 	.multi_io_quirk	= tmio_multi_io_quirk,
+	.hw_reset	= tmio_mmc_hw_reset,
 };
 
 static int tmio_mmc_init_ocr(struct tmio_mmc_host *host)
-- 
2.7.0.rc3.207.g0ac5344

