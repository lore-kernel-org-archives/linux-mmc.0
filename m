From: Michal Kadlic <michal.kadlic@spinet.sk>
Subject: [PATCH v2] mmc: moxart-mmc: Fix APP_CMD flag set on non-application
 commands
Date: Tue, 7 Jun 2016 11:33:01 +0200
Message-ID: <3da4c01c-cce4-0803-700f-963479e6a110@spinet.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.spinet.sk ([212.89.230.194]:48583 "EHLO mail.spinet.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbcFGJdI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Jun 2016 05:33:08 -0400
Received: from mail.spinet.sk (localhost [127.0.0.1])
	by smtp.spinet.sk (Postfix) with ESMTP id 27A7D3336A
	for <linux-mmc@vger.kernel.org>; Tue,  7 Jun 2016 11:33:02 +0200 (CEST)
Received: from [10.1.1.4] (unknown [10.1.1.4])
	(Authenticated sender: michal.kadlic@spinet.sk)
	by mail.spinet.sk (Postfix) with ESMTPSA id 238B033369
	for <linux-mmc@vger.kernel.org>; Tue,  7 Jun 2016 11:33:02 +0200 (CEST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>

Resending with correct formatting this time, at least I hope so

Moxart MMC host controller has an APP_CMD flag, that's set when sending 
an ACMD. This was set by checking command opcode instead of CMD55->ACMDx 
sequence, which could lead to regular commands like CMD6,CMD13,CMD23 and 
CMD42 flagged as application commands.

Patch is against kernel version 4.6 -
the original code was lifted unchanged from 2007 Moxa code so it applies to older versions as well.

Signed-off-by: Michal Kadlic <michal.kadlic@spinet.sk>

---

diff -purN a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
--- a/drivers/mmc/host/moxart-mmc.c     2016-06-01 14:39:12.000000000 +0200
+++ b/drivers/mmc/host/moxart-mmc.c     2016-06-07 10:12:38.428539771 +0200
@@ -60,6 +60,7 @@
 #define CMD_LONG_RSP           BIT(7)
 #define CMD_NEED_RSP           BIT(6)
 #define CMD_IDX_MASK           0x3f
+#define CMD_MMC_APP_CMD        55

 /* REG_RESPONSE_COMMAND */
 #define RSP_CMD_APP            BIT(6)
@@ -146,6 +147,7 @@ struct moxart_host {

        bool                            have_dma;
        bool                            is_removed;
+       bool                            app_cmd_flag;
 };

  static inline void moxart_init_sg(struct moxart_host *host,
@@ -211,10 +213,11 @@ static void moxart_send_command(struct m
        writel(cmd->arg, host->base + REG_ARGUMENT);

        cmdctrl = cmd->opcode & CMD_IDX_MASK;
-       if (cmdctrl == SD_APP_SET_BUS_WIDTH    || cmdctrl == SD_APP_OP_COND   ||
-           cmdctrl == SD_APP_SEND_SCR         || cmdctrl == SD_APP_SD_STATUS ||
-           cmdctrl == SD_APP_SEND_NUM_WR_BLKS)
+
+       /* If previous command was CMD55 set APP_CMD flag, except for CMD0(Reset) */
+       if ((host->app_cmd_flag) && cmd->opcode)
                cmdctrl |= CMD_APP_CMD;
+       host->app_cmd_flag = false;

        if (cmd->flags & MMC_RSP_PRESENT)
                cmdctrl |= CMD_NEED_RSP;
@@ -244,6 +248,11 @@ static void moxart_send_command(struct m
                 } else {
                         cmd->resp[0] = readl(host->base + REG_RESPONSE0);
                 }
+
+ /* If CMD55 is sent sucessfully - next command will be interpreted as ACMD */
+               if ((!cmd->error) && (cmd->opcode==CMD_MMC_APP_CMD)) {
+                       host->app_cmd_flag = true;
+               }
        }
 }

@@ -611,6 +621,7 @@ static int moxart_probe(struct platform_
        host->fifo_width = readl(host->base + REG_FEATURE) << 2;
        host->dma_chan_tx = dma_request_slave_channel_reason(dev, "tx");
        host->dma_chan_rx = dma_request_slave_channel_reason(dev, "rx");
+       host->app_cmd_flag=false;

        spin_lock_init(&host->lock);
