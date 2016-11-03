From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v8 2/6] mmc: tmio: enhance illegal sequence handling
Date: Thu,  3 Nov 2016 15:16:00 +0100
Message-ID: <1478182564-18762-3-git-send-email-horms+renesas@verge.net.au>
References: <1478182564-18762-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:48260 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755028AbcKCOQh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Nov 2016 10:16:37 -0400
In-Reply-To: <1478182564-18762-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ai Kyuse <ai.kyuse.uw@renesas.com>, Simon Horman <horms+renesas@verge.net.au>

From: Ai Kyuse <ai.kyuse.uw@renesas.com>

An illegal sequence command error may occur if there is a stopbit or
cmd_index error as well as a CRC error. The correct course of action
is to re-enable IRQs

An illegal sequence data error may occur if there is a CRC or stopbit
error,  or underrun. In this case set data->error correctly.

This is in preparation for enabling tuning support which relies on
differentiating between illegal sequence and other errors.

Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
[simon: broken out of a larger patch]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v4
* Added Ack from Wolfram Sang

v3
* No change

v2
* Broken out of a larger patch (but forgot to post)
---
 drivers/mmc/host/tmio_mmc_pio.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 700567603107..0ae967087ea1 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -522,7 +522,7 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
 	schedule_work(&host->done);
 }
 
-static void tmio_mmc_data_irq(struct tmio_mmc_host *host)
+static void tmio_mmc_data_irq(struct tmio_mmc_host *host, unsigned int stat)
 {
 	struct mmc_data *data;
 	spin_lock(&host->lock);
@@ -531,6 +531,9 @@ static void tmio_mmc_data_irq(struct tmio_mmc_host *host)
 	if (!data)
 		goto out;
 
+	if (stat & TMIO_STAT_CRCFAIL || stat & TMIO_STAT_STOPBIT_ERR ||
+	    stat & TMIO_STAT_TXUNDERRUN)
+		data->error = -EILSEQ;
 	if (host->chan_tx && (data->flags & MMC_DATA_WRITE) && !host->force_pio) {
 		u32 status = sd_ctrl_read16_and_16_as_32(host, CTL_STATUS);
 		bool done = false;
@@ -579,8 +582,6 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
 		goto out;
 	}
 
-	host->cmd = NULL;
-
 	/* This controller is sicker than the PXA one. Not only do we need to
 	 * drop the top 8 bits of the first response word, we also need to
 	 * modify the order of the response for short response command types.
@@ -600,14 +601,16 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
 
 	if (stat & TMIO_STAT_CMDTIMEOUT)
 		cmd->error = -ETIMEDOUT;
-	else if (stat & TMIO_STAT_CRCFAIL && cmd->flags & MMC_RSP_CRC)
+	else if ((stat & TMIO_STAT_CRCFAIL && cmd->flags & MMC_RSP_CRC) ||
+		 stat & TMIO_STAT_STOPBIT_ERR ||
+		 stat & TMIO_STAT_CMD_IDX_ERR)
 		cmd->error = -EILSEQ;
 
 	/* If there is data to handle we enable data IRQs here, and
 	 * we will ultimatley finish the request in the data_end handler.
 	 * If theres no data or we encountered an error, finish now.
 	 */
-	if (host->data && !cmd->error) {
+	if (host->data && (!cmd->error || cmd->error == -EILSEQ)) {
 		if (host->data->flags & MMC_DATA_READ) {
 			if (host->force_pio || !host->chan_rx)
 				tmio_mmc_enable_mmc_irqs(host, TMIO_MASK_READOP);
@@ -668,7 +671,7 @@ static bool __tmio_mmc_sdcard_irq(struct tmio_mmc_host *host,
 	/* Data transfer completion */
 	if (ireg & TMIO_STAT_DATAEND) {
 		tmio_mmc_ack_mmc_irqs(host, TMIO_STAT_DATAEND);
-		tmio_mmc_data_irq(host);
+		tmio_mmc_data_irq(host, status);
 		return true;
 	}
 
-- 
2.7.0.rc3.207.g0ac5344

