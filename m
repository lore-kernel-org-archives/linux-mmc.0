From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 20/22] mmc: tmio: move clk_enable/disable out of tmio_mmc_host_probe()
Date: Sat, 25 Nov 2017 01:24:55 +0900
Message-ID: <1511540697-27387-21-git-send-email-yamada.masahiro@socionext.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

The clock is enabled in the tmio_mmc_host_probe().  It also prevents
drivers from performing platform-specific settings before mmc_add_host()
because the register access generally requires a clock.

Enable/disable the clock in drivers' probe/remove.  Also, I passed
tmio_mmc_data to tmio_mmc_host_alloc() because renesas_sdhi_clk_enable()
needs it to get the private data from tmio_mmc_host.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Newly added

 drivers/mmc/host/renesas_sdhi_core.c | 13 ++++++++++---
 drivers/mmc/host/tmio_mmc.c          |  7 +++++--
 drivers/mmc/host/tmio_mmc.h          |  4 ++--
 drivers/mmc/host/tmio_mmc_core.c     | 33 +++++++++++++--------------------
 4 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 446ff54..a5749d7 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -510,7 +510,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 						"state_uhs");
 	}
 
-	host = tmio_mmc_host_alloc(pdev);
+	host = tmio_mmc_host_alloc(pdev, mmc_data);
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
@@ -570,10 +570,14 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	/* All SDHI have SDIO status bits which must be 1 */
 	mmc_data->flags |= TMIO_MMC_SDIO_STATUS_SETBITS;
 
-	ret = tmio_mmc_host_probe(host, mmc_data, dma_ops);
-	if (ret < 0)
+	ret = renesas_sdhi_clk_enable(host);
+	if (ret)
 		goto efree;
 
+	ret = tmio_mmc_host_probe(host, dma_ops);
+	if (ret < 0)
+		goto edisclk;
+
 	/* One Gen2 SDHI incarnation does NOT have a CBSY bit */
 	if (sd_ctrl_read16(host, CTL_VERSION) == SDHI_VER_GEN2_SDR50)
 		mmc_data->flags &= ~TMIO_MMC_HAVE_CBSY;
@@ -634,6 +638,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 
 eirq:
 	tmio_mmc_host_remove(host);
+edisclk:
+	renesas_sdhi_clk_disable(host);
 efree:
 	tmio_mmc_host_free(host);
 
@@ -646,6 +652,7 @@ int renesas_sdhi_remove(struct platform_device *pdev)
 	struct tmio_mmc_host *host = platform_get_drvdata(pdev);
 
 	tmio_mmc_host_remove(host);
+	renesas_sdhi_clk_disable(host);
 
 	return 0;
 }
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index d660816..11b87ce 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -92,7 +92,7 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 
 	pdata->flags |= TMIO_MMC_HAVE_HIGH_REG;
 
-	host = tmio_mmc_host_alloc(pdev);
+	host = tmio_mmc_host_alloc(pdev, pdata);
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
 		goto cell_disable;
@@ -101,7 +101,10 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 	/* SD control register space size is 0x200, 0x400 for bus_shift=1 */
 	host->bus_shift = resource_size(res) >> 10;
 
-	ret = tmio_mmc_host_probe(host, pdata, NULL);
+	host->mmc->f_max = pdata->hclk;
+	host->mmc->f_min = pdata->hclk / 512;
+
+	ret = tmio_mmc_host_probe(host, NULL);
 	if (ret)
 		goto host_free;
 
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 27894474..f46d282 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -195,10 +195,10 @@ struct tmio_mmc_host {
 	const struct tmio_mmc_dma_ops *dma_ops;
 };
 
-struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev);
+struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev,
+					  struct tmio_mmc_data *pdata);
 void tmio_mmc_host_free(struct tmio_mmc_host *host);
 int tmio_mmc_host_probe(struct tmio_mmc_host *host,
-			struct tmio_mmc_data *pdata,
 			const struct tmio_mmc_dma_ops *dma_ops);
 void tmio_mmc_host_remove(struct tmio_mmc_host *host);
 void tmio_mmc_do_data_irq(struct tmio_mmc_host *host);
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index c392694..b51486d 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1160,8 +1160,8 @@ static void tmio_mmc_of_parse(struct platform_device *pdev,
 		pdata->flags |= TMIO_MMC_WRPROTECT_DISABLE;
 }
 
-struct tmio_mmc_host*
-tmio_mmc_host_alloc(struct platform_device *pdev)
+struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev,
+					  struct tmio_mmc_data *pdata)
 {
 	struct tmio_mmc_host *host;
 	struct mmc_host *mmc;
@@ -1181,9 +1181,12 @@ tmio_mmc_host_alloc(struct platform_device *pdev)
 	host->ctl = ctl;
 	host->mmc = mmc;
 	host->pdev = pdev;
+	host->pdata = pdata;
 	host->ops = tmio_mmc_ops;
 	mmc->ops = &host->ops;
 
+	platform_set_drvdata(pdev, host);
+
 	return host;
 }
 EXPORT_SYMBOL_GPL(tmio_mmc_host_alloc);
@@ -1195,13 +1198,20 @@ void tmio_mmc_host_free(struct tmio_mmc_host *host)
 EXPORT_SYMBOL_GPL(tmio_mmc_host_free);
 
 int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
-			struct tmio_mmc_data *pdata,
 			const struct tmio_mmc_dma_ops *dma_ops)
 {
 	struct platform_device *pdev = _host->pdev;
+	struct tmio_mmc_data *pdata = _host->pdata;
 	struct mmc_host *mmc = _host->mmc;
 	int ret;
 
+	/*
+	 * Check the sanity of mmc->f_min to prevent tmio_mmc_set_clock() from
+	 * looping forever...
+	 */
+	if (mmc->f_min == 0)
+		return -EINVAL;
+
 	tmio_mmc_of_parse(pdev, pdata);
 
 	if (!(pdata->flags & TMIO_MMC_HAS_IDLE_WAIT))
@@ -1211,9 +1221,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 	if (ret < 0)
 		return ret;
 
-	_host->pdata = pdata;
-	platform_set_drvdata(pdev, _host);
-
 	_host->set_pwr = pdata->set_pwr;
 	_host->set_clk_div = pdata->set_clk_div;
 
@@ -1261,18 +1268,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 	if (pdata->flags & TMIO_MMC_MIN_RCAR2)
 		_host->native_hotplug = true;
 
-	if (tmio_mmc_clk_enable(_host) < 0) {
-		mmc->f_max = pdata->hclk;
-		mmc->f_min = mmc->f_max / 512;
-	}
-
-	/*
-	 * Check the sanity of mmc->f_min to prevent tmio_mmc_set_clock() from
-	 * looping forever...
-	 */
-	if (mmc->f_min == 0)
-		return -EINVAL;
-
 	/*
 	 * While using internal tmio hardware logic for card detection, we need
 	 * to ensure it stays powered for it to work.
@@ -1344,8 +1339,6 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	tmio_mmc_clk_disable(host);
 }
 EXPORT_SYMBOL_GPL(tmio_mmc_host_remove);
 
-- 
2.7.4
