From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [RFC PATCH 2/4] mmc: core: add mmc-sleep-awake caps
Date: Mon, 20 Feb 2017 13:33:10 +0530
Message-ID: <1487577792-12510-3-git-send-email-riteshh@codeaurora.org>
References: <1487577792-12510-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487577792-12510-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com
Cc: shawn.lin@rock-chips.com, devicetree@vger.kernel.org, andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, linux-kernel@vger.kernel.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

This patch introduce mmc-sleep-awake for platforms
which want to enable CMD5 awake & partial_init.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/core/host.c  | 2 ++
 include/linux/mmc/host.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 3f8c85d..e798814 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -320,6 +320,8 @@ int mmc_of_parse(struct mmc_host *host)
 		host->caps2 |= MMC_CAP2_NO_SD;
 	if (of_property_read_bool(np, "no-mmc"))
 		host->caps2 |= MMC_CAP2_NO_MMC;
+	if (of_property_read_bool(np, "mmc-sleep-awake"))
+		host->caps2 |= MMC_CAP2_SLEEP_AWAKE;
 
 	host->dsr_req = !of_property_read_u32(np, "dsr", &host->dsr);
 	if (host->dsr_req && (host->dsr & ~0xffff)) {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 83f1c4a..df7882b 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -303,6 +303,7 @@ struct mmc_host {
 #define MMC_CAP2_HS400_ES	(1 << 20)	/* Host supports enhanced strobe */
 #define MMC_CAP2_NO_SD		(1 << 21)	/* Do not send SD commands during initialization */
 #define MMC_CAP2_NO_MMC		(1 << 22)	/* Do not send (e)MMC commands during initialization */
+#define MMC_CAP2_SLEEP_AWAKE	(1 << 23)	/* Use Sleep/Awake (CMD5) */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
