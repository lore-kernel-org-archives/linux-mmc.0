From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/3] mmc: core: Allow hosts to specify non-support for MMC commands
Date: Fri,  1 Jul 2016 15:45:28 +0800
Message-ID: <1467359130-11409-2-git-send-email-shawn.lin@rock-chips.com>
References: <1467359130-11409-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467359130-11409-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

Host drivers which needs to valdiate for non-supported MMC
commands and returnn error code for such requests.

To improve and simplify the behaviour, let's invent MMC_CAP2_NO_MMC
which these host drivers can set to tell the mmc core to skip sending MMC
commands during card initialization.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/mmc/core/core.c  | 5 +++--
 include/linux/mmc/host.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 4c823df..94cbf4e 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2510,8 +2510,9 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 		if (!mmc_attach_sd(host))
 			return 0;
 
-	if (!mmc_attach_mmc(host))
-		return 0;
+	if (!(host->caps2 & MMC_CAP2_NO_MMC))
+		if (!mmc_attach_mmc(host))
+			return 0;
 
 	mmc_power_off(host);
 	return -EIO;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index c22476d..aa4bfbf 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -310,6 +310,7 @@ struct mmc_host {
 #define MMC_CAP2_NO_SDIO	(1 << 19)	/* Do not send SDIO commands during initialization */
 #define MMC_CAP2_HS400_ES	(1 << 20)	/* Host supports enhanced strobe */
 #define MMC_CAP2_NO_SD		(1 << 21)	/* Do not send SD commands during initialization */
+#define MMC_CAP2_NO_MMC		(1 << 22)	/* Do not send (e)MMC commands during initialization */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
-- 
2.3.7
