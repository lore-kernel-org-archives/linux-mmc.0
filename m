Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0CDC433FE
	for <linux-mmc@archiver.kernel.org>; Sat, 15 Oct 2022 11:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiJOLTl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 15 Oct 2022 07:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiJOLTk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 15 Oct 2022 07:19:40 -0400
Received: from mail3.swissbit.com (mail3.swissbit.com [176.95.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104351E71A
        for <linux-mmc@vger.kernel.org>; Sat, 15 Oct 2022 04:19:37 -0700 (PDT)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id A0F53462FEC;
        Sat, 15 Oct 2022 13:19:35 +0200 (CEST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 898B8462EBC;
        Sat, 15 Oct 2022 13:19:35 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (unknown [10.149.2.42])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Sat, 15 Oct 2022 13:19:35 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Sat, 15 Oct
 2022 13:19:32 +0200
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Sat, 15 Oct 2022 13:19:32 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
CC:     Avri Altman <Avri.Altman@wdc.com>
Subject: [PATCHv4 2/2] mmc-utils: Allow for custom sanitize timeout
Thread-Topic: [PATCHv4 2/2] mmc-utils: Allow for custom sanitize timeout
Thread-Index: Adjgh7hSXN/cQvh4SS6ilhYhnV9Wng==
Date:   Sat, 15 Oct 2022 11:19:31 +0000
Message-ID: <4ddb5a5510d74645b2724d274c96ab02@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.242.2.5]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27202.006
X-TMASE-Result: 10-0.507000-10.000000
X-TMASE-MatchedRID: xSJL/ht5SGBINlHl+WuFyhqkhv3OdF4DrzD8YrC59vxGQgIVrmBL5OqO
        SOOdRR5aOuzeNmOGKnO12HagvbwDji/7QU2czuUNA9lly13c/gGUq+GQ/zyJdEPRcdZ0KZk84Q6
        Ie8Gz9n+GeJZdmj+W7kmlX2scVfeP80zZ28YwZ5yeAiCmPx4NwIRgZNP+6bISxEHRux+uk8h+IC
        quNi0WJJtOPRRnpR6U8y/PygQizf8J7+uMOn1P3xdGyd5LT3nbftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: cf95cabe-ef9f-4c0b-b4d7-3b293cf91ccb-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Some cards with certain preconditioning require a higher timeout
when sanitizing. Let the user set the maximum timeout.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
-v4: Fix argument order in help text
 mmc.c      |  2 +-
 mmc_cmds.c | 10 +++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/mmc.c b/mmc.c
index 6c56387..4c09b79 100644
--- a/mmc.c
+++ b/mmc.c
@@ -150,7 +150,7 @@ static struct Command commands[] = {
 	  NULL
 	},
 	{ do_sanitize, -1,
-	  "sanitize", "<device>\n"
+	  "sanitize", "<device> [timeout_ms]\n"
 		"Send Sanitize command to the <device>.\nThis will delete the unmapped memory region of the device.",
 	  NULL
 	},
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 3337ded..9e0571f 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1986,12 +1986,16 @@ int do_sanitize(int nargs, char **argv)
 {
 	int fd, ret;
 	char *device;
+	unsigned int timeout = 0;
 
-	if (nargs != 2) {
-		fprintf(stderr, "Usage: mmc sanitize </path/to/mmcblkX>\n");
+	if (nargs != 2 && nargs != 3) {
+		fprintf(stderr, "Usage: mmc sanitize </path/to/mmcblkX> [timeout_in_ms]\n");
 		exit(1);
 	}
 
+	if (nargs == 3)
+		timeout = strtol(argv[2], NULL, 10);
+
 	device = argv[1];
 
 	fd = open(device, O_RDWR);
@@ -2000,7 +2004,7 @@ int do_sanitize(int nargs, char **argv)
 		exit(1);
 	}
 
-	ret = write_extcsd_value(fd, EXT_CSD_SANITIZE_START, 1, 0);
+	ret = write_extcsd_value(fd, EXT_CSD_SANITIZE_START, 1, timeout);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
 			1, EXT_CSD_SANITIZE_START, device);
-- 
2.37.3

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

