Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB3DC433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jun 2022 13:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiFXNSQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Jun 2022 09:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiFXNSP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jun 2022 09:18:15 -0400
Received: from mail3.swissbit.com (mail3.swissbit.com [176.95.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0543753A6C
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jun 2022 06:18:12 -0700 (PDT)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 3CFE5462FA7;
        Fri, 24 Jun 2022 15:18:11 +0200 (CEST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 2D0F4462F67;
        Fri, 24 Jun 2022 15:18:11 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Fri, 24 Jun 2022 15:18:11 +0200 (CEST)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Fri, 24 Jun
 2022 15:18:10 +0200
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.1118.009; Fri, 24 Jun 2022 15:18:10 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [PATCHv2] mmc-utils: Fix 4k sector size block count in FFU
Thread-Topic: [PATCHv2] mmc-utils: Fix 4k sector size block count in FFU
Thread-Index: AdiHzKkF75C3NmKTTRSsXIOfFip8FA==
Date:   Fri, 24 Jun 2022 13:18:10 +0000
Message-ID: <54477cf05b9148109996dd85c9afc30f@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.44]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-26974.007
X-TMASE-Result: 10-3.181000-10.000000
X-TMASE-MatchedRID: h20DFeLkM8/ApTjLoiwjs/7FEhWgo0y82FA7wK9mP9eBC3MCELqzqBOC
        3iCulpIK9GF0M6TbxPxoVBGpf4JXIy/7QU2czuUNA9lly13c/gFMVCcj56k8hrs3Yh2IOCYzw91
        kHJhEaErPJCbjMogt5c3PpbmzIRlJoYfhbcru7VUapIb9znReA5HcXE2JOFJtmyiLZetSf8kTGR
        upINaDD3YJEUfDojP/ec3QM3secWbtgR74NJNnSQxWM4xMbzeCA9obXDAkXfykwHgU0o+eC21P8
        8aFfSWPlExlQIQeRG0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 80411e39-a363-401d-85ed-af13fed5f0ee-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

FFU used the wrong assumption, that CMD23 work in
4k sector chunks when setting the block count.
Instead the CMD23 block count argument just needs
to be a multiple of 8, which the fw_size is anyway.

Fixes: 89cd01ed865a (mmc_utils: add ffu support)
Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 mmc_cmds.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index bb0f022..12b7802 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2768,7 +2768,6 @@ int do_ffu(int nargs, char **argv)
 	ssize_t chunk_size;
 	char *device;
 	struct mmc_ioc_multi_cmd *multi_cmd = NULL;
-	__u32 blocks = 1;
 
 	if (nargs != 3) {
 		fprintf(stderr, "Usage: ffu <image name> </path/to/mmcblkX> \n");
@@ -2826,15 +2825,13 @@ int do_ffu(int nargs, char **argv)
 		goto out;
 	}
 
+	/* ensure fw is multiple of native sector size */
 	sect_size = (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] == 0) ? 512 : 4096;
 	if (fw_size % sect_size) {
 		fprintf(stderr, "Firmware data size (%jd) is not aligned!\n", (intmax_t)fw_size);
 		goto out;
 	}
 
-	/* calculate required fw blocks for CMD25 */
-	blocks = fw_size / sect_size;
-
 	/* set CMD ARG */
 	arg = ext_csd[EXT_CSD_FFU_ARG_0] |
 		ext_csd[EXT_CSD_FFU_ARG_1] << 8 |
@@ -2857,13 +2854,17 @@ int do_ffu(int nargs, char **argv)
 
 	/* send block count */
 	multi_cmd->cmds[1].opcode = MMC_SET_BLOCK_COUNT;
-	multi_cmd->cmds[1].arg = blocks;
+	multi_cmd->cmds[1].arg = fw_size / 512;
 	multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
 
 	/* send image chunk */
 	multi_cmd->cmds[2].opcode = MMC_WRITE_MULTIPLE_BLOCK;
-	multi_cmd->cmds[2].blksz = sect_size;
-	multi_cmd->cmds[2].blocks = blocks;
+	/*
+	 * blksz and blocks essentially do not matter, as long as the product
+	 * is fw_size, but some hosts don't handle larger blksz well.
+	 */
+	multi_cmd->cmds[2].blksz = 512;
+	multi_cmd->cmds[2].blocks = fw_size / 512;
 	multi_cmd->cmds[2].arg = arg;
 	multi_cmd->cmds[2].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
 	multi_cmd->cmds[2].write_flag = 1;
-- 
2.36.1

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

