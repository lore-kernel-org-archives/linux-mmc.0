Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B3FC7EE2E
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Jun 2023 08:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241411AbjFIIfm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Jun 2023 04:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240625AbjFIIej (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jun 2023 04:34:39 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D9CE2
        for <linux-mmc@vger.kernel.org>; Fri,  9 Jun 2023 01:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686299675; x=1717835675;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o5n4MgIrIiRyTdJPIwyM67pw4uDI4CDCkKlyG6hFQfY=;
  b=Lct7OgCa0+3jFGOkcuSmfYcOdxfYIXAuEtACBq4r5EtQzIAB+nl5AAzJ
   cE9ueXSWlDl/zsEcbN1UszYd/vPJWlpVd8UI7oaGVQQt+4eVoxSun5Qvp
   u6/774lygZRY7jDQb6xziQgjF+vyYvdJ4s2q9GyOW7I9Uc6a/oeeYkMTJ
   cV6jqY6cDQz774N0hSxCWss3f1+vdbocVwyyeWD87Zn5TNpGLvzFsPa5X
   jLK0Fis0X6vnrLavCT3gWPuNdWdvjtFS2zxtnIv9lLBNV8I90EHD4LjYE
   Gbw5GVDzIWC4EtZmyVK2jpn2NZ4DocUmrvMRUx3OboBhZG4fGoqhyN/sJ
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,228,1681142400"; 
   d="scan'208";a="234504439"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2023 16:34:34 +0800
IronPort-SDR: mFXoNALG+CoUdq+1M6O8P5DOzFHDoSIfzG2DXerlIqHd27RLal2ZoPVBkekjiUUWcneKvaYOle
 zp/F3CLYhJ8anFXckVAGJ2p4YpDM3ZP3vamFh3+wfR1bAT9d+GtS5C+twihUYoyPSRNN12jRWW
 AwaQLxJ9eIRZ2AFhQUjaNQtwI9W0puyhRdDapcblqhrjUnY7HzpN8BJHDqGtWU1CxAh3A6N6kP
 YqYIgwwc7ONTw+tD4Tw997T/AmOrpwIEQG2HBXlBv2luq/+eJJcUPCLiMJWv91jk8J+6NKYygj
 HcM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jun 2023 00:49:15 -0700
IronPort-SDR: MLx2yOTaiTrPNe43hZmldEdZxfoFE1Rzl64JtFNBHXmfeTgQ367gktFUwDkxMqvs8ev5UbRtyy
 NobcMaimwWV0MgBoAdg6wuC+OFbKFy4qZJq3NZM/pLrGmszm912J3/IaGFmkCqeZv8S5wD+3g7
 Rs+fyhDr9ggf4Himy94A+weYwPqmp28tok8qEI+JjSyOSeRoW1YPJ9AA8OUrMi3IU83lAdyAST
 JxSUWo7diAhn1CS7WtWNwSJbvOrdP69w2bZfUxxBmDiNzi20A5poNp2Me/eBSf+tHBLdewJYsF
 Qvs=
WDCIronportException: Internal
Received: from 5cg9473214.ad.shared (HELO BXYGM33.ad.shared) ([10.225.33.249])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Jun 2023 01:34:33 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2] mmc-utils: Assert MMC_IOC_MULTI_CMD in compile time
Date:   Fri,  9 Jun 2023 11:34:25 +0300
Message-Id: <20230609083425.765-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

v1 -> v2: Address Ulf's suggestions

Notify of mult-ioctl violation during preprocessing instead of bailing
out in runtime.  Would not even allow bogus copies of mmc-utils binaries
wondering about out there.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 mmc_cmds.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index df66986..26bdc38 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -34,6 +34,10 @@
 #include "mmc_cmds.h"
 #include "3rdparty/hmac_sha/hmac_sha2.h"
 
+#ifndef MMC_IOC_MULTI_CMD
+#error "mmc-utils needs MMC_IOC_MULTI_CMD support (added in kernel v4.4)"
+#endif
+
 #ifndef offsetof
 #define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
 #endif
@@ -2112,11 +2116,6 @@ static int do_rpmb_op(int fd,
 					  struct rpmb_frame *frame_out,
 					  unsigned int out_cnt)
 {
-#ifndef MMC_IOC_MULTI_CMD
-	fprintf(stderr, "mmc-utils has been compiled without MMC_IOC_MULTI_CMD"
-		" support, needed by RPMB operation.\n");
-	exit(1);
-#else
 	int err;
 	u_int16_t rpmb_type;
 	struct mmc_ioc_multi_cmd *mioc;
@@ -2196,7 +2195,6 @@ static int do_rpmb_op(int fd,
 out:
 	free(mioc);
 	return err;
-#endif /* !MMC_IOC_MULTI_CMD */
 }
 
 int do_rpmb_write_key(int nargs, char **argv)
@@ -2804,11 +2802,6 @@ out:
 
 int do_ffu(int nargs, char **argv)
 {
-#ifndef MMC_IOC_MULTI_CMD
-	fprintf(stderr, "mmc-utils has been compiled without MMC_IOC_MULTI_CMD"
-			" support, needed by FFU.\n");
-	exit(1);
-#else
 	int dev_fd, img_fd;
 	int sect_done = 0, retry = 3, ret = -EINVAL;
 	unsigned int sect_size;
@@ -3034,7 +3027,6 @@ out:
 	close(img_fd);
 	close(dev_fd);
 	return ret;
-#endif
 }
 
 int do_general_cmd_read(int nargs, char **argv)
-- 
2.40.0

