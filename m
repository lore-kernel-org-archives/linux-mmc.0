From: Andrei Warkentin <andreiw@motorola.com>
Subject: [patchv3 3/4] MMC: Allow setting CMD timeout for CMD6 (SWITCH).
Date: Mon, 11 Apr 2011 16:13:43 -0500
Message-ID: <1302556424-21951-3-git-send-email-andreiw@motorola.com>
References: <BANLkTikA56sD_A6VVPF15SgA-AnKOZ2ZXw@mail.gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og107.obsmtp.com ([64.18.0.184]:43239 "EHLO
	exprod5og107.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836Ab1DKUeu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2011 16:34:50 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3BKZB5i018344
	for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 16:35:11 -0400 (EDT)
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com [209.85.160.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3BKZAEA018335
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 16:35:11 -0400 (EDT)
Received: by gyb11 with SMTP id 11so4142777gyb.15
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 13:34:47 -0700 (PDT)
In-Reply-To: <BANLkTikA56sD_A6VVPF15SgA-AnKOZ2ZXw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: arnd@arndb.de, cjb@laptop.org, Andrei Warkentin <andreiw@motorola.com>

CMD6 is R1B-type command, where DAT is used as busy. Depending
on register written using CMD6, timeout value can be different
as per spec.

Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/core/mmc.c     |   14 ++++++++------
 drivers/mmc/core/mmc_ops.c |   17 ++++++++++++++++-
 drivers/mmc/core/mmc_ops.h |    1 -
 include/linux/mmc/core.h   |    1 +
 4 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index caba751..a5cf423 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -548,7 +548,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 */
 	if (card->ext_csd.enhanced_area_en) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				EXT_CSD_ERASE_GROUP_DEF, 1);
+				 EXT_CSD_ERASE_GROUP_DEF, 1, 0);
 
 		if (err && err != -EBADMSG)
 			goto free_card;
@@ -579,7 +579,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	if (card->ext_csd.bootconfig & 0x7) {
 		card->ext_csd.bootconfig &= ~0x7;
 		mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BOOT_CONFIG,
-			   card->ext_csd.bootconfig);
+			   card->ext_csd.bootconfig, 0);
 	}
 
 	/*
@@ -588,7 +588,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	if ((card->ext_csd.hs_max_dtr != 0) &&
 		(host->caps & MMC_CAP_MMC_HIGHSPEED)) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-			EXT_CSD_HS_TIMING, 1);
+				 EXT_CSD_HS_TIMING, 1, 0);
 		if (err && err != -EBADMSG)
 			goto free_card;
 
@@ -655,7 +655,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 				ddr = 0; /* no DDR for 1-bit width */
 			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 					 EXT_CSD_BUS_WIDTH,
-					 ext_csd_bits[idx][0]);
+					 ext_csd_bits[idx][0],
+					 0);
 			if (!err) {
 				mmc_set_bus_width_ddr(card->host,
 						      bus_width, MMC_SDR_MODE);
@@ -674,8 +675,9 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 
 		if (!err && ddr) {
 			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-					EXT_CSD_BUS_WIDTH,
-					ext_csd_bits[idx][1]);
+					 EXT_CSD_BUS_WIDTH,
+					 ext_csd_bits[idx][1],
+					 0);
 		}
 		if (err) {
 			printk(KERN_WARNING "%s: switch to bus width %d ddr %d "
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 60842f8..586f9b4 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -387,7 +387,19 @@ int mmc_spi_set_crc(struct mmc_host *host, int use_crc)
 	return err;
 }
 
-int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value)
+/**
+ *	mmc_switch - modify EXT_CSD register
+ *	@card: the MMC card associated with the data transfer
+ *	@set: cmd set values
+ *	@index: EXT_CSD register index
+ *	@value: value to program into EXT_CSD register
+ *	@timeout_ms: timeout (ms) for operation performed by register write,
+ *                   timeout of zero implies maximum possible timeout
+ *
+ *	Modifies the EXT_CSD register for selected card.
+ */
+int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
+	unsigned int timeout_ms)
 {
 	int err;
 	struct mmc_command cmd;
@@ -404,6 +416,7 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value)
 		  (value << 8) |
 		  set;
 	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+	cmd.cmd_timeout_ms = timeout_ms;
 
 	err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
 	if (err)
@@ -434,6 +447,8 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value)
 	return 0;
 }
 
+EXPORT_SYMBOL(mmc_switch);
+
 int mmc_send_status(struct mmc_card *card, u32 *status)
 {
 	int err;
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index e6d44b8..9276946 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -20,7 +20,6 @@ int mmc_all_send_cid(struct mmc_host *host, u32 *cid);
 int mmc_set_relative_addr(struct mmc_card *card);
 int mmc_send_csd(struct mmc_card *card, u32 *csd);
 int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd);
-int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value);
 int mmc_send_status(struct mmc_card *card, u32 *status);
 int mmc_send_cid(struct mmc_host *host, u32 *cid);
 int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp);
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 811e96e..f8e4bcb 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -135,6 +135,7 @@ extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
 extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *, int);
 extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *,
 	struct mmc_command *, int);
+extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
 
 #define MMC_ERASE_ARG		0x00000000
 #define MMC_SECURE_ERASE_ARG	0x80000000
-- 
1.7.0.4

