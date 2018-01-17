From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 15/16] mmc: tmio: clear force_pio flag before starting data transfer
Date: Thu, 18 Jan 2018 01:28:15 +0900
Message-ID: <1516206496-16612-16-git-send-email-yamada.masahiro@socionext.com>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Currently, force_pio is cleared when the driver exits.  Then, it
resulted in clearing it in multiple places since MMC drivers in
general have multiple exit points.

 tmio_mmc_reset_work - bails out on timeout
 tmio_process_mrq - error out when it cannot send a command
 tmio_mmc_finish_request - successful exit

This is error-prone since we may miss to cover all bail-out points.

To simplify the code, the data structure should be initialized just
before used since we have a single entrance.  force_pio is only used
for data transfer, so tmio_mmc_start_data() will be a suitable place
to clear this flag.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - newly added

Changes in v2: None

 drivers/mmc/host/tmio_mmc_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 731552a..494f0b3 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -278,7 +278,6 @@ static void tmio_mmc_reset_work(struct work_struct *work)
 
 	host->cmd = NULL;
 	host->data = NULL;
-	host->force_pio = false;
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
@@ -759,6 +758,7 @@ static int tmio_mmc_start_data(struct tmio_mmc_host *host,
 
 	tmio_mmc_init_sg(host, data);
 	host->data = data;
+	host->force_pio = false;
 
 	/* Set transfer length / blocksize */
 	sd_ctrl_write16(host, CTL_SD_XFER_LEN, data->blksz);
@@ -850,7 +850,6 @@ static void tmio_process_mrq(struct tmio_mmc_host *host,
 	return;
 
 fail:
-	host->force_pio = false;
 	host->mrq = NULL;
 	mrq->cmd->error = ret;
 	mmc_request_done(host->mmc, mrq);
@@ -900,7 +899,6 @@ static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
 	if (host->cmd != mrq->sbc) {
 		host->cmd = NULL;
 		host->data = NULL;
-		host->force_pio = false;
 		host->mrq = NULL;
 	}
 
-- 
2.7.4
