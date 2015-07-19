From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: [PATCH v2] mmc: tmio: Fix timeout value for command request
Date: Mon, 20 Jul 2015 01:39:59 +0900
Message-ID: <1437323999-7938-1-git-send-email-ykaneko0929@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ian Molton <ian.molton@codethink.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

Fix the problem which timeout occurs at the time of command request with
several cards.

The timeout value was insufficient as a verification of several cards,
so it was changed 5 seconds from 2 seconds.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on mmc-next branch of Ulf Hansson's mmc tree.

v2 [Yoshihiro Kaneko]
* As suggested by Wolfram Sang
- use a definition instead of a magic value

 drivers/mmc/host/tmio_mmc_pio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index e3dcf31..a10fde4 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -83,6 +83,8 @@ static int tmio_mmc_next_sg(struct tmio_mmc_host *host)
 	return --host->sg_len;
 }
 
+#define CMDREQ_TIMEOUT	5000
+
 #ifdef CONFIG_MMC_DEBUG
 
 #define STATUS_TO_TEXT(a, status, i) \
@@ -230,7 +232,7 @@ static void tmio_mmc_reset_work(struct work_struct *work)
 	 */
 	if (IS_ERR_OR_NULL(mrq)
 	    || time_is_after_jiffies(host->last_req_ts +
-		msecs_to_jiffies(2000))) {
+		msecs_to_jiffies(CMDREQ_TIMEOUT))) {
 		spin_unlock_irqrestore(&host->lock, flags);
 		return;
 	}
@@ -818,7 +820,7 @@ static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	ret = tmio_mmc_start_command(host, mrq->cmd);
 	if (!ret) {
 		schedule_delayed_work(&host->delayed_reset_work,
-				      msecs_to_jiffies(2000));
+				      msecs_to_jiffies(CMDREQ_TIMEOUT));
 		return;
 	}
 
-- 
1.9.1

