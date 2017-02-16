From: =?UTF-8?q?Micha=C5=82=20Zegan?= <webczat@webczatnet.pl>
Subject: [PATCH 0/2] mmc: meson-gx: fix mmc module unloading
Date: Thu, 16 Feb 2017 15:39:55 +0100
Message-ID: <20170216143955.1233-1-webczat@webczatnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from webczatnet.pl ([91.121.100.5]:60946 "EHLO webczatnet.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932110AbdBPPIR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 16 Feb 2017 10:08:17 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Micha=C5=82=20Zegan?= <webczat@webczatnet.pl>

This patch series fixes mmc driver unloading.
Previously, unloading meson-gx-mmc module would trigger kernel warnings.

Michał Zegan (2):
  mmc: meson-gx: prevent cfg_div_clk from being disabled on init
  mmc: meson-gx: remove mmc host on device removal

 drivers/mmc/host/meson-gx-mmc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.11.0

>From 4ce6f7bc460aad2a60b4023ce0467c02c92fa92f Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Micha=C5=82=20Zegan?= <webczat@webczatnet.pl>
Date: Thu, 16 Feb 2017 14:44:36 +0100
Subject: [PATCH 1/2] mmc: meson-gx: prevent cfg_div_clk from being disabled on
 init
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

At the end of function meson_mmc_clk_init, the cfg_div clock was
prepared, enabled and configured, but then immediately disabled due to bogus if statements.
That made later calls to clk_disable_unprepare executed during module removal to fail with a kernel warning.
Fix that by changing the code to disable clock only when it failed to be configured.

Signed-off-by: Michał Zegan <webczat@webczatnet.pl>
---
 drivers/mmc/host/meson-gx-mmc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 09739352834c..d444b6bfa02b 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -324,11 +324,12 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	writel(cfg, host->regs + SD_EMMC_CFG);
 
 	ret = clk_prepare_enable(host->cfg_div_clk);
-	if (!ret)
+	if (!ret) {
 		ret = meson_mmc_clk_set(host, f_min);
 
-	if (!ret)
-		clk_disable_unprepare(host->cfg_div_clk);
+		if (ret)
+			clk_disable_unprepare(host->cfg_div_clk);
+	}
 
 	return ret;
 }
-- 
2.11.0


>From 66bcfa5eb8375f8b7fcd06fd0a83791c0d61f38b Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Micha=C5=82=20Zegan?= <webczat@webczatnet.pl>
Date: Thu, 16 Feb 2017 15:08:56 +0100
Subject: [PATCH 2/2] mmc: meson-gx: remove mmc host on device removal
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The mmc host was added in meson_mmc_probe, but never removed in meson_mmc_remove.
Fix that by removing the host before deallocating other resources.

Signed-off-by: Michał Zegan <webczat@webczatnet.pl>
---
 drivers/mmc/host/meson-gx-mmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index d444b6bfa02b..bb83446118a3 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -818,6 +818,8 @@ static int meson_mmc_remove(struct platform_device *pdev)
 	if (WARN_ON(!host))
 		return 0;
 
+	mmc_remove_host(host->mmc);
+
 	if (host->bounce_buf)
 		dma_free_coherent(host->dev, host->bounce_buf_size,
 				  host->bounce_buf, host->bounce_dma_addr);
-- 
2.11.0

