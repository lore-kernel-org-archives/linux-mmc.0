From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] mmc: cavium-octeon: Use devm_platform_ioremap_resource() in
 octeon_mmc_probe()
Date: Wed, 18 Sep 2019 14:28:38 +0200
Message-ID: <4ad4cdb5-3623-4416-d3d2-b3c048a42139@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, David Daney <david.daney@cavium.com>, Jan Glauber <jglauber@cavium.com>, "Steven J. Hill" <Steven.Hill@cavium.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Himanshu Jha <himanshujha199640@gmail.com>
List-Id: linux-mmc@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 18 Sep 2019 14:20:34 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/mmc/host/cavium-octeon.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-oc=
teon.c
index 22aded1065ae..916746c6c2c7 100644
=2D-- a/drivers/mmc/host/cavium-octeon.c
+++ b/drivers/mmc/host/cavium-octeon.c
@@ -148,7 +148,6 @@ static int octeon_mmc_probe(struct platform_device *pd=
ev)
 {
 	struct device_node *cn, *node =3D pdev->dev.of_node;
 	struct cvm_mmc_host *host;
-	struct resource	*res;
 	void __iomem *base;
 	int mmc_irq[9];
 	int i, ret =3D 0;
@@ -205,23 +204,13 @@ static int octeon_mmc_probe(struct platform_device *=
pdev)

 	host->last_slot =3D -1;

-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Platform resource[0] is missing\n");
-		return -ENXIO;
-	}
-	base =3D devm_ioremap_resource(&pdev->dev, res);
+	base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 	host->base =3D (void __iomem *)base;
 	host->reg_off =3D 0;

-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res) {
-		dev_err(&pdev->dev, "Platform resource[1] is missing\n");
-		return -EINVAL;
-	}
-	base =3D devm_ioremap_resource(&pdev->dev, res);
+	base =3D devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 	host->dma_base =3D (void __iomem *)base;
=2D-
2.23.0
