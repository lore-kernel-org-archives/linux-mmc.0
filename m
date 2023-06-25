Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA7BEB64DC
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jun 2023 10:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjFYKie (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 25 Jun 2023 06:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjFYKic (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Jun 2023 06:38:32 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7544FE44
        for <linux-mmc@vger.kernel.org>; Sun, 25 Jun 2023 03:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687689512; x=1719225512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MS+iE3tmGZDg6oxTGv/Nw5+qXdl+a4OOoBrBlUJwlcc=;
  b=mlpMAiBtzbsNxCp5p4XUQ9fB/J/7bVviCkb7bmhXeo5TrmYCbH1fjusu
   Fqia7E40tx0Yd+KKUPmWBqdLRMWgHV8JkBWuGCtMXoOxy8srfrFFvLT/S
   C/n7mOFqI3uKw1cjNSYDzRXrjjZDjlZkd7ZpYj/92Ex8gdoWt7x005q2j
   1gwu9tj7vEo7blRrGwOQV9zfLVNEcIeTBvEr6Vs0jteea5gINStbG+Jgp
   BZ+N24y7RR7y/pYQwN23lPSpsVFEpuh5TEsIr3T0BJ6t8QEW0ZKcMxQt5
   vRUrHQ1UhCnxIFlxUHwIfcJufG8JVVUGjJwjN8LwKZW7wDhrkCqfACTpK
   A==;
X-IronPort-AV: E=Sophos;i="6.01,157,1684771200"; 
   d="scan'208";a="236159312"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2023 18:38:32 +0800
IronPort-SDR: U8SxvUUfj3LJnIfhuH7mIfKgMkBLDKW/POQ6dp8GR9k8AGnOP0JEsD01YDcvBqSYWMUgmAP4Lr
 5zgh8tdSIKa5jjJ2pGYsP+5Q3c12VqRY95LzVFIN1uqsII/PXPvmM7SotRD6yXTSUPsZQJAu4j
 1qXTO43j6wtW39zg6hldLPrHZTLYI2cN8JvwqZiLhcKcWMu1wNatN4zRX1wEDTNgg/n7rmte3l
 lnzb3iw966pkesO/lFxUrSwkrwqLDHJSRH9/QVHNjWqOk7Mk8Vzq8J7ZZEc/fywxN1QTGZidUa
 exo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2023 02:47:12 -0700
IronPort-SDR: YQZo9Cme1VeUGrAzwDdCpbY4ffW9dblMU56n7npGwLMDV4gpB9ptUMAmGb75kNLGqBURhBcT8Y
 9VLiWie+rUjaX3H8Y1fnuk+WqBvsaDZnPJkKzgwYdMqnbtcDgyj0+mgKKYwA/c7LzhowGOH3X6
 /aWYw0w5Gwde9b1nFFIvC4SPdMKd4xVFuDMzJdFeAJssymBXvNs8hiJPCDdMZPJ4Gt2LAyZP6+
 zyvL9Z/OW1Yid8zX5cdkE5dvti4dHybwztG+Y3BER+gALveZr/I1Gh5UvpsycEKlySNwkdoqUx
 +6U=
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jun 2023 03:38:31 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 1/6] mmc-utils: Add fill_switch_cmd handler
Date:   Sun, 25 Jun 2023 13:38:09 +0300
Message-Id: <20230625103814.105-2-avri.altman@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230625103814.105-1-avri.altman@wdc.com>
References: <20230625103814.105-1-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Writing the ext_csd (MMC_SWITCH) is done in several places throught the
code.  Prepare a single handler for that.

This patch has no functional change.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 mmc_cmds.c | 50 ++++++++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 26bdc38..da89724 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -79,19 +79,22 @@ int read_extcsd(int fd, __u8 *ext_csd)
 	return ret;
 }
 
+static void fill_switch_cmd(struct mmc_ioc_cmd *cmd, __u8 index, __u8 value)
+{
+	cmd->opcode = MMC_SWITCH;
+	cmd->write_flag = 1;
+	cmd->arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) | (index << 16) |
+		   (value << 8) | EXT_CSD_CMD_SET_NORMAL;
+	cmd->flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+}
+
 int write_extcsd_value(int fd, __u8 index, __u8 value, unsigned int timeout_ms)
 {
 	int ret = 0;
-	struct mmc_ioc_cmd idata;
+	struct mmc_ioc_cmd idata = {};
+
+	fill_switch_cmd(&idata, index, value);
 
-	memset(&idata, 0, sizeof(idata));
-	idata.write_flag = 1;
-	idata.opcode = MMC_SWITCH;
-	idata.arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
-			(index << 16) |
-			(value << 8) |
-			EXT_CSD_CMD_SET_NORMAL;
-	idata.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
 	/* Kernel will set cmd_timeout_ms if 0 is set */
 	idata.cmd_timeout_ms = timeout_ms;
 
@@ -2887,13 +2890,8 @@ int do_ffu(int nargs, char **argv)
 	multi_cmd->num_of_cmds = 4;
 
 	/* put device into ffu mode */
-	multi_cmd->cmds[0].opcode = MMC_SWITCH;
-	multi_cmd->cmds[0].arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
-			(EXT_CSD_MODE_CONFIG << 16) |
-			(EXT_CSD_FFU_MODE << 8) |
-			EXT_CSD_CMD_SET_NORMAL;
-	multi_cmd->cmds[0].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
-	multi_cmd->cmds[0].write_flag = 1;
+	fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG,
+			EXT_CSD_FFU_MODE);
 
 	/* send block count */
 	multi_cmd->cmds[1].opcode = MMC_SET_BLOCK_COUNT;
@@ -2914,13 +2912,8 @@ int do_ffu(int nargs, char **argv)
 	mmc_ioc_cmd_set_data(multi_cmd->cmds[2], buf);
 
 	/* return device into normal mode */
-	multi_cmd->cmds[3].opcode = MMC_SWITCH;
-	multi_cmd->cmds[3].arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
-			(EXT_CSD_MODE_CONFIG << 16) |
-			(EXT_CSD_NORMAL_MODE << 8) |
-			EXT_CSD_CMD_SET_NORMAL;
-	multi_cmd->cmds[3].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
-	multi_cmd->cmds[3].write_flag = 1;
+	fill_switch_cmd(&multi_cmd->cmds[3], EXT_CSD_MODE_CONFIG,
+			EXT_CSD_NORMAL_MODE);
 
 	/* read firmware */
 	lseek(img_fd, 0, SEEK_SET);
@@ -2986,15 +2979,8 @@ do_retry:
 	multi_cmd->num_of_cmds = 2;
 
 	/* set ext_csd to install mode */
-	multi_cmd->cmds[1].opcode = MMC_SWITCH;
-	multi_cmd->cmds[1].blksz = 0;
-	multi_cmd->cmds[1].blocks = 0;
-	multi_cmd->cmds[1].arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
-			(EXT_CSD_MODE_OPERATION_CODES << 16) |
-			(EXT_CSD_FFU_INSTALL << 8) |
-			EXT_CSD_CMD_SET_NORMAL;
-	multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
-	multi_cmd->cmds[1].write_flag = 1;
+	fill_switch_cmd(&multi_cmd->cmds[1], EXT_CSD_MODE_OPERATION_CODES,
+			EXT_CSD_FFU_INSTALL);
 
 	/* send ioctl with multi-cmd */
 	ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
-- 
2.40.1

