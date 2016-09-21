From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 4/5] mmc: sdhci: Don't try to switch to unsupported voltage
Date: Wed, 21 Sep 2016 09:43:52 +0800
Message-ID: <1474422233-29355-5-git-send-email-shawn.lin@rock-chips.com>
References: <1474422233-29355-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474422233-29355-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Ziyuan Xu <xzy.xu@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

From: Ziyuan Xu <xzy.xu@rock-chips.com>

Sdhci shouldn't switch to the unsupported voltage if claiming
that it can not support the requested voltage. Let's fix it.

Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4805566..b1f1edd 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1845,7 +1845,8 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 
 	switch (ios->signal_voltage) {
 	case MMC_SIGNAL_VOLTAGE_330:
-		if (!(host->flags & SDHCI_SIGNALING_330))
+		if (!(host->flags & SDHCI_SIGNALING_330) ||
+		    !(host->caps & SDHCI_CAN_VDD_330))
 			return -EINVAL;
 		/* Set 1.8V Signal Enable in the Host Control2 register to 0 */
 		ctrl &= ~SDHCI_CTRL_VDD_180;
@@ -1872,7 +1873,8 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 
 		return -EAGAIN;
 	case MMC_SIGNAL_VOLTAGE_180:
-		if (!(host->flags & SDHCI_SIGNALING_180))
+		if (!(host->flags & SDHCI_SIGNALING_180) ||
+		    !(host->caps & SDHCI_CAN_VDD_180))
 			return -EINVAL;
 		if (!IS_ERR(mmc->supply.vqmmc)) {
 			ret = mmc_regulator_set_vqmmc(mmc, ios);
-- 
2.3.7
