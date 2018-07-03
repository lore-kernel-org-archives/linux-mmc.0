From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mmc: sdhci-xenon: mark expected switch fall-through
Date: Tue, 3 Jul 2018 17:56:59 -0500
Message-ID: <20180703225659.GA14443@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-mmc@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Warning level 2 was used: -Wimplicit-fallthrough=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mmc/host/sdhci-xenon-phy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
index a35804b..c335052 100644
--- a/drivers/mmc/host/sdhci-xenon-phy.c
+++ b/drivers/mmc/host/sdhci-xenon-phy.c
@@ -526,6 +526,7 @@ static bool xenon_emmc_phy_slow_mode(struct sdhci_host *host,
 			ret = true;
 			break;
 		}
+		/* else: fall through */
 	default:
 		reg &= ~XENON_TIMING_ADJUST_SLOW_MODE;
 		ret = false;
-- 
2.7.4
