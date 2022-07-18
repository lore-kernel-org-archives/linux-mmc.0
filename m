Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E24CC433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jul 2022 12:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbiGRMRh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Jul 2022 08:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbiGRMRh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jul 2022 08:17:37 -0400
Received: from mail3.swissbit.com (mail3.swissbit.com [176.95.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2C324080
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2022 05:17:35 -0700 (PDT)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id DC3074636D2;
        Mon, 18 Jul 2022 14:17:33 +0200 (CEST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id C4FF9462F12;
        Mon, 18 Jul 2022 14:17:33 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (unknown [10.149.2.42])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Mon, 18 Jul 2022 14:17:33 +0200 (CEST)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Mon, 18 Jul
 2022 14:17:33 +0200
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.1118.009; Mon, 18 Jul 2022 14:17:33 +0200
From:   Christian Loehle <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Subject: [PATCH] mmc-utils: Add softreset command for issuing CMD0
Thread-Topic: [PATCH] mmc-utils: Add softreset command for issuing CMD0
Thread-Index: AdiaoDZBaBhbwaxFRXm22iF8+Gujgg==
Date:   Mon, 18 Jul 2022 12:17:33 +0000
Message-ID: <fee2ce51a200442f90bea0668466a2b1@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.44]
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27022.007
X-TMASE-Result: 10--5.532100-10.000000
X-TMASE-MatchedRID: 2wfub8HDRfPyaWDdlFBzB5lQbjWLQqObsXm0OsXi/nXe6dEbvIyrxZKP
        VSCA9cWVjx5X3FdI4UDmn3xyPJAJoh2P280ZiGmR8IK7yRWPRNEYH39vFLryE54Q+L3BXIWuaqB
        jsGYT41oXjQchKpIrqptCs4DdnIBwXd2C0i9IY+mF0P4btTlf9ARryDXHx6oXX/yUapWy0lf64E
        XalNg4NQJSVkTADkn2fyYDewMOrQDkwjHXXC/4IzsAVzN+Ov/sFB93SnvedLt9akUwUiXe/8QNW
        UILFhRaXfNQHYdxzlLm3j97dEt+7A==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 7e601c42-1f1a-461f-b93d-fd7f29f45a4c-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

CMD0 may be used to see if the hardware can handle a UHS card
that completed the voltage switch. If a UHS card has problems
coming back up after CMD0 your hardware may not support a hard
reset properly.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 mmc.c      |  5 +++++
 mmc.h      |  3 +++
 mmc_cmds.c | 30 ++++++++++++++++++++++++++++++
 mmc_cmds.h |  1 +
 4 files changed, 39 insertions(+)

diff --git a/mmc.c b/mmc.c
index 6c56387..ba2c883 100644
--- a/mmc.c
+++ b/mmc.c
@@ -245,6 +245,11 @@ static struct Command commands[] = {
 		"be 1.",
 	NULL
 	},
+	{ do_soft_reset, -1,
+	  "softreset", "<device>\n"
+	  "Issues a CMD0 softreset, e.g. for testing if hardware reset for UHS works\n\n",
+	  NULL
+	},
 	{ 0, 0, 0, 0 }
 };
 
diff --git a/mmc.h b/mmc.h
index daff62c..9796d2e 100644
--- a/mmc.h
+++ b/mmc.h
@@ -21,6 +21,7 @@
 #include <linux/mmc/ioctl.h>
 
 /* From kernel linux/mmc/mmc.h */
+#define MMC_GO_IDLE_STATE         0   /* bc                          */
 #define MMC_SWITCH		6	/* ac	[31:0] See below	R1b */
 #define MMC_SEND_EXT_CSD	8	/* adtc				R1  */
 #define MMC_SEND_STATUS		13	/* ac   [31:16] RCA        R1  */
@@ -226,6 +227,7 @@
 
 
 /* From kernel linux/mmc/core.h */
+#define MMC_RSP_NONE	0			/* no response */
 #define MMC_RSP_PRESENT	(1 << 0)
 #define MMC_RSP_136	(1 << 1)		/* 136 bit response */
 #define MMC_RSP_CRC	(1 << 2)		/* expect valid crc */
@@ -234,6 +236,7 @@
 
 #define MMC_CMD_AC	(0 << 5)
 #define MMC_CMD_ADTC	(1 << 5)
+#define MMC_CMD_BC	(2 << 5)
 
 #define MMC_RSP_SPI_S1	(1 << 7)		/* one status byte */
 #define MMC_RSP_SPI_BUSY (1 << 10)		/* card may send busy */
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 12b7802..c027cfa 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -3039,3 +3039,33 @@ out:
 	close(dev_fd);
 	return ret;
 }
+
+int do_soft_reset(int nargs, char **argv)
+{
+	int fd;
+	char *device;
+	struct mmc_ioc_cmd idata;
+
+	if (nargs != 2) {
+		fprintf(stderr, "Usage: mmc status softreset </path/to/mmcblkX>\n");
+		exit(1);
+	}
+
+	device = argv[1];
+
+	fd = open(device, O_RDWR);
+	if (fd < 0) {
+		perror("open");
+		exit(1);
+	}
+
+	memset(&idata, 0, sizeof(idata));
+	idata.opcode = MMC_GO_IDLE_STATE;
+	idata.flags = MMC_RSP_NONE | MMC_CMD_BC;
+
+	/* No need to check for error, it is expected */
+	ioctl(fd, MMC_IOC_CMD, &idata);
+	close(fd);
+
+	return 0;
+}
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 0f7c004..c112a95 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -47,3 +47,4 @@ int do_read_cid(int argc, char **argv);
 int do_read_csd(int argc, char **argv);
 int do_erase(int nargs, char **argv);
 int do_general_cmd_read(int nargs, char **argv);
+int do_soft_reset(int nargs, char **argv);
-- 
2.36.1

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

