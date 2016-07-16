From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/4] mmc: sunxi: Make sample clocks optional
Date: Sat, 16 Jul 2016 12:46:02 +0200
Message-ID: <1468665964-27142-3-git-send-email-hdegoede@redhat.com>
References: <1468665964-27142-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46781 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439AbcGPKqO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 16 Jul 2016 06:46:14 -0400
In-Reply-To: <1468665964-27142-1-git-send-email-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>

It turns out that sun4i (A10) and sun5i (A13 & co) do not have sample
clocks, so make them optional.

Since these do not have sample clocks, they cannot (reliably) do
DDR rates, so only set MMC_CAP_1_8V_DDR when we do have sample clks.

Note this patch only changes the devm_clk_get error checking and sets
the clocks to NULL if they don't exists. All the clk_foo calls accept
a NULL clk and will return success when called with a NULL clk, so this
is all that is necessary.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mmc/host/sunxi-mmc.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 71a480b..4552ee0 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1016,14 +1016,20 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 
 	host->clk_output = devm_clk_get(&pdev->dev, "output");
 	if (IS_ERR(host->clk_output)) {
-		dev_err(&pdev->dev, "Could not get output clock\n");
-		return PTR_ERR(host->clk_output);
+		if (PTR_ERR(host->clk_output) != -ENOENT) {
+			dev_err(&pdev->dev, "Could not get output clock\n");
+			return PTR_ERR(host->clk_output);
+		}
+		host->clk_output = NULL;
 	}
 
 	host->clk_sample = devm_clk_get(&pdev->dev, "sample");
 	if (IS_ERR(host->clk_sample)) {
-		dev_err(&pdev->dev, "Could not get sample clock\n");
-		return PTR_ERR(host->clk_sample);
+		if (PTR_ERR(host->clk_sample) != -ENOENT) {
+			dev_err(&pdev->dev, "Could not get sample clock\n");
+			return PTR_ERR(host->clk_sample);
+		}
+		host->clk_sample = NULL;
 	}
 
 	host->reset = devm_reset_control_get_optional(&pdev->dev, "ahb");
@@ -1126,9 +1132,11 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	mmc->f_min		=   400000;
 	mmc->f_max		= 52000000;
 	mmc->caps	       |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
-				  MMC_CAP_1_8V_DDR |
 				  MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;
 
+	if (host->clk_output && host->clk_sample)
+		mmc->caps      |= MMC_CAP_1_8V_DDR;
+
 	ret = mmc_of_parse(mmc);
 	if (ret)
 		goto error_free_dma;
-- 
2.7.4

