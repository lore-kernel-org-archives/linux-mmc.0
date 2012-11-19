From: Bill Pemberton <wfp5p@virginia.edu>
Subject: =?UTF-8?q?=5BPATCH=20414/493=5D=20mmc=3A=20remove=20use=20of=20=5F=5Fdevexit?=
Date: Mon, 19 Nov 2012 13:26:03 -0500
Message-ID: <1353349642-3677-414-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-omap-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Manuel Lauss <manuel.lauss@gmail.com>, Chris Ball <cjb@laptop.org>, =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, Venkatraman S <svenkatr@ti.com>, Viresh Kumar <viresh.linux@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, Bruce Chang <brucechang@via.com.tw>, Harald Welte <HaraldWelte@viatech.com>, Pierre Ossman <pierre@ossman.eu>, linux-mmc@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, spear-devel@list.st.com
List-Id: linux-mmc@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Manuel Lauss <manuel.lauss@gmail.com>=20
Cc: Chris Ball <cjb@laptop.org>=20
Cc: "Micha=C5=82 Miros=C5=82aw" <mirq-linux@rere.qmqm.pl>=20
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>=20
Cc: Venkatraman S <svenkatr@ti.com>=20
Cc: Viresh Kumar <viresh.linux@gmail.com>=20
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>=20
Cc: Ian Molton <ian@mnementh.co.uk>=20
Cc: Bruce Chang <brucechang@via.com.tw>=20
Cc: Harald Welte <HaraldWelte@viatech.com>=20
Cc: Pierre Ossman <pierre@ossman.eu>=20
Cc: linux-mmc@vger.kernel.org=20
Cc: uclinux-dist-devel@blackfin.uclinux.org=20
Cc: linux-omap@vger.kernel.org=20
Cc: linux-arm-kernel@lists.infradead.org=20
Cc: spear-devel@list.st.com=20
---
 drivers/mmc/host/au1xmmc.c         | 2 +-
 drivers/mmc/host/bfin_sdh.c        | 2 +-
 drivers/mmc/host/cb710-mmc.c       | 2 +-
 drivers/mmc/host/dw_mmc-pci.c      | 2 +-
 drivers/mmc/host/dw_mmc-pltfm.c    | 2 +-
 drivers/mmc/host/dw_mmc-pltfm.h    | 2 +-
 drivers/mmc/host/jz4740_mmc.c      | 2 +-
 drivers/mmc/host/mmc_spi.c         | 2 +-
 drivers/mmc/host/mmci.c            | 4 ++--
 drivers/mmc/host/omap.c            | 2 +-
 drivers/mmc/host/omap_hsmmc.c      | 2 +-
 drivers/mmc/host/s3cmci.c          | 2 +-
 drivers/mmc/host/sdhci-cns3xxx.c   | 2 +-
 drivers/mmc/host/sdhci-dove.c      | 2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 drivers/mmc/host/sdhci-of-esdhc.c  | 2 +-
 drivers/mmc/host/sdhci-of-hlwd.c   | 2 +-
 drivers/mmc/host/sdhci-pci.c       | 4 ++--
 drivers/mmc/host/sdhci-pxav2.c     | 2 +-
 drivers/mmc/host/sdhci-pxav3.c     | 2 +-
 drivers/mmc/host/sdhci-s3c.c       | 2 +-
 drivers/mmc/host/sdhci-spear.c     | 2 +-
 drivers/mmc/host/sdhci-tegra.c     | 2 +-
 drivers/mmc/host/sh_mmcif.c        | 2 +-
 drivers/mmc/host/tmio_mmc.c        | 2 +-
 drivers/mmc/host/via-sdmmc.c       | 2 +-
 drivers/mmc/host/wbsd.c            | 6 +++---
 27 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index 606c16a..127a8fa 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -1114,7 +1114,7 @@ out0:
 	return ret;
 }
=20
-static int __devexit au1xmmc_remove(struct platform_device *pdev)
+static int au1xmmc_remove(struct platform_device *pdev)
 {
 	struct au1xmmc_host *host =3D platform_get_drvdata(pdev);
=20
diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
index 4ef3901..fb4348c 100644
--- a/drivers/mmc/host/bfin_sdh.c
+++ b/drivers/mmc/host/bfin_sdh.c
@@ -617,7 +617,7 @@ out1:
 	return ret;
 }
=20
-static int __devexit sdh_remove(struct platform_device *pdev)
+static int sdh_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc =3D platform_get_drvdata(pdev);
=20
diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.=
c
index c12a561..777ca20 100644
--- a/drivers/mmc/host/cb710-mmc.c
+++ b/drivers/mmc/host/cb710-mmc.c
@@ -746,7 +746,7 @@ err_free_mmc:
 	return err;
 }
=20
-static int __devexit cb710_mmc_exit(struct platform_device *pdev)
+static int cb710_mmc_exit(struct platform_device *pdev)
 {
 	struct cb710_slot *slot =3D cb710_pdev_to_slot(pdev);
 	struct mmc_host *mmc =3D cb710_slot_to_mmc(slot);
diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pc=
i.c
index 324c8bf..083fcd2 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -85,7 +85,7 @@ err_disable_dev:
 	return ret;
 }
=20
-static void __devexit dw_mci_pci_remove(struct pci_dev *pdev)
+static void dw_mci_pci_remove(struct pci_dev *pdev)
 {
 	struct dw_mci *host =3D pci_get_drvdata(pdev);
=20
diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-=
pltfm.c
index ff73a87..5e1fb1d 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -67,7 +67,7 @@ static int dw_mci_pltfm_probe(struct platform_device =
*pdev)
 	return dw_mci_pltfm_register(pdev, NULL);
 }
=20
-static int __devexit dw_mci_pltfm_remove(struct platform_device *pdev)
+static int dw_mci_pltfm_remove(struct platform_device *pdev)
 {
 	struct dw_mci *host =3D platform_get_drvdata(pdev);
=20
diff --git a/drivers/mmc/host/dw_mmc-pltfm.h b/drivers/mmc/host/dw_mmc-=
pltfm.h
index 2ac37b8..68e7fd2 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.h
+++ b/drivers/mmc/host/dw_mmc-pltfm.h
@@ -14,7 +14,7 @@
=20
 extern int dw_mci_pltfm_register(struct platform_device *pdev,
 				const struct dw_mci_drv_data *drv_data);
-extern int __devexit dw_mci_pltfm_remove(struct platform_device *pdev)=
;
+extern int dw_mci_pltfm_remove(struct platform_device *pdev);
 extern const struct dev_pm_ops dw_mci_pltfm_pmops;
=20
 #endif /* _DW_MMC_PLTFM_H_ */
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mm=
c.c
index 81826be..2391c6b 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -938,7 +938,7 @@ err_free_host:
 	return ret;
 }
=20
-static int __devexit jz4740_mmc_remove(struct platform_device *pdev)
+static int jz4740_mmc_remove(struct platform_device *pdev)
 {
 	struct jz4740_mmc_host *host =3D platform_get_drvdata(pdev);
=20
diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 1e2256b..74145d1 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1485,7 +1485,7 @@ nomem:
 }
=20
=20
-static int __devexit mmc_spi_remove(struct spi_device *spi)
+static int mmc_spi_remove(struct spi_device *spi)
 {
 	struct mmc_host		*mmc =3D dev_get_drvdata(&spi->dev);
 	struct mmc_spi_host	*host;
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index bf5f7a5..aa04b42 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -338,7 +338,7 @@ static void mmci_dma_setup(struct mmci_host *host)
 }
=20
 /*
- * This is used in or __devexit so inline it
+ * This is used in or so inline it
  * so it can be discarded.
  */
 static inline void mmci_dma_release(struct mmci_host *host)
@@ -1546,7 +1546,7 @@ static int mmci_probe(struct amba_device *dev,
 	return ret;
 }
=20
-static int __devexit mmci_remove(struct amba_device *dev)
+static int mmci_remove(struct amba_device *dev)
 {
 	struct mmc_host *mmc =3D amba_get_drvdata(dev);
=20
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 5cd976a..4254975 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1495,7 +1495,7 @@ err_free_mem_region:
 	return ret;
 }
=20
-static int __devexit mmc_omap_remove(struct platform_device *pdev)
+static int mmc_omap_remove(struct platform_device *pdev)
 {
 	struct mmc_omap_host *host =3D platform_get_drvdata(pdev);
 	int i;
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmm=
c.c
index 492d8cf..fca9b5f 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1993,7 +1993,7 @@ err:
 	return ret;
 }
=20
-static int __devexit omap_hsmmc_remove(struct platform_device *pdev)
+static int omap_hsmmc_remove(struct platform_device *pdev)
 {
 	struct omap_hsmmc_host *host =3D platform_get_drvdata(pdev);
 	struct resource *res;
diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index b846a97..63fb265 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1819,7 +1819,7 @@ static void s3cmci_shutdown(struct platform_devic=
e *pdev)
 	clk_disable(host->clk);
 }
=20
-static int __devexit s3cmci_remove(struct platform_device *pdev)
+static int s3cmci_remove(struct platform_device *pdev)
 {
 	struct mmc_host		*mmc  =3D platform_get_drvdata(pdev);
 	struct s3cmci_host	*host =3D mmc_priv(mmc);
diff --git a/drivers/mmc/host/sdhci-cns3xxx.c b/drivers/mmc/host/sdhci-=
cns3xxx.c
index ce959dcf..30bfdc4 100644
--- a/drivers/mmc/host/sdhci-cns3xxx.c
+++ b/drivers/mmc/host/sdhci-cns3xxx.c
@@ -100,7 +100,7 @@ static int sdhci_cns3xxx_probe(struct platform_devi=
ce *pdev)
 	return sdhci_pltfm_register(pdev, &sdhci_cns3xxx_pdata);
 }
=20
-static int __devexit sdhci_cns3xxx_remove(struct platform_device *pdev=
)
+static int sdhci_cns3xxx_remove(struct platform_device *pdev)
 {
 	return sdhci_pltfm_unregister(pdev);
 }
diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dov=
e.c
index 73c0eb8..5f4d033 100644
--- a/drivers/mmc/host/sdhci-dove.c
+++ b/drivers/mmc/host/sdhci-dove.c
@@ -114,7 +114,7 @@ sdhci_dove_register_fail:
 	return ret;
 }
=20
-static int __devexit sdhci_dove_remove(struct platform_device *pdev)
+static int sdhci_dove_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host =3D platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhc=
i-esdhc-imx.c
index cd741bb..8d54fd7 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -599,7 +599,7 @@ err_imx_data:
 	return err;
 }
=20
-static int __devexit sdhci_esdhc_imx_remove(struct platform_device *pd=
ev)
+static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host =3D platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci=
-of-esdhc.c
index 1aceed7..6617d67 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -213,7 +213,7 @@ static int sdhci_esdhc_probe(struct platform_device=
 *pdev)
 	return sdhci_pltfm_register(pdev, &sdhci_esdhc_pdata);
 }
=20
-static int __devexit sdhci_esdhc_remove(struct platform_device *pdev)
+static int sdhci_esdhc_remove(struct platform_device *pdev)
 {
 	return sdhci_pltfm_unregister(pdev);
 }
diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-=
of-hlwd.c
index aa78f3c..c3d3715 100644
--- a/drivers/mmc/host/sdhci-of-hlwd.c
+++ b/drivers/mmc/host/sdhci-of-hlwd.c
@@ -71,7 +71,7 @@ static int sdhci_hlwd_probe(struct platform_device *p=
dev)
 	return sdhci_pltfm_register(pdev, &sdhci_hlwd_pdata);
 }
=20
-static int __devexit sdhci_hlwd_remove(struct platform_device *pdev)
+static int sdhci_hlwd_remove(struct platform_device *pdev)
 {
 	return sdhci_pltfm_unregister(pdev);
 }
diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.=
c
index 3844771..d01aa61 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1347,7 +1347,7 @@ static void sdhci_pci_runtime_pm_allow(struct dev=
ice *dev)
 	pm_suspend_ignore_children(dev, 1);
 }
=20
-static void __devexit sdhci_pci_runtime_pm_forbid(struct device *dev)
+static void sdhci_pci_runtime_pm_forbid(struct device *dev)
 {
 	pm_runtime_forbid(dev);
 	pm_runtime_get_noresume(dev);
@@ -1445,7 +1445,7 @@ err:
 	return ret;
 }
=20
-static void __devexit sdhci_pci_remove(struct pci_dev *pdev)
+static void sdhci_pci_remove(struct pci_dev *pdev)
 {
 	int i;
 	struct sdhci_pci_chip *chip;
diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-px=
av2.c
index 7d4dc19..ac854aa 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -247,7 +247,7 @@ err_clk_get:
 	return ret;
 }
=20
-static int __devexit sdhci_pxav2_remove(struct platform_device *pdev)
+static int sdhci_pxav2_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host =3D platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-px=
av3.c
index e89c809..186dfc3 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -313,7 +313,7 @@ err_clk_get:
 	return ret;
 }
=20
-static int __devexit sdhci_pxav3_remove(struct platform_device *pdev)
+static int sdhci_pxav3_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host =3D platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.=
c
index f5dde9e..fe21ed4 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -778,7 +778,7 @@ static int sdhci_s3c_probe(struct platform_device *=
pdev)
 	return ret;
 }
=20
-static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
+static int sdhci_s3c_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host =3D  platform_get_drvdata(pdev);
 	struct sdhci_s3c *sc =3D sdhci_priv(host);
diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-sp=
ear.c
index 3fd1896..df2379a 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -266,7 +266,7 @@ err:
 	return ret;
 }
=20
-static int __devexit sdhci_remove(struct platform_device *pdev)
+static int sdhci_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host =3D platform_get_drvdata(pdev);
 	struct spear_sdhci *sdhci =3D dev_get_platdata(&pdev->dev);
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-te=
gra.c
index d3936d0..3695b2e 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -370,7 +370,7 @@ err_no_plat:
 	return rc;
 }
=20
-static int __devexit sdhci_tegra_remove(struct platform_device *pdev)
+static int sdhci_tegra_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host =3D platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 9872b52..9b8efac 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1430,7 +1430,7 @@ ealloch:
 	return ret;
 }
=20
-static int __devexit sh_mmcif_remove(struct platform_device *pdev)
+static int sh_mmcif_remove(struct platform_device *pdev)
 {
 	struct sh_mmcif_host *host =3D platform_get_drvdata(pdev);
 	struct sh_mmcif_plat_data *pd =3D pdev->dev.platform_data;
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index f415be8..139212e 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -107,7 +107,7 @@ out:
 	return ret;
 }
=20
-static int __devexit tmio_mmc_remove(struct platform_device *pdev)
+static int tmio_mmc_remove(struct platform_device *pdev)
 {
 	const struct mfd_cell *cell =3D mfd_get_cell(pdev);
 	struct mmc_host *mmc =3D platform_get_drvdata(pdev);
diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.=
c
index 1f1a252..4f84586 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -1176,7 +1176,7 @@ disable:
 	return ret;
 }
=20
-static void __devexit via_sd_remove(struct pci_dev *pcidev)
+static void via_sd_remove(struct pci_dev *pcidev)
 {
 	struct via_crdr_mmc_host *sdhost =3D pci_get_drvdata(pcidev);
 	unsigned long flags;
diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index d71358a..e954b77 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1735,7 +1735,7 @@ static int wbsd_init(struct device *dev, int base=
, int irq, int dma,
 	return 0;
 }
=20
-static void __devexit wbsd_shutdown(struct device *dev, int pnp)
+static void wbsd_shutdown(struct device *dev, int pnp)
 {
 	struct mmc_host *mmc =3D dev_get_drvdata(dev);
 	struct wbsd_host *host;
@@ -1768,7 +1768,7 @@ static int wbsd_probe(struct platform_device *dev=
)
 	return wbsd_init(&dev->dev, param_io, param_irq, param_dma, 0);
 }
=20
-static int __devexit wbsd_remove(struct platform_device *dev)
+static int wbsd_remove(struct platform_device *dev)
 {
 	wbsd_shutdown(&dev->dev, 0);
=20
@@ -1801,7 +1801,7 @@ wbsd_pnp_probe(struct pnp_dev *pnpdev, const stru=
ct pnp_device_id *dev_id)
 	return wbsd_init(&pnpdev->dev, io, irq, dma, 1);
 }
=20
-static void __devexit wbsd_pnp_remove(struct pnp_dev *dev)
+static void wbsd_pnp_remove(struct pnp_dev *dev)
 {
 	wbsd_shutdown(&dev->dev, 1);
 }
--=20
1.8.0

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
