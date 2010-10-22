From: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
Subject: [PATCH v2 2/2] sdhci-esdhc-imx: enable QUIRK_NO_MULTIBLOCK only for i.MX25 and i.MX35
Date: Fri, 22 Oct 2010 10:46:19 +0200
Message-ID: <1287737179-3956-2-git-send-email-eric@eukrea.com>
References: <20101022061803.GB5572@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 30.mail-out.ovh.net ([213.186.62.213]:33952 "HELO
	30.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751956Ab0JVIq0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Oct 2010 04:46:26 -0400
In-Reply-To: <20101022061803.GB5572@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, shawn.gsc@gmail.com, w.sang@pengutronix.de, nicolas.pitre@linaro.org, r65037@freescale.com, amit.kucheria@linaro.org, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>

only these CPU's errata list this bug.

Signed-off-by: Eric B=C3=A9nard <eric@eukrea.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhc=
i-esdhc-imx.c
index 31256ad..14d2836 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -134,6 +134,10 @@ static int esdhc_pltfm_init(struct sdhci_host *hos=
t, struct sdhci_pltfm_data *pd
 	if (cpu_is_mx35() || cpu_is_mx51())
 		host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
=20
+	/* fix errata ENGcm07207 which is present on i.MX25 and i.MX35 */
+	if (cpu_is_mx25() || cpu_is_mx35())
+		host->quirks |=3D SDHCI_QUIRK_NO_MULTIBLOCK;
+
 	return 0;
 }
=20
@@ -160,10 +164,8 @@ static struct sdhci_ops sdhci_esdhc_ops =3D {
 };
=20
 struct sdhci_pltfm_data sdhci_esdhc_imx_pdata =3D {
-	.quirks =3D ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_NO_MULTIBLOCK
-			| SDHCI_QUIRK_BROKEN_ADMA,
+	.quirks =3D ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_ADMA,
 	/* ADMA has issues. Might be fixable */
-	/* NO_MULTIBLOCK might be MX35 only (Errata: ENGcm07207) */
 	.ops =3D &sdhci_esdhc_ops,
 	.init =3D esdhc_pltfm_init,
 	.exit =3D esdhc_pltfm_exit,
--=20
1.7.0.4

