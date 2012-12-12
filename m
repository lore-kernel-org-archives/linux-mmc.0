From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 14/14] mmc: sh-mmcif: report all errors
Date: Wed, 12 Dec 2012 15:38:18 +0100
Message-ID: <1355323098-18061-15-git-send-email-g.liakhovetski@gmx.de>
References: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Teppei Kamijou <teppei.kamijou.yb@renesas.com>, Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
List-Id: linux-mmc@vger.kernel.org

From: Teppei Kamijou <teppei.kamijou.yb@renesas.com>

Make error reporting in the driver more verbose. This patch is based on
an earlier work by Teppei Kamijou, but we try to not add any new error
messages to the log in the normal case to avoid confusing the user, and
also add a few more dev_dbg() calls.

Signed-off-by: Teppei Kamijou <teppei.kamijou.yb@renesas.com>
Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
[g.liakhovetski@gmx.de: avoid producing new errors in normal case]
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |   31 +++++++++++++++++++++++--------
 1 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 36eee8d..7abf009 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -514,13 +514,16 @@ static int sh_mmcif_error_manage(struct sh_mmcif_host *host)
 	}
 
 	if (state2 & STS2_CRC_ERR) {
-		dev_dbg(&host->pd->dev, ": CRC error\n");
+		dev_err(&host->pd->dev, " CRC error: state %u, wait %u\n",
+			host->state, host->wait_for);
 		ret = -EIO;
 	} else if (state2 & STS2_TIMEOUT_ERR) {
-		dev_dbg(&host->pd->dev, ": Timeout\n");
+		dev_err(&host->pd->dev, " Timeout: state %u, wait %u\n",
+			host->state, host->wait_for);
 		ret = -ETIMEDOUT;
 	} else {
-		dev_dbg(&host->pd->dev, ": End/Index error\n");
+		dev_dbg(&host->pd->dev, " End/Index error: state %u, wait %u\n",
+			host->state, host->wait_for);
 		ret = -EIO;
 	}
 	return ret;
@@ -566,6 +569,7 @@ static bool sh_mmcif_read_block(struct sh_mmcif_host *host)
 
 	if (host->sd_error) {
 		data->error = sh_mmcif_error_manage(host);
+		dev_dbg(&host->pd->dev, "%s(): %d\n", __func__, data->error);
 		return false;
 	}
 
@@ -606,6 +610,7 @@ static bool sh_mmcif_mread_block(struct sh_mmcif_host *host)
 
 	if (host->sd_error) {
 		data->error = sh_mmcif_error_manage(host);
+		dev_dbg(&host->pd->dev, "%s(): %d\n", __func__, data->error);
 		return false;
 	}
 
@@ -642,6 +647,7 @@ static bool sh_mmcif_write_block(struct sh_mmcif_host *host)
 
 	if (host->sd_error) {
 		data->error = sh_mmcif_error_manage(host);
+		dev_dbg(&host->pd->dev, "%s(): %d\n", __func__, data->error);
 		return false;
 	}
 
@@ -682,6 +688,7 @@ static bool sh_mmcif_mwrite_block(struct sh_mmcif_host *host)
 
 	if (host->sd_error) {
 		data->error = sh_mmcif_error_manage(host);
+		dev_dbg(&host->pd->dev, "%s(): %d\n", __func__, data->error);
 		return false;
 	}
 
@@ -823,7 +830,7 @@ static int sh_mmcif_data_trans(struct sh_mmcif_host *host,
 		sh_mmcif_single_read(host, mrq);
 		return 0;
 	default:
-		dev_err(&host->pd->dev, "UNSUPPORTED CMD = d'%08d\n", opc);
+		dev_err(&host->pd->dev, "Unsupported CMD%d\n", opc);
 		return -EINVAL;
 	}
 }
@@ -894,6 +901,7 @@ static void sh_mmcif_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	spin_lock_irqsave(&host->lock, flags);
 	if (host->state != STATE_IDLE) {
+		dev_dbg(&host->pd->dev, "%s() rejected, state %u\n", __func__, host->state);
 		spin_unlock_irqrestore(&host->lock, flags);
 		mrq->cmd->error = -EAGAIN;
 		mmc_request_done(mmc, mrq);
@@ -957,6 +965,7 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	spin_lock_irqsave(&host->lock, flags);
 	if (host->state != STATE_IDLE) {
+		dev_dbg(&host->pd->dev, "%s() rejected, state %u\n", __func__, host->state);
 		spin_unlock_irqrestore(&host->lock, flags);
 		return;
 	}
@@ -1042,10 +1051,10 @@ static bool sh_mmcif_end_cmd(struct sh_mmcif_host *host)
 			break;
 		default:
 			cmd->error = sh_mmcif_error_manage(host);
-			dev_dbg(&host->pd->dev, "Cmd(d'%d) error %d\n",
-				cmd->opcode, cmd->error);
 			break;
 		}
+		dev_dbg(&host->pd->dev, "CMD%d error %d\n",
+			cmd->opcode, cmd->error);
 		host->sd_error = false;
 		return false;
 	}
@@ -1097,8 +1106,11 @@ static bool sh_mmcif_end_cmd(struct sh_mmcif_host *host)
 		/* Woken up by an error IRQ: abort DMA */
 		data->error = sh_mmcif_error_manage(host);
 	} else if (!time) {
+		dev_err(host->mmc->parent, "DMA timeout!\n");
 		data->error = -ETIMEDOUT;
 	} else if (time < 0) {
+		dev_err(host->mmc->parent,
+			"wait_for_completion_...() error %ld!\n", time);
 		data->error = time;
 	}
 	sh_mmcif_bitclr(host, MMCIF_CE_BUF_ACC,
@@ -1167,6 +1179,7 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
 	case MMCIF_WAIT_FOR_STOP:
 		if (host->sd_error) {
 			mrq->stop->error = sh_mmcif_error_manage(host);
+			dev_dbg(&host->pd->dev, "%s(): %d\n", __func__, mrq->stop->error);
 			break;
 		}
 		sh_mmcif_get_cmd12response(host, mrq->stop);
@@ -1174,8 +1187,10 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
 		break;
 	case MMCIF_WAIT_FOR_READ_END:
 	case MMCIF_WAIT_FOR_WRITE_END:
-		if (host->sd_error)
+		if (host->sd_error) {
 			mrq->data->error = sh_mmcif_error_manage(host);
+			dev_dbg(&host->pd->dev, "%s(): %d\n", __func__, mrq->data->error);
+		}
 		break;
 	default:
 		BUG();
@@ -1292,7 +1307,7 @@ static void mmcif_timeout_work(struct work_struct *work)
 		/* Don't run after mmc_remove_host() */
 		return;
 
-	dev_dbg(&host->pd->dev, "Timeout waiting for %u, opcode %u\n",
+	dev_err(&host->pd->dev, "Timeout waiting for %u on CMD%u\n",
 		host->wait_for, mrq->cmd->opcode);
 
 	spin_lock_irqsave(&host->lock, flags);
-- 
1.7.2.5

