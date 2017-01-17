From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] mmc: host: tmio: disable clocks when unbinding
Date: Tue, 17 Jan 2017 21:26:01 +0100
Message-ID: <20170117202601.3742-1-wsa@the-dreams.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34191 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751381AbdAQUe3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Jan 2017 15:34:29 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Chris Brandt <chris.brandt@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Create a helper function to disable clocks and use it in remove(), too.
Now, clk_summary in debugfs reports the clocks as disabled and
unprepared after unbinding.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index ddba7b833f2c52..db3bde716b3eed 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -947,6 +947,12 @@ static int tmio_mmc_clk_enable(struct tmio_mmc_host *host)
 	return host->clk_enable(host);
 }
 
+static void tmio_mmc_clk_disable(struct tmio_mmc_host *host)
+{
+	if (host->clk_disable)
+		host->clk_disable(host);
+}
+
 static void tmio_mmc_power_on(struct tmio_mmc_host *host, unsigned short vdd)
 {
 	struct mmc_host *mmc = host->mmc;
@@ -1332,6 +1338,8 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+
+	tmio_mmc_clk_disable(host);
 }
 EXPORT_SYMBOL(tmio_mmc_host_remove);
 
@@ -1346,8 +1354,7 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
 	if (host->clk_cache)
 		tmio_mmc_clk_stop(host);
 
-	if (host->clk_disable)
-		host->clk_disable(host);
+	tmio_mmc_clk_disable(host);
 
 	return 0;
 }
-- 
2.11.0

