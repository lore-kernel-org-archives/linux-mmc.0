From: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
Subject: [PATCH v2 2/2] mmc: sdhci: Use sdhci-caps-mask and sdhci-caps to change the caps read during __sdhci_read_caps
Date: Wed, 2 Nov 2016 10:26:16 -0500
Message-ID: <1478100376-602-3-git-send-email-zach.brown@ni.com>
References: <1478100376-602-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1478100376-602-1-git-send-email-zach.brown-acOepvfBmUk@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zach.brown-acOepvfBmUk@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

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

Signed-off-by: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/mmc/host/sdhci.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1e25b01..eba5f39 100644
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
+	if (caps) {
+		host->caps = *caps;
+	} else {
+		host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+		host->caps &= ~lower_32_bits(dt_caps_mask);
+		host->caps |= lower_32_bits(dt_caps);
+	}
 
 	if (host->version < SDHCI_SPEC_300)
 		return;
 
-	host->caps1 = caps1 ? *caps1 : sdhci_readl(host, SDHCI_CAPABILITIES_1);
+	if (caps1) {
+		host->caps1 = *caps1;
+	} else {
+		host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
+		host->caps1 &= ~upper_32_bits(dt_caps_mask);
+		host->caps1 |= upper_32_bits(dt_caps);
+	}
 }
 EXPORT_SYMBOL_GPL(__sdhci_read_caps);
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
