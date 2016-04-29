From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 2/6] mmc: core: add mmc-hs400-enhanced-strobe support
Date: Fri, 29 Apr 2016 10:46:35 +0800
Message-ID: <1461897995-28903-1-git-send-email-shawn.lin@rock-chips.com>
References: <1461897751-28810-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:37307 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762AbcD2CrY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2016 22:47:24 -0400
In-Reply-To: <1461897751-28810-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

This patch introduce mmc-hs400-enhanced-strobe for platforms
which want to enable enhanced strobe function from DT if the
mmc host controller claims to support enhanced strobe.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- switch to HS400ES from Highspeed mode directly

 drivers/mmc/core/host.c  | 2 ++
 include/linux/mmc/host.h | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index e0a3ee1..eb1530a 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -289,6 +289,8 @@ int mmc_of_parse(struct mmc_host *host)
 		host->caps2 |= MMC_CAP2_HS400_1_8V | MMC_CAP2_HS200_1_8V_SDR;
 	if (of_property_read_bool(np, "mmc-hs400-1_2v"))
 		host->caps2 |= MMC_CAP2_HS400_1_2V | MMC_CAP2_HS200_1_2V_SDR;
+	if (of_property_read_bool(np, "mmc-hs400-enhanced-strobe"))
+		host->caps2 |= MMC_CAP2_HS400_ENHANCED_STROBE;
 
 	host->dsr_req = !of_property_read_u32(np, "dsr", &host->dsr);
 	if (host->dsr_req && (host->dsr & ~0xffff)) {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 85800b4..11e89d3 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -302,6 +302,7 @@ struct mmc_host {
 #define MMC_CAP2_SDIO_IRQ_NOTHREAD (1 << 17)
 #define MMC_CAP2_NO_WRITE_PROTECT (1 << 18)	/* No physical write protect pin, assume that card is always read-write */
 #define MMC_CAP2_NO_SDIO	(1 << 19)	/* Do not send SDIO commands during initialization */
+#define MMC_CAP2_HS400_ENHANCED_STROBE (1 << 20) /* Host supports enhanced strobe */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
@@ -480,6 +481,11 @@ static inline int mmc_host_uhs(struct mmc_host *host)
 		 MMC_CAP_UHS_DDR50);
 }
 
+static inline int mmc_host_hs400_enhanced_strobe(struct mmc_host *host)
+{
+	return host->caps2 & MMC_CAP2_HS400_ENHANCED_STROBE;
+}
+
 static inline int mmc_host_packed_wr(struct mmc_host *host)
 {
 	return host->caps2 & MMC_CAP2_PACKED_WR;
-- 
2.3.7


