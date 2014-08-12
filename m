From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH RFC 3/5] mmc: mmci: relax blksz check for SDIO
Date: Tue, 12 Aug 2014 13:04:40 +0100
Message-ID: <1407845080-8353-1-git-send-email-srinivas.kandadgatla@linaro.org>
References: <1407844950-8072-1-git-send-email-srinivas.kandadgatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1407844950-8072-1-git-send-email-srinivas.kandadgatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: linux-mmc@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds condition in mmci_validate_data to skip checking
blocksize for SDIO card types. SDIO card type can issue blocksizes
which are not exactly power of 2 so this check always fails, resulting
in SDIO failures.

Relaxing this check for SDIO in mmci_validate_data solves the issue
encountered during WLAN ath6kl testing with Qualcomm APQ8064 SOC on
IFC6410 board.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mmc/host/mmci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 99fe80a..747aba0 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -240,6 +240,10 @@ static int mmci_validate_data(struct mmci_host *host,
 	if (!data)
 		return 0;
 
+	/* sdio could have sizes which are not power of 2 */
+	if (host->mmc->card && mmc_card_sdio(host->mmc->card))
+		return 0;
+
 	if (!is_power_of_2(data->blksz)) {
 		dev_err(mmc_dev(host->mmc),
 			"unsupported block size (%d bytes)\n", data->blksz);
-- 
1.9.1
