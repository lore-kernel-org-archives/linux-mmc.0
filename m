From: Bill Pemberton <wfp5p@virginia.edu>
Subject: =?UTF-8?q?=5BPATCH=20077/493=5D=20mmc=3A=20remove=20use=20of=20=5F=5Fdevexit=5Fp?=
Date: Mon, 19 Nov 2012 13:20:26 -0500
Message-ID: <1353349642-3677-77-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-omap-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Chris Ball <cjb@laptop.org>, =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, Venkatraman S <svenkatr@ti.com>, Viresh Kumar <viresh.linux@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, Bruce Chang <brucechang@via.com.tw>, Harald Welte <HaraldWelte@viatech.com>, Pierre Ossman <pierre@ossman.eu>, uclinux-dist-devel@blackfin.uclinux.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, spear-devel@list.st.com
List-Id: linux-mmc@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org=20
Cc: linux-mmc@vger.kernel.org=20
Cc: linux-omap@vger.kernel.org=20
Cc: linux-arm-kernel@lists.infradead.org=20
Cc: spear-devel@list.st.com=20
---
 drivers/mmc/host/bfin_sdh.c        | 2 +-
 drivers/mmc/host/cb710-mmc.c       | 2 +-
 drivers/mmc/host/dw_mmc-pci.c      | 2 +-
 drivers/mmc/host/dw_mmc-pltfm.c    | 2 +-
 drivers/mmc/host/jz4740_mmc.c      | 2 +-
 drivers/mmc/host/mmc_spi.c         | 2 +-
 drivers/mmc/host/mmci.c            | 2 +-
 drivers/mmc/host/omap.c            | 2 +-
 drivers/mmc/host/omap_hsmmc.c      | 2 +-
 drivers/mmc/host/s3cmci.c          | 2 +-
 drivers/mmc/host/sdhci-cns3xxx.c   | 2 +-
 drivers/mmc/host/sdhci-dove.c      | 2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 drivers/mmc/host/sdhci-of-esdhc.c  | 2 +-
 drivers/mmc/host/sdhci-of-hlwd.c   | 2 +-
 drivers/mmc/host/sdhci-pci.c       | 2 +-
 drivers/mmc/host/sdhci-pxav2.c     | 2 +-
 drivers/mmc/host/sdhci-pxav3.c     | 2 +-
 drivers/mmc/host/sdhci-s3c.c       | 2 +-
 drivers/mmc/host/sdhci-spear.c     | 2 +-
 drivers/mmc/host/sdhci-tegra.c     | 2 +-
 drivers/mmc/host/sh_mobile_sdhi.c  | 2 +-
 drivers/mmc/host/tmio_mmc.c        | 2 +-
 drivers/mmc/host/via-sdmmc.c       | 2 +-
 drivers/mmc/host/wbsd.c            | 4 ++--
 25 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
index b9b463e..156ebe7 100644
--- a/drivers/mmc/host/bfin_sdh.c
+++ b/drivers/mmc/host/bfin_sdh.c
@@ -680,7 +680,7 @@ static int sdh_resume(struct platform_device *dev)
=20
 static struct platform_driver sdh_driver =3D {
 	.probe   =3D sdh_probe,
-	.remove  =3D __devexit_p(sdh_remove),
+	.remove  =3D sdh_remove,
 	.suspend =3D sdh_suspend,
 	.resume  =3D sdh_resume,
 	.driver  =3D {
diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.=
c
index 83693fd..39280b5 100644
--- a/drivers/mmc/host/cb710-mmc.c
+++ b/drivers/mmc/host/cb710-mmc.c
@@ -773,7 +773,7 @@ static int __devexit cb710_mmc_exit(struct platform=
_device *pdev)
 static struct platform_driver cb710_mmc_driver =3D {
 	.driver.name =3D "cb710-mmc",
 	.probe =3D cb710_mmc_init,
-	.remove =3D __devexit_p(cb710_mmc_exit),
+	.remove =3D cb710_mmc_exit,
 #ifdef CONFIG_PM
 	.suspend =3D cb710_mmc_suspend,
 	.resume =3D cb710_mmc_resume,
diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pc=
i.c
index 53a09cb..edb37e9 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -134,7 +134,7 @@ static struct pci_driver dw_mci_pci_driver =3D {
 	.name		=3D "dw_mmc_pci",
 	.id_table	=3D dw_mci_pci_id,
 	.probe		=3D dw_mci_pci_probe,
-	.remove		=3D __devexit_p(dw_mci_pci_remove),
+	.remove		=3D dw_mci_pci_remove,
 	.driver		=3D	{
 		.pm =3D   &dw_mci_pci_pmops
 	},
diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-=
pltfm.c
index 4e13370..4c1b1df 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -120,7 +120,7 @@ MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
=20
 static struct platform_driver dw_mci_pltfm_driver =3D {
 	.probe		=3D dw_mci_pltfm_probe,
-	.remove		=3D __devexit_p(dw_mci_pltfm_remove),
+	.remove		=3D dw_mci_pltfm_remove,
 	.driver		=3D {
 		.name		=3D "dw_mmc",
 		.of_match_table	=3D of_match_ptr(dw_mci_pltfm_match),
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mm=
c.c
index c8852a8..31cf20f 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1004,7 +1004,7 @@ const struct dev_pm_ops jz4740_mmc_pm_ops =3D {
=20
 static struct platform_driver jz4740_mmc_driver =3D {
 	.probe =3D jz4740_mmc_probe,
-	.remove =3D __devexit_p(jz4740_mmc_remove),
+	.remove =3D jz4740_mmc_remove,
 	.driver =3D {
 		.name =3D "jz4740-mmc",
 		.owner =3D THIS_MODULE,
diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index a600eab..f7df798 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1529,7 +1529,7 @@ static struct spi_driver mmc_spi_driver =3D {
 		.of_match_table =3D mmc_spi_of_match_table,
 	},
 	.probe =3D	mmc_spi_probe,
-	.remove =3D	__devexit_p(mmc_spi_remove),
+	.remove =3D	mmc_spi_remove,
 };
=20
 module_spi_driver(mmc_spi_driver);
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 9446c17..705c3be 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1693,7 +1693,7 @@ static struct amba_driver mmci_driver =3D {
 		.pm	=3D &mmci_dev_pm_ops,
 	},
 	.probe		=3D mmci_probe,
-	.remove		=3D __devexit_p(mmci_remove),
+	.remove		=3D mmci_remove,
 	.id_table	=3D mmci_ids,
 };
=20
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index ae115c0..f65ec26 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1583,7 +1583,7 @@ static int mmc_omap_resume(struct platform_device=
 *pdev)
=20
 static struct platform_driver mmc_omap_driver =3D {
 	.probe		=3D mmc_omap_probe,
-	.remove		=3D __devexit_p(mmc_omap_remove),
+	.remove		=3D mmc_omap_remove,
 	.suspend	=3D mmc_omap_suspend,
 	.resume		=3D mmc_omap_resume,
 	.driver		=3D {
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmm=
c.c
index 7546cb2..8f5c7e2 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2156,7 +2156,7 @@ static struct dev_pm_ops omap_hsmmc_dev_pm_ops =3D=
 {
=20
 static struct platform_driver omap_hsmmc_driver =3D {
 	.probe		=3D omap_hsmmc_probe,
-	.remove		=3D __devexit_p(omap_hsmmc_remove),
+	.remove		=3D omap_hsmmc_remove,
 	.driver		=3D {
 		.name =3D DRIVER_NAME,
 		.owner =3D THIS_MODULE,
diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 4638dda..a5fe5b2 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1906,7 +1906,7 @@ static struct platform_driver s3cmci_driver =3D {
 	},
 	.id_table	=3D s3cmci_driver_ids,
 	.probe		=3D s3cmci_probe,
-	.remove		=3D __devexit_p(s3cmci_remove),
+	.remove		=3D s3cmci_remove,
 	.shutdown	=3D s3cmci_shutdown,
 };
=20
diff --git a/drivers/mmc/host/sdhci-cns3xxx.c b/drivers/mmc/host/sdhci-=
cns3xxx.c
index 28a8708..9236fa9 100644
--- a/drivers/mmc/host/sdhci-cns3xxx.c
+++ b/drivers/mmc/host/sdhci-cns3xxx.c
@@ -112,7 +112,7 @@ static struct platform_driver sdhci_cns3xxx_driver =
=3D {
 		.pm	=3D SDHCI_PLTFM_PMOPS,
 	},
 	.probe		=3D sdhci_cns3xxx_probe,
-	.remove		=3D __devexit_p(sdhci_cns3xxx_remove),
+	.remove		=3D sdhci_cns3xxx_remove,
 };
=20
 module_platform_driver(sdhci_cns3xxx_driver);
diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dov=
e.c
index 8fd50a2..7ad1bb6 100644
--- a/drivers/mmc/host/sdhci-dove.c
+++ b/drivers/mmc/host/sdhci-dove.c
@@ -143,7 +143,7 @@ static struct platform_driver sdhci_dove_driver =3D=
 {
 		.of_match_table =3D of_match_ptr(sdhci_dove_of_match_table),
 	},
 	.probe		=3D sdhci_dove_probe,
-	.remove		=3D __devexit_p(sdhci_dove_remove),
+	.remove		=3D sdhci_dove_remove,
 };
=20
 module_platform_driver(sdhci_dove_driver);
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhc=
i-esdhc-imx.c
index effc2ac..6a4e98e 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -637,7 +637,7 @@ static struct platform_driver sdhci_esdhc_imx_drive=
r =3D {
 	},
 	.id_table	=3D imx_esdhc_devtype,
 	.probe		=3D sdhci_esdhc_imx_probe,
-	.remove		=3D __devexit_p(sdhci_esdhc_imx_remove),
+	.remove		=3D sdhci_esdhc_imx_remove,
 };
=20
 module_platform_driver(sdhci_esdhc_imx_driver);
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci=
-of-esdhc.c
index 63d219f..d7eb4ed 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -234,7 +234,7 @@ static struct platform_driver sdhci_esdhc_driver =3D=
 {
 		.pm =3D SDHCI_PLTFM_PMOPS,
 	},
 	.probe =3D sdhci_esdhc_probe,
-	.remove =3D __devexit_p(sdhci_esdhc_remove),
+	.remove =3D sdhci_esdhc_remove,
 };
=20
 module_platform_driver(sdhci_esdhc_driver);
diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-=
of-hlwd.c
index 0ce088ae..3b68069 100644
--- a/drivers/mmc/host/sdhci-of-hlwd.c
+++ b/drivers/mmc/host/sdhci-of-hlwd.c
@@ -90,7 +90,7 @@ static struct platform_driver sdhci_hlwd_driver =3D {
 		.pm =3D SDHCI_PLTFM_PMOPS,
 	},
 	.probe =3D sdhci_hlwd_probe,
-	.remove =3D __devexit_p(sdhci_hlwd_remove),
+	.remove =3D sdhci_hlwd_remove,
 };
=20
 module_platform_driver(sdhci_hlwd_driver);
diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.=
c
index 04936f3..7bc2270 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1470,7 +1470,7 @@ static struct pci_driver sdhci_driver =3D {
 	.name =3D		"sdhci-pci",
 	.id_table =3D	pci_ids,
 	.probe =3D	sdhci_pci_probe,
-	.remove =3D	__devexit_p(sdhci_pci_remove),
+	.remove =3D	sdhci_pci_remove,
 	.driver =3D	{
 		.pm =3D   &sdhci_pci_pm_ops
 	},
diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-px=
av2.c
index 8e63a9c..964fc6d 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -275,7 +275,7 @@ static struct platform_driver sdhci_pxav2_driver =3D=
 {
 		.pm	=3D SDHCI_PLTFM_PMOPS,
 	},
 	.probe		=3D sdhci_pxav2_probe,
-	.remove		=3D __devexit_p(sdhci_pxav2_remove),
+	.remove		=3D sdhci_pxav2_remove,
 };
=20
 module_platform_driver(sdhci_pxav2_driver);
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-px=
av3.c
index e918a2b..a46cb67 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -346,7 +346,7 @@ static struct platform_driver sdhci_pxav3_driver =3D=
 {
 		.pm	=3D SDHCI_PLTFM_PMOPS,
 	},
 	.probe		=3D sdhci_pxav3_probe,
-	.remove		=3D __devexit_p(sdhci_pxav3_remove),
+	.remove		=3D sdhci_pxav3_remove,
 };
=20
 module_platform_driver(sdhci_pxav3_driver);
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.=
c
index a54dd5d..b62a0c1 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -916,7 +916,7 @@ MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
=20
 static struct platform_driver sdhci_s3c_driver =3D {
 	.probe		=3D sdhci_s3c_probe,
-	.remove		=3D __devexit_p(sdhci_s3c_remove),
+	.remove		=3D sdhci_s3c_remove,
 	.id_table	=3D sdhci_s3c_driver_ids,
 	.driver		=3D {
 		.owner	=3D THIS_MODULE,
diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-sp=
ear.c
index 6be89c0..3ba9479 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -336,7 +336,7 @@ static struct platform_driver sdhci_driver =3D {
 		.of_match_table =3D of_match_ptr(sdhci_spear_id_table),
 	},
 	.probe		=3D sdhci_probe,
-	.remove		=3D __devexit_p(sdhci_remove),
+	.remove		=3D sdhci_remove,
 };
=20
 module_platform_driver(sdhci_driver);
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-te=
gra.c
index f9eb916..f284354 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -407,7 +407,7 @@ static struct platform_driver sdhci_tegra_driver =3D=
 {
 		.pm	=3D SDHCI_PLTFM_PMOPS,
 	},
 	.probe		=3D sdhci_tegra_probe,
-	.remove		=3D __devexit_p(sdhci_tegra_remove),
+	.remove		=3D sdhci_tegra_remove,
 };
=20
 module_platform_driver(sdhci_tegra_driver);
diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mo=
bile_sdhi.c
index 0bdc146..6a9a625 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -330,7 +330,7 @@ static struct platform_driver sh_mobile_sdhi_driver=
 =3D {
 		.of_match_table =3D sh_mobile_sdhi_of_match,
 	},
 	.probe		=3D sh_mobile_sdhi_probe,
-	.remove		=3D __devexit_p(sh_mobile_sdhi_remove),
+	.remove		=3D sh_mobile_sdhi_remove,
 };
=20
 module_platform_driver(sh_mobile_sdhi_driver);
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 113ce6c..2f9bbdf 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -133,7 +133,7 @@ static struct platform_driver tmio_mmc_driver =3D {
 		.owner =3D THIS_MODULE,
 	},
 	.probe =3D tmio_mmc_probe,
-	.remove =3D __devexit_p(tmio_mmc_remove),
+	.remove =3D tmio_mmc_remove,
 	.suspend =3D tmio_mmc_suspend,
 	.resume =3D tmio_mmc_resume,
 };
diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.=
c
index f18bece..d8f8a5e 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -1332,7 +1332,7 @@ static struct pci_driver via_sd_driver =3D {
 	.name =3D DRV_NAME,
 	.id_table =3D via_ids,
 	.probe =3D via_sd_probe,
-	.remove =3D __devexit_p(via_sd_remove),
+	.remove =3D via_sd_remove,
 	.suspend =3D via_sd_suspend,
 	.resume =3D via_sd_resume,
 };
diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index 64acd9c..3c8ef59 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1941,7 +1941,7 @@ static struct platform_device *wbsd_device;
=20
 static struct platform_driver wbsd_driver =3D {
 	.probe		=3D wbsd_probe,
-	.remove		=3D __devexit_p(wbsd_remove),
+	.remove		=3D wbsd_remove,
=20
 	.suspend	=3D wbsd_platform_suspend,
 	.resume		=3D wbsd_platform_resume,
@@ -1957,7 +1957,7 @@ static struct pnp_driver wbsd_pnp_driver =3D {
 	.name		=3D DRIVER_NAME,
 	.id_table	=3D pnp_dev_table,
 	.probe		=3D wbsd_pnp_probe,
-	.remove		=3D __devexit_p(wbsd_pnp_remove),
+	.remove		=3D wbsd_pnp_remove,
=20
 	.suspend	=3D wbsd_pnp_suspend,
 	.resume		=3D wbsd_pnp_resume,
--=20
1.8.0

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
