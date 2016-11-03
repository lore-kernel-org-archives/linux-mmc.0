From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v8 3/6] mmc: tmio: document mandatory and optional callbacks
Date: Thu,  3 Nov 2016 15:16:01 +0100
Message-ID: <1478182564-18762-4-git-send-email-horms+renesas@verge.net.au>
References: <1478182564-18762-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:49638 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757150AbcKCO6j (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Nov 2016 10:58:39 -0400
In-Reply-To: <1478182564-18762-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v5
* New patch
---
 drivers/mmc/host/tmio_mmc.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 8e126afd988c..b93762950e8f 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -154,8 +154,10 @@ struct tmio_mmc_host {
 	bool			native_hotplug;
 	bool			sdio_irq_enabled;
 
-	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
+	/* Mandatory callback */
 	int (*clk_enable)(struct tmio_mmc_host *host);
+
+	/* Optional callbacks */
 	unsigned int (*clk_update)(struct tmio_mmc_host *host,
 				   unsigned int new_clock);
 	void (*clk_disable)(struct tmio_mmc_host *host);
@@ -164,6 +166,7 @@ struct tmio_mmc_host {
 	int (*card_busy)(struct mmc_host *mmc);
 	int (*start_signal_voltage_switch)(struct mmc_host *mmc,
 					   struct mmc_ios *ios);
+	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
 };
 
 struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev);
-- 
2.7.0.rc3.207.g0ac5344

