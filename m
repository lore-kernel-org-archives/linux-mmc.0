From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: [PATCH 1/1] mmc:Extension of MMC Block IOCTL Command support for testing of non read/write Commands
Date: Wed, 16 Nov 2011 16:38:54 +0530
Message-ID: <1321441734-24191-1-git-send-email-shashidharh@vayavyalabs.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:43881 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756022Ab1KPLJP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2011 06:09:15 -0500
Received: by wwe3 with SMTP id 3so1049176wwe.1
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2011 03:09:13 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Jaehoon Chung <jh80.chung@samsung.com>, Philip Rakity <prakity@ma>
Cc: linux-mmc@vger.kernel.org, pk <pavitra@vayavyalabs.com>, Sandeep <sandeep@vayavyalabs.com>, Rayagond <rayagond@vayavyalabs.com>, Shashidhar Hiremath <shashidharh@vayavyalabs.com>

The patch provides An infrastructure to test commands other than Read/Write commands using the IOCTL interface.The Patch can be useful incase of validating the device to verify whether device support a given command or not. The result of the sent command will be written to the  result element of the mmc_ioc_cmd structure passed through IOCTL interface.

Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
---
 drivers/mmc/card/Makefile    |    2 +-
 drivers/mmc/card/block.c     |   28 ++
 drivers/mmc/card/test_cmds.c |  743 ++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/card/test_cmds.h |   53 +++
 drivers/mmc/core/core.c      |    4 +
 drivers/mmc/core/mmc.c       |    4 +
 drivers/mmc/core/mmc_ops.c   |    1 +
 drivers/mmc/core/sd.c        |    2 +
 include/linux/mmc/ioctl.h    |    1 +
 9 files changed, 837 insertions(+), 1 deletions(-)
 create mode 100644 drivers/mmc/card/test_cmds.c
 create mode 100644 drivers/mmc/card/test_cmds.h

diff --git a/drivers/mmc/card/Makefile b/drivers/mmc/card/Makefile
index c73b406..ea52ee1 100644
--- a/drivers/mmc/card/Makefile
+++ b/drivers/mmc/card/Makefile
@@ -3,7 +3,7 @@
 #
 
 obj-$(CONFIG_MMC_BLOCK)		+= mmc_block.o
-mmc_block-objs			:= block.o queue.o
+mmc_block-objs			:= block.o queue.o test_cmds.o
 obj-$(CONFIG_MMC_TEST)		+= mmc_test.o
 
 obj-$(CONFIG_SDIO_UART)		+= sdio_uart.o
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c80bb6d..c55d564 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -58,6 +58,7 @@ MODULE_ALIAS("mmc:block");
 #define INAND_CMD38_ARG_SECERASE 0x80
 #define INAND_CMD38_ARG_SECTRIM1 0x81
 #define INAND_CMD38_ARG_SECTRIM2 0x88
+#define NON_DATA_CMD 2
 
 static DEFINE_MUTEX(block_mutex);
 
@@ -77,6 +78,11 @@ static int max_devices;
 static DECLARE_BITMAP(dev_use, 256);
 static DECLARE_BITMAP(name_use, 256);
 
+/* prototype of function called for testing
+ * non-read-write commands
+ */
+void test_command(struct mmc_card *card, struct mmc_ioc_cmd *cmd);
+
 /*
  * There is one mmc_blk_data per slot.
  */
@@ -345,6 +351,28 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 
 	mmc_claim_host(card->host);
 
+	/* Calling API for testing the non-read/write commands */
+	if (idata->ic.write_flag == NON_DATA_CMD) {
+		test_command(card, &(idata->ic));
+		err = 0;
+		if (copy_to_user(&(ic_ptr->response), cmd.resp
+				 , sizeof(cmd.resp))) {
+			err = -EFAULT;
+			goto cmd_rel_host;
+		}
+		/* The result of the state of the tested command is returned
+		 * to user space RESULT OK - 0, RESULT_FAIL - 1
+		 * RESUL_UNSUP_CMD - 2, RESULT_UNSUP_CARD - 3
+		 * Other Failures - any other integer.
+		 */
+		if (copy_to_user(&(ic_ptr->result), &(idata->ic.result)
+				 , sizeof(idata->ic.result))) {
+			err = -EFAULT;
+			goto cmd_rel_host;
+		}
+		goto cmd_rel_host;
+	}
+
 	if (idata->ic.is_acmd) {
 		err = mmc_app_cmd(card->host, card);
 		if (err)
diff --git a/drivers/mmc/card/test_cmds.c b/drivers/mmc/card/test_cmds.c
new file mode 100644
index 0000000..dd9671f
--- /dev/null
+++ b/drivers/mmc/card/test_cmds.c
@@ -0,0 +1,743 @@
+/*
+ *  linux/drivers/mmc/card/test_cmds.c
+ *
+ *  This File implements functions for testing non-data commands 
+ *  through IOCTL interface.
+ *
+ *  Copyright (C) 2011 Vayavya Labs Pvt. Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/mmc/core.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/sd.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/mmc/ioctl.h>
+
+#include "../core/sd_ops.h"
+#include "../core/mmc_ops.h"
+#include "../core/sdio_ops.h"
+#include "test_cmds.h"
+
+static int mmc_test_CMD0(struct mmc_card *card)
+{
+	int ret;
+	struct mmc_host *host = card->host;
+
+	mmc_power_off(host);
+	mmc_power_up(host);
+
+	ret = mmc_go_idle(card->host);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int mmc_test_CMD1(struct mmc_card *card)
+{
+	int err = 0;
+	struct mmc_host *host = card->host;
+	u32 ocr;
+
+	if (card->type == MMC_TYPE_MMC) {
+		mmc_test_CMD0(card);
+
+		err = mmc_send_op_cond(card->host, 0, &ocr);
+		if (err)
+			return err;
+
+		/*
+		 * Sanity check the voltages that the card claims to
+		 * support.
+		 */
+		if (ocr & 0x7F) {
+			printk(KERN_WARNING
+			       "%s: card claims to support voltages "
+			       "below the defined range. These will be ignored.\n",
+			       mmc_hostname(host));
+			ocr &= ~0x7F;
+		}
+
+		host->ocr = mmc_select_voltage(host, ocr);
+
+		/*
+		 * Can we support the voltage of the card?
+		 */
+		if (!host->ocr) {
+			err = -EINVAL;
+			printk(KERN_ALERT
+			       "Card voltages cannot be supported\n");
+			return err;
+		}
+
+		mmc_go_idle(host);
+
+		/* The extra bit indicates that we support high capacity */
+		/*Sending ocr = 0 will just probe the card */
+		err = mmc_send_op_cond(card->host, ocr | (1 << 30), NULL);
+		if (err)
+			return err;
+	} else
+		err = RESULT_UNSUP_CARD;
+
+	return err;
+}
+
+static int mmc_test_CMD2(struct mmc_card *card)
+{
+	int err = 0;
+	u32 cid[4], rocr = 0;
+	struct mmc_host *host = card->host;
+	u32 ocr = host->ocr;
+
+	if (card->type == MMC_TYPE_MMC) {
+		err = mmc_test_CMD1(card);
+		if (err)
+			return err;
+
+		/*
+		 * For SPI, enable CRC as appropriate.
+		 */
+		if (mmc_host_is_spi(host)) {
+			err = mmc_spi_set_crc(host, 0);
+			if (err)
+				goto error;
+		}
+
+		/*
+		 * Fetch CID from card.
+		 */
+		if (mmc_host_is_spi(host)) {
+			printk(KERN_ALERT
+			       "Failed to execute since the host is SPI. Send cmd 10 to get CID\n");
+			return err = 1;
+		} else
+			err = mmc_all_send_cid(host, cid);
+		if (err)
+			goto error;
+
+		/*
+		 * Oldcard is not considered, infact the card we operate has its
+		 * card struct which was not freed. Also the CID will be stored
+		 * in the card struct filed CID.
+		 */
+
+		card->type = MMC_TYPE_MMC;
+		card->rca = 1;
+		memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
+	} else if (card->type == MMC_TYPE_SD) {
+
+		mmc_test_CMD0(card);
+		mmc_send_if_cond(host, host->ocr_avail);
+
+		err = mmc_send_app_op_cond(host, 0, &ocr);
+		if (err)
+			return err;
+
+		/*
+		 * Sanity check the voltages that the card claims to
+		 * support.
+		 */
+		if (ocr & 0x7F) {
+			printk(KERN_WARNING
+			       "%s: card claims to support voltages "
+			       "below the defined range. These will be ignored.\n",
+			       mmc_hostname(host));
+			ocr &= ~0x7F;
+		}
+
+		if (ocr & MMC_VDD_165_195) {
+			printk(KERN_WARNING "%s: SD card claims to support the "
+			       "incompletely defined 'low voltage range'. This "
+			       "will be ignored.\n", mmc_hostname(host));
+			ocr &= ~MMC_VDD_165_195;
+		}
+
+		host->ocr = mmc_select_voltage(host, ocr);
+
+		/*
+		 * Can we support the voltage(s) of the card(s)?
+		 */
+		if (!host->ocr) {
+			printk(KERN_ALERT
+			       "Card voltages cannot be supported\n");
+			err = -EINVAL;
+			return err;
+		}
+
+		err = mmc_sd_get_cid(host, ocr, cid, &rocr);
+		if (err)
+			return err;
+
+		card->type = MMC_TYPE_SD;
+		memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
+	} else {
+		err = RESULT_UNSUP_CARD;
+		return err;
+	}
+
+error:
+	return err;
+}
+
+static int mmc_test_CMD3(struct mmc_card *card)
+{
+	int err;
+	struct mmc_host *host = card->host;
+
+	err = mmc_test_CMD2(card);
+	if (err)
+		return err;
+
+	if (card->type == MMC_TYPE_MMC) {
+		/* For native busses:  set card RCA and quit open drain mode */
+		if (!mmc_host_is_spi(host)) {
+			err = mmc_set_relative_addr(card);
+			if (err)
+				return err;
+
+			mmc_set_bus_mode(host, MMC_BUSMODE_PUSHPULL);
+		}
+	} else if (card->type == MMC_TYPE_SD) {
+
+
+		/* For native busses:  get card RCA and quit open drain mode */
+		if (!mmc_host_is_spi(host)) {
+			err = mmc_send_relative_addr(host, &card->rca);
+			if (err)
+				return err;
+
+			mmc_set_bus_mode(host, MMC_BUSMODE_PUSHPULL);
+		}
+	} else {
+		/* SDIO cards not supported */
+		err = RESULT_UNSUP_CARD;
+		return err;
+	}
+
+	return 0;
+}
+
+static int unsupp_cmd(struct mmc_card *card)
+{
+	printk(KERN_ERR "COMMAND NOT SUPPORTED");
+	return RESULT_UNSUP_CMD;
+}
+
+/* TODO Deselection of the card is yet to be supported */
+static int mmc_test_CMD7(struct mmc_card *card)
+{
+	int err = 0;
+	struct mmc_host *host = card->host;
+
+	if (card->type == MMC_TYPE_MMC || card->type == MMC_TYPE_SD) {
+		err = mmc_test_CMD3(card);
+		if (err)
+			return err;
+	} else {
+		err = RESULT_UNSUP_CARD;
+		return err;
+	}
+
+	/* Select card, as all following commands rely on that */
+	if (!mmc_host_is_spi(host)) {
+		err = mmc_select_card(card);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int mmc_test_CMD8(struct mmc_card *card)
+{
+	int err;
+	struct mmc_host *host = card->host;
+	u32 ocr = host->ocr;
+
+	if (card->type == MMC_TYPE_MMC) {
+
+		err = mmc_test_CMD7(card);
+		if (err)
+			return err;
+
+		/*
+		 * Fetch and process extended CSD.
+		 */
+		err = mmc_read_ext_csd(card);
+		if (err)
+			return err;
+		/* Erase size depends on CSD and Extended CSD */
+		mmc_set_erase_size(card);
+	} else if (card->type == MMC_TYPE_SD) {
+
+		mmc_test_CMD0(card);
+		mmc_send_if_cond(host, host->ocr_avail);
+
+		err = mmc_send_app_op_cond(host, 0, &ocr);
+		if (err)
+			return err;
+
+		/*
+		 * Sanity check the voltages that the card claims to
+		 * support.
+		 */
+		if (ocr & 0x7F) {
+			printk(KERN_WARNING
+			       "%s: card claims to support voltages "
+			       "below the defined range. These will be ignored.\n",
+			       mmc_hostname(host));
+			ocr &= ~0x7F;
+		}
+
+		if (ocr & MMC_VDD_165_195) {
+			printk(KERN_WARNING "%s: SD card claims to support the "
+			       "incompletely defined 'low voltage range'. This "
+			       "will be ignored.\n", mmc_hostname(host));
+			ocr &= ~MMC_VDD_165_195;
+		}
+
+		host->ocr = mmc_select_voltage(host, ocr);
+
+		/*
+		 * Can we support the voltage(s) of the card(s)?
+		 */
+		if (!host->ocr) {
+			printk(KERN_ALERT
+			       "Card voltages cannot be supported\n");
+			err = -EINVAL;
+			return err;
+		}
+
+		/*
+		 * Since we're changing the OCR value, we seem to
+		 * need to tell some cards to go back to the idle
+		 * state.  We wait 1ms to give cards time to
+		 * respond.
+		 */
+		mmc_go_idle(host);
+
+		/*
+		 * If SD_SEND_IF_COND indicates an SD 2.0
+		 * compliant card and we should set bit 30
+		 * of the ocr to indicate that we can handle
+		 * block-addressed SDHC cards.
+		 */
+		err = mmc_send_if_cond(host, host->ocr);
+		if (!err)
+			ocr |= 1 << 30;
+		else
+			return err;
+	} else {
+		err = RESULT_UNSUP_CARD;
+		return err;
+	}
+
+	return 0;
+}
+
+static int mmc_test_CMD9(struct mmc_card *card)
+{
+	int err;
+	struct mmc_host *host = card->host;
+
+	err = mmc_test_CMD3(card);
+	if (err)
+		return err;
+
+	if (card->type == MMC_TYPE_MMC) {
+		/*
+		 * Fetch CSD from card.
+		 */
+		err = mmc_send_csd(card, card->raw_csd);
+		if (err)
+			return err;
+
+		err = mmc_decode_csd(card);
+		if (err)
+			return err;
+
+		err = mmc_decode_cid(card);
+		if (err)
+			return err;
+	} else if (card->type == MMC_TYPE_SD) {
+		err = mmc_sd_get_csd(host, card);
+		if (err)
+			return err;
+
+		mmc_decode_cid(card);
+	} else {
+		return err;
+	}
+
+	return 0;
+}
+
+static int mmc_test_CMD10(struct mmc_card *card)
+{
+	int err = 0;
+	u32 cid[4];
+	struct mmc_host *host = card->host;
+	u32 ocr = host->ocr;
+
+	/* The code has been copied here from the mmc_init_card function. This
+	 * just to stop after CMD2 is successfully sent to the card */
+	if (card->type == MMC_TYPE_MMC) {
+		err = mmc_test_CMD1(card);
+		if (err)
+			return err;
+
+		/*
+		 * For SPI, enable CRC as appropriate.
+		 */
+		if (mmc_host_is_spi(host)) {
+			err = mmc_spi_set_crc(host, 0);
+			if (err)
+				return err;
+		}
+
+		/*
+		 * Fetch CID from card.
+		 */
+		if (mmc_host_is_spi(host))
+			err = mmc_send_cid(host, cid);
+		else {
+			printk(KERN_ALERT
+			       "Host is non-SPI, use CMD2 to get the CID\n");
+			err = 1;
+		}
+		if (err)
+			return err;
+	} else if (card->type == MMC_TYPE_SD) {
+
+		mmc_test_CMD0(card);
+		mmc_send_if_cond(host, host->ocr_avail);
+
+		err = mmc_send_app_op_cond(host, 0, &ocr);
+		if (err)
+			return err;
+
+		/*
+		 * Sanity check the voltages that the card claims to
+		 * support.
+		 */
+		if (ocr & 0x7F) {
+			printk(KERN_WARNING
+			       "%s: card claims to support voltages "
+			       "below the defined range. These will be ignored.\n",
+			       mmc_hostname(host));
+			ocr &= ~0x7F;
+		}
+
+		if (ocr & MMC_VDD_165_195) {
+			printk(KERN_WARNING "%s: SD card claims to support the "
+			       "incompletely defined 'low voltage range'. This "
+			       "will be ignored.\n", mmc_hostname(host));
+			ocr &= ~MMC_VDD_165_195;
+		}
+
+		host->ocr = mmc_select_voltage(host, ocr);
+
+		/*
+		 * Can we support the voltage(s) of the card(s)?
+		 */
+		if (!host->ocr) {
+			printk(KERN_ALERT
+			       "Card voltages cannot be supported\n");
+			err = -EINVAL;
+			return err;
+		}
+
+		/*
+		 * Since we're changing the OCR value, we seem to
+		 * need to tell some cards to go back to the idle
+		 * state.  We wait 1ms to give cards time to
+		 * respond.
+		 */
+		mmc_go_idle(host);
+
+		/*
+		 * If SD_SEND_IF_COND indicates an SD 2.0
+		 * compliant card and we should set bit 30
+		 * of the ocr to indicate that we can handle
+		 * block-addressed SDHC cards.
+		 */
+		err = mmc_send_if_cond(host, host->ocr);
+		if (!err)
+			ocr |= 1 << 30;
+
+		err = mmc_send_app_op_cond(host, ocr, NULL);
+		if (err)
+			return err;
+
+		if (mmc_host_is_spi(host)) {
+			err = mmc_send_cid(host, cid);
+		} else {
+			printk(KERN_ALERT
+			       "Host is non-SPI, hence use CMD2 to get CID\n");
+			err = 1;
+		}
+	} else
+		err = RESULT_UNSUP_CARD;
+
+	return err;
+}
+
+static int mmc_test_CMD12(struct mmc_card *card)
+{
+	int err;
+	struct mmc_command cmd;
+	struct mmc_host *host = card->host;
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+
+	cmd.opcode = MMC_STOP_TRANSMISSION;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int mmc_test_CMD13(struct mmc_card *card)
+{
+	int err = 0;
+	struct mmc_command cmd;
+	u32 *ssr;
+
+	if (card->type == MMC_TYPE_MMC) {
+		/* This code just sends the get status command only
+		 * Get the status of the card without disturbing anything */
+
+		memset(&cmd, 0, sizeof(struct mmc_command));
+		cmd.opcode = MMC_SEND_STATUS;
+		if (!mmc_host_is_spi(card->host))
+			cmd.arg = card->rca << 16;
+		cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
+		err = mmc_wait_for_cmd(card->host, &cmd, 0);
+		if (err) {
+			printk(KERN_ERR "error %d sending status comand\n",
+			       err);
+
+			return err;
+		}
+	} else if (card->type == MMC_TYPE_SD) {
+		if (!(card->csd.cmdclass & CCC_APP_SPEC)) {
+			printk(KERN_WARNING
+			       "%s: card lacks mandatory SD Status "
+			       "function.\n", mmc_hostname(card->host));
+			return 0;
+		}
+
+		ssr = kmalloc(64, GFP_KERNEL);
+		if (!ssr)
+			return -ENOMEM;
+
+		err = mmc_app_sd_status(card, ssr);
+		if (err)
+			printk(KERN_ALERT "%s: problem reading SD Status "
+			       "register.\n", mmc_hostname(card->host));
+		kfree(ssr);
+		return err;
+	} else
+		err = RESULT_UNSUP_CARD;
+
+
+	return 0;
+}
+
+static int mmc_go_inactive_state(struct mmc_card *card)
+{
+	int err;
+	struct mmc_command cmd;
+
+	BUG_ON(!card->host);
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+
+	cmd.opcode = MMC_GO_INACTIVE_STATE;
+	cmd.arg = card->host->card->rca << 16;
+	cmd.flags = MMC_RSP_NONE | MMC_CMD_AC;
+
+	err = mmc_wait_for_cmd(card->host, &cmd, 4);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int mmc_test_CMD15(struct mmc_card *card)
+{
+	int err;
+
+	if (card->type == MMC_TYPE_SDIO) {
+		err = RESULT_UNSUP_CARD;
+		return err;
+	}
+
+	err = mmc_go_inactive_state(card);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+/*
+ * Configure correct block size in card
+ */
+static int mmc_test_set_blksize(struct mmc_card *card, unsigned size)
+{
+	return mmc_set_blocklen(card, size);
+}
+
+/* Coded as a stand alone API
+ * To be used only if the card is in data transfer mode
+ */
+static int mmc_test_CMD16(struct mmc_card *card)
+{
+	int err;
+
+	/* Calling the top level mmc/sd card init functions */
+
+	if (card->type == MMC_TYPE_SDIO) {
+		err = RESULT_UNSUP_CARD;
+		return err;
+	}
+
+	/* Set to 512 for testing */
+	err = mmc_test_set_blksize(card, 512);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+struct mmc_test_case {
+	const char *name;
+	int (*prepare) (struct mmc_card *);
+	int (*run) (struct mmc_card *);
+	int (*cleanup) (struct mmc_card *);
+};
+
+const struct mmc_test_case mmc_test_cases[] = {
+	{
+	 .name = "Test CMD0",
+	 .run = mmc_test_CMD0,
+	 },
+	{
+	 .name = "Test CMD1",
+	 .run = mmc_test_CMD1,
+	 },
+	{
+	 .name = "Test CMD2",
+	 .run = mmc_test_CMD2,
+	 },
+	{
+	 .name = "Test CMD3",
+	 .run = mmc_test_CMD3,
+	 },
+	{
+	 .name = "Test CMD4",
+	 .run = unsupp_cmd,
+	 },
+	{
+	 .name = "Test CMD5",
+	 .run = unsupp_cmd,
+	 },
+	{
+	 .name = "Test CMD6",
+	 .run = unsupp_cmd,
+	 },
+
+	{
+	 .name = "Test CMD7",
+	 .run = mmc_test_CMD7,
+	 },
+	{
+	 .name = "Test CMD8",
+	 .run = mmc_test_CMD8,
+	 },
+	{
+	 .name = "Test CMD9",
+	 .run = mmc_test_CMD9,
+	 },
+	{
+	 .name = "Test CMD10",
+	 .run = mmc_test_CMD10,
+	 },
+	{
+	 .name = "Test CMD11",
+	 .run = unsupp_cmd,
+	 },
+	{
+	 .name = "Test CMD12",
+	 .run = mmc_test_CMD12,
+	 },
+	{
+	 .name = "Test CMD13",
+	 .run = mmc_test_CMD13,
+	 },
+	{
+	 .name = "Test CMD14",
+	 .run = unsupp_cmd,
+	 },
+	{
+	 .name = "Test CMD15",
+	 .run = mmc_test_CMD15,
+	 },
+	{
+	 .name = "Test CMD16",
+	 .run = mmc_test_CMD16,
+	 },
+};
+
+static void mmc_test_run(struct mmc_card *card, struct mmc_ioc_cmd *cmd)
+{
+	int ret;
+
+
+	printk(KERN_ALERT "%s: Test case %d. %s...\n",
+	       mmc_hostname(card->host), cmd->opcode,
+	       mmc_test_cases[cmd->opcode].name);
+
+	ret = mmc_test_cases[cmd->opcode].run(card);
+	switch (ret) {
+	case RESULT_OK:
+		cmd->result = RESULT_OK;
+		break;
+	case RESULT_FAIL:
+		cmd->result = RESULT_FAIL;
+		break;
+	case RESULT_UNSUP_CMD:
+		cmd->result = RESULT_UNSUP_CMD;
+		break;
+	case RESULT_UNSUP_CARD:
+		cmd->result = RESULT_UNSUP_CARD;
+		break;
+	default:
+		cmd->result = ret;
+	}
+
+}
+
+void test_command(struct mmc_card *card, struct mmc_ioc_cmd *cmd)
+{
+
+	mmc_test_run(card, cmd);
+}
+
+MODULE_DESCRIPTION("Supplements the Block Layer for non-data command testing");
+MODULE_AUTHOR("Shashidhar Hiremath");
+MODULE_AUTHOR("Vayavya Labs Pvt. Ltd");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/card/test_cmds.h b/drivers/mmc/card/test_cmds.h
new file mode 100644
index 0000000..877e6c5
--- /dev/null
+++ b/drivers/mmc/card/test_cmds.h
@@ -0,0 +1,53 @@
+/*
+ *  linux/drivers/mmc/card/test_cmds.c
+ *
+ *  This File includes protos for functions for testing non-data commands
+ *  through IOCTL interface.
+ *
+ *  Copyright (C) 2011 Vayavya Labs Pvt. Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef _TEST_CMDS_H_
+#define _TEST_CMDS_H_
+
+#include <linux/mmc/core.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/slab.h>
+#include <linux/scatterlist.h>
+#include <linux/swap.h>
+
+#define RESULT_OK		0
+#define RESULT_FAIL		1
+#define RESULT_UNSUP_CMD	2
+#define RESULT_UNSUP_CARD	3
+
+
+/* core.c layer exported functions */
+extern void mmc_set_bus_mode(struct mmc_host *, unsigned int);
+extern u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
+extern void mmc_power_up(struct mmc_host *);
+extern void mmc_power_off(struct mmc_host *);
+
+/* Both the below functions are present in sd.c and mmc.c files */
+extern int mmc_decode_csd(struct mmc_card *);
+extern int mmc_decode_cid(struct mmc_card *);
+
+/*Exported from mmc.c file */
+extern int mmc_read_ext_csd(struct mmc_card *);
+extern void mmc_set_erase_size(struct mmc_card *);
+
+/* Defined and exported in mmc_ops.c */
+extern int mmc_spi_set_crc(struct mmc_host *host, int use_crc);
+
+/* Defined and exported in sd.c */
+extern int mmc_sd_get_csd(struct mmc_host *, struct mmc_card *);
+extern int mmc_sd_get_cid(struct mmc_host *, u32, u32 *, u32 *);
+
+#endif /* _TEST_CMDS_H_ */
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 7ee2e07..424e0bc 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -951,6 +951,7 @@ void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode)
 	mmc_set_ios(host);
 	mmc_host_clk_release(host);
 }
+EXPORT_SYMBOL(mmc_set_bus_mode);
 
 /*
  * Change data bus width of a host.
@@ -1170,6 +1171,7 @@ u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
 
 	return ocr;
 }
+EXPORT_SYMBOL(mmc_select_voltage);
 
 int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, bool cmd11)
 {
@@ -1318,6 +1320,7 @@ static void mmc_power_up(struct mmc_host *host)
 
 	mmc_host_clk_release(host);
 }
+EXPORT_SYMBOL(mmc_power_up);
 
 void mmc_power_off(struct mmc_host *host)
 {
@@ -1352,6 +1355,7 @@ void mmc_power_off(struct mmc_host *host)
 
 	mmc_host_clk_release(host);
 }
+EXPORT_SYMBOL(mmc_power_off);
 
 /*
  * Cleanup when the last reference to the bus operator is dropped.
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index a1223bd..23d7d8e 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -108,6 +108,7 @@ static int mmc_decode_cid(struct mmc_card *card)
 
 	return 0;
 }
+EXPORT_SYMBOL(mmc_decode_cid);
 
 static void mmc_set_erase_size(struct mmc_card *card)
 {
@@ -118,6 +119,7 @@ static void mmc_set_erase_size(struct mmc_card *card)
 
 	mmc_init_erase(card);
 }
+EXPORT_SYMBOL(mmc_set_erase_size);
 
 /*
  * Given a 128-bit response, decode to our card CSD structure.
@@ -172,6 +174,7 @@ static int mmc_decode_csd(struct mmc_card *card)
 
 	return 0;
 }
+EXPORT_SYMBOL(mmc_decode_csd);
 
 /*
  * Read extended CSD.
@@ -492,6 +495,7 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 out:
 	return err;
 }
+EXPORT_SYMBOL(mmc_read_ext_csd);
 
 static inline void mmc_free_ext_csd(u8 *ext_csd)
 {
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 007863e..1420ba0 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -364,6 +364,7 @@ int mmc_spi_set_crc(struct mmc_host *host, int use_crc)
 		host->use_spi_crc = use_crc;
 	return err;
 }
+EXPORT_SYMBOL(mmc_spi_set_crc);
 
 /**
  *	mmc_switch - modify EXT_CSD register
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index bcc2c90..ba1d3c8 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -776,6 +776,7 @@ try_again:
 
 	return err;
 }
+EXPORT_SYMBOL(mmc_sd_get_cid);
 
 int mmc_sd_get_csd(struct mmc_host *host, struct mmc_card *card)
 {
@@ -794,6 +795,7 @@ int mmc_sd_get_csd(struct mmc_host *host, struct mmc_card *card)
 
 	return 0;
 }
+EXPORT_SYMBOL(mmc_sd_get_csd);
 
 int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
 	bool reinit)
diff --git a/include/linux/mmc/ioctl.h b/include/linux/mmc/ioctl.h
index 8fa5bc5..0186a86 100644
--- a/include/linux/mmc/ioctl.h
+++ b/include/linux/mmc/ioctl.h
@@ -39,6 +39,7 @@ struct mmc_ioc_cmd {
 
 	/* DAT buffer */
 	__u64 data_ptr;
+	unsigned int result;
 };
 #define mmc_ioc_cmd_set_data(ic, ptr) ic.data_ptr = (__u64)(unsigned long) ptr
 
-- 
1.7.6.4

