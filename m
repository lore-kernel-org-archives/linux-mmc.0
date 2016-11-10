From: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Subject: [PATCH 1/2] mmc: allow mmc_alloc_host() to return proper error code
Date: Thu, 10 Nov 2016 22:24:22 +0900
Message-ID: <1478784263-18777-2-git-send-email-yamada.masahiro@socionext.com>
References: <1478784263-18777-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1478784263-18777-1-git-send-email-yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Sascha Sommer <saschasommer-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Pierre Ossman <pierre-vCPtPcF4ZGuHXe+LvDLADg@public.gmane.org>, Harald Welte <HaraldWelte-yS34VQbMlVtBDgjK7y7TUQ@public.gmane.org>, Alex Dubov <oakad-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>, Rui Miguel Silva <rmfrfs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Tony Olech <tony.olech-ze5PQcJzaeOs0fm86SgGizGjJy/sRE9J@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel@
List-Id: linux-mmc@vger.kernel.org

Currently, mmc_alloc_host() returns NULL on error, so its callers
cannot return anything but -ENOMEM when it fails, assuming the most
failure cases are due to memory shortage, but it is not true.

Allow mmc_alloc_host() to return an error pointer, then propagate
the proper error code to its callers.

Signed-off-by: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
---

 drivers/mmc/core/host.c             | 11 ++++++-----
 drivers/mmc/host/android-goldfish.c |  4 ++--
 drivers/mmc/host/atmel-mci.c        |  4 ++--
 drivers/mmc/host/au1xmmc.c          |  4 ++--
 drivers/mmc/host/bfin_sdh.c         |  4 ++--
 drivers/mmc/host/cb710-mmc.c        |  4 ++--
 drivers/mmc/host/davinci_mmc.c      |  4 ++--
 drivers/mmc/host/dw_mmc.c           |  4 ++--
 drivers/mmc/host/jz4740_mmc.c       |  4 ++--
 drivers/mmc/host/mmc_spi.c          |  9 ++++++---
 drivers/mmc/host/mmci.c             |  4 ++--
 drivers/mmc/host/moxart-mmc.c       |  4 ++--
 drivers/mmc/host/mtk-sd.c           |  4 ++--
 drivers/mmc/host/mvsdio.c           |  4 ++--
 drivers/mmc/host/mxcmmc.c           |  4 ++--
 drivers/mmc/host/mxs-mmc.c          |  4 ++--
 drivers/mmc/host/omap.c             |  4 ++--
 drivers/mmc/host/omap_hsmmc.c       |  4 ++--
 drivers/mmc/host/pxamci.c           |  4 ++--
 drivers/mmc/host/rtsx_pci_sdmmc.c   |  4 ++--
 drivers/mmc/host/rtsx_usb_sdmmc.c   |  4 ++--
 drivers/mmc/host/s3cmci.c           |  4 ++--
 drivers/mmc/host/sdhci.c            |  4 ++--
 drivers/mmc/host/sdricoh_cs.c       |  4 ++--
 drivers/mmc/host/sh_mmcif.c         |  4 ++--
 drivers/mmc/host/sunxi-mmc.c        |  4 ++--
 drivers/mmc/host/tifm_sd.c          |  4 ++--
 drivers/mmc/host/tmio_mmc_pio.c     |  2 +-
 drivers/mmc/host/toshsd.c           |  4 ++--
 drivers/mmc/host/usdhi6rol0.c       |  4 ++--
 drivers/mmc/host/ushc.c             |  4 ++--
 drivers/mmc/host/via-sdmmc.c        |  4 ++--
 drivers/mmc/host/vub300.c           |  4 ++--
 drivers/mmc/host/wbsd.c             |  4 ++--
 drivers/mmc/host/wmt-sdmmc.c        |  4 ++--
 drivers/staging/greybus/sdio.c      |  4 ++--
 36 files changed, 79 insertions(+), 75 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 98f25ff..b3e13e0 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -349,7 +349,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
 	host = kzalloc(sizeof(struct mmc_host) + extra, GFP_KERNEL);
 	if (!host)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	/* scanning will be enabled when we're ready */
 	host->rescan_disable = 1;
@@ -357,7 +357,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 again:
 	if (!ida_pre_get(&mmc_host_ida, GFP_KERNEL)) {
 		kfree(host);
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	spin_lock(&mmc_host_lock);
@@ -368,7 +368,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 		goto again;
 	} else if (err) {
 		kfree(host);
-		return NULL;
+		return ERR_PTR(err);
 	}
 
 	dev_set_name(&host->class_dev, "mmc%d", host->index);
@@ -379,9 +379,10 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	device_initialize(&host->class_dev);
 	device_enable_async_suspend(&host->class_dev);
 
-	if (mmc_gpio_alloc(host)) {
+	err = mmc_gpio_alloc(host);
+	if (err < 0) {
 		put_device(&host->class_dev);
-		return NULL;
+		return ERR_PTR(err);
 	}
 
 	spin_lock_init(&host->lock);
diff --git a/drivers/mmc/host/android-goldfish.c b/drivers/mmc/host/android-goldfish.c
index dca5518..7363663 100644
--- a/drivers/mmc/host/android-goldfish.c
+++ b/drivers/mmc/host/android-goldfish.c
@@ -467,8 +467,8 @@ static int goldfish_mmc_probe(struct platform_device *pdev)
 		return -ENXIO;
 
 	mmc = mmc_alloc_host(sizeof(struct goldfish_mmc_host), &pdev->dev);
-	if (mmc == NULL) {
-		ret = -ENOMEM;
+	if (IS_ERR(mmc)) {
+		ret = PTR_ERR(mmc);
 		goto err_alloc_host_failed;
 	}
 
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 0ad8ef5..d0cb112 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2296,8 +2296,8 @@ static int atmci_init_slot(struct atmel_mci *host,
 	struct atmel_mci_slot		*slot;
 
 	mmc = mmc_alloc_host(sizeof(struct atmel_mci_slot), &host->pdev->dev);
-	if (!mmc)
-		return -ENOMEM;
+	if (IS_ERR(mmc))
+		return PTR_ERR(mmc);
 
 	slot = mmc_priv(mmc);
 	slot->mmc = mmc;
diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index ed77fbfa..d97b409 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -951,9 +951,9 @@ static int au1xmmc_probe(struct platform_device *pdev)
 	int ret, iflag;
 
 	mmc = mmc_alloc_host(sizeof(struct au1xmmc_host), &pdev->dev);
-	if (!mmc) {
+	if (IS_ERR(mmc)) {
 		dev_err(&pdev->dev, "no memory for mmc_host\n");
-		ret = -ENOMEM;
+		ret = PTR_ERR(mmc);
 		goto out0;
 	}
 
diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
index 526231e..60c52d1 100644
--- a/drivers/mmc/host/bfin_sdh.c
+++ b/drivers/mmc/host/bfin_sdh.c
@@ -532,8 +532,8 @@ static int sdh_probe(struct platform_device *pdev)
 	}
 
 	mmc = mmc_alloc_host(sizeof(struct sdh_host), &pdev->dev);
-	if (!mmc) {
-		ret = -ENOMEM;
+	if (IS_ERR(mmc)) {
+		ret = PTR_ERR(mmc);
 		goto out;
 	}
 
diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.c
index 1087b4c..79ce871 100644
--- a/drivers/mmc/host/cb710-mmc.c
+++ b/drivers/mmc/host/cb710-mmc.c
@@ -692,8 +692,8 @@ static int cb710_mmc_init(struct platform_device *pdev)
 	u32 val;
 
 	mmc = mmc_alloc_host(sizeof(*reader), cb710_slot_dev(slot));
-	if (!mmc)
-		return -ENOMEM;
+	if (IS_ERR(mmc))
+		return PTR_ERR(mmc);
 
 	platform_set_drvdata(pdev, mmc);
 
diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 8fa478c..225b9a8 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1229,8 +1229,8 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 		return -EBUSY;
 
 	mmc = mmc_alloc_host(sizeof(struct mmc_davinci_host), &pdev->dev);
-	if (!mmc)
-		return -ENOMEM;
+	if (IS_ERR(mmc))
+		return PTR_ERR(mmc);
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;	/* Important */
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 4fcbc40..4f06528 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2598,8 +2598,8 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	u32 freq[2];
 
 	mmc = mmc_alloc_host(sizeof(struct dw_mci_slot), host->dev);
-	if (!mmc)
-		return -ENOMEM;
+	if (IS_ERR(mmc))
+		return PTR_ERR(mmc);
 
 	slot = mmc_priv(mmc);
 	slot->id = id;
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 684087d..351dd68 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -998,9 +998,9 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	pdata = pdev->dev.platform_data;
 
 	mmc = mmc_alloc_host(sizeof(struct jz4740_mmc_host), &pdev->dev);
-	if (!mmc) {
+	if (IS_ERR(mmc)) {
 		dev_err(&pdev->dev, "Failed to alloc mmc host structure\n");
-		return -ENOMEM;
+		return PTR_ERR(mmc);
 	}
 
 	host = mmc_priv(mmc);
diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index e77d79c..165f73e 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1333,15 +1333,18 @@ static int mmc_spi_probe(struct spi_device *spi)
 	 * NOTE if many systems use more than one MMC-over-SPI connector
 	 * it'd save some memory to share this.  That's evidently rare.
 	 */
-	status = -ENOMEM;
 	ones = kmalloc(MMC_SPI_BLOCKSIZE, GFP_KERNEL);
-	if (!ones)
+	if (!ones) {
+		status = -ENOMEM;
 		goto nomem;
+	}
 	memset(ones, 0xff, MMC_SPI_BLOCKSIZE);
 
 	mmc = mmc_alloc_host(sizeof(*host), &spi->dev);
-	if (!mmc)
+	if (IS_ERR(mmc)) {
+		status = PTR_ERR(mmc);
 		goto nomem;
+	}
 
 	mmc->ops = &mmc_spi_ops;
 	mmc->max_blk_size = MMC_SPI_BLOCKSIZE;
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index df990bb..5779b57 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1509,8 +1509,8 @@ static int mmci_probe(struct amba_device *dev,
 	}
 
 	mmc = mmc_alloc_host(sizeof(struct mmci_host), &dev->dev);
-	if (!mmc)
-		return -ENOMEM;
+	if (IS_ERR(mmc))
+		return PTR_ERR(mmc);
 
 	ret = mmci_of_parse(np, mmc);
 	if (ret)
diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index bbad309..f453e55 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -568,9 +568,9 @@ static int moxart_probe(struct platform_device *pdev)
 	u32 i;
 
 	mmc = mmc_alloc_host(sizeof(struct moxart_host), dev);
-	if (!mmc) {
+	if (IS_ERR(mmc)) {
 		dev_err(dev, "mmc_alloc_host failed\n");
-		ret = -ENOMEM;
+		ret = PTR_ERR(mmc);
 		goto out;
 	}
 
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 84e9afc..ef28f64 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1494,8 +1494,8 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	}
 	/* Allocate MMC host for this device */
 	mmc = mmc_alloc_host(sizeof(struct msdc_host), &pdev->dev);
-	if (!mmc)
-		return -ENOMEM;
+	if (IS_ERR(mmc))
+		return PTR_ERR(mmc);
 
 	host = mmc_priv(mmc);
 	ret = mmc_of_parse(mmc);
diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 42296e5..5594f58 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -711,8 +711,8 @@ static int mvsd_probe(struct platform_device *pdev)
 		return -ENXIO;
 
 	mmc = mmc_alloc_host(sizeof(struct mvsd_host), &pdev->dev);
-	if (!mmc) {
-		ret = -ENOMEM;
+	if (IS_ERR(mmc)) {
+		ret = PTR_ERR(mmc);
 		goto out;
 	}
 
diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index fb3ca82..5bdc644 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1018,8 +1018,8 @@ static int mxcmci_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);
-	if (!mmc)
-		return -ENOMEM;
+	if (IS_ERR(mmc))
+		return PTR_ERR(mmc);
 
 	host = mmc_priv(mmc);
 
diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index d839147..7f72bb4 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -586,8 +586,8 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 		return irq_err;
 
 	mmc = mmc_alloc_host(sizeof(struct mxs_mmc_host), &pdev->dev);
-	if (!mmc)
-		return -ENOMEM;
+	if (IS_ERR(mmc))
+		return PTR_ERR(mmc);
 
 	host = mmc_priv(mmc);
 	ssp = &host->ssp;
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index be3c49f..b1ec63f 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1227,8 +1227,8 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
 	int r;
 
 	mmc = mmc_alloc_host(sizeof(struct mmc_omap_slot), host->dev);
-	if (mmc == NULL)
-		return -ENOMEM;
+	if (IS_ERR(mmc))
+		return PTR_ERR(mmc);
 
 	slot = mmc_priv(mmc);
 	slot->host = host;
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 5f2f24a..6154b55 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2024,8 +2024,8 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	mmc = mmc_alloc_host(sizeof(struct omap_hsmmc_host), &pdev->dev);
-	if (!mmc) {
-		ret = -ENOMEM;
+	if (IS_ERR(mmc)) {
+		ret = PTR_ERR(mmc);
 		goto err;
 	}
 
diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index c763b40..9e9b02f 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -652,8 +652,8 @@ static int pxamci_probe(struct platform_device *pdev)
 		return irq;
 
 	mmc = mmc_alloc_host(sizeof(struct pxamci_host), &pdev->dev);
-	if (!mmc) {
-		ret = -ENOMEM;
+	if (IS_ERR(mmc)) {
+		ret = PTR_ERR(mmc);
 		goto out;
 	}
 
diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 3ccaa14..551536e 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1399,8 +1399,8 @@ static int rtsx_pci_sdmmc_drv_probe(struct platform_device *pdev)
 	dev_dbg(&(pdev->dev), ": Realtek PCI-E SDMMC controller found\n");
 
 	mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);
-	if (!mmc)
-		return -ENOMEM;
+	if (IS_ERR(mmc))
+		return PTR_ERR(mmc);
 
 	host = mmc_priv(mmc);
 	host->pcr = pcr;
diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 6e9c0f8..443679f 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1363,8 +1363,8 @@ static int rtsx_usb_sdmmc_drv_probe(struct platform_device *pdev)
 	dev_dbg(&(pdev->dev), ": Realtek USB SD/MMC controller found\n");
 
 	mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);
-	if (!mmc)
-		return -ENOMEM;
+	if (IS_ERR(mmc))
+		return PTR_ERR(mmc);
 
 	host = mmc_priv(mmc);
 	host->ucr = ucr;
diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index c531dee..aacc5cf 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1556,8 +1556,8 @@ static int s3cmci_probe(struct platform_device *pdev)
 	is2440 = platform_get_device_id(pdev)->driver_data;
 
 	mmc = mmc_alloc_host(sizeof(struct s3cmci_host), &pdev->dev);
-	if (!mmc) {
-		ret = -ENOMEM;
+	if (IS_ERR(mmc)) {
+		ret = PTR_ERR(mmc);
 		goto probe_out;
 	}
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 71654b9..eb8199e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2946,8 +2946,8 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 	WARN_ON(dev == NULL);
 
 	mmc = mmc_alloc_host(sizeof(struct sdhci_host) + priv_size, dev);
-	if (!mmc)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(mmc))
+		return ERR_CAST(mmc);
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
diff --git a/drivers/mmc/host/sdricoh_cs.c b/drivers/mmc/host/sdricoh_cs.c
index 5ff26ab..6d2f671 100644
--- a/drivers/mmc/host/sdricoh_cs.c
+++ b/drivers/mmc/host/sdricoh_cs.c
@@ -424,9 +424,9 @@ static int sdricoh_init_mmc(struct pci_dev *pci_dev,
 	/* allocate privdata */
 	mmc = pcmcia_dev->priv =
 	    mmc_alloc_host(sizeof(struct sdricoh_host), &pcmcia_dev->dev);
-	if (!mmc) {
+	if (IS_ERR(mmc)) {
 		dev_err(dev, "mmc_alloc_host failed\n");
-		result = -ENOMEM;
+		result = PTR_ERR(mmc);
 		goto unmap_io;
 	}
 	host = mmc_priv(mmc);
diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 9007784..c2affc6 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1432,8 +1432,8 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 		return PTR_ERR(reg);
 
 	mmc = mmc_alloc_host(sizeof(struct sh_mmcif_host), dev);
-	if (!mmc)
-		return -ENOMEM;
+	if (IS_ERR(mmc))
+		return PTR_ERR(mmc);
 
 	ret = mmc_of_parse(mmc);
 	if (ret < 0)
diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index c0a5c67..a3cb388 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1212,9 +1212,9 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	int ret;
 
 	mmc = mmc_alloc_host(sizeof(struct sunxi_mmc_host), &pdev->dev);
-	if (!mmc) {
+	if (IS_ERR(mmc)) {
 		dev_err(&pdev->dev, "mmc alloc host failed\n");
-		return -ENOMEM;
+		return PTR_ERR(mmc);
 	}
 
 	host = mmc_priv(mmc);
diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
index 93c4b40..b088cb8 100644
--- a/drivers/mmc/host/tifm_sd.c
+++ b/drivers/mmc/host/tifm_sd.c
@@ -958,8 +958,8 @@ static int tifm_sd_probe(struct tifm_dev *sock)
 	}
 
 	mmc = mmc_alloc_host(sizeof(struct tifm_sd), &sock->dev);
-	if (!mmc)
-		return -ENOMEM;
+	if (IS_ERR(mmc))
+		return PTR_ERR(mmc);
 
 	host = mmc_priv(mmc);
 	tifm_set_drvdata(sock, mmc);
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 7005676..18106fc 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -1013,7 +1013,7 @@ struct tmio_mmc_host*
 	struct mmc_host *mmc;
 
 	mmc = mmc_alloc_host(sizeof(struct tmio_mmc_host), &pdev->dev);
-	if (!mmc)
+	if (IS_ERR(mmc))
 		return NULL;
 
 	host = mmc_priv(mmc);
diff --git a/drivers/mmc/host/toshsd.c b/drivers/mmc/host/toshsd.c
index 553ef41..7b086ed 100644
--- a/drivers/mmc/host/toshsd.c
+++ b/drivers/mmc/host/toshsd.c
@@ -617,8 +617,8 @@ static int toshsd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return ret;
 
 	mmc = mmc_alloc_host(sizeof(struct toshsd_host), &pdev->dev);
-	if (!mmc) {
-		ret = -ENOMEM;
+	if (IS_ERR(mmc)) {
+		ret = PTR_ERR(mmc);
 		goto err;
 	}
 
diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 1bd5f1a..e9d0126 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1753,8 +1753,8 @@ static int usdhi6_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	mmc = mmc_alloc_host(sizeof(struct usdhi6_host), dev);
-	if (!mmc)
-		return -ENOMEM;
+	if (IS_ERR(mmc))
+		return PTR_ERR(mmc);
 
 	ret = mmc_regulator_get_supply(mmc);
 	if (ret == -EPROBE_DEFER)
diff --git a/drivers/mmc/host/ushc.c b/drivers/mmc/host/ushc.c
index d2c386f..6937021 100644
--- a/drivers/mmc/host/ushc.c
+++ b/drivers/mmc/host/ushc.c
@@ -427,8 +427,8 @@ static int ushc_probe(struct usb_interface *intf, const struct usb_device_id *id
 	int ret;
 
 	mmc = mmc_alloc_host(sizeof(struct ushc_data), &intf->dev);
-	if (mmc == NULL)
-		return -ENOMEM;
+	if (IS_ERR(mmc))
+		return PTR_ERR(mmc);
 	ushc = mmc_priv(mmc);
 	usb_set_intfdata(intf, ushc);
 
diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
index 63fac78..010bfdb 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -1108,8 +1108,8 @@ static int via_sd_probe(struct pci_dev *pcidev,
 	pci_write_config_byte(pcidev, VIA_CRDR_PCI_DBG_MODE, 0);
 
 	mmc = mmc_alloc_host(sizeof(struct via_crdr_mmc_host), &pcidev->dev);
-	if (!mmc) {
-		ret = -ENOMEM;
+	if (IS_ERR(mmc)) {
+		ret = PTR_ERR(mmc);
 		goto release;
 	}
 
diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index bb3e0d1..d052c23 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2125,8 +2125,8 @@ static int vub300_probe(struct usb_interface *interface,
 	}
 	/* this also allocates memory for our VUB300 mmc host device */
 	mmc = mmc_alloc_host(sizeof(struct vub300_mmc_host), &udev->dev);
-	if (!mmc) {
-		retval = -ENOMEM;
+	if (IS_ERR(mmc)) {
+		retval = PTR_ERR(mmc);
 		dev_err(&udev->dev, "not enough memory for the mmc_host\n");
 		goto error4;
 	}
diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index c3fd16d..40f8fd6 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1204,8 +1204,8 @@ static int wbsd_alloc_mmc(struct device *dev)
 	 * Allocate MMC structure.
 	 */
 	mmc = mmc_alloc_host(sizeof(struct wbsd_host), dev);
-	if (!mmc)
-		return -ENOMEM;
+	if (IS_ERR(mmc))
+		return PTR_ERR(mmc);
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 5af0055..f37f9a4cd 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -782,9 +782,9 @@ static int wmt_mci_probe(struct platform_device *pdev)
 	}
 
 	mmc = mmc_alloc_host(sizeof(struct wmt_mci_priv), &pdev->dev);
-	if (!mmc) {
+	if (IS_ERR(mmc)) {
 		dev_err(&pdev->dev, "Failed to allocate mmc_host\n");
-		ret = -ENOMEM;
+		ret = PTR_ERR(mmc);
 		goto fail1;
 	}
 
diff --git a/drivers/staging/greybus/sdio.c b/drivers/staging/greybus/sdio.c
index 5649ef1..01c443d 100644
--- a/drivers/staging/greybus/sdio.c
+++ b/drivers/staging/greybus/sdio.c
@@ -768,8 +768,8 @@ static int gb_sdio_probe(struct gbphy_device *gbphy_dev,
 	int ret = 0;
 
 	mmc = mmc_alloc_host(sizeof(*host), &gbphy_dev->dev);
-	if (!mmc)
-		return -ENOMEM;
+	if (IS_ERR(mmc))
+		return PTR_ERR(mmc);
 
 	connection = gb_connection_create(gbphy_dev->bundle,
 					  le16_to_cpu(gbphy_dev->cport_desc->id),
-- 
1.9.1
