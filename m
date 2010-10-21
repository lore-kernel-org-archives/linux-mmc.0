From: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
Subject: [PATCH 1/2] sdhci-esdhc-imx: fix timeout on i.MX's sdhci
Date: Thu, 21 Oct 2010 23:20:27 +0200
Message-ID: <1287696028-27854-1-git-send-email-eric@eukrea.com>
References: <4CC0A281.1010202@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 63.mail-out.ovh.net ([91.121.185.56]:54041 "HELO
	63.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752931Ab0JUVUl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Oct 2010 17:20:41 -0400
In-Reply-To: <4CC0A281.1010202@eukrea.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, shawn.gsc@gmail.com, w.sang@pengutronix.de, nicolas.pitre@linaro.org, r65037@freescale.com, amit.kucheria@linaro.org, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>

this patch fix timeout problems on i.MX's sdhci as suggested by
Richard Zhu.

Tested on :
- i.MX257 : not needed
- i.MX357 : needed
- i.MX515 : needed

more details can be found here :
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-October/0297=
48.html

Signed-off-by: Eric B=C3=A9nard <eric@eukrea.com>
Tested-by: Shawn Guo <shawn.gsc@gmail.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhc=
i-esdhc-imx.c
index afbac9a..11e1ae1 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -130,6 +130,12 @@ static int esdhc_pltfm_init(struct sdhci_host *hos=
t, struct sdhci_pltfm_data *pd
 		gpio_request(boarddata->wp_gpio, "SD_WP");
 		gpio_direction_input(boarddata->wp_gpio);
 	}
+
+	if (cpu_is_mx35() || cpu_is_mx51()) {
+		dev_info(mmc_dev(host->mmc), "using broken timeout quirk\n");
+		host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+	}
+
 	return 0;
 }
=20
--=20
1.7.0.4

