Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED013C678D7
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Jan 2023 11:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjAPLTp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Jan 2023 06:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjAPLTF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2023 06:19:05 -0500
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5481DBB4
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 03:19:03 -0800 (PST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 50FB83A16BB
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 12:19:02 +0100 (CET)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 3F2723A16B8
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 12:19:02 +0100 (CET)
X-TM-AS-ERS: 10.181.10.102-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgyLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx2.dmz.swissbit.com (mx2.dmz.swissbit.com [10.181.10.102])
        by mail5.swissbit.com (Postfix) with ESMTPS
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 12:19:02 +0100 (CET)
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: [PATCHv3] mmc-utils: Add basic erase error check
Thread-Topic: [PATCHv3] mmc-utils: Add basic erase error check
Thread-Index: AdkpnBz4vb9STB+lRhSmAMC2A/DE0g==
Date:   Mon, 16 Jan 2023 11:18:59 +0000
Message-ID: <c91cdde6288d4db6aad45f5d50d129c8@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27388.007
X-TMASE-Result: 10-1.452400-10.000000
X-TMASE-MatchedRID: xSJL/ht5SGAus6wjYQDwl0hwlOfYeSqx5mggwpemm73a9yHV8yqYj5Ky
        Pf1j7t43nFafp20DkZC8MOaGTOJX/QV2NKF6aideEXjPIvKd74BMkOX0UoduuXd17Y6gGqDCyL5
        QmWOgMfCEkt/L8HtAJ/HDDHGSFyr6kfRhdidsajMTNCcUsR4xSWVV1G+Ck2l7+gtHj7OwNO2+Ij
        sEEOIzYoemVWizua/cDdjtT0IDMbb1BGh0+71rpsp4Un1wqv+9
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 608ac312-077e-436e-840a-a09694c323f6-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Check for erase specific R1 errors so e.g. an OOR erase is not
reported as successful when it never executed.

There could be checks for more error bits but R1_ERASE_SEQ_ERROR
on CMD38 should catch all that are reported by hardware anyway.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
-v3: Check for ERASE_PARAM on CMD36
-v2: Remove unneeded error bit checking
 mmc_cmds.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index e6d3273..6c50bbe 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -54,7 +54,6 @@
 #define WPTYPE_PWRON 2
 #define WPTYPE_PERM 3
 
-
 int read_extcsd(int fd, __u8 *ext_csd)
 {
 	int ret = 0;
@@ -2668,6 +2667,18 @@ static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
 	if (ret)
 		perror("Erase multi-cmd ioctl");
 
+	/* Does not work for SPI cards */
+	if (multi_cmd->cmds[1].response[0] & R1_ERASE_PARAM) {
+		fprintf(stderr, "Erase start response: 0x%08x\n",
+				multi_cmd->cmds[0].response[0]);
+		ret = -EIO;
+	}
+	if (multi_cmd->cmds[2].response[0] & R1_ERASE_SEQ_ERROR) {
+		fprintf(stderr, "Erase response: 0x%08x\n",
+				multi_cmd->cmds[2].response[0]);
+		ret = -EIO;
+	}
+
 	free(multi_cmd);
 	return ret;
 }
-- 
2.37.3


Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

