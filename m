From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [RFC PATCH 3/4] mmc: mmc: add support for CMD5 awake
Date: Mon, 20 Feb 2017 13:33:11 +0530
Message-ID: <1487577792-12510-4-git-send-email-riteshh@codeaurora.org>
References: <1487577792-12510-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487577792-12510-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com
Cc: shawn.lin@rock-chips.com, devicetree@vger.kernel.org, andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, linux-kernel@vger.kernel.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

This patch adds CMD5 awake support for emmc.
This will be used to awake emmc from suspend together
with partial_init support to reduce resume latencies.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/core/mmc.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 7fd7228..83bcc86 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1827,7 +1827,7 @@ static int mmc_can_sleep(struct mmc_card *card)
 	return (card && card->ext_csd.rev >= 3);
 }
 
-static int mmc_sleep(struct mmc_host *host)
+static int mmc_sleepawake(struct mmc_host *host, bool sleep)
 {
 	struct mmc_command cmd = {};
 	struct mmc_card *card = host->card;
@@ -1837,13 +1837,16 @@ static int mmc_sleep(struct mmc_host *host)
 	/* Re-tuning can't be done once the card is deselected */
 	mmc_retune_hold(host);
 
-	err = mmc_deselect_cards(host);
-	if (err)
-		goto out_release;
+	if (sleep) {
+		err = mmc_deselect_cards(host);
+		if (err)
+			goto out_release;
+	}
 
 	cmd.opcode = MMC_SLEEP_AWAKE;
 	cmd.arg = card->rca << 16;
-	cmd.arg |= 1 << 15;
+	if (sleep)
+		cmd.arg |= 1 << 15;
 
 	/*
 	 * If the max_busy_timeout of the host is specified, validate it against
@@ -1871,11 +1874,24 @@ static int mmc_sleep(struct mmc_host *host)
 	if (!cmd.busy_timeout || !(host->caps & MMC_CAP_WAIT_WHILE_BUSY))
 		mmc_delay(timeout_ms);
 
+	if (!sleep)
+		err = mmc_select_card(card);
+
 out_release:
 	mmc_retune_release(host);
 	return err;
 }
 
+static int mmc_sleep(struct mmc_host *host)
+{
+	return mmc_sleepawake(host, true);
+}
+
+static int mmc_awake(struct mmc_host *host)
+{
+	return mmc_sleepawake(host, false);
+}
+
 static int mmc_can_poweroff_notify(const struct mmc_card *card)
 {
 	return card &&
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
