From: Zach Brown <zach.brown@ni.com>
Subject: [RFC v3 2/2] mmc: sdhci: Ignore capability register when it comes to speeds and use DT binding instead when sdhci-cap-speed-modes-broken is set.
Date: Mon, 24 Oct 2016 14:04:10 -0500
Message-ID: <1477335850-14945-3-git-send-email-zach.brown@ni.com>
References: <1477335850-14945-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:42879 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S941463AbcJXTEV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Oct 2016 15:04:21 -0400
In-Reply-To: <1477335850-14945-1-git-send-email-zach.brown@ni.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, zach.brown@ni.com

When the sdhci-cap-speed-modes-broken DT property is set, the driver
will ignore the bits of the capability registers that correspond to
speed modes.

Signed-off-by: Zach Brown <zach.brown@ni.com>
---
 drivers/mmc/host/sdhci.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1e25b01..a17c47e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -22,6 +22,7 @@
 #include <linux/scatterlist.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
 
 #include <linux/leds.h>
 
@@ -2991,6 +2992,7 @@ static int sdhci_set_dma_mask(struct sdhci_host *host)
 void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
 {
 	u16 v;
+	unsigned int speed_cap_broken = false;
 
 	if (host->read_caps)
 		return;
@@ -3005,18 +3007,37 @@ void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
 
 	sdhci_do_reset(host, SDHCI_RESET_ALL);
 
+	if (of_property_read_bool(mmc_dev(host->mmc)->of_node,
+				  "sdhci-cap-speed-modes-broken"))
+		speed_cap_broken = true;
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
+		if (speed_cap_broken)
+			host->caps &= ~SDHCI_CAN_DO_HISPD;
+	}
 
 	if (host->version < SDHCI_SPEC_300)
 		return;
 
-	host->caps1 = caps1 ? *caps1 : sdhci_readl(host, SDHCI_CAPABILITIES_1);
+	if (caps1)
+		host->caps1 = *caps1;
+	else {
+		host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
+		if (speed_cap_broken)
+			host->caps1 &= ~(SDHCI_SUPPORT_SDR50 |
+					 SDHCI_SUPPORT_SDR104 |
+					 SDHCI_SUPPORT_DDR50 |
+					 SDHCI_SUPPORT_HS400);
+	}
 }
 EXPORT_SYMBOL_GPL(__sdhci_read_caps);
 
-- 
2.7.4

