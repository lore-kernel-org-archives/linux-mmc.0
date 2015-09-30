From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH] mmc: core: fix dead loop of mmc_retune
Date: Wed, 30 Sep 2015 17:37:18 +0800
Message-ID: <1443605838-5948-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:46659 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753378AbbI3Jkb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Sep 2015 05:40:31 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Johan Rudholm <johan.rudholm@axis.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Shawn Lin <shawn.lin@rock-chips.com>, Andrew Gabbasov <andrew_gabbasov@mentor.com>, David Jander <david@protonic.nl>, Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Chaotian Jing <chaotian.jing@mediatek.com>

When get a CRC error, start the mmc_retune, it will issue CMD19/CMD21
to do tune, assume there were 10 clock phase need to try, phase 0 to
phase 6 is ok, phase 7 to phase 9 is NG, we try it from 0 to 9, so
the last CMD19/CMD21 will get CRC error, host->need_retune was set and
cause mmc_retune was called, then dead loop of mmc_retune

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/core/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0520064..a3eb20b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -134,9 +134,11 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 	int err = cmd->error;
 
 	/* Flag re-tuning needed on CRC errors */
-	if (err == -EILSEQ || (mrq->sbc && mrq->sbc->error == -EILSEQ) ||
+	if ((cmd->opcode != MMC_SEND_TUNING_BLOCK &&
+	    cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200) &&
+	    (err == -EILSEQ || (mrq->sbc && mrq->sbc->error == -EILSEQ) ||
 	    (mrq->data && mrq->data->error == -EILSEQ) ||
-	    (mrq->stop && mrq->stop->error == -EILSEQ))
+	    (mrq->stop && mrq->stop->error == -EILSEQ)))
 		mmc_retune_needed(host);
 
 	if (err && cmd->retries && mmc_host_is_spi(host)) {
-- 
1.8.1.1.dirty

