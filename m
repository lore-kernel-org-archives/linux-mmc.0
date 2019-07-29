From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mmc: atmel-mci: Mark expected switch fall-throughs
Date: Sun, 28 Jul 2019 19:01:23 -0500
Message-ID: <20190729000123.GA23902@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@microchip.com>, Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Kees Cook <keescook@chromium.org>
List-Id: linux-mmc@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/mmc/host/atmel-mci.c: In function 'atmci_get_cap':
drivers/mmc/host/atmel-mci.c:2415:30: warning: this statement may fall through [-Wimplicit-fallthrough=]
   host->caps.has_odd_clk_div = 1;
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
drivers/mmc/host/atmel-mci.c:2416:2: note: here
  case 0x400:
  ^~~~
drivers/mmc/host/atmel-mci.c:2422:28: warning: this statement may fall through [-Wimplicit-fallthrough=]
   host->caps.has_highspeed = 1;
   ~~~~~~~~~~~~~~~~~~~~~~~~~^~~
drivers/mmc/host/atmel-mci.c:2423:2: note: here
  case 0x200:
  ^~~~
drivers/mmc/host/atmel-mci.c:2426:40: warning: this statement may fall through [-Wimplicit-fallthrough=]
   host->caps.need_notbusy_for_read_ops = 1;
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
drivers/mmc/host/atmel-mci.c:2427:2: note: here
  case 0x100:
  ^~~~

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mmc/host/atmel-mci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 9ee0bc0ce6d0..c26fbe5f2222 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2413,6 +2413,7 @@ static void atmci_get_cap(struct atmel_mci *host)
 	case 0x600:
 	case 0x500:
 		host->caps.has_odd_clk_div = 1;
+		/* Fall through */
 	case 0x400:
 	case 0x300:
 		host->caps.has_dma_conf_reg = 1;
@@ -2420,13 +2421,16 @@ static void atmci_get_cap(struct atmel_mci *host)
 		host->caps.has_cfg_reg = 1;
 		host->caps.has_cstor_reg = 1;
 		host->caps.has_highspeed = 1;
+		/* Fall through */
 	case 0x200:
 		host->caps.has_rwproof = 1;
 		host->caps.need_blksz_mul_4 = 0;
 		host->caps.need_notbusy_for_read_ops = 1;
+		/* Fall through */
 	case 0x100:
 		host->caps.has_bad_data_ordering = 0;
 		host->caps.need_reset_after_xfer = 0;
+		/* Fall through */
 	case 0x0:
 		break;
 	default:
-- 
2.22.0
