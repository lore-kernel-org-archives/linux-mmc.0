From: Baolin Wang <baolin.wang@linaro.org>
Subject: [RFC] mmc: Change the max discard sectors and erase response if mmc host supports busy signalling
Date: Wed, 20 Apr 2016 15:11:41 +0800
Message-ID: <52b204074e197e9bb58b5c56d5e2ebb71942b4b7.1461135976.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, rmk+kernel@arm.linux.org.uk, shawn.lin@rock-chips.com, dianders@chromium.org, heiko@sntech.de, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org, linus.walleij@linaro.org, baolin.wang@linaro.org
List-Id: linux-mmc@vger.kernel.org

When mmc host HW supports busy signalling (using R1B as response), We
shouldn't use 'host->max_busy_timeout' as the limitation when deciding
the max discard sectors that we tell the generic BLOCK layer about.
Instead, we should pick one preferred erase size as the max discard sectors.

If the host controller supports busy signalling and the timeout for
the erase operation exceeds the max_busy_timeout, we should use R1B
response. Or we need to prevent the host from doing hw busy
detection, which is done by converting to a R1 response instead.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/core/core.c |   50 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 3f1362a..8164c01 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2008,7 +2008,7 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 			unsigned int to, unsigned int arg)
 {
 	struct mmc_command cmd = {0};
-	unsigned int qty = 0;
+	unsigned int qty = 0, busy_timeout = 0;
 	unsigned long timeout;
 	int err;
 
@@ -2076,8 +2076,21 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 	memset(&cmd, 0, sizeof(struct mmc_command));
 	cmd.opcode = MMC_ERASE;
 	cmd.arg = arg;
-	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
-	cmd.busy_timeout = mmc_erase_timeout(card, arg, qty);
+	busy_timeout = mmc_erase_timeout(card, arg, qty);
+	/*
+	 * If the host controller supports busy signalling and the timeout for
+	 * the erase operation exceeds the max_busy_timeout, we should use R1B
+	 * response. Or we need to prevent the host from doing hw busy
+	 * detection, which is done by converting to a R1 response instead.
+	 */
+	if (card->host->caps & MMC_CAP_WAIT_WHILE_BUSY &&
+	    busy_timeout > card->host->max_busy_timeout) {
+		cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+		cmd.busy_timeout = busy_timeout;
+	} else {
+		cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+	}
+
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
 	if (err) {
 		pr_err("mmc_erase: erase error %d, status %#x\n",
@@ -2269,23 +2282,42 @@ static unsigned int mmc_do_calc_max_discard(struct mmc_card *card,
 					    unsigned int arg)
 {
 	struct mmc_host *host = card->host;
-	unsigned int max_discard, x, y, qty = 0, max_qty, timeout;
+	unsigned int max_discard, x, y, qty = 0, max_qty, min_qty, timeout;
 	unsigned int last_timeout = 0;
 
-	if (card->erase_shift)
+	if (card->erase_shift) {
 		max_qty = UINT_MAX >> card->erase_shift;
-	else if (mmc_card_sd(card))
+		min_qty = card->pref_erase >> card->erase_shift;
+	} else if (mmc_card_sd(card)) {
 		max_qty = UINT_MAX;
-	else
+		min_qty = card->pref_erase;
+	} else {
 		max_qty = UINT_MAX / card->erase_size;
+		min_qty = card->pref_erase / card->erase_size;
+	}
 
 	/* Find the largest qty with an OK timeout */
 	do {
 		y = 0;
 		for (x = 1; x && x <= max_qty && max_qty - x >= qty; x <<= 1) {
 			timeout = mmc_erase_timeout(card, arg, qty + x);
-			if (timeout > host->max_busy_timeout)
-				break;
+			/*
+			 * If the host can support busy signalling, then it is
+			 * no need to use 'host->max_busy_timeout' as the
+			 * limitation when deciding the max discards sectors.
+			 * We should set a balance value to improve the erase
+			 * speed, and it can not get too long timeout at the
+			 * same time.
+			 */
+			if (host->caps & MMC_CAP_WAIT_WHILE_BUSY) {
+				if (qty + x > min_qty &&
+				    timeout > host->max_busy_timeout)
+					break;
+			} else {
+				if (timeout > host->max_busy_timeout)
+					break;
+			}
+
 			if (timeout < last_timeout)
 				break;
 			last_timeout = timeout;
-- 
1.7.9.5
