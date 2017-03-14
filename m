From: =?UTF-8?q?Micha=C5=82=20Zegan?= <webczat@webczatnet.pl>
Subject: [PATCH v2] mmc: meson-gx: fix error path when driver initialization fails before enabling clocks
Date: Tue, 14 Mar 2017 21:05:20 +0100
Message-ID: <20170314200520.6276-1-webczat@webczatnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from webczatnet.pl ([91.121.100.5]:46134 "EHLO webczatnet.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751822AbdCNUFj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 14 Mar 2017 16:05:39 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Micha=C5=82=20Zegan?= <webczat@webczatnet.pl>

This patch fixes the case where meson_mmc_probe function fails before
core_clk is enabled.
Originally, that would result in a try to disable the core clock, and if
it was not already enabled, it would result in a kernel warning.
This issue is similar to the one with div_clk.
Fix it by introducing another error path used only between successfully
enabling the core clock, and successfully enabling the div clock.
That would ensure that core clock is disabled only if it was enabled before.

Signed-off-by: Michał Zegan <webczat@webczatnet.pl>
---
changes since v1:
cherry picked on top of mmc next branch
 drivers/mmc/host/meson-gx-mmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index c574e1519623..bd075fef08d4 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -743,7 +743,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 
 	ret = meson_mmc_clk_init(host);
 	if (ret)
-		goto free_host;
+		goto err_core_clk;
 
 	/* Stop execution */
 	writel(0, host->regs + SD_EMMC_START);
@@ -783,8 +783,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
 
 err_div_clk:
 	clk_disable_unprepare(host->cfg_div_clk);
-free_host:
+err_core_clk:
 	clk_disable_unprepare(host->core_clk);
+free_host:
 	mmc_free_host(mmc);
 	return ret;
 }
-- 
2.12.0

