From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: [PATCH] mmc: sdhci-pltfm: Use devm_platform_ioremap_resource() to
 simplify code
Date: Thu, 25 Jul 2019 07:28:22 +0000
Message-ID: <20190725151748.1a59b1ba@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <DFBD51F7FD4080428927BA250222F162@namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

devm_platform_ioremap_resource() wraps platform_get_resource() and
devm_ioremap_resource() in a single helper, let's use that helper to
simplify the code.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/sdhci-pltfm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.=
c
index d268b3b8850a..11ecff9e998d 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -118,12 +118,10 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_d=
evice *pdev,
 				    size_t priv_size)
 {
 	struct sdhci_host *host;
-	struct resource *iomem;
 	void __iomem *ioaddr;
 	int irq, ret;
=20
-	iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ioaddr =3D devm_ioremap_resource(&pdev->dev, iomem);
+	ioaddr =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ioaddr)) {
 		ret =3D PTR_ERR(ioaddr);
 		goto err;
--=20
2.22.0
