From: ludovic.desroches@atmel.com
Subject: [PATCH v2 5/8] mmc: atmel-mci: change atmci_start_command to atmci_send_command
Date: Thu, 11 Aug 2011 17:25:45 +0200
Message-ID: <63e45b775c555f3e97741409653f75651c963b87.1313071126.git.ludovic.desroches@atmel.com>
References: <1311863398-31579-1-git-send-email-ludovic.desroches@atmel.com>
 <1313076348-3065-1-git-send-email-ludovic.desroches@atmel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:23247 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab1HKOQG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Aug 2011 10:16:06 -0400
In-Reply-To: <1313076348-3065-1-git-send-email-ludovic.desroches@atmel.com>
In-Reply-To: <3408076e8bc2e7b3ad3bb4d3ae3859ab665a59aa.1313071125.git.ludovic.desroches@atmel.com>
References: <3408076e8bc2e7b3ad3bb4d3ae3859ab665a59aa.1313071125.git.ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, Ludovic Desroches <ludovic.desroches@atmel.com>

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Change atmci_start_command function name to atmci_send_command which is more
appropriate to no think we are sending a start command.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index efbee87..7955697 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -565,7 +565,7 @@ static u32 atmci_prepare_command(struct mmc_host *mmc,
 	return cmdr;
 }
 
-static void atmci_start_command(struct atmel_mci *host,
+static void atmci_send_command(struct atmel_mci *host,
 		struct mmc_command *cmd, u32 cmd_flags)
 {
 	WARN_ON(host->cmd);
@@ -581,7 +581,7 @@ static void atmci_start_command(struct atmel_mci *host,
 
 static void atmci_send_stop_cmd(struct atmel_mci *host, struct mmc_data *data)
 {
-	atmci_start_command(host, data->stop, host->stop_cmdr);
+	atmci_send_command(host, data->stop, host->stop_cmdr);
 	atmci_writel(host, ATMCI_IER, ATMCI_CMDRDY);
 }
 
@@ -1003,7 +1003,7 @@ static void atmci_start_request(struct atmel_mci *host,
 	iflags |= ATMCI_CMDRDY;
 	cmd = mrq->cmd;
 	cmdflags = atmci_prepare_command(slot->mmc, cmd);
-	atmci_start_command(host, cmd, cmdflags);
+	atmci_send_command(host, cmd, cmdflags);
 
 	if (data)
 		host->submit_data(host, data);
-- 
1.7.0.4

