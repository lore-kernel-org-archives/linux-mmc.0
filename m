From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] mmc: sdhci-of-arasan: Call OF parsing for MMC
Date: Tue,  7 Apr 2015 07:57:32 +0200
Message-ID: <35949221633dcbb490c3c28b8099c5be00cb9730.1428386249.git.michal.simek@xilinx.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:34913 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbbDGF5j (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Apr 2015 01:57:39 -0400
Received: by wgyo15 with SMTP id o15so33869135wgy.2
        for <linux-mmc@vger.kernel.org>; Mon, 06 Apr 2015 22:57:38 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Also check MMC OF properties. The controller supports MMC too.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/mmc/host/sdhci-of-arasan.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index bcb51e9..b8cfac1 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -173,6 +173,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	pltfm_host->priv = sdhci_arasan;
 	pltfm_host->clk = clk_xin;
 
+	ret = mmc_of_parse(host->mmc);
+	if (ret) {
+		dev_err(&pdev->dev, "parsing dt failed (%u)\n", ret);
+		goto clk_disable_all;
+	}
+
 	ret = sdhci_add_host(host);
 	if (ret)
 		goto err_pltfm_free;
-- 
1.7.2.3

