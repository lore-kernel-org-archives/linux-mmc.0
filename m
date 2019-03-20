From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mmc: usdhi6rol0: mark expected switch fall-throughs
Date: Wed, 20 Mar 2019 15:00:10 -0500
Message-ID: <20190320200010.GA14527@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Kees Cook <keescook@chromium.org>
List-Id: linux-mmc@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

In file included from drivers/mmc/host/usdhi6rol0.c:9:
drivers/mmc/host/usdhi6rol0.c: In function ‘usdhi6_timeout_work’:
./include/linux/device.h:1483:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
  _dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/mmc/host/usdhi6rol0.c:1689:3: note: in expansion of macro ‘dev_err’
   dev_err(mmc_dev(host->mmc), "Invalid state %u\n", host->wait);
   ^~~~~~~
drivers/mmc/host/usdhi6rol0.c:1691:2: note: here
  case USDHI6_WAIT_FOR_CMD:
  ^~~~
drivers/mmc/host/usdhi6rol0.c:1711:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   usdhi6_sg_unmap(host, true);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/mmc/host/usdhi6rol0.c:1716:2: note: here
  case USDHI6_WAIT_FOR_DATA_END:
  ^~~~
drivers/mmc/host/usdhi6rol0.c: In function ‘usdhi6_stop_cmd’:
drivers/mmc/host/usdhi6rol0.c:1338:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (mrq->stop->opcode == MMC_STOP_TRANSMISSION) {
      ^
drivers/mmc/host/usdhi6rol0.c:1343:2: note: here
  default:
  ^~~~~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mmc/host/usdhi6rol0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index cd8b1b9d4d8a..b9712ac96be5 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1339,7 +1339,7 @@ static int usdhi6_stop_cmd(struct usdhi6_host *host)
 			host->wait = USDHI6_WAIT_FOR_STOP;
 			return 0;
 		}
-		/* Unsupported STOP command */
+		/* fall through - Unsupported STOP command */
 	default:
 		dev_err(mmc_dev(host->mmc),
 			"unsupported stop CMD%d for CMD%d\n",
@@ -1688,6 +1688,7 @@ static void usdhi6_timeout_work(struct work_struct *work)
 	default:
 		dev_err(mmc_dev(host->mmc), "Invalid state %u\n", host->wait);
 		/* mrq can be NULL in this actually impossible case */
+		/* fall through */
 	case USDHI6_WAIT_FOR_CMD:
 		usdhi6_error_code(host);
 		if (mrq)
@@ -1713,6 +1714,7 @@ static void usdhi6_timeout_work(struct work_struct *work)
 		 * If USDHI6_WAIT_FOR_DATA_END times out, we have already unmapped
 		 * the page
 		 */
+		/* fall through */
 	case USDHI6_WAIT_FOR_DATA_END:
 		usdhi6_error_code(host);
 		data->error = -ETIMEDOUT;
-- 
2.21.0
