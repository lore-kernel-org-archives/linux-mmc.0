From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 02/10] mmc: tmio, sh_mobile_sdhi: Pass tmio_mmc_host ptr to clk_{enable,disable} ops
Date: Sat, 12 Mar 2016 10:15:04 +0100
Message-ID: <1457774112-16958-3-git-send-email-wsa@the-dreams.de>
References: <1457774112-16958-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1457774112-16958-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-mmc@vger.kernel.org, Dirk Behme <dirk.behme@gmail.com>, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-mmc@vger.kernel.org

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

Change the clk_enable operation to take a pointer to the struct
tmio_mmc_host and have it set f_max.  For consistency, also change the
clk_disable operation to take a pointer to struct tmio_mmc_host.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 12 +++++-------
 drivers/mmc/host/tmio_mmc.h       |  4 ++--
 drivers/mmc/host/tmio_mmc_pio.c   |  4 ++--
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 9aa147959276d0..55849350202b7d 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -131,16 +131,15 @@ static void sh_mobile_sdhi_sdbuf_width(struct tmio_mmc_host *host, int width)
 	sd_ctrl_write16(host, EXT_ACC, val);
 }
 
-static int sh_mobile_sdhi_clk_enable(struct platform_device *pdev, unsigned int *f)
+static int sh_mobile_sdhi_clk_enable(struct tmio_mmc_host *host)
 {
-	struct mmc_host *mmc = platform_get_drvdata(pdev);
-	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct mmc_host *mmc = host->mmc;
 	struct sh_mobile_sdhi *priv = host_to_priv(host);
 	int ret = clk_prepare_enable(priv->clk);
 	if (ret < 0)
 		return ret;
 
-	*f = clk_get_rate(priv->clk);
+	mmc->f_max = clk_get_rate(priv->clk);
 
 	/* enable 16bit data access on SDBUF as default */
 	sh_mobile_sdhi_sdbuf_width(host, 16);
@@ -148,11 +147,10 @@ static int sh_mobile_sdhi_clk_enable(struct platform_device *pdev, unsigned int
 	return 0;
 }
 
-static void sh_mobile_sdhi_clk_disable(struct platform_device *pdev)
+static void sh_mobile_sdhi_clk_disable(struct tmio_mmc_host *host)
 {
-	struct mmc_host *mmc = platform_get_drvdata(pdev);
-	struct tmio_mmc_host *host = mmc_priv(mmc);
 	struct sh_mobile_sdhi *priv = host_to_priv(host);
+
 	clk_disable_unprepare(priv->clk);
 }
 
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 4a597f5a53e20f..68fd8d791358c1 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -95,8 +95,8 @@ struct tmio_mmc_host {
 	bool			sdio_irq_enabled;
 
 	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
-	int (*clk_enable)(struct platform_device *pdev, unsigned int *f);
-	void (*clk_disable)(struct platform_device *pdev);
+	int (*clk_enable)(struct tmio_mmc_host *host);
+	void (*clk_disable)(struct tmio_mmc_host *host);
 	int (*multi_io_quirk)(struct mmc_card *card,
 			      unsigned int direction, int blk_size);
 };
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 03f6e74c190691..d1160156678ade 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -845,7 +845,7 @@ static int tmio_mmc_clk_update(struct tmio_mmc_host *host)
 	if (!host->clk_enable)
 		return -ENOTSUPP;
 
-	ret = host->clk_enable(host->pdev, &mmc->f_max);
+	ret = host->clk_enable(host);
 	if (!ret)
 		mmc->f_min = mmc->f_max / 512;
 
@@ -1251,7 +1251,7 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
 		tmio_mmc_clk_stop(host);
 
 	if (host->clk_disable)
-		host->clk_disable(host->pdev);
+		host->clk_disable(host);
 
 	return 0;
 }
-- 
2.7.0
