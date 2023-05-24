Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9ADC7EE2C
	for <linux-mmc@archiver.kernel.org>; Wed, 24 May 2023 08:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240411AbjEXInI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 May 2023 04:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240266AbjEXIml (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 May 2023 04:42:41 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5CD132
        for <linux-mmc@vger.kernel.org>; Wed, 24 May 2023 01:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684917759; x=1716453759;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N9Qu0sSgAf0y91Ee/hBammYaVWjN4tjJJaJjqHVd0jE=;
  b=dNeMHrRgFYFyAxq1wIeBXXajXtLH2Ofd43LUBKVk3SP5kYlxMLZY/CKz
   xn2BqVr2GmdVmtc5VDOZTdowA64N9mBm7H2oS7GXIVlicWMcxMzKHvUmR
   Qvxzv+NfAX4hQ6vBFA7GQ6pg+iSf53RGtij0RnQTrXPg9iYISwbc5dtoy
   K+kbyw8ByYeuEfahcA3lOEPCxBYaOP1gh2/HnW1WOlup3j30BnSMBSNaA
   moOiJ73nvCXspMs7BFAOLNt8a2hCp05pgl6oVz+AL3gE55StRdtik5PyE
   H+UNumF4lpNYAYWGOMDaRsaD2guL+gz4sN27Da5JGghEr/NSv7nRyxAaJ
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,188,1681142400"; 
   d="scan'208";a="231446763"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 May 2023 16:42:39 +0800
IronPort-SDR: Si7ilcIJCbc3HOA/3xmrN5K0KbvPkiRuRX4lol14ji89toCCoauOsaxRr8U0wj6iDa6UQQizV4
 tfNtMx4YV8o7t/uHV5sPaRTX3/ExXolfg5BXAytwNRMolXS6cOrBWL6Zi5POf0hwR9wP0fahI3
 eWm4iPRpVf8FChpcpSujkLIoX4dFTlRF7+eRaObyoIVaNjUC+y20q1E1YRyXV3r+i8OSvNvjy/
 kUNAX1EDYDBqqo9eRemWRKu1QQaakJjQkX7fWzjhyfLvLIb0UowhQWd1OBKVMTZwaFgvl3YevE
 7Wk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 May 2023 00:51:58 -0700
IronPort-SDR: TRdC6P7r6jCZ6452DlQr870ls2Ti46KpZ9lXKuuw1hY4r0DfydL/EOLz8KsqqCqBtvv08vsYSj
 3wYTvr+G5ROiYV+djUujSJTWRMjip0lLVSbZpunlNMsQXtan4BsJppGOSVNZNn0U6RMCXzi8jU
 ZOUHhVetcU+/Sh3hPoUpTF9LgAGcyWb8p7DqwAYyV1M2OOf22bVznPcIpGQ3OxJiEVPWYH0pvk
 pcL4C82Y+Bcz/3DiMdQZKPlxj5WhrQ//6mMKlW8lP++JIwtUeV9zA84qToY8FaB7O1X8+hcblN
 ip0=
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 May 2023 01:42:37 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>
Subject: [PATCH] mmc-utils: Assert MMC_IOC_MULTI_CMD in compile time
Date:   Wed, 24 May 2023 11:42:24 +0300
Message-Id: <20230524084224.558-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Notify of mult-ioctl violation during preprocessing instead of bailing
out in runtime.  Would not even allow bogus copies of mmc-utils binaries
wondering about out there.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 mmc_cmds.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index df66986..a4819ab 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2113,9 +2113,7 @@ static int do_rpmb_op(int fd,
 					  unsigned int out_cnt)
 {
 #ifndef MMC_IOC_MULTI_CMD
-	fprintf(stderr, "mmc-utils has been compiled without MMC_IOC_MULTI_CMD"
-		" support, needed by RPMB operation.\n");
-	exit(1);
+#error "mmc-utils needs MMC_IOC_MULTI_CMD support"
 #else
 	int err;
 	u_int16_t rpmb_type;
@@ -2805,9 +2803,7 @@ out:
 int do_ffu(int nargs, char **argv)
 {
 #ifndef MMC_IOC_MULTI_CMD
-	fprintf(stderr, "mmc-utils has been compiled without MMC_IOC_MULTI_CMD"
-			" support, needed by FFU.\n");
-	exit(1);
+#error "mmc-utils needs MMC_IOC_MULTI_CMD support"
 #else
 	int dev_fd, img_fd;
 	int sect_done = 0, retry = 3, ret = -EINVAL;
-- 
2.40.0

