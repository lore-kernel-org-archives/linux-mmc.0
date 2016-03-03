From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 1/4] mmc: core: add cap-enhanced-strobe support
Date: Thu,  3 Mar 2016 10:36:25 +0800
Message-ID: <1456972585-8036-1-git-send-email-shawn.lin@rock-chips.com>
References: <1456972557-7994-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:60567 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756008AbcCCCoC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Mar 2016 21:44:02 -0500
In-Reply-To: <1456972557-7994-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

This patch introduce cap-enhanced-strobe for platforms which
want to enable enhanced strobe function from DT if the mmc host
controller claims to support enhanced strobe.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 Documentation/devicetree/bindings/mmc/mmc.txt | 1 +
 drivers/mmc/core/host.c                       | 2 ++
 include/linux/mmc/host.h                      | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index ed23b9b..51ec979 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -39,6 +39,7 @@ Optional properties:
 - cap-power-off-card: powering off the card is safe
 - cap-mmc-hw-reset: eMMC hardware reset is supported
 - cap-sdio-irq: enable SDIO IRQ signalling on this interface
+- cap-enhanced-strobe: enable enhanced strobe function for emmc v5.1+
 - full-pwr-cycle: full power cycle of the card is supported
 - mmc-ddr-1_8v: eMMC high-speed DDR mode(1.8V I/O) is supported
 - mmc-ddr-1_2v: eMMC high-speed DDR mode(1.2V I/O) is supported
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 1d94607..b49d786 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -270,6 +270,8 @@ int mmc_of_parse(struct mmc_host *host)
 		host->caps |= MMC_CAP_HW_RESET;
 	if (of_property_read_bool(np, "cap-sdio-irq"))
 		host->caps |= MMC_CAP_SDIO_IRQ;
+	if (of_property_read_bool(np, "cap-enhanced-strobe"))
+		host->caps |= MMC_CAP_ENHANCED_STROBE;
 	if (of_property_read_bool(np, "full-pwr-cycle"))
 		host->caps2 |= MMC_CAP2_FULL_PWR_CYCLE;
 	if (of_property_read_bool(np, "keep-power-in-suspend"))
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 8dd4d29..2a292b3 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -264,6 +264,7 @@ struct mmc_host {
 #define MMC_CAP_DRIVER_TYPE_A	(1 << 23)	/* Host supports Driver Type A */
 #define MMC_CAP_DRIVER_TYPE_C	(1 << 24)	/* Host supports Driver Type C */
 #define MMC_CAP_DRIVER_TYPE_D	(1 << 25)	/* Host supports Driver Type D */
+#define MMC_CAP_ENHANCED_STROBE	(1 << 20)	/* Host supports enhanced strobe */
 #define MMC_CAP_CMD23		(1 << 30)	/* CMD23 supported. */
 #define MMC_CAP_HW_RESET	(1 << 31)	/* Hardware reset */
 
@@ -469,6 +470,11 @@ static inline int mmc_host_uhs(struct mmc_host *host)
 		 MMC_CAP_UHS_DDR50);
 }
 
+static inline int mmc_host_enhanced_strobe(struct mmc_host *host)
+{
+	return host->caps & MMC_CAP_ENHANCED_STROBE;
+}
+
 static inline int mmc_host_packed_wr(struct mmc_host *host)
 {
 	return host->caps2 & MMC_CAP2_PACKED_WR;
-- 
2.3.7


