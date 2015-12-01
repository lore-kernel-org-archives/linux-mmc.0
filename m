From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH] mmc: mediatek: change some dev_err to dev_dbg
Date: Tue, 1 Dec 2015 20:12:34 +0800
Message-ID: <1448971954-398-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:50945 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756089AbbLAMMm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Dec 2015 07:12:42 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Chaotian Jing <chaotian.jing@mediatek.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, Daniel Kurtz <djkurtz@chromium.org>

there are too many error logs shown when use CMD21/CMD19 to do tune,
and it will appear at each resume time, print out so many logs to the
uart console cost too mush time. so change it to dev_dbg.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 39568cc..34d23b8 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -972,7 +972,7 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
 		if ((events & MSDC_INT_XFER_COMPL) && (!stop || !stop->error)) {
 			data->bytes_xfered = data->blocks * data->blksz;
 		} else {
-			dev_err(host->dev, "interrupt events: %x\n", events);
+			dev_dbg(host->dev, "interrupt events: %x\n", events);
 			msdc_reset_hw(host);
 			host->error |= REQ_DAT_ERR;
 			data->bytes_xfered = 0;
@@ -982,10 +982,10 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
 			else if (events & MSDC_INT_DATCRCERR)
 				data->error = -EILSEQ;
 
-			dev_err(host->dev, "%s: cmd=%d; blocks=%d",
+			dev_dbg(host->dev, "%s: cmd=%d; blocks=%d",
 				__func__, mrq->cmd->opcode, data->blocks);
-			dev_err(host->dev, "data_error=%d xfer_size=%d\n",
-					(int)data->error, data->bytes_xfered);
+			dev_dbg(host->dev, "data_error=%d xfer_size=%d\n",
+				(int)data->error, data->bytes_xfered);
 		}
 
 		msdc_data_xfer_next(host, mrq, data);
-- 
1.8.1.1.dirty

