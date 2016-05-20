From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 2/5] mmc: core: add mmc-hs400-enhanced-strobe support
Date: Fri, 20 May 2016 16:35:50 +0800
Message-ID: <1463733350-861-1-git-send-email-shawn.lin@rock-chips.com>
References: <1463733285-770-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463733285-770-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

This patch introduce mmc-hs400-enhanced-strobe for platforms
which want to enable enhanced strobe function from DT if the
mmc host controller claims to support enhanced strobe.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v4:
- check avail_type with EXT_CSD_CARD_TYPE_HS400 instead of
  card_type
- check if host support 8-bit when selecting hs400es
- some minor fix suggested by Douglas and add his review tag

Changes in v3:
- remove helper function and shorten cap2 to MMC_CAP2_HS400_ES
- rename callback to hs400_enhanced_strobe and make it return void
- add enhanced_strobe in mmc_ios and pass it to hs400_enhanced_strobe
- disable host's enhanced strobe in mmc_set_initial_state
- remove bus checking after switching hs400es
- add new function for hs400es timing selection
- fix wrong judgement of mmc_card_hs400es

Changes in v2:
- switch to HS400ES from Highspeed mode directly

 drivers/mmc/core/host.c  | 2 ++
 include/linux/mmc/host.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index e0a3ee1..45773e4 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -289,6 +289,8 @@ int mmc_of_parse(struct mmc_host *host)
 		host->caps2 |= MMC_CAP2_HS400_1_8V | MMC_CAP2_HS200_1_8V_SDR;
 	if (of_property_read_bool(np, "mmc-hs400-1_2v"))
 		host->caps2 |= MMC_CAP2_HS400_1_2V | MMC_CAP2_HS200_1_2V_SDR;
+	if (of_property_read_bool(np, "mmc-hs400-enhanced-strobe"))
+		host->caps2 |= MMC_CAP2_HS400_ES;
 
 	host->dsr_req = !of_property_read_u32(np, "dsr", &host->dsr);
 	if (host->dsr_req && (host->dsr & ~0xffff)) {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 85800b4..2a06fb0 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -302,6 +302,7 @@ struct mmc_host {
 #define MMC_CAP2_SDIO_IRQ_NOTHREAD (1 << 17)
 #define MMC_CAP2_NO_WRITE_PROTECT (1 << 18)	/* No physical write protect pin, assume that card is always read-write */
 #define MMC_CAP2_NO_SDIO	(1 << 19)	/* Do not send SDIO commands during initialization */
+#define MMC_CAP2_HS400_ES	(1 << 20)	/* Host supports enhanced strobe */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
-- 
2.3.7
