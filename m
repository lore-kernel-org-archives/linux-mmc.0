From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH 4/8] mmc: sdhci: fix coding style in sdhci_set_clock
Date: Fri,  9 Nov 2012 17:09:54 +0530
Message-ID: <1352461198-21941-5-git-send-email-tushar.behera@linaro.org>
References: <1352461198-21941-1-git-send-email-tushar.behera@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352461198-21941-1-git-send-email-tushar.behera@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 drivers/mmc/host/sdhci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 73bb41f..28da461 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1138,9 +1138,9 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 			}
 		} else {
 			/* Version 3.00 divisors must be a multiple of 2. */
-			if (host->max_clk <= clock)
+			if (host->max_clk <= clock) {
 				div = 1;
-			else {
+			} else {
 				for (div = 2; div < SDHCI_MAX_DIV_SPEC_300;
 				     div += 2) {
 					if ((host->max_clk / div) <= clock)
-- 
1.7.4.1
