Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCBDEB64DD
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jun 2023 10:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjFYKjQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 25 Jun 2023 06:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjFYKjP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Jun 2023 06:39:15 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A870CE44
        for <linux-mmc@vger.kernel.org>; Sun, 25 Jun 2023 03:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687689554; x=1719225554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KNgCFGINjqnl5pO21kpxt1eMm28/6BzGbKhBD4WEPrI=;
  b=ct2pGnX8H86SrOchT2S8W8fVktzIyB3ZZsC8Lv91Gzuly8A3RppV1CJK
   h7TpEMnd49sA5QS3+aYvuOU/YIW0c7NbE46Yfqm/MUY4D+mCi7Ak2htmw
   lbpXbGd6hS5DdnMu9H9eIUtEsiS6cbpyg+L7I/iet+ljIGPeuyOMgfBDW
   k7QgIdsNm/qOMgZLRdZy67gBcpQUZl29OtVQ5U1wItFbDpceL3JU/GE6w
   PO/CGzAc4E8pnvc7lD67xQD/G/ehZbqQDl/oWCiMyCPU+qWwcx4zTE2Kz
   5apY4k1vXJGdcBpED7/Zs0Qzg64GilPDW8LbcGaMzKNpS2z9+OPNXF548
   w==;
X-IronPort-AV: E=Sophos;i="6.01,157,1684771200"; 
   d="scan'208";a="236798744"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2023 18:39:13 +0800
IronPort-SDR: YWvtwt6kPQtF45EXvLJs1NX/Fa/5ZvocYbAwIMww/jZjYEVIxp0VqqSeTN0bfiuR89ztLhHG+/
 Phn4dlafgRpekRxXt3b1F4f8kuGIeojbxVhOk/y91DmRrjetQMuk1sDSSgKADFi0wRERumIShx
 QAZe2Wk+UH9cfABu7iCNtxwyOhHp8BG3USWbP78xcOiHC8yGq9du9lWnHTqLkFeGxAauylUlvq
 IP4MWtq0XU5YzWOWqpqipBn6NL6yccaoZEnBGOxhayr2+jEI25rfux6Xb/Tj42jjXCUHPE94j2
 Blo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2023 02:47:54 -0700
IronPort-SDR: A4IyB2U6v0kxhKlsNMC4f6ZkYPRncEE5U6fLV3MDpSG+0CXX0s2ZcSCy8jd2ikrfvfV8aPxgmx
 ixQVIERrfTuTskNHT2VpIdR5eHBDT/JpuqhIJFUCmvEP9pjddvy9l7lcW2CCQykjq3/yCxnqhM
 Xz14tk+P05Qpw2B2MFNJOWxo7ova+fABqL/YY4GSWaM1ybUcz+3R5YFAftPRFtTeU2AEXDl8Ji
 GsL/Eh7mp3FpjgEzkTex6aG6yD20c3Qqa0+SdplLkCa10WCFtqe2JKVEki7nNCrA3/wxBVBi8D
 DMk=
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jun 2023 03:39:12 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>,
        Lund Austin <Austin.Lund@garmin.com>
Subject: [PATCH 5/6] mmc-utils: ffu: Allow ffu of large images
Date:   Sun, 25 Jun 2023 13:38:13 +0300
Message-Id: <20230625103814.105-6-avri.altman@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230625103814.105-1-avri.altman@wdc.com>
References: <20230625103814.105-1-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

ffu is done using a single multi-ioctl to carry the entire firmware
image. This is limiting the fw image size to be at most 512KB, as the
mmc driver restricts each single ioc data to be at most
MMC_IOC_MAX_BYTES.

the spec however, allows the fw image to be written using multiple write
commands.

To overcome this limitation, if the fw image is larger than 512KB,
split it into a series of 512KB chunks.

fixes: 1b8b13beb424 (mmc-utils: let FFU mode use CMD23 and CMD25)
Reported-by: Lund Austin <Austin.Lund@garmin.com>
Tested-by: Lund Austin <Austin.Lund@garmin.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 mmc_cmds.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 0321118..a1adbde 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2831,7 +2831,7 @@ int do_ffu(int nargs, char **argv)
 	unsigned int sect_size;
 	__u8 ext_csd[512];
 	__u8 *buf = NULL;
-	off_t fw_size;
+	off_t fw_size, bytes_left, off;
 	char *device;
 	struct mmc_ioc_multi_cmd *multi_cmd = NULL;
 
@@ -2877,7 +2877,7 @@ int do_ffu(int nargs, char **argv)
 	}
 
 	fw_size = lseek(img_fd, 0, SEEK_END);
-	if (fw_size > MMC_IOC_MAX_BYTES || fw_size == 0) {
+	if (fw_size == 0) {
 		fprintf(stderr, "Wrong firmware size");
 		goto out;
 	}
@@ -2906,8 +2906,6 @@ int do_ffu(int nargs, char **argv)
 	fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG,
 			EXT_CSD_FFU_MODE);
 
-	set_ffu_single_cmd(multi_cmd, ext_csd, fw_size, buf, 0);
-
 	/* return device into normal mode */
 	fill_switch_cmd(&multi_cmd->cmds[3], EXT_CSD_MODE_CONFIG,
 			EXT_CSD_NORMAL_MODE);
@@ -2921,14 +2919,30 @@ int do_ffu(int nargs, char **argv)
 	}
 
 do_retry:
-	/* send ioctl with multi-cmd */
-	ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
+	bytes_left = fw_size;
+	off = 0;
+	while (bytes_left) {
+		unsigned int chunk_size = bytes_left < MMC_IOC_MAX_BYTES ?
+					  bytes_left : MMC_IOC_MAX_BYTES;
 
-	if (ret) {
-		perror("Multi-cmd ioctl");
-		/* In case multi-cmd ioctl failed before exiting from ffu mode */
-		ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
-		goto out;
+		/* prepare multi_cmd for FFU based on cmd to be used */
+		set_ffu_single_cmd(multi_cmd, ext_csd, chunk_size, buf, off);
+
+		/* send ioctl with multi-cmd */
+		ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
+
+		if (ret) {
+			perror("Multi-cmd ioctl");
+			/*
+			 * In case multi-cmd ioctl failed before exiting from
+			 * ffu mode
+			 */
+			ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
+			goto out;
+		}
+
+		bytes_left -= chunk_size;
+		off += chunk_size;
 	}
 
 	/*
-- 
2.40.1

