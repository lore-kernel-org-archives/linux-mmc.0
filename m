From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] mmc: sdhci-esdhc-imx: Call mmc_pwrseq_alloc()
Date: Mon,  6 Apr 2015 21:53:30 -0300
Message-ID: <1428368010-10094-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vn0-f53.google.com ([209.85.216.53]:41289 "EHLO
	mail-vn0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbbDGAxr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Apr 2015 20:53:47 -0400
Received: by vnbg190 with SMTP id g190so3459145vnb.8
        for <linux-mmc@vger.kernel.org>; Mon, 06 Apr 2015 17:53:46 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux@arm.linux.org.uk, kernel@pengutronix.de, otavio@ossystems.com.br, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Currently it is not possible to use 'mmc-pwrseq-simple' property with
this driver because mmc_pwrseq_alloc() is never called.

Call mmc_pwrseq_alloc so that we enable the support for providing a
reset GPIO to the Wifi/BT chipset.

Tested on a imx6sl-warp board:

root@imx6sl-warp:~# hciattach /dev/ttymxc1 3wire
Device setup complete
root@imx6sl-warp:~# hciconfig hci0 up
root@imx6sl-warp:~# hciconfig
hci0:   Type: BR/EDR  Bus: UART
        BD Address: 2A:23:AA:6E:C7:A0  ACL MTU: 1021:8  SCO MTU: 64:1
        UP RUNNING 
        RX bytes:795 acl:0 sco:0 events:29 errors:0
        TX bytes:613 acl:0 sco:0 commands:29 errors:0

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Calling mmc_of_parse() breaks some boards due to bad card detect parsing.
Call only mmc_pwrseq_alloc() instead, which what we really need.

 drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 7ee8312..5bcabdc 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -31,6 +31,8 @@
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
 
+#include "../core/pwrseq.h"
+
 #define	ESDHC_CTRL_D3CD			0x08
 /* VENDOR SPEC register */
 #define ESDHC_VENDOR_SPEC		0xc0
@@ -1079,6 +1081,10 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 	}
 
+	err = mmc_pwrseq_alloc(host->mmc);
+	if (err)
+		goto disable_clk;
+
 	err = sdhci_add_host(host);
 	if (err)
 		goto disable_clk;
-- 
1.9.1

