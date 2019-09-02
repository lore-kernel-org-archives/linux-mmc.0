From: Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH v2 2/4] mmc: sdhci-of-aspeed: Drop redundant assignment to host->clock
Date: Mon,  2 Sep 2019 13:28:40 +0930
Message-ID: <20190902035842.2747-3-andrew@aj.id.au>
References: <20190902035842.2747-1-andrew@aj.id.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190902035842.2747-1-andrew@aj.id.au>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrew Jeffery <andrew@aj.id.au>, adrian.hunter@intel.com, ulf.hansson@linaro.org, joel@jms.id.au, openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

host->clock is already managed by sdhci_set_ios().

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 96ca494752c5..213b3dbd49ef 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -61,7 +61,7 @@ static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 
 	if (clock == 0)
-		goto out;
+		return;
 
 	for (div = 1; div < 256; div *= 2) {
 		if ((host->max_clk / div) <= clock)
@@ -72,9 +72,6 @@ static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	clk = div << SDHCI_DIVIDER_SHIFT;
 
 	sdhci_enable_clk(host, clk);
-
-out:
-	host->clock = clock;
 }
 
 static void aspeed_sdhci_set_bus_width(struct sdhci_host *host, int width)
-- 
2.20.1
