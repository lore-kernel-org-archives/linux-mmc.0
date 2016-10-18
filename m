From: Zach Brown <zach.brown@ni.com>
Subject: [RFC 2/2] mmc: sdhci: Ignore capability register when it comes to speeds and use DT binding instead when sdhci-cap-speed-modes-broken is set.
Date: Tue, 18 Oct 2016 16:05:36 -0500
Message-ID: <1476824736-9337-3-git-send-email-zach.brown@ni.com>
References: <1476824736-9337-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:54281 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752675AbcJRVFq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 18 Oct 2016 17:05:46 -0400
In-Reply-To: <1476824736-9337-1-git-send-email-zach.brown@ni.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, zach.brown@ni.com

When the sdhci-cap-speed-modes-broken DT property is set, the driver
will ignore the bits of the capability registers that correspond to
speed modes and will read the of properties of the device to determine
which speeds are supported.

Signed-off-by: Zach Brown <zach.brown@ni.com>
---
 drivers/mmc/host/sdhci.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1e25b01..100649a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -22,6 +22,7 @@
 #include <linux/scatterlist.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
 
 #include <linux/leds.h>
 
@@ -3020,6 +3021,32 @@ void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
 }
 EXPORT_SYMBOL_GPL(__sdhci_read_caps);
 
+void sdhci_get_speed_caps_from_of(struct sdhci_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	host->caps &= ~SDHCI_CAN_DO_HISPD;
+
+	if (of_property_read_bool(mmc_dev(mmc)->of_node, "cap-sd-highspeed"))
+		host->caps |= SDHCI_CAN_DO_HISPD;
+
+	if (host->version < SDHCI_SPEC_300)
+		return;
+
+	host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
+			 SDHCI_SUPPORT_DDR50);
+
+	if (of_property_read_bool(mmc_dev(mmc)->of_node, "sd-uhs-sdr50"))
+		host->caps1 |= SDHCI_SUPPORT_SDR50;
+
+	if (of_property_read_bool(mmc_dev(mmc)->of_node, "sd-uhs-sdr104"))
+		host->caps1 |= SDHCI_SUPPORT_SDR104;
+
+	if (of_property_read_bool(mmc_dev(mmc)->of_node, "sd-uhs-ddr50"))
+		host->caps1 |= SDHCI_SUPPORT_DDR50;
+
+}
+
 int sdhci_setup_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc;
@@ -3046,6 +3073,10 @@ int sdhci_setup_host(struct sdhci_host *host)
 		return ret;
 
 	sdhci_read_caps(host);
+	if (of_property_read_bool(mmc_dev(mmc)->of_node,
+				  "sdhci-cap-speed-modes-broken"))
+		sdhci_get_speed_caps_from_of(host);
+
 
 	override_timeout_clk = host->timeout_clk;
 
-- 
2.7.4

