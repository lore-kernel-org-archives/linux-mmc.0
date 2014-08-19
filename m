From: Barry Song <Barry.Song@csr.com>
Subject: [PATCH] mmc: sdhci-sirf: fix 8bit width enable by overwriting set_bus_width
Date: Tue, 19 Aug 2014 15:07:47 +0800
Message-ID: <1408432067-5257-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:34948 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726AbaHSHI2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Aug 2014 03:08:28 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com, Minda Chen <Minda.Chen@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Minda Chen <Minda.Chen@csr.com>

8bit-width enable bit of CSR MMC hosts is 3, while stardard hosts use
bit 5. this patch fixes the functionality of 8bit transfer in CSR mmc
controllers and improve performance for mmc0 a lot.

Signed-off-by: Minda Chen <Minda.Chen@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/mmc/host/sdhci-sirf.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index 1700453..376f45f 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -15,6 +15,8 @@
 #include <linux/mmc/slot-gpio.h>
 #include "sdhci-pltfm.h"
 
+#define SDHCI_SIRF_8BITBUS BIT(3)
+
 struct sdhci_sirf_priv {
 	struct clk *clk;
 	int gpio_cd;
@@ -27,10 +29,33 @@ static unsigned int sdhci_sirf_get_max_clk(struct sdhci_host *host)
 	return clk_get_rate(priv->clk);
 }
 
+static void sdhci_sirf_set_bus_width(struct sdhci_host *host, int width)
+{
+        u8 ctrl;
+
+        ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+        if (width == MMC_BUS_WIDTH_8) {
+                ctrl &= ~SDHCI_CTRL_4BITBUS;
+                /*
+                 * 8bit-width enable bit of CSR MMC hosts is 3,
+                 * while stardard hosts use bit 5
+                 */
+                ctrl |= SDHCI_SIRF_8BITBUS;
+        } else {
+                if (host->version >= SDHCI_SPEC_300)
+                        ctrl &= ~SDHCI_SIRF_8BITBUS;
+                if (width == MMC_BUS_WIDTH_4)
+                        ctrl |= SDHCI_CTRL_4BITBUS;
+                else
+                        ctrl &= ~SDHCI_CTRL_4BITBUS;
+        }
+        sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+}
+
 static struct sdhci_ops sdhci_sirf_ops = {
 	.set_clock = sdhci_set_clock,
 	.get_max_clock	= sdhci_sirf_get_max_clk,
-	.set_bus_width = sdhci_set_bus_width,
+	.set_bus_width = sdhci_sirf_set_bus_width,
 	.reset = sdhci_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
-- 
2.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
