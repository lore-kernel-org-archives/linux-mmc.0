Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382E0C433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Oct 2022 10:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiJRKo4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Oct 2022 06:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJRKoz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2022 06:44:55 -0400
Received: from mail3.swissbit.com (mail3.swissbit.com [176.95.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E23F2ED42
        for <linux-mmc@vger.kernel.org>; Tue, 18 Oct 2022 03:44:53 -0700 (PDT)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id C2E11462C92;
        Tue, 18 Oct 2022 12:44:51 +0200 (CEST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id B39F546181C;
        Tue, 18 Oct 2022 12:44:51 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (unknown [10.149.2.42])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Tue, 18 Oct 2022 12:44:51 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Tue, 18 Oct
 2022 12:44:51 +0200
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Tue, 18 Oct 2022 12:44:51 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Subject: [PATCHv2] mmc-utils: Add CMD0 softreset and preidle command
Thread-Topic: [PATCHv2] mmc-utils: Add CMD0 softreset and preidle command
Thread-Index: Adji3jrc3gUSbE0uQsWCbLHtmguQSg==
Date:   Tue, 18 Oct 2022 10:44:51 +0000
Message-ID: <333eee173dfc4765a866537b863945cb@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.242.2.2]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27208.007
X-TMASE-Result: 10--10.177100-10.000000
X-TMASE-MatchedRID: GBgFBUqwD4Eus6wjYQDwl3T7rnt3EYkYajzNTFMlQCNGhv4wII7rlgcs
        lYpo5iSTugcM4hLuMwtifbr8eLH9Y1ZVo+BBBYvwqhcdnP91eXGUq+GQ/zyJdFcZNuxCoduS6Ch
        K9oqyX+Qi+t+0AiFaYvL3NxFKQpq1YDVHXGJx4TsRW4LR41Fi8u9Bi8r8zoNMYD4HoIFcAhYMvI
        MMSRKyeNq6ESmdTGy8mM4UIhVaVhPSeXWew2NHuEhwlOfYeSqxl9q75JzWJRN3de2OoBqgwjv6C
        Ezcdfmj4vM1YF6AJbZ0uL0K7fOJNyAHAopEd76v2NJYFKokke5A4byToKJObmZa72YF7HKEj3Uz
        J6v++DVQCdPZzqDXZg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: a18a55d1-6923-49c4-beb2-f91262599fca-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

CMD0 may be used to see if the hardware can handle a UHS card
that completed the voltage switch. If a UHS card has problems
coming back up after CMD0 your hardware may not support a hard
reset properly.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
-v2: Use macro for cmd0 argument
Note: A previous version has been discussed as
mmc-utils: Add softreset command for issuing CMD0
but with the addition of preidle I considered this to be
a different patch
mmc.c      | 10 ++++++++++
 mmc.h      |  5 +++++
 mmc_cmds.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |  2 ++
 4 files changed, 68 insertions(+)

diff --git a/mmc.c b/mmc.c
index 6c56387..50493f3 100644
--- a/mmc.c
+++ b/mmc.c
@@ -245,6 +245,16 @@ static struct Command commands[] = {
 		"be 1.",
 	NULL
 	},
+	{ do_softreset, -1,
+	  "softreset", "<device>\n"
+	  "Issues a CMD0 softreset, e.g. for testing if hardware reset for UHS works",
+	  NULL
+	},
+	{ do_preidle, -1,
+	  "preidle", "<device>\n"
+	  "Issues a CMD0 GO_PRE_IDLE",
+	  NULL
+	},
 	{ 0, 0, 0, 0 }
 };
 
diff --git a/mmc.h b/mmc.h
index daff62c..6511dbc 100644
--- a/mmc.h
+++ b/mmc.h
@@ -21,6 +21,9 @@
 #include <linux/mmc/ioctl.h>
 
 /* From kernel linux/mmc/mmc.h */
+#define MMC_GO_IDLE_STATE         0   /* bc                          */
+#define MMC_GO_IDLE_STATE_ARG		0x0
+#define MMC_GO_PRE_IDLE_STATE_ARG	0xF0F0F0F0
 #define MMC_SWITCH		6	/* ac	[31:0] See below	R1b */
 #define MMC_SEND_EXT_CSD	8	/* adtc				R1  */
 #define MMC_SEND_STATUS		13	/* ac   [31:16] RCA        R1  */
@@ -226,6 +229,7 @@
 
 
 /* From kernel linux/mmc/core.h */
+#define MMC_RSP_NONE	0			/* no response */
 #define MMC_RSP_PRESENT	(1 << 0)
 #define MMC_RSP_136	(1 << 1)		/* 136 bit response */
 #define MMC_RSP_CRC	(1 << 2)		/* expect valid crc */
@@ -234,6 +238,7 @@
 
 #define MMC_CMD_AC	(0 << 5)
 #define MMC_CMD_ADTC	(1 << 5)
+#define MMC_CMD_BC	(2 << 5)
 
 #define MMC_RSP_SPI_S1	(1 << 7)		/* one status byte */
 #define MMC_RSP_SPI_BUSY (1 << 10)		/* card may send busy */
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 2957aa9..94e30e0 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -3044,3 +3044,54 @@ out:
 	close(dev_fd);
 	return ret;
 }
+
+void issue_cmd0(char *device, __u32 arg)
+{
+	struct mmc_ioc_cmd idata;
+	int fd;
+
+	fd = open(device, O_RDWR);
+	if (fd < 0) {
+		perror("open");
+		exit(1);
+	}
+
+	memset(&idata, 0, sizeof(idata));
+	idata.opcode = MMC_GO_IDLE_STATE;
+	idata.arg = arg;
+	idata.flags = MMC_RSP_NONE | MMC_CMD_BC;
+
+	/* No need to check for error, it is expected */
+	ioctl(fd, MMC_IOC_CMD, &idata);
+	close(fd);
+}
+
+int do_softreset(int nargs, char **argv)
+{
+	char *device;
+
+	if (nargs != 2) {
+		fprintf(stderr, "Usage: mmc softreset </path/to/mmcblkX>\n");
+		exit(1);
+	}
+
+	device = argv[1];
+	issue_cmd0(device, MMC_GO_IDLE_STATE_ARG);
+
+	return 0;
+}
+
+int do_preidle(int nargs, char **argv)
+{
+	char *device;
+
+	if (nargs != 2) {
+		fprintf(stderr, "Usage: mmc preidle </path/to/mmcblkX>\n");
+		exit(1);
+	}
+
+	device = argv[1];
+	issue_cmd0(device, MMC_GO_PRE_IDLE_STATE_ARG);
+
+	return 0;
+}
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 0f7c004..faab362 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -47,3 +47,5 @@ int do_read_cid(int argc, char **argv);
 int do_read_csd(int argc, char **argv);
 int do_erase(int nargs, char **argv);
 int do_general_cmd_read(int nargs, char **argv);
+int do_softreset(int nargs, char **argv);
+int do_preidle(int nargs, char **argv);
-- 
2.37.3

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

