From: Andrei Warkentin <andreiw@motorola.com>
Subject: [PATCH 1/4] MMC: Rename erase_timeout to cmd_timeout.
Date: Tue,  5 Apr 2011 20:09:50 -0500
Message-ID: <1302052193-23317-2-git-send-email-andreiw@motorola.com>
References: <1302052193-23317-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og112.obsmtp.com ([64.18.0.24]:46035 "EHLO
	exprod5og112.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab1DFAaI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2011 20:30:08 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.167])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p360USpk023472
	for <linux-mmc@vger.kernel.org>; Tue, 5 Apr 2011 20:30:28 -0400 (EDT)
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com [209.85.160.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p360URqw023459
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 5 Apr 2011 20:30:28 -0400 (EDT)
Received: by gyb11 with SMTP id 11so631744gyb.15
        for <linux-mmc@vger.kernel.org>; Tue, 05 Apr 2011 17:30:05 -0700 (PDT)
In-Reply-To: <1302052193-23317-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: arnd@arndb.de, cjb@laptop.org, Andrei Warkentin <andreiw@motorola.com>

Renames erase_timeout to cmd_timeout inside struct mmc_command.
First step to making host honor timeouts for non-data-transfer
commands. Cleans up erase timeout code.

Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/core/core.c  |   39 +++++++++++++++++++++------------------
 include/linux/mmc/core.h |    2 +-
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 1f453ac..fed232d 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1187,9 +1187,8 @@ void mmc_init_erase(struct mmc_card *card)
 	}
 }
 
-static void mmc_set_mmc_erase_timeout(struct mmc_card *card,
-				      struct mmc_command *cmd,
-				      unsigned int arg, unsigned int qty)
+static unsigned int  mmc_mmc_erase_timeout(struct mmc_card *card,
+					   unsigned int arg, unsigned int qty)
 {
 	unsigned int erase_timeout;
 
@@ -1246,38 +1245,42 @@ static void mmc_set_mmc_erase_timeout(struct mmc_card *card,
 	if (mmc_host_is_spi(card->host) && erase_timeout < 1000)
 		erase_timeout = 1000;
 
-	cmd->erase_timeout = erase_timeout;
+	return erase_timeout;
 }
 
-static void mmc_set_sd_erase_timeout(struct mmc_card *card,
-				     struct mmc_command *cmd, unsigned int arg,
-				     unsigned int qty)
+static unsigned int mmc_sd_erase_timeout(struct mmc_card *card,
+					 unsigned int arg,
+					 unsigned int qty)
 {
+	unsigned int erase_timeout;
+
 	if (card->ssr.erase_timeout) {
 		/* Erase timeout specified in SD Status Register (SSR) */
-		cmd->erase_timeout = card->ssr.erase_timeout * qty +
-				     card->ssr.erase_offset;
+		erase_timeout = card->ssr.erase_timeout * qty +
+			card->ssr.erase_offset;
 	} else {
 		/*
 		 * Erase timeout not specified in SD Status Register (SSR) so
 		 * use 250ms per write block.
 		 */
-		cmd->erase_timeout = 250 * qty;
+		erase_timeout = 250 * qty;
 	}
 
 	/* Must not be less than 1 second */
-	if (cmd->erase_timeout < 1000)
-		cmd->erase_timeout = 1000;
+	if (erase_timeout < 1000)
+		erase_timeout = 1000;
+
+	return erase_timeout;
 }
 
-static void mmc_set_erase_timeout(struct mmc_card *card,
-				  struct mmc_command *cmd, unsigned int arg,
-				  unsigned int qty)
+static unsigned int mmc_erase_timeout(struct mmc_card *card,
+				      unsigned int arg,
+				      unsigned int qty)
 {
 	if (mmc_card_sd(card))
-		mmc_set_sd_erase_timeout(card, cmd, arg, qty);
+		return mmc_sd_erase_timeout(card, arg, qty);
 	else
-		mmc_set_mmc_erase_timeout(card, cmd, arg, qty);
+		return mmc_mmc_erase_timeout(card, arg, qty);
 }
 
 static int mmc_do_erase(struct mmc_card *card, unsigned int from,
@@ -1351,7 +1354,7 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 	cmd.opcode = MMC_ERASE;
 	cmd.arg = arg;
 	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
-	mmc_set_erase_timeout(card, &cmd, arg, qty);
+	cmd.cmd_timeout = mmc_erase_timeout(card, arg, qty);
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
 	if (err) {
 		printk(KERN_ERR "mmc_erase: erase error %d, status %#x\n",
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 07f27af..a7d7da7 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -92,7 +92,7 @@ struct mmc_command {
  *              actively failing requests
  */
 
-	unsigned int		erase_timeout;	/* in milliseconds */
+	unsigned int		cmd_timeout;	/* in milliseconds */
 
 	struct mmc_data		*data;		/* data segment associated with cmd */
 	struct mmc_request	*mrq;		/* associated request */
-- 
1.7.0.4

