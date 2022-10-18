Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47F3C4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Oct 2022 09:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiJRJNM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Oct 2022 05:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJRJNL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2022 05:13:11 -0400
Received: from mail3.swissbit.com (mail3.swissbit.com [176.95.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ED815FD9
        for <linux-mmc@vger.kernel.org>; Tue, 18 Oct 2022 02:13:07 -0700 (PDT)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 7C2FF460CFF;
        Tue, 18 Oct 2022 11:13:05 +0200 (CEST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 692BB463103;
        Tue, 18 Oct 2022 11:13:05 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (unknown [10.149.2.42])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Tue, 18 Oct 2022 11:13:05 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Tue, 18 Oct
 2022 11:13:04 +0200
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Tue, 18 Oct 2022 11:13:04 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Subject: [PATCH] mmc-utils: Add CMD0 softreset and preidle command
Thread-Topic: [PATCH] mmc-utils: Add CMD0 softreset and preidle command
Thread-Index: Adji0bdh7EK1ICQ5RKCr0hZaXnhBxw==
Date:   Tue, 18 Oct 2022 09:13:04 +0000
Message-ID: <452efc77cda34926a1b2147e754e6455@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.242.2.2]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27208.006
X-TMASE-Result: 10--7.009100-10.000000
X-TMASE-MatchedRID: dwNgap4H9hgus6wjYQDwl3T7rnt3EYkYajzNTFMlQCNGhv4wII7rlgcs
        lYpo5iSTJDNqi6K9LCm12HagvbwDji/7QU2czuUNA9lly13c/gGUq+GQ/zyJdEPRcdZ0KZk85ax
        aw7fIL5GWxgRUGvFU+MK1eBjDLtPWjxmC4zinH8oZgmFGHqyx68qspZV+lCSLTm8VsmUIJLEbJA
        HWhH3kCmBf3D1+kshy3SNXrC5GPUTlRxm3A2wKuhM0JxSxHjFJ3QfwsVk0UbtuRXh7bFKB7svPL
        Cj6NSUd2al/wi8FB5OVIQGgjNgei4nBlZem2mf9S4W/MRhJ1X4=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 2a65fa08-6633-4d82-bbcd-c56d40ff776d-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

CMD0 may be used to see if the hardware can handle a UHS card
that completed the voltage switch. If a UHS card has problems
coming back up after CMD0 your hardware may not support a hard
reset properly.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 mmc.c      | 10 ++++++++++
 mmc.h      |  3 +++
 mmc_cmds.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |  2 ++
 4 files changed, 66 insertions(+)

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
index 2957aa9..ed2be69 100644
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
+	issue_cmd0(device, 0x0);
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
+	issue_cmd0(device, 0xf0f0f0f0);
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

