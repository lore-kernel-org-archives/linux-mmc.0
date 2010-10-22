From: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
Subject: [PATCH v2 1/2] sdhci-esdhc-imx: fix timeout on i.MX's sdhci
Date: Fri, 22 Oct 2010 10:46:18 +0200
Message-ID: <1287737179-3956-1-git-send-email-eric@eukrea.com>
References: <20101022061803.GB5572@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 30.mail-out.ovh.net ([213.186.62.213]:53139 "HELO
	30.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751917Ab0JVIqZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Oct 2010 04:46:25 -0400
In-Reply-To: <20101022061803.GB5572@pengutronix.de>
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
Acked-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhc=
i-esdhc-imx.c
index afbac9a..31256ad 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -130,6 +130,10 @@ static int esdhc_pltfm_init(struct sdhci_host *hos=
t, struct sdhci_pltfm_data *pd
 		gpio_request(boarddata->wp_gpio, "SD_WP");
 		gpio_direction_input(boarddata->wp_gpio);
 	}
+
+	if (cpu_is_mx35() || cpu_is_mx51())
+		host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+
 	return 0;
 }
=20
--=20
1.7.0.4

