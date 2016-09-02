From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v6 3/9] mmc: tmio: document mandatory and optional callbacks
Date: Fri,  2 Sep 2016 13:17:32 +0200
Message-ID: <1472815058-11562-4-git-send-email-horms+renesas@verge.net.au>
References: <1472815058-11562-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1472815058-11562-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v5
* New patch
---
 drivers/mmc/host/tmio_mmc.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 1f1cb2628f67..4b36cb5c2d9c 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -151,8 +151,10 @@ struct tmio_mmc_host {
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
@@ -161,6 +163,7 @@ struct tmio_mmc_host {
 	int (*card_busy)(struct mmc_host *mmc);
 	int (*start_signal_voltage_switch)(struct mmc_host *mmc,
 					   struct mmc_ios *ios);
+	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
 };
 
 struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev);
-- 
2.7.0.rc3.207.g0ac5344
