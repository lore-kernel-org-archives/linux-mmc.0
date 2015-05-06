From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH] mmc: atmel-mci: fix bad variable type for clkdiv
Date: Wed, 6 May 2015 15:16:46 +0200
Message-ID: <1430918206-19911-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nicolas.ferre@atmel.com, ulf.hansson@linaro.org, Ludovic Desroches <ludovic.desroches@atmel.com>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

clkdiv is declared as an u32 but it can be set to a negative value
causing a huge divisor value. Change its type to int to avoid this case.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: <stable@vger.kernel.org> # 3.4 and later
---
 drivers/mmc/host/atmel-mci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 03d7c75..9a39e0b 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1304,7 +1304,7 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	if (ios->clock) {
 		unsigned int clock_min = ~0U;
-		u32 clkdiv;
+		int clkdiv;
 
 		spin_lock_bh(&host->lock);
 		if (!host->mode_reg) {
@@ -1328,7 +1328,12 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		/* Calculate clock divider */
 		if (host->caps.has_odd_clk_div) {
 			clkdiv = DIV_ROUND_UP(host->bus_hz, clock_min) - 2;
-			if (clkdiv > 511) {
+			if (clkdiv < 0) {
+				dev_warn(&mmc->class_dev,
+					 "clock %u too fast; using %lu\n",
+					 clock_min, host->bus_hz / 2);
+				clkdiv = 0;
+			} else if (clkdiv > 511) {
 				dev_warn(&mmc->class_dev,
 				         "clock %u too slow; using %lu\n",
 				         clock_min, host->bus_hz / (511 + 2));
-- 
2.2.0
