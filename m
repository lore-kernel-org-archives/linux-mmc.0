From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: [PATCH/RFC] mmc: sh_mmcif: Move dev_err() of mmcif_timeout_work()
Date: Sun, 15 Feb 2015 23:46:47 +0900
Message-ID: <1424011607-3682-2-git-send-email-ykaneko0929@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Kouichi Tomita <kouichi.tomita.yn@renesas.com>

If interruption of command already occurred, mrq pointer in dev_err()
would refer to NULL, because the host-state is changed to STATE_IDLE
and mrq pointer is changed to NULL by interrupt handler.
Therefore dev_err is moved after checking STATE_IDLE.

Signed-off-by: Kouichi Tomita <kouichi.tomita.yn@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on next branch of Chris Ball's mmc tree.

 drivers/mmc/host/sh_mmcif.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 7d9d6a3..e075804 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1312,15 +1312,15 @@ static void mmcif_timeout_work(struct work_struct *work)
 		/* Don't run after mmc_remove_host() */
 		return;
 
-	dev_err(&host->pd->dev, "Timeout waiting for %u on CMD%u\n",
-		host->wait_for, mrq->cmd->opcode);
-
 	spin_lock_irqsave(&host->lock, flags);
 	if (host->state == STATE_IDLE) {
 		spin_unlock_irqrestore(&host->lock, flags);
 		return;
 	}
 
+	dev_err(&host->pd->dev, "Timeout waiting for %u on CMD%u\n",
+		host->wait_for, mrq->cmd->opcode);
+
 	host->state = STATE_TIMEOUT;
 	spin_unlock_irqrestore(&host->lock, flags);
 
-- 
1.9.1

