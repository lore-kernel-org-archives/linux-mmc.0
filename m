Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990EFC4167B
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Dec 2022 09:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiLLJW5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Dec 2022 04:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiLLJWD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Dec 2022 04:22:03 -0500
Received: from mail6.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5D910D5
        for <linux-mmc@vger.kernel.org>; Mon, 12 Dec 2022 01:21:34 -0800 (PST)
Received: from mail6.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 2F1B7221D64
        for <linux-mmc@vger.kernel.org>; Mon, 12 Dec 2022 09:20:55 +0000 (UTC)
Received: from mail6.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 24994221D63
        for <linux-mmc@vger.kernel.org>; Mon, 12 Dec 2022 09:20:55 +0000 (UTC)
X-TM-AS-ERS: 10.181.10.102-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgyLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx2.dmz.swissbit.com (mx2.dmz.swissbit.com [10.181.10.102])
        by mail6.swissbit.com (Postfix) with ESMTPS
        for <linux-mmc@vger.kernel.org>; Mon, 12 Dec 2022 09:20:55 +0000 (UTC)
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [PATCH] mmc-utils: Add basic erase error check
Thread-Topic: [PATCH] mmc-utils: Add basic erase error check
Thread-Index: AdkOCrPej0mSjhUcTiSz6oCfSEK7yw==
Date:   Mon, 12 Dec 2022 09:21:31 +0000
Message-ID: <16c9b85406034bd6b3c526070b9fd995@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27318.007
X-TMASE-Result: 10-0.942200-10.000000
X-TMASE-MatchedRID: ewN4Wv8Mz/gus6wjYQDwl0hwlOfYeSqx5mggwpemm73a9yHV8yqYj5Ky
        Pf1j7t43nFafp20DkZAeR0iAFEaV0y/7QU2czuUNA9lly13c/gGZIt4iAQN6Pw3vouJTzOe2Fn1
        HfFYSiYKX81JAaXNO9sBSF5SyieX8jQZ1YqAZsGGeAiCmPx4NwItuikALUpnGVDC1CbuJXmMqtq
        5d3cxkNX0IQgVUelAt24r4N3+8AdltbvNXHwiFwidSqNBdBKn9onRr5BtoLz4=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: b9478f6e-0edc-4906-90da-d8897aefcaf9-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Check for erase specific R1 errors so e.g. an OOR erase is not
reported as successful when it never executed.

There could be checks for more error bits but R1_ERASE_SEQ_ERROR
on CMD38 should catch all that are reported by hardware anyway.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 mmc_cmds.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index e6d3273..c00fe5e 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -54,6 +54,7 @@
 #define WPTYPE_PWRON 2
 #define WPTYPE_PERM 3
 
+#define ERASE_R1_ERR_MASK (R1_ERASE_SEQ_ERROR | R1_ERASE_PARAM | R1_ERASE_RESET)
 
 int read_extcsd(int fd, __u8 *ext_csd)
 {
@@ -2668,6 +2669,23 @@ static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
 	if (ret)
 		perror("Erase multi-cmd ioctl");
 
+	/* Does not work for SPI cards */
+	if (multi_cmd->cmds[0].response[0] & ERASE_R1_ERR_MASK) {
+		fprintf(stderr, "Erase start response: %08x\n",
+				multi_cmd->cmds[0].response[0]);
+		ret = -EIO;
+	}
+	if (multi_cmd->cmds[1].response[0] & ERASE_R1_ERR_MASK) {
+		fprintf(stderr, "Erase end response: %08x\n",
+				multi_cmd->cmds[1].response[0]);
+		ret = -EIO;
+	}
+	if (multi_cmd->cmds[2].response[0] & ERASE_R1_ERR_MASK) {
+		fprintf(stderr, "Erase response: %08x\n",
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

