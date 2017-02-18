From: =?UTF-8?q?Micha=C5=82=20Zegan?= <webczat@webczatnet.pl>
Subject: [PATCH] mmc: meson-gx: fix error path when driver initialization fails before enabling clocks
Date: Sat, 18 Feb 2017 18:06:46 +0100
Message-ID: <20170218170647.5860-1-webczat@webczatnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from webczatnet.pl ([91.121.100.5]:46376 "EHLO webczatnet.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753035AbdBRRHZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 18 Feb 2017 12:07:25 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, =?UTF-8?q?Micha=C5=82=20Zegan?= <webczat@webczatnet.pl>

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
applies on top of Heiner's patchset v3
https://patchwork.kernel.org/patch/9581057/
That in turn applies on top of https://patchwork.kernel.org/patch/9561215/

 drivers/mmc/host/meson-gx-mmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 336b6a2e94c6..7917a3fe51ad 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -752,7 +752,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 
 	ret = meson_mmc_clk_init(host);
 	if (ret)
-		goto free_host;
+		goto err_core_clk;
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq, meson_mmc_irq,
 					meson_mmc_irq_thread, IRQF_SHARED,
@@ -781,8 +781,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
 
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
2.11.0

