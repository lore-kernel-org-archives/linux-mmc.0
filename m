Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190D9C001B0
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jun 2023 10:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjFYKjM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 25 Jun 2023 06:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjFYKjL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Jun 2023 06:39:11 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5340EE46
        for <linux-mmc@vger.kernel.org>; Sun, 25 Jun 2023 03:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687689545; x=1719225545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dDNFcDZZ+TK/O446jyxYdu4diRUG5fN1WskB4PdK1GQ=;
  b=UjAItU+86isl5cHisJRTR2NAHMaGRCMOomxR/huc0/wp+qorHvkEYq/0
   QvLdYyMXZ2H3TnrozuGT+wxebgD6AmewCT7xpjTuCDlqQrSkcj4ZYv1yL
   CXS/TeWvZC3dPbf1hu6ncyexZY9MkAylPaHTmD3umINg31MARY9NVKhIm
   QCZBfEzrgVyfAxOdnqxFjzqhjXXT4KoWkIKK3+LuvcYANX9kQlQJCvVWF
   ctoI1l3Uoi3WlXkMorv2qhzeCCJuOz9vkj4OWL4gqbEBPEBEfvt6E19w0
   uBNUuF/KxYPWy/F1EpKwwmJYdfTtbZjP1B4ZPt0/r4u7q2dtprll95yuX
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,157,1684771200"; 
   d="scan'208";a="348334278"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2023 18:39:05 +0800
IronPort-SDR: F6IN0F4URqPEfkr7kYBUFUKEBgRU/jVTFc6OHtS6gHEoHp8WAzxB+oO7nz9zTiScng/z6HdqW6
 pqgUBP3jG4EkWgUGWWQcwXkPpTpbkJYeNXInhRIcyO8cKG4jdCWe6we09aAmRSjlbiI0EnUCKa
 5cUdkXHHdtpe1Oz3AcuJKB/9auAc3f/JGWw49NqFOTV5Yx/P35GoSTBN14KlYNiIrnctj2MsHP
 /Krekt/CTpvsunRVWJpNYp1RafKlgyzynpNw2myJvwqQ3yI6U8w7ZoVI7KnDYWUnTrYXvVF2hD
 +xI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2023 02:53:27 -0700
IronPort-SDR: qqYhXHlPsYLPL/Thfx9l1lZ//0K/TVkp8Oj67Mc9d4mFBXOK8Tw0cKJc/s1mrZtdQj+9ngyXUT
 rAkRaa2QapO2veYSj26fOBQF9N2OE/8gXXjeSUcdh/i+6rrPsJQYhdAN0X11UsU8rQZMbhKma5
 jXNSgnBkES/C5t4TJ0qpws9FRcZ9TQSrnxTWMxN2WPKZLTqGJXPQRblTYevfdgETcdUYndl+Qe
 buv58mt2Q2+u8z5aI1xBMtyN8yo3Y8KZx+jfJEEsW0xIAxRe5fpZR1fzI8LP3/KWGV0scI2KI1
 dqY=
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jun 2023 03:39:05 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 4/6] mmc-utils: ffu: Add ffu multi-command set handler
Date:   Sun, 25 Jun 2023 13:38:12 +0300
Message-Id: <20230625103814.105-5-avri.altman@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230625103814.105-1-avri.altman@wdc.com>
References: <20230625103814.105-1-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In preparation of sending the fw image in several chunks.
While at it, make use of set_single_cmd() to preapare CMD23 and CMD25.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 mmc_cmds.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index adb72af..0321118 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2803,6 +2803,26 @@ out:
 	return ret;
 }
 
+static void set_ffu_single_cmd(struct mmc_ioc_multi_cmd *multi_cmd,
+			       __u8 *ext_csd, unsigned int bytes, __u8 *buf,
+			       off_t offset)
+{
+	__u32 arg = htole32(*((__u32 *)&ext_csd[EXT_CSD_FFU_ARG_0]));
+
+	/* send block count */
+	set_single_cmd(&multi_cmd->cmds[1], MMC_SET_BLOCK_COUNT, 0, 0,
+		       bytes / 512);
+	multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+
+	/*
+	 * send image chunk: blksz and blocks essentially do not matter, as
+	 * long as the product is fw_size, but some hosts don't handle larger
+	 * blksz well.
+	 */
+	set_single_cmd(&multi_cmd->cmds[2], MMC_WRITE_MULTIPLE_BLOCK, 1,
+		       bytes / 512, arg);
+	mmc_ioc_cmd_set_data(multi_cmd->cmds[2], buf + offset);
+}
 
 int do_ffu(int nargs, char **argv)
 {
@@ -2811,7 +2831,6 @@ int do_ffu(int nargs, char **argv)
 	unsigned int sect_size;
 	__u8 ext_csd[512];
 	__u8 *buf = NULL;
-	__u32 arg;
 	off_t fw_size;
 	char *device;
 	struct mmc_ioc_multi_cmd *multi_cmd = NULL;
@@ -2879,35 +2898,15 @@ int do_ffu(int nargs, char **argv)
 		goto out;
 	}
 
-	/* set CMD ARG */
-	arg = htole32(*((__u32 *)&ext_csd[EXT_CSD_FFU_ARG_0]));
-
 	/* prepare multi_cmd for FFU based on cmd to be used */
 
-	/* prepare multi_cmd to be sent */
 	multi_cmd->num_of_cmds = 4;
 
 	/* put device into ffu mode */
 	fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG,
 			EXT_CSD_FFU_MODE);
 
-	/* send block count */
-	multi_cmd->cmds[1].opcode = MMC_SET_BLOCK_COUNT;
-	multi_cmd->cmds[1].arg = fw_size / 512;
-	multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
-
-	/* send image chunk */
-	multi_cmd->cmds[2].opcode = MMC_WRITE_MULTIPLE_BLOCK;
-	/*
-	 * blksz and blocks essentially do not matter, as long as the product
-	 * is fw_size, but some hosts don't handle larger blksz well.
-	 */
-	multi_cmd->cmds[2].blksz = 512;
-	multi_cmd->cmds[2].blocks = fw_size / 512;
-	multi_cmd->cmds[2].arg = arg;
-	multi_cmd->cmds[2].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
-	multi_cmd->cmds[2].write_flag = 1;
-	mmc_ioc_cmd_set_data(multi_cmd->cmds[2], buf);
+	set_ffu_single_cmd(multi_cmd, ext_csd, fw_size, buf, 0);
 
 	/* return device into normal mode */
 	fill_switch_cmd(&multi_cmd->cmds[3], EXT_CSD_MODE_CONFIG,
-- 
2.40.1

