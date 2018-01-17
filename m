From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 03/16] mmc: tmio: move {tmio_}mmc_of_parse() to tmio_mmc_host_alloc()
Date: Thu, 18 Jan 2018 01:28:03 +0900
Message-ID: <1516206496-16612-4-git-send-email-yamada.masahiro@socionext.com>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

mmc_of_parse() parses various DT properties and sets capability flags
accordingly.  However, drivers have no chance to run platform init
code depending on such flags because mmc_of_parse() is called from
tmio_mmc_host_probe().

Move mmc_of_parse() to tmio_mmc_host_alloc() so that drivers can
handle capabilities before mmc_add_host().  Move tmio_mmc_of_parse()
likewise.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Changes in v3: None
Changes in v2:
  - Newly added

 drivers/mmc/host/tmio_mmc_core.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 55442ed..fc9b28d 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1152,6 +1152,7 @@ struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev,
 	struct mmc_host *mmc;
 	struct resource *res;
 	void __iomem *ctl;
+	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ctl = devm_ioremap_resource(&pdev->dev, res);
@@ -1170,9 +1171,21 @@ struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev,
 	host->ops = tmio_mmc_ops;
 	mmc->ops = &host->ops;
 
+	ret = mmc_of_parse(host->mmc);
+	if (ret) {
+		host = ERR_PTR(ret);
+		goto free;
+	}
+
+	tmio_mmc_of_parse(pdev, pdata);
+
 	platform_set_drvdata(pdev, host);
 
 	return host;
+free:
+	mmc_free_host(mmc);
+
+	return host;
 }
 EXPORT_SYMBOL_GPL(tmio_mmc_host_alloc);
 
@@ -1198,15 +1211,9 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 	if (mmc->f_min == 0)
 		return -EINVAL;
 
-	tmio_mmc_of_parse(pdev, pdata);
-
 	if (!(pdata->flags & TMIO_MMC_HAS_IDLE_WAIT))
 		_host->write16_hook = NULL;
 
-	ret = mmc_of_parse(mmc);
-	if (ret < 0)
-		return ret;
-
 	_host->set_pwr = pdata->set_pwr;
 	_host->set_clk_div = pdata->set_clk_div;
 
-- 
2.7.4
