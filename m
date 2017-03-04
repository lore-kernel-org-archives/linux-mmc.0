From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v5 6/10] mmc: meson-gx: fix error path in meson_mmc_clk_init /
 meson_mmc_probe
Date: Sat, 4 Mar 2017 13:25:14 +0100
Message-ID: <5291f703-af62-b9a5-3f5e-f0f8a2d6248e@gmail.com>
References: <a76c3483-2c86-85c1-446e-f2522bd28aa8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34856 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751910AbdCDMi5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Mar 2017 07:38:57 -0500
Received: by mail-wr0-f195.google.com with SMTP id u108so12257783wrb.2
        for <linux-mmc@vger.kernel.org>; Sat, 04 Mar 2017 04:38:21 -0800 (PST)
In-Reply-To: <a76c3483-2c86-85c1-446e-f2522bd28aa8@gmail.com>
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
v5:
- no changes
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
2.12.0


