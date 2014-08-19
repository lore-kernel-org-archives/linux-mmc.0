From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH v2] mmc: sdhci-sirf: fix 8bit width enable by overwriting set_bus_width
Date: Tue, 19 Aug 2014 20:59:13 +0800
Message-ID: <1408453153-8125-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:61219 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbaHSM7m (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Aug 2014 08:59:42 -0400
Received: by mail-pa0-f51.google.com with SMTP id ey11so9720633pad.24
        for <linux-mmc@vger.kernel.org>; Tue, 19 Aug 2014 05:59:37 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, chris@printf.net
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com, Minda Chen <Minda.Chen@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Minda Chen <Minda.Chen@csr.com>

8bit-width enable bit of CSR MMC hosts is 3, while stardard hosts use
bit 5. this patch fixes the functionality of 8bit transfer in CSR mmc
controllers and improve performance for mmc0 a lot.

Signed-off-by: Minda Chen <Minda.Chen@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 -v2: check for host->version >= SDHCI_SPEC_300

 drivers/mmc/host/sdhci-sirf.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index 1700453..a7224e5 100644
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
@@ -27,10 +29,34 @@ static unsigned int sdhci_sirf_get_max_clk(struct sdhci_host *host)
 	return clk_get_rate(priv->clk);
 }
 
+static void sdhci_sirf_set_bus_width(struct sdhci_host *host, int width)
+{
+	u8 ctrl;
+
+	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+	if (width == MMC_BUS_WIDTH_8) {
+		ctrl &= ~SDHCI_CTRL_4BITBUS;
+		/*
+		 * 8bit-width enable bit of CSR MMC hosts is 3,
+		 * while stardard hosts use bit 5
+		 */
+		if (host->version >= SDHCI_SPEC_300)
+			ctrl |= SDHCI_SIRF_8BITBUS;
+	} else {
+		if (host->version >= SDHCI_SPEC_300)
+			ctrl &= ~SDHCI_SIRF_8BITBUS;
+		if (width == MMC_BUS_WIDTH_4)
+			ctrl |= SDHCI_CTRL_4BITBUS;
+		else
+			ctrl &= ~SDHCI_CTRL_4BITBUS;
+	}
+	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
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

