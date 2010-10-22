From: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
Subject: [PATCH 1/2] sdhci-esdhc-imx: fix timeout on i.MX's sdhci
Date: Sat, 23 Oct 2010 01:57:21 +0200
Message-ID: <1287791842-706-1-git-send-email-eric@eukrea.com>
References: <20101022231203.GA6502@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 63.mail-out.ovh.net ([91.121.185.56]:41529 "HELO
	63.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755537Ab0JVX51 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Oct 2010 19:57:27 -0400
In-Reply-To: <20101022231203.GA6502@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.gsc@gmail.com, w.sang@pengutronix.de, nicolas.pitre@linaro.org, r65037@freescale.com, amit.kucheria@linaro.org, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>

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
index 2e9cca1..28e63ef 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -17,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sdhci-pltfm.h>
+#include <mach/hardware.h>
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
@@ -112,6 +113,9 @@ static int esdhc_pltfm_init(struct sdhci_host *host=
, struct sdhci_pltfm_data *pd
 	clk_enable(clk);
 	pltfm_host->clk =3D clk;
=20
+	if (cpu_is_mx35() || cpu_is_mx51())
+		host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+
 	return 0;
 }
=20
--=20
1.7.0.4

