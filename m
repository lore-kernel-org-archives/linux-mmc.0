From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/6] mmc: tmio: set tmio_mmc_host to driver data
Date: Tue,  7 Nov 2017 17:09:28 +0900
Message-ID: <1510042172-27220-3-git-send-email-yamada.masahiro@socionext.com>
References: <1510042172-27220-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510042172-27220-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

The remove, suspend, resume hooks need tmio_mmc_host.  It is tedious
to get mmc_host from the driver_data and pass it to mmc_priv().
We can directly set tmio_mmc_host to driver data to clean up the code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/renesas_sdhi_core.c |  3 +--
 drivers/mmc/host/tmio_mmc.c          | 12 ++++--------
 drivers/mmc/host/tmio_mmc_core.c     |  8 +++-----
 3 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 4b7a4e2..23c250e 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -656,8 +656,7 @@ EXPORT_SYMBOL_GPL(renesas_sdhi_probe);
 
 int renesas_sdhi_remove(struct platform_device *pdev)
 {
-	struct mmc_host *mmc = platform_get_drvdata(pdev);
-	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct tmio_mmc_host *host = platform_get_drvdata(pdev);
 
 	tmio_mmc_host_remove(host);
 
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 64b7e9f..ccfbc15 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -128,15 +128,11 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 static int tmio_mmc_remove(struct platform_device *pdev)
 {
 	const struct mfd_cell *cell = mfd_get_cell(pdev);
-	struct mmc_host *mmc = platform_get_drvdata(pdev);
+	struct tmio_mmc_host *host = platform_get_drvdata(pdev);
 
-	if (mmc) {
-		struct tmio_mmc_host *host = mmc_priv(mmc);
-
-		tmio_mmc_host_remove(host);
-		if (cell->disable)
-			cell->disable(pdev);
-	}
+	tmio_mmc_host_remove(host);
+	if (cell->disable)
+		cell->disable(pdev);
 
 	return 0;
 }
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 9c4e619..9b8ef73 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1190,7 +1190,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 		return ret;
 
 	_host->pdata = pdata;
-	platform_set_drvdata(pdev, mmc);
+	platform_set_drvdata(pdev, _host);
 
 	_host->set_pwr = pdata->set_pwr;
 	_host->set_clk_div = pdata->set_clk_div;
@@ -1347,8 +1347,7 @@ EXPORT_SYMBOL_GPL(tmio_mmc_host_remove);
 #ifdef CONFIG_PM
 int tmio_mmc_host_runtime_suspend(struct device *dev)
 {
-	struct mmc_host *mmc = dev_get_drvdata(dev);
-	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct tmio_mmc_host *host = dev_get_drvdata(dev);
 
 	tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
 
@@ -1368,8 +1367,7 @@ static bool tmio_mmc_can_retune(struct tmio_mmc_host *host)
 
 int tmio_mmc_host_runtime_resume(struct device *dev)
 {
-	struct mmc_host *mmc = dev_get_drvdata(dev);
-	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct tmio_mmc_host *host = dev_get_drvdata(dev);
 
 	tmio_mmc_reset(host);
 	tmio_mmc_clk_enable(host);
-- 
2.7.4
