From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mmc: sdhci-xenon: Mark expected switch fall-through
Date: Tue, 12 Feb 2019 09:25:58 -0600
Message-ID: <20190212152558.GA21933@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Kees Cook <keescook@chromium.org>
List-Id: linux-mmc@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

drivers/mmc/host/sdhci-xenon-phy.c: In function ‘xenon_emmc_phy_slow_mode’:
drivers/mmc/host/sdhci-xenon-phy.c:527:47: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if ((priv->init_card_type == MMC_TYPE_SDIO) ||
       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~
       params->slow_mode) {
       ~~~~~~~~~~~~~~~~~
drivers/mmc/host/sdhci-xenon-phy.c:534:2: note: here
  default:
  ^~~~~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comment is modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mmc/host/sdhci-xenon-phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
index 5b5eb53a63d2..8d07ee1b8f08 100644
--- a/drivers/mmc/host/sdhci-xenon-phy.c
+++ b/drivers/mmc/host/sdhci-xenon-phy.c
@@ -530,7 +530,7 @@ static bool xenon_emmc_phy_slow_mode(struct sdhci_host *host,
 			ret = true;
 			break;
 		}
-		/* else: fall through */
+		/* fall through */
 	default:
 		reg &= ~XENON_TIMING_ADJUST_SLOW_MODE;
 		ret = false;
-- 
2.20.1
