From: Zach Brown <zach.brown@ni.com>
Subject: [PATCH 2/2] mmc: sdhci: Use sdhci-caps-mask and sdhci-caps to change the caps read during __sdhci_read_caps
Date: Fri, 28 Oct 2016 10:56:11 -0500
Message-ID: <1477670171-30015-3-git-send-email-zach.brown@ni.com>
References: <1477670171-30015-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:39563 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1761037AbcJ1P4W (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 28 Oct 2016 11:56:22 -0400
In-Reply-To: <1477670171-30015-1-git-send-email-zach.brown@ni.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, zach.brown@ni.com

The sdhci capabilities register can be incorrect. The sdhci-caps-mask
and sdhci-caps dt properties specify which bits of the register are
incorrect and what their values should be. This patch makes the sdhci
driver use those properties to correct the caps during
__sdhci_read_caps.

During __sdhci_read_caps
Use the sdhci-caps-mask property to turn off the incorrect bits of the
sdhci register after reading them.
Use the sdhci-caps to turn on bits after using sdhci-caps-mask to turn
off the incorrect ones.

Signed-off-by: Zach Brown <zach.brown@ni.com>
---
 drivers/mmc/host/sdhci.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1e25b01..d5feae4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -22,6 +22,7 @@
 #include <linux/scatterlist.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
 
 #include <linux/leds.h>
 
@@ -2991,6 +2992,8 @@ static int sdhci_set_dma_mask(struct sdhci_host *host)
 void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
 {
 	u16 v;
+	u64 dt_caps_mask = 0;
+	u64 dt_caps = 0;
 
 	if (host->read_caps)
 		return;
@@ -3005,18 +3008,35 @@ void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
 
 	sdhci_do_reset(host, SDHCI_RESET_ALL);
 
+	of_property_read_u64(mmc_dev(host->mmc)->of_node,
+			     "sdhci-caps-mask", &dt_caps_mask);
+	of_property_read_u64(mmc_dev(host->mmc)->of_node,
+			     "sdhci-caps", &dt_caps);
+
 	v = ver ? *ver : sdhci_readw(host, SDHCI_HOST_VERSION);
 	host->version = (v & SDHCI_SPEC_VER_MASK) >> SDHCI_SPEC_VER_SHIFT;
 
 	if (host->quirks & SDHCI_QUIRK_MISSING_CAPS)
 		return;
 
-	host->caps = caps ? *caps : sdhci_readl(host, SDHCI_CAPABILITIES);
+	if (caps)
+		host->caps = *caps;
+	else {
+		host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+		host->caps &= ~lower_32_bits(dt_caps_mask);
+		host->caps |= lower_32_bits(dt_caps);
+	}
 
 	if (host->version < SDHCI_SPEC_300)
 		return;
 
-	host->caps1 = caps1 ? *caps1 : sdhci_readl(host, SDHCI_CAPABILITIES_1);
+	if (caps1)
+		host->caps1 = *caps1;
+	else {
+		host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
+		host->caps1 &= ~upper_32_bits(dt_caps_mask);
+		host->caps1 |= upper_32_bits(dt_caps);
+	}
 }
 EXPORT_SYMBOL_GPL(__sdhci_read_caps);
 
-- 
2.7.4

