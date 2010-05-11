From: akpm@linux-foundation.org
Subject: [patch 07/17] mmc: atmel-mci: fix in debugfs: response value printing
Date: Tue, 11 May 2010 14:06:50 -0700
Message-ID: <201005112106.o4BL6onu023085@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56701 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751032Ab0EKVG4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 May 2010 17:06:56 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, nicolas.ferre@atmel.com, hskinnemoen@atmel.com, linux-mmc@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>

In debugfs, printing of command response reports resp[2] twice: fix it to
resp[3].

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/atmel-mci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/mmc/host/atmel-mci.c~mmc-atmel-mci-fix-in-debugfs-response-value-printing drivers/mmc/host/atmel-mci.c
--- a/drivers/mmc/host/atmel-mci.c~mmc-atmel-mci-fix-in-debugfs-response-value-printing
+++ a/drivers/mmc/host/atmel-mci.c
@@ -266,7 +266,7 @@ static int atmci_req_show(struct seq_fil
 				"CMD%u(0x%x) flg %x rsp %x %x %x %x err %d\n",
 				cmd->opcode, cmd->arg, cmd->flags,
 				cmd->resp[0], cmd->resp[1], cmd->resp[2],
-				cmd->resp[2], cmd->error);
+				cmd->resp[3], cmd->error);
 		if (data)
 			seq_printf(s, "DATA %u / %u * %u flg %x err %d\n",
 				data->bytes_xfered, data->blocks,
@@ -276,7 +276,7 @@ static int atmci_req_show(struct seq_fil
 				"CMD%u(0x%x) flg %x rsp %x %x %x %x err %d\n",
 				stop->opcode, stop->arg, stop->flags,
 				stop->resp[0], stop->resp[1], stop->resp[2],
-				stop->resp[2], stop->error);
+				stop->resp[3], stop->error);
 	}
 
 	spin_unlock_bh(&slot->host->lock);
_
