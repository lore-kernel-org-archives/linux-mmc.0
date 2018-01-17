From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 01/16] mmc: tmio: ioremap memory resource in tmio_mmc_host_alloc()
Date: Thu, 18 Jan 2018 01:28:01 +0900
Message-ID: <1516206496-16612-2-git-send-email-yamada.masahiro@socionext.com>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

The register region is ioremap'ed in the tmio_mmc_host_probe(), i.e.
drivers cannot get access to the hardware before mmc_add_host().

Actually, renesas_sdhi_core.c reads out the CTL_VERSION register to
complete the platform-specific settings.  However, at this point,
the MMC host is already running.

Move the register ioremap to tmio_mmc_host_alloc() so that drivers
can perform platform-specific settings between tmio_mmc_host_alloc()
and tmio_mmc_host_probe().

I changed tmio_mmc_host_alloc() to return an error pointer to
propagate the return code from devm_ioremap_resource().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Changes in v3: None
Changes in v2: None

 drivers/mmc/host/renesas_sdhi_core.c |  4 ++--
 drivers/mmc/host/tmio_mmc.c          |  4 +++-
 drivers/mmc/host/tmio_mmc_core.c     | 16 +++++++++-------
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 6a2988b..ccdde27 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -512,8 +512,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	}
 
 	host = tmio_mmc_host_alloc(pdev);
-	if (!host)
-		return -ENOMEM;
+	if (IS_ERR(host))
+		return PTR_ERR(host);
 
 	if (of_data) {
 		mmc_data->flags |= of_data->tmio_flags;
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index ccfbc15..d660816 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -93,8 +93,10 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 	pdata->flags |= TMIO_MMC_HAVE_HIGH_REG;
 
 	host = tmio_mmc_host_alloc(pdev);
-	if (!host)
+	if (IS_ERR(host)) {
+		ret = PTR_ERR(host);
 		goto cell_disable;
+	}
 
 	/* SD control register space size is 0x200, 0x400 for bus_shift=1 */
 	host->bus_shift = resource_size(res) >> 10;
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 610f26f..5f0f12a 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1150,12 +1150,20 @@ tmio_mmc_host_alloc(struct platform_device *pdev)
 {
 	struct tmio_mmc_host *host;
 	struct mmc_host *mmc;
+	struct resource *res;
+	void __iomem *ctl;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ctl = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ctl))
+		return ERR_CAST(ctl);
 
 	mmc = mmc_alloc_host(sizeof(struct tmio_mmc_host), &pdev->dev);
 	if (!mmc)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	host = mmc_priv(mmc);
+	host->ctl = ctl;
 	host->mmc = mmc;
 	host->pdev = pdev;
 	host->ops = tmio_mmc_ops;
@@ -1177,7 +1185,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 {
 	struct platform_device *pdev = _host->pdev;
 	struct mmc_host *mmc = _host->mmc;
-	struct resource *res_ctl;
 	int ret;
 	u32 irq_mask = TMIO_MASK_CMD;
 
@@ -1186,11 +1193,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 	if (!(pdata->flags & TMIO_MMC_HAS_IDLE_WAIT))
 		_host->write16_hook = NULL;
 
-	res_ctl = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	_host->ctl = devm_ioremap_resource(&pdev->dev, res_ctl);
-	if (IS_ERR(_host->ctl))
-		return PTR_ERR(_host->ctl);
-
 	ret = mmc_of_parse(mmc);
 	if (ret < 0)
 		return ret;
-- 
2.7.4
