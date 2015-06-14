From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: [PATCH/RFC] mmc: tmio: Fix timeout value for command request
Date: Mon, 15 Jun 2015 02:23:26 +0900
Message-ID: <1434302606-31040-1-git-send-email-ykaneko0929@gmail.com>
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

 drivers/mmc/host/tmio_mmc_pio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index e3dcf31..0f7c4ae 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -230,7 +230,7 @@ static void tmio_mmc_reset_work(struct work_struct *work)
 	 */
 	if (IS_ERR_OR_NULL(mrq)
 	    || time_is_after_jiffies(host->last_req_ts +
-		msecs_to_jiffies(2000))) {
+		msecs_to_jiffies(5000))) {
 		spin_unlock_irqrestore(&host->lock, flags);
 		return;
 	}
@@ -818,7 +818,7 @@ static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	ret = tmio_mmc_start_command(host, mrq->cmd);
 	if (!ret) {
 		schedule_delayed_work(&host->delayed_reset_work,
-				      msecs_to_jiffies(2000));
+				      msecs_to_jiffies(5000));
 		return;
 	}
 
-- 
1.9.1

