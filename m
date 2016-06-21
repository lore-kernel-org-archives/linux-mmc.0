From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/5] mmc: sh_mmcif: Use response type to know when to enable busy detection
Date: Tue, 21 Jun 2016 15:12:48 +0200
Message-ID: <1466514770-9462-4-git-send-email-ulf.hansson@linaro.org>
References: <1466514770-9462-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:32931 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbcFUNhh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2016 09:37:37 -0400
Received: by mail-lf0-f41.google.com with SMTP id f6so24264704lfg.0
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jun 2016 06:37:29 -0700 (PDT)
In-Reply-To: <1466514770-9462-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Baolin Wang <baolin.wang@linaro.org>

The sh_mmcif explicity checks for certain commands to decide when to
enable HW busy detection. Instead, it should only check the response type
as it tells if busy detection is needed.

In this way, the mmc core also gets full control whether it thinks busy
detection should be done or not. In some specific scenarios, like for
ERASE and STOP commands it may decide to fall back to use a CMD13 to poll
the card status instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sh_mmcif.c | 32 +++++++-------------------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 4d6c59f..96a45d8 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -819,10 +819,12 @@ static u32 sh_mmcif_set_cmd(struct sh_mmcif_host *host,
 		tmp |= CMD_SET_RTYP_NO;
 		break;
 	case MMC_RSP_R1:
-	case MMC_RSP_R1B:
 	case MMC_RSP_R3:
 		tmp |= CMD_SET_RTYP_6B;
 		break;
+	case MMC_RSP_R1B:
+		tmp |= CMD_SET_RBSY | CMD_SET_RTYP_6B;
+		break;
 	case MMC_RSP_R2:
 		tmp |= CMD_SET_RTYP_17B;
 		break;
@@ -830,17 +832,7 @@ static u32 sh_mmcif_set_cmd(struct sh_mmcif_host *host,
 		dev_err(dev, "Unsupported response type.\n");
 		break;
 	}
-	switch (opc) {
-	/* RBSY */
-	case MMC_SLEEP_AWAKE:
-	case MMC_SWITCH:
-	case MMC_STOP_TRANSMISSION:
-	case MMC_SET_WRITE_PROT:
-	case MMC_CLR_WRITE_PROT:
-	case MMC_ERASE:
-		tmp |= CMD_SET_RBSY;
-		break;
-	}
+
 	/* WDAT / DATW */
 	if (data) {
 		tmp |= CMD_SET_WDAT;
@@ -925,23 +917,13 @@ static void sh_mmcif_start_cmd(struct sh_mmcif_host *host,
 {
 	struct mmc_command *cmd = mrq->cmd;
 	u32 opc = cmd->opcode;
-	u32 mask;
+	u32 mask = 0;
 	unsigned long flags;
 
-	switch (opc) {
-	/* response busy check */
-	case MMC_SLEEP_AWAKE:
-	case MMC_SWITCH:
-	case MMC_STOP_TRANSMISSION:
-	case MMC_SET_WRITE_PROT:
-	case MMC_CLR_WRITE_PROT:
-	case MMC_ERASE:
+	if (cmd->flags & MMC_RSP_BUSY)
 		mask = MASK_START_CMD | MASK_MRBSYE;
-		break;
-	default:
+	else
 		mask = MASK_START_CMD | MASK_MCRSPE;
-		break;
-	}
 
 	if (host->ccs_enable)
 		mask |= MASK_MCCSTO;
-- 
1.9.1

