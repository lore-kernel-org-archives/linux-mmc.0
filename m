Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D73EB64DC
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jun 2023 10:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjFYKin (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 25 Jun 2023 06:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjFYKil (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Jun 2023 06:38:41 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCBCE44
        for <linux-mmc@vger.kernel.org>; Sun, 25 Jun 2023 03:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687689521; x=1719225521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MWJLiWUXbMwqaIOfCZ1EtBsphwfasQAQddP1C9KPvTI=;
  b=kV5vml3XpSXSzNSfYUt6rZqIhcULGvRKJi4yEfp5H+lNbFMIBp34mQi3
   pSn/hlGWiWaMqMTN4vwvfWYfKKhDapydnfABLF0vS8JmyzU6tZ97u3b3q
   AyTzT1i2u3hBKfbxmt62XJ/CqeYQ8MlhiZ2SM//EepoHfB24PvvVu7jqe
   c99fW7/L/TloxtcRjHPTICbxQDiod0E/nqGoGQ5JfSDw5Emfw9qcR487g
   H0Es7ywYpiPD+0sRVp0FjDrVQ75PnrCxIXKwMn4ukKKgl5wvkgQ2pW7Ib
   J/TLS7fzSNIs+y9fQkfyMdB+5K69rcWzR1mPaYPdC5XK6h/LFmpBvKlMf
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,157,1684771200"; 
   d="scan'208";a="236159314"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2023 18:38:41 +0800
IronPort-SDR: miFaXqsed8E/gttjPitGYcAENVgS5ysu5TqD9pgKyP7rGjkE2oO026E6HOeWnEyBqaT4tvrTga
 seu0zlIaigWz51VUnM1HQvOlDnIIUHctkxoQKN2eQgJ6CfNf5+a5fuzmbVfO0zevPSsDPn0pTn
 6OcFr3bj5wshhzZdrsQBLDfz6qa2BLPPvAvCMC9CqmAIUNHDy/T4uD0/TyGndbRaQKtqknVciG
 gpY4MQB2l1SSuRi4/pcf9Z7aF4MCKQsXf6KTgUvHb5eYYJrcK0AzdvoyAamD49et8U/uuP1ce8
 Vos=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2023 02:47:21 -0700
IronPort-SDR: BEGS0jaXdn1IY73vxj+57h9Ma2hLPvSIz8euCfzIsteWA4j4EoPhj99SQOyuSPjXoIQb8+4nAD
 cEX2LWSNHrwil7Y8bjIas07rQ8UUaQqgx9sF+iyA0gonpRFFewTU+M49tNyAhif0nrx1Qnbp+V
 Gu4l9K5gfeGlH73lvoU1TTUfotMhcIo4kO7tH+zyKR3wVTiJ94VbzUBIbSq0lOuvWVvptWQGSD
 yNUTIQDP/+Tj3l8sLufhb9AbTBSQZsXNdGHrA/Dijv4Q49+rcq6dUCokebuQxI+E/+HLXeZdtY
 6Y4=
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jun 2023 03:38:40 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 2/6] mmc-utils: Add arg argument to set_single_cmd
Date:   Sun, 25 Jun 2023 13:38:10 +0300
Message-Id: <20230625103814.105-3-avri.altman@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230625103814.105-1-avri.altman@wdc.com>
References: <20230625103814.105-1-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Will prove itself useful in a minute.
No functional change.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 mmc_cmds.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index da89724..8650c2f 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2095,11 +2095,12 @@ struct rpmb_frame {
 };
 
 static inline void set_single_cmd(struct mmc_ioc_cmd *ioc, __u32 opcode,
-				  int write_flag, unsigned int blocks)
+				  int write_flag, unsigned int blocks,
+				  __u32 arg)
 {
 	ioc->opcode = opcode;
 	ioc->write_flag = write_flag;
-	ioc->arg = 0x0;
+	ioc->arg = arg;
 	ioc->blksz = 512;
 	ioc->blocks = blocks;
 	ioc->flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
@@ -2152,18 +2153,18 @@ static int do_rpmb_op(int fd,
 
 		/* Write request */
 		ioc = &mioc->cmds[0];
-		set_single_cmd(ioc, MMC_WRITE_MULTIPLE_BLOCK, (1 << 31) | 1, 1);
+		set_single_cmd(ioc, MMC_WRITE_MULTIPLE_BLOCK, (1 << 31) | 1, 1, 0);
 		mmc_ioc_cmd_set_data((*ioc), frame_in);
 
 		/* Result request */
 		ioc = &mioc->cmds[1];
 		frame_status.req_resp = htobe16(MMC_RPMB_READ_RESP);
-		set_single_cmd(ioc, MMC_WRITE_MULTIPLE_BLOCK, 1, 1);
+		set_single_cmd(ioc, MMC_WRITE_MULTIPLE_BLOCK, 1, 1, 0);
 		mmc_ioc_cmd_set_data((*ioc), &frame_status);
 
 		/* Get response */
 		ioc = &mioc->cmds[2];
-		set_single_cmd(ioc, MMC_READ_MULTIPLE_BLOCK, 0, 1);
+		set_single_cmd(ioc, MMC_READ_MULTIPLE_BLOCK, 0, 1, 0);
 		mmc_ioc_cmd_set_data((*ioc), frame_out);
 
 		break;
@@ -2179,12 +2180,12 @@ static int do_rpmb_op(int fd,
 
 		/* Read request */
 		ioc = &mioc->cmds[0];
-		set_single_cmd(ioc, MMC_WRITE_MULTIPLE_BLOCK, 1, 1);
+		set_single_cmd(ioc, MMC_WRITE_MULTIPLE_BLOCK, 1, 1, 0);
 		mmc_ioc_cmd_set_data((*ioc), frame_in);
 
 		/* Get response */
 		ioc = &mioc->cmds[1];
-		set_single_cmd(ioc, MMC_READ_MULTIPLE_BLOCK, 0, out_cnt);
+		set_single_cmd(ioc, MMC_READ_MULTIPLE_BLOCK, 0, out_cnt, 0);
 		mmc_ioc_cmd_set_data((*ioc), frame_out);
 
 		break;
-- 
2.40.1

