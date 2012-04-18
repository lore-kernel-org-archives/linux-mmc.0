From: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
Subject: [PATCH] mmc: unbreak sdhci-esdhc-imx on i.MX25
Date: Wed, 18 Apr 2012 02:30:20 +0200
Message-ID: <1334709020-31088-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:59138 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752357Ab2DRAal (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 17 Apr 2012 20:30:41 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: shawn.guo@linaro.org, w.sang@pengutronix.de, cjb@laptop.org, s.hauer@pengutronix.de, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>

this was broken by me in 37865fe91582582a6f6c00652f6a2b1ff71f8a78
"mmc: sdhci-esdhc-imx: fix timeout on i.MX's sdhc" where more
extensive tests would have shown that read or write of data
to the card were failing (even if the partition table was
correctly read).

Signed-off-by: Eric B=C3=A9nard <eric@eukrea.com>
Acked-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhc=
i-esdhc-imx.c
index 6193a0d..8abdaf6 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -467,8 +467,7 @@ static int __devinit sdhci_esdhc_imx_probe(struct p=
latform_device *pdev)
 	clk_prepare_enable(clk);
 	pltfm_host->clk =3D clk;
=20
-	if (!is_imx25_esdhc(imx_data))
-		host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+	host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
=20
 	if (is_imx25_esdhc(imx_data) || is_imx35_esdhc(imx_data))
 		/* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
--=20
1.7.7.6

