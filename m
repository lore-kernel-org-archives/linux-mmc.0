From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 04/22] mmc: tmio: set tmio_mmc_host to driver data
Date: Sat, 25 Nov 2017 01:24:39 +0900
Message-ID: <1511540697-27387-5-git-send-email-yamada.masahiro@socionext.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conuserg-11.nifty.com ([210.131.2.78]:61433 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753620AbdKXQZ6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Nov 2017 11:25:58 -0500
In-Reply-To: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

The remove, suspend, resume hooks need to get tmio_mmc_host.  It is
tedious to call mmc_priv() to convert mmc_host to tmio_mmc_host.
We can directly set tmio_mmc_host to driver data.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Changes in v2: None

 drivers/mmc/host/renesas_sdhi_core.c |  3 +--
 drivers/mmc/host/tmio_mmc.c          | 12 ++++--------
 drivers/mmc/host/tmio_mmc_core.c     |  8 +++-----
 3 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 0590ae0..9baf4d1 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -657,8 +657,7 @@ EXPORT_SYMBOL_GPL(renesas_sdhi_probe);
 
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
index 583bf32..12df338 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1193,7 +1193,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 		return ret;
 
 	_host->pdata = pdata;
-	platform_set_drvdata(pdev, mmc);
+	platform_set_drvdata(pdev, _host);
 
 	_host->set_pwr = pdata->set_pwr;
 	_host->set_clk_div = pdata->set_clk_div;
@@ -1351,8 +1351,7 @@ EXPORT_SYMBOL_GPL(tmio_mmc_host_remove);
 #ifdef CONFIG_PM
 int tmio_mmc_host_runtime_suspend(struct device *dev)
 {
-	struct mmc_host *mmc = dev_get_drvdata(dev);
-	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct tmio_mmc_host *host = dev_get_drvdata(dev);
 
 	tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
 
@@ -1372,8 +1371,7 @@ static bool tmio_mmc_can_retune(struct tmio_mmc_host *host)
 
 int tmio_mmc_host_runtime_resume(struct device *dev)
 {
-	struct mmc_host *mmc = dev_get_drvdata(dev);
-	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct tmio_mmc_host *host = dev_get_drvdata(dev);
 
 	tmio_mmc_reset(host);
 	tmio_mmc_clk_enable(host);
-- 
2.7.4

