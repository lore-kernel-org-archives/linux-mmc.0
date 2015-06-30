From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH v4 3/8] mmc: tmio, sh_mobile_sdhi: Pass tmio_mmc_host ptr to
 clk_{enable,disable} ops
Date: Tue, 30 Jun 2015 17:54:21 +0100
Message-ID: <1435683261.23818.63.camel@codethink.co.uk>
References: <1435683177.23818.60.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:60331 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbbF3Qy3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Jun 2015 12:54:29 -0400
In-Reply-To: <1435683177.23818.60.camel@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Change the clk_enable operation to take a pointer to the struct
tmio_mmc_host and have it set f_max.  For consistency, also change the
clk_disable operation to take a pointer to struct tmio_mmc_host.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 12 +++++-------
 drivers/mmc/host/tmio_mmc.h       |  4 ++--
 drivers/mmc/host/tmio_mmc_pio.c   |  4 ++--
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 354f4f335ed5..f6e8c98819ad 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -111,16 +111,15 @@ static void sh_mobile_sdhi_sdbuf_width(struct tmio_mmc_host *host, int width)
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
@@ -128,11 +127,10 @@ static int sh_mobile_sdhi_clk_enable(struct platform_device *pdev, unsigned int
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
index 4a597f5a53e2..68fd8d791358 100644
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
index e3dcf31a8bd6..8fdb8a6209e6 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -840,7 +840,7 @@ static int tmio_mmc_clk_update(struct tmio_mmc_host *host)
 	if (!host->clk_enable)
 		return -ENOTSUPP;
 
-	ret = host->clk_enable(host->pdev, &mmc->f_max);
+	ret = host->clk_enable(host);
 	if (!ret)
 		mmc->f_min = mmc->f_max / 512;
 
@@ -1246,7 +1246,7 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
 		tmio_mmc_clk_stop(host);
 
 	if (host->clk_disable)
-		host->clk_disable(host->pdev);
+		host->clk_disable(host);
 
 	return 0;
 }
-- 
2.1.4




