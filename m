From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v4 6/10] mmc: meson-gx: fix error path in meson_mmc_clk_init /
 meson_mmc_probe
Date: Fri, 3 Mar 2017 20:56:33 +0100
Message-ID: <52120418-6365-51af-252e-8ad969969acd@gmail.com>
References: <62912f3d-2307-cfff-3c69-c8b8ffaeb474@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32924 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbdCCUAr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Mar 2017 15:00:47 -0500
Received: by mail-wm0-f66.google.com with SMTP id n11so4726581wma.0
        for <linux-mmc@vger.kernel.org>; Fri, 03 Mar 2017 12:00:46 -0800 (PST)
In-Reply-To: <62912f3d-2307-cfff-3c69-c8b8ffaeb474@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

The condition should be "if (ret)" as the disable/unprepare is
supposed to be executed if the previous command fails.
In addition adjust the error path in probe to properly deal
with the case that cfg_div_clk can be registered successfully
but enable/prepare fails.
In this case we shouldn't call clk_disable_unprepare.

Reported-by: Michał Zegan <webczat_200@poczta.onet.pl>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Acked-by: Kevin Hilman <khilman@baylibre.com>
---
v2:
- extended commit message
v3:
- adjust error path in probe
v4:
- added acked-by
---
 drivers/mmc/host/meson-gx-mmc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 68e76fa8..002e4aac 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -321,7 +321,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	host->mmc->f_min = clk_round_rate(host->cfg_div_clk, 400000);
 
 	ret = meson_mmc_clk_set(host, host->mmc->f_min);
-	if (!ret)
+	if (ret)
 		clk_disable_unprepare(host->cfg_div_clk);
 
 	return ret;
@@ -771,7 +771,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 					meson_mmc_irq_thread, IRQF_SHARED,
 					DRIVER_NAME, host);
 	if (ret)
-		goto free_host;
+		goto err_div_clk;
 
 	mmc->max_blk_count = CMD_CFG_LENGTH_MASK;
 	mmc->max_req_size = mmc->max_blk_count * mmc->max_blk_size;
@@ -784,7 +784,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	if (host->bounce_buf == NULL) {
 		dev_err(host->dev, "Unable to map allocate DMA bounce buffer.\n");
 		ret = -ENOMEM;
-		goto free_host;
+		goto err_div_clk;
 	}
 
 	mmc->ops = &meson_mmc_ops;
@@ -792,8 +792,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
 
 	return 0;
 
-free_host:
+err_div_clk:
 	clk_disable_unprepare(host->cfg_div_clk);
+free_host:
 	clk_disable_unprepare(host->core_clk);
 	mmc_free_host(mmc);
 	return ret;
-- 
2.11.1



