From: Mahadev Cholachagudda <mgudda@gmail.com>
Subject: [PATCH 1/1] Implementation for knowing speed_class of inserted SD
	card from user space
Date: Wed, 30 Sep 2009 17:22:14 +0530
Message-ID: <bd31ea570909300452u49ec17b3h4399da986dd2f78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f194.google.com ([209.85.216.194]:34043 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754173AbZI3LwK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Sep 2009 07:52:10 -0400
Received: by pxi32 with SMTP id 32so5384513pxi.4
        for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2009 04:52:14 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Pierre Ossman <pierre@ossman.eu>, Pierre Ossman <drzeus-list@drzeus.cx>, Matt Fleming <matt@console-pimps.org>

Dear All,

The below patch allows an application to know the speed_class of the
inserted SD card. Since the MMC cards do not specify speed_class, I'm
making the speed_class to indicate as 0xFF. The coding of the
speed_class is same as present in the SD Simplified specification.

simplified SD spec:
http://www.sdcard.org/developers/tech/sdcard/pls/Simplified_Physical_La=
yer_Spec.pdf

See page 65 and 66

SPEED_CLASS
This 8-bit field indicates the Speed Class and the value can be
calculated by Pw/2.
SPEED_CLASS Value Definition
00h Class 0
01h Class 2
02h Class 4
03h Class 6
04h =96 FFh Reserved
Table 4-38: Speed Class Code Field

The changes were tested in our platform, which displayed the proper
speed_class for inserted SD cards (6 of them were tested) and one
MMCMobile card.

The speed_class can be known by looking at sysfs entries at :
/sys/devices/platform/nx_sdiomc.0/mmc_host/mmc0/mmc0:XXXX/speed_class

	This file contains the speed class of the SD/MMC card that is
inserted. Please note that, speed_class is not applicable for MMC
cards. This file contains a hexadecimal number. Interpretation shall
be like as below:
0x00 =E0 Class 0
0x01 =E0 Class 2
0x02 =E0 Class 4
0x03 =E0 Class 6
0x04 to 0xFF =E0 Reserved (currently, for MMC based cards, it is 0xFF)

(where in nx_sdiomc.0 is our platform driver for sdhci)

Let me know if you have any comments/suggestions?

Regards,
Mahadev K Cholachagudda

diff -urNd linux-orig/drivers/mmc/core/mmc.c
linux-current/drivers/mmc/core/mmc.c
--- linux-orig/drivers/mmc/core/mmc.c	2009-09-30 16:52:16.973273403 +05=
30
+++ linux-current/drivers/mmc/core/mmc.c	2009-09-30 17:06:48.321273501 =
+0530
@@ -258,6 +258,7 @@
 MMC_DEV_ATTR(name, "%s\n", card->cid.prod_name);
 MMC_DEV_ATTR(oemid, "0x%04x\n", card->cid.oemid);
 MMC_DEV_ATTR(serial, "0x%08x\n", card->cid.serial);
+MMC_DEV_ATTR(speed_class, "0x%02x\n", card->speed_class);

 static struct attribute *mmc_std_attrs[] =3D {
 	&dev_attr_cid.attr,
@@ -269,6 +270,7 @@
 	&dev_attr_name.attr,
 	&dev_attr_oemid.attr,
 	&dev_attr_serial.attr,
+	&dev_attr_speed_class.attr,
 	NULL,
 };

@@ -454,6 +456,12 @@
 		mmc_set_bus_width(card->host, bus_width);
 	}

+	/*
+	 * to indicate speed_class reserved, as MMC card do not indicate
+	 * any speed_class
+	 * */
+	card->speed_class =3D 0xFF;
+
 	if (!oldcard)
 		host->card =3D card;

diff -urNd linux-orig/drivers/mmc/core/sd.c linux-current/drivers/mmc/c=
ore/sd.c
--- linux-orig/drivers/mmc/core/sd.c	2009-09-30 16:52:10.588335882 +053=
0
+++ linux-current/drivers/mmc/core/sd.c	2009-09-30 17:03:59.458273462 +=
0530
@@ -294,6 +294,7 @@
 MMC_DEV_ATTR(name, "%s\n", card->cid.prod_name);
 MMC_DEV_ATTR(oemid, "0x%04x\n", card->cid.oemid);
 MMC_DEV_ATTR(serial, "0x%08x\n", card->cid.serial);
+MMC_DEV_ATTR(speed_class, "0x%02x\n", card->speed_class);


 static struct attribute *sd_std_attrs[] =3D {
@@ -307,6 +308,7 @@
 	&dev_attr_name.attr,
 	&dev_attr_oemid.attr,
 	&dev_attr_serial.attr,
+	&dev_attr_speed_class.attr,
 	NULL,
 };

@@ -508,6 +510,20 @@
 		}
 	}

+	if (!oldcard) {
+		/* get the speed class */
+		u8 *sd_status;
+		sd_status =3D kmalloc(64, GFP_KERNEL);
+		if(!sd_status)
+			goto free_card;
+
+		err =3D mmc_app_sd_status(card, sd_status);
+		card->speed_class =3D sd_status[8];
+		kfree(sd_status);
+		if(err)
+			goto free_card;
+	}
+
 	if (!oldcard)
 		host->card =3D card;

diff -urNd linux-orig/drivers/mmc/core/sd_ops.c
linux-current/drivers/mmc/core/sd_ops.c
--- linux-orig/drivers/mmc/core/sd_ops.c	2009-09-30 16:52:22.195336136 =
+0530
+++ linux-current/drivers/mmc/core/sd_ops.c	2009-09-30 17:01:11.9012742=
05 +0530
@@ -348,3 +348,50 @@
 	return 0;
 }

+int mmc_app_sd_status(struct mmc_card *card, u8 *sd_status)
+{
+	int err;
+	struct mmc_request mrq;
+	struct mmc_command cmd;
+	struct mmc_data data;
+	struct scatterlist sg;
+
+	BUG_ON(!card);
+	BUG_ON(!card->host);
+	BUG_ON(!sd_status);
+
+	/* NOTE: caller guarantees sd_status is heap-allocated */
+	err =3D mmc_app_cmd(card->host, card);
+	if (err)
+		return err;
+
+	memset(&mrq, 0, sizeof(struct mmc_request));
+	memset(&cmd, 0, sizeof(struct mmc_command));
+	memset(&data, 0, sizeof(struct mmc_data));
+
+	mrq.cmd =3D &cmd;
+	mrq.data =3D &data;
+
+	cmd.opcode =3D 13;
+	cmd.arg =3D 0;
+	cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+
+	data.blksz =3D 64;
+	data.blocks =3D 1;
+	data.flags =3D MMC_DATA_READ;
+	data.sg =3D &sg;
+	data.sg_len =3D 1;
+
+	sg_init_one(&sg, sd_status, 64);
+
+	mmc_set_data_timeout(&data, card);
+
+	mmc_wait_for_req(card->host, &mrq);
+
+	if (cmd.error)
+		return cmd.error;
+	if (data.error)
+		return data.error;
+	return 0;
+}
+
diff -urNd linux-orig/drivers/mmc/core/sd_ops.h
linux-current/drivers/mmc/core/sd_ops.h
--- linux-orig/drivers/mmc/core/sd_ops.h	2009-09-30 16:52:25.708273492 =
+0530
+++ linux-current/drivers/mmc/core/sd_ops.h	2009-09-30 16:59:04.7672738=
89 +0530
@@ -19,6 +19,7 @@
 int mmc_app_send_scr(struct mmc_card *card, u32 *scr);
 int mmc_sd_switch(struct mmc_card *card, int mode, int group,
 	u8 value, u8 *resp);
+int mmc_app_sd_status(struct mmc_card *card, u8 *sd_status);

 #endif

diff -urNd linux-orig/include/linux/mmc/card.h
linux-current/include/linux/mmc/card.h
--- linux-orig/include/linux/mmc/card.h	2009-09-30 16:51:59.230273430 +=
0530
+++ linux-current/include/linux/mmc/card.h	2009-09-30 16:53:54.16227301=
3 +0530
@@ -111,6 +111,7 @@
 	unsigned		num_info;	/* number of info strings */
 	const char		**info;		/* info strings */
 	struct sdio_func_tuple	*tuples;	/* unknown common tuples */
+	u32 speed_class; /* speed_class for SD cards, for MMC, it is always
reserved */

 	struct dentry		*debugfs_root;
 };
