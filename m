Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2C2EB64DD
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jun 2023 10:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjFYKjX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 25 Jun 2023 06:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjFYKjW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Jun 2023 06:39:22 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5A1E44
        for <linux-mmc@vger.kernel.org>; Sun, 25 Jun 2023 03:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687689560; x=1719225560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cbPr9is1lhDIdyfCo15q74NmPvMaF3gMv7Z2OgyuoBM=;
  b=AEd7rREx4bZbt4RSv+KbPnjZI/1sx9T7LNc7G+PPYZF74QjQ6Tq3a+uk
   PhGtrwynCNmuvvdncZLi9pG75jhY7GSzi6ML53+voi/XLE9BDE9C0WsLz
   p+yXxmGR1cmKAgi2Ww6y2YQ24qhftIAynUv7Og0KwCp9E5GuiLXMVcprY
   1mugggQYJJSOVTsmeDT4AKmPxCHXZenNFA/zIQe1zu8+H5nQPMoIyxThD
   aTMzp6jktG+t6x0pKJu8t/W9M1FcvJDCI4ZV81mIEYUjRSuT61+LoP6+z
   Af2vJCvJ7LUEdKZzUUHKNNgHW3LXwtcGSrUJ4tDLE02wQnwn0pyS5ds/2
   A==;
X-IronPort-AV: E=Sophos;i="6.01,157,1684771200"; 
   d="scan'208";a="236798746"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2023 18:39:20 +0800
IronPort-SDR: bfYaOFTSLknvINKL6fQY9EtNQAkh7F6YeNpuY0FVwJBzYR+cO/O3h968X3Nn+oKpmqW8r1dggX
 j30A2aLIZzBVsaj9k6MoVW+yaIvzbhk67Hq4rX7rU2bvP5plBkPa0IecCCFH6Cnxt2XJb0prrt
 UFSNXiXvUqWT0Kb4TBrU7BOswImezoMth2v//mD/Zh1CxSAYB+M2vToRTeynZVqOza8Di2l0Ro
 R+aV1KILVaP2mz8bOV/8u3ahBNjmbWEUGQeC9fL2tyUA0sTAIaEwkSpJ/l5EhVXXVnfQwEo8MH
 72o=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2023 02:53:42 -0700
IronPort-SDR: 4vfUHZhQl5+TdbTEg87IteUtrC9PHYOrAI6oCEM8Aglvr9PnPX8eSC+5nr+jf3mcWC/ErPKksB
 WMB3BBBhXOrq6uaDUuVrRSLvM900feRoZMmM3sULoZXheXYFzxcRGCYGFzY818q4NH2T20WVGi
 Ztu8IrxL1T4NtbMsK7GBw6y17A3RzuLaAGNdaBfyeO/z/Tv/+8l1RDmZzNwW3OeiSnRe9kAd//
 llPAJQNIuc4nw+vh+RxpaloePeaeeyCOuGerRBQGIUuuVnnBBhQYb4kwmEHoAQ3CBv+6b7SkY+
 Tv4=
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jun 2023 03:39:20 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>,
        Lund Austin <Austin.Lund@garmin.com>
Subject: [PATCH 6/6] mmc-utils: ffu: Add optional chunk-size argument
Date:   Sun, 25 Jun 2023 13:38:14 +0300
Message-Id: <20230625103814.105-7-avri.altman@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230625103814.105-1-avri.altman@wdc.com>
References: <20230625103814.105-1-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Normally one would like to perform ffu using the largest possible chunk.
However, since the ffu-timeout is vendor specific, there are times in
which smaller chunks would lead to a more robust ffu process.  Allow
this via an additional optional argument.

Tested-by: Lund Austin <Austin.Lund@garmin.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 mmc.c      |  6 ++++--
 mmc_cmds.c | 18 ++++++++++++------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/mmc.c b/mmc.c
index 795b4e3..bc8f74e 100644
--- a/mmc.c
+++ b/mmc.c
@@ -228,8 +228,10 @@ static struct Command commands[] = {
 	  NULL
 	},
 	{ do_ffu, -2,
-	  "ffu", "<image name> <device>\n"
-		"Run Field Firmware Update with <image name> on <device>.\n",
+	  "ffu", "<image name> <device> [chunk-bytes]\n"
+		"Run Field Firmware Update with <image name> on <device>.\n"
+		"[chunk-bytes] is optional and defaults to its max - 512k. "
+		"should be in decimal bytes and sector aligned.\n",
 	  NULL
 	},
 	{ do_erase, -4,
diff --git a/mmc_cmds.c b/mmc_cmds.c
index a1adbde..10d063d 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2834,11 +2834,9 @@ int do_ffu(int nargs, char **argv)
 	off_t fw_size, bytes_left, off;
 	char *device;
 	struct mmc_ioc_multi_cmd *multi_cmd = NULL;
+	unsigned int default_chunk = MMC_IOC_MAX_BYTES;
 
-	if (nargs != 3) {
-		fprintf(stderr, "Usage: ffu <image name> </path/to/mmcblkX> \n");
-		exit(1);
-	}
+	assert (nargs == 3 || nargs == 4);
 
 	device = argv[2];
 	dev_fd = open(device, O_RDWR);
@@ -2898,6 +2896,14 @@ int do_ffu(int nargs, char **argv)
 		goto out;
 	}
 
+	if (nargs == 4) {
+		default_chunk = strtol(argv[3], NULL, 10);
+		if (default_chunk > MMC_IOC_MAX_BYTES || default_chunk % 512) {
+			fprintf(stderr, "Invalid chunk size");
+			goto out;
+		}
+	}
+
 	/* prepare multi_cmd for FFU based on cmd to be used */
 
 	multi_cmd->num_of_cmds = 4;
@@ -2922,8 +2928,8 @@ do_retry:
 	bytes_left = fw_size;
 	off = 0;
 	while (bytes_left) {
-		unsigned int chunk_size = bytes_left < MMC_IOC_MAX_BYTES ?
-					  bytes_left : MMC_IOC_MAX_BYTES;
+		unsigned int chunk_size = bytes_left < default_chunk ?
+					  bytes_left : default_chunk;
 
 		/* prepare multi_cmd for FFU based on cmd to be used */
 		set_ffu_single_cmd(multi_cmd, ext_csd, chunk_size, buf, off);
-- 
2.40.1

