From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 3/3] mmc: mxs-mmc: Check for clk_prepare_enable() error
Date: Wed, 19 Nov 2014 11:16:59 -0200
Message-ID: <1416403019-6353-3-git-send-email-fabio.estevam@freescale.com>
References: <1416403019-6353-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0110.outbound.protection.outlook.com ([157.56.111.110]:62674
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752315AbaKSNRP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 19 Nov 2014 08:17:15 -0500
In-Reply-To: <1416403019-6353-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: s.hauer@pengutronix.de, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

clk_prepare_enable() may fail and in this case we should propagate the error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/mmc/host/mxs-mmc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index f2c49e0..60c4ca9 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -619,7 +619,9 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 		ret = PTR_ERR(ssp->clk);
 		goto out_mmc_free;
 	}
-	clk_prepare_enable(ssp->clk);
+	ret = clk_prepare_enable(ssp->clk);
+	if (ret)
+		goto out_mmc_free;
 
 	ret = mxs_mmc_reset(host);
 	if (ret) {
@@ -719,8 +721,7 @@ static int mxs_mmc_resume(struct device *dev)
 	struct mxs_mmc_host *host = mmc_priv(mmc);
 	struct mxs_ssp *ssp = &host->ssp;
 
-	clk_prepare_enable(ssp->clk);
-	return 0;
+	return clk_prepare_enable(ssp->clk);
 }
 #endif
 
-- 
1.9.1

