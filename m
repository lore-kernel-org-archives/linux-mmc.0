From: Barry Song <Baohua.Song@csr.com>
Subject: [PATCH v2] mmc: sdhci-sirf: let device core setup the default pin configuration
Date: Tue, 14 May 2013 17:08:31 +0800
Message-ID: <1368522511-26491-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:43841 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756309Ab3ENJJs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 May 2013 05:09:48 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>

With device core now able to setup the default pin configuration, the call
to devm_pinctrl_get_select_default can be removed. And the pin configuration
code based on the deprecated Samsung specific gpio bindings is also removed.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 -v2:
 delete "#include <linux/pinctrl/consumer.h>"

 drivers/mmc/host/sdhci-sirf.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index 09805af..ccf12dd 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -13,7 +13,6 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/mmc/slot-gpio.h>
-#include <linux/pinctrl/consumer.h>
 #include "sdhci-pltfm.h"
 
 struct sdhci_sirf_priv {
@@ -46,15 +45,8 @@ static int sdhci_sirf_probe(struct platform_device *pdev)
 	struct sdhci_host *host;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_sirf_priv *priv;
-	struct pinctrl *pinctrl;
 	int ret;
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl)) {
-		dev_err(&pdev->dev, "unable to get pinmux");
-		return PTR_ERR(pinctrl);
-	}
-
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct sdhci_sirf_priv),
 		GFP_KERNEL);
 	if (!priv) {
-- 
1.7.4.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
