Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22DCC4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Oct 2022 09:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiJMJKm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Oct 2022 05:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiJMJKj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2022 05:10:39 -0400
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9613713954B
        for <linux-mmc@vger.kernel.org>; Thu, 13 Oct 2022 02:10:35 -0700 (PDT)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 141F13A1927;
        Thu, 13 Oct 2022 11:10:34 +0200 (CEST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 0505D3A1619;
        Thu, 13 Oct 2022 11:10:34 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (sbdeex04.sbitdom.lan [10.149.2.42])
        by mail5.swissbit.com (Postfix) with ESMTPS;
        Thu, 13 Oct 2022 11:10:33 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Thu, 13 Oct
 2022 11:10:33 +0200
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Thu, 13 Oct 2022 11:10:33 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Subject: [PATCHv3 2/2] mmc-utils: Allow for custom sanitize timeout
Thread-Topic: [PATCHv3 2/2] mmc-utils: Allow for custom sanitize timeout
Thread-Index: Adje43JOZaYCnu4XQLyVuyVzcXP++Q==
Date:   Thu, 13 Oct 2022 09:10:33 +0000
Message-ID: <5a0ec3abd08f437690c705fe2da4766e@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.242.2.66]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27198.006
X-TMASE-Result: 10-0.507000-10.000000
X-TMASE-MatchedRID: xSJL/ht5SGBINlHl+WuFyhqkhv3OdF4DrzD8YrC59vxGQgIVrmBL5OqO
        SOOdRR5ajx5X3FdI4UDmn3xyPJAJoh2P280ZiGmR8IK7yRWPRNEYH39vFLryE9MvYZEcBz1xvnV
        hS/vsz71N1PNr4XCqchSUdrT1oRMN5UcZtwNsCroTNCcUsR4xSWVV1G+Ck2l7+gtHj7OwNO14uF
        xKD13nMYAnj3TzcScQNH3n86JShscKKNDeMUfRSIaN8bJQu2r+
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 3f2586d2-e252-46c1-b829-ac7dea269544-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Some cards with certain preconditioning require a higher timeout
when sanitizing. Let the user set the maximum timeout.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 mmc.c      |  2 +-
 mmc_cmds.c | 10 +++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/mmc.c b/mmc.c
index 6c56387..2344879 100644
--- a/mmc.c
+++ b/mmc.c
@@ -150,7 +150,7 @@ static struct Command commands[] = {
 	  NULL
 	},
 	{ do_sanitize, -1,
-	  "sanitize", "<device>\n"
+	  "sanitize", "[timeout_ms] <device>\n"
 		"Send Sanitize command to the <device>.\nThis will delete the unmapped memory region of the device.",
 	  NULL
 	},
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 3337ded..4171dfd 100644
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
+		fprintf(stderr, "Usage: mmc sanitize [timeout_in_ms] </path/to/mmcblkX>\n");
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

