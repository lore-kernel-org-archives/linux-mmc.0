Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FECC43334
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Jun 2022 09:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbiFVJlh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Jun 2022 05:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350562AbiFVJld (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jun 2022 05:41:33 -0400
Received: from mail3.swissbit.com (mail3.swissbit.com [176.95.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118AB39B8B
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jun 2022 02:41:31 -0700 (PDT)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 24BA4462F3F;
        Wed, 22 Jun 2022 11:41:27 +0200 (CEST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 15CAC462D2F;
        Wed, 22 Jun 2022 11:41:27 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Wed, 22 Jun 2022 11:41:27 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 22 Jun
 2022 11:41:26 +0200
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 22 Jun
 2022 11:41:26 +0200
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.1118.009; Wed, 22 Jun 2022 11:41:26 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [PATCH] mmc-utils: dont divide CMD23 count by sector size
Thread-Topic: [PATCH] mmc-utils: dont divide CMD23 count by sector size
Thread-Index: AdiGG5pmW471gNuQTayLmad2s/EH8Q==
Date:   Wed, 22 Jun 2022 09:41:26 +0000
Message-ID: <1b5d40da9b8948dc8e8f1b90ef75baab@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.44]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-26970.005
X-TMASE-Result: 10-2.574000-10.000000
X-TMASE-MatchedRID: zdfKSpJbRLhPTly3n9bADN9JA2lmQRNUcV3n4J/0zUN7YhuCO/3iFSOV
        sz0LL9wGIvrftAIhWmLy9zcRSkKatUPu4/hW5W83Ss47mbT7SASu+ZyFqtd5FQE3IOP2oHsonzG
        rpysaH8BsQpY62QYCy29yZj3aufb5aDAi8sBNMoFqHXONfTwSQsRB0bsfrpPIx1FPlNAAmcBDAA
        DK5NrUR9zIpaOlXMDS/aoxDQuz0vi9K1jK9k1lpvqy+VVvqH2X
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: db38d67d-9264-4a6a-bc1b-62f542d7c2e6-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

FFU used to divide the fw_size by native sector size.
If native sector size is 4K the accesses need to be aligned
and a multiple of 4K, other than that CMD23 SET_BLOCK_COUNT
does not change.

The previous handling lead to MMC_SET_BLOCK_COUNT setting
a too small block count for the FFU fw_size.
While at it also correct CMD25 blksz and blocks fields
to reflect the actual transfer.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 mmc_cmds.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index bb0f022..048a0af 100644
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
@@ -2857,13 +2854,13 @@ int do_ffu(int nargs, char **argv)
 
 	/* send block count */
 	multi_cmd->cmds[1].opcode = MMC_SET_BLOCK_COUNT;
-	multi_cmd->cmds[1].arg = blocks;
+	multi_cmd->cmds[1].arg = fw_size;
 	multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
 
 	/* send image chunk */
 	multi_cmd->cmds[2].opcode = MMC_WRITE_MULTIPLE_BLOCK;
-	multi_cmd->cmds[2].blksz = sect_size;
-	multi_cmd->cmds[2].blocks = blocks;
+	multi_cmd->cmds[2].blksz = fw_size;
+	multi_cmd->cmds[2].blocks = 1;
 	multi_cmd->cmds[2].arg = arg;
 	multi_cmd->cmds[2].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
 	multi_cmd->cmds[2].write_flag = 1;
-- 
2.36.1
Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

