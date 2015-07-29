From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH v2 1/3] mmc: sdhci: switch from programmable clock mode to divided one if needed
Date: Wed, 29 Jul 2015 16:22:46 +0200
Message-ID: <1438179768-818-2-git-send-email-ludovic.desroches@atmel.com>
References: <1438179768-818-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438179768-818-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: ulf.hansson@linaro.org, nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com, pebolle@tiscali.nl, arnd@arndb.de, Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-mmc@vger.kernel.org

In programmable mode, if the clock frequency is too high, the divider
can be too small to meet the clock frequency requirement especially to
init the SD card. In this case, switch to the divided clock mode.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/sdhci.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index bc14452..32cf274 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1152,6 +1152,7 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	int real_div = div, clk_mul = 1;
 	u16 clk = 0;
 	unsigned long timeout;
+	bool switch_base_clk = false;
 
 	host->mmc->actual_clock = 0;
 
@@ -1189,15 +1190,25 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 					<= clock)
 					break;
 			}
-			/*
-			 * Set Programmable Clock Mode in the Clock
-			 * Control register.
-			 */
-			clk = SDHCI_PROG_CLOCK_MODE;
-			real_div = div;
-			clk_mul = host->clk_mul;
-			div--;
-		} else {
+			if ((host->max_clk * host->clk_mul / div) <= clock) {
+				/*
+				 * Set Programmable Clock Mode in the Clock
+				 * Control register.
+				 */
+				clk = SDHCI_PROG_CLOCK_MODE;
+				real_div = div;
+				clk_mul = host->clk_mul;
+				div--;
+			} else {
+				/*
+				 * Divisor can be too small to reach clock
+				 * speed requirement. Then use the base clock.
+				 */
+				switch_base_clk = true;
+			}
+		}
+
+		if (!host->clk_mul || switch_base_clk) {
 			/* Version 3.00 divisors must be a multiple of 2. */
 			if (host->max_clk <= clock)
 				div = 1;
-- 
2.5.0
