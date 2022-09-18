Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827B0C32771
	for <linux-mmc@archiver.kernel.org>; Sun, 18 Sep 2022 16:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiIRQR5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 18 Sep 2022 12:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIRQR4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Sep 2022 12:17:56 -0400
Received: from smtpcmd10101.aruba.it (smtpcmd10101.aruba.it [62.149.156.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A452A1ADB4
        for <linux-mmc@vger.kernel.org>; Sun, 18 Sep 2022 09:17:54 -0700 (PDT)
Received: from localhost.localdomain ([146.241.46.240])
        by Aruba Outgoing Smtp  with ESMTPSA
        id ZwzQo9TDweVWJZwzQoW2S3; Sun, 18 Sep 2022 18:17:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1663517873; bh=S9T3fQuMmtcrQsLLtAG39YqR4ypZte6/Zew+weuzGIU=;
        h=From:To:Subject:Date:MIME-Version;
        b=Bi8r6AFPjMVlXz9iG9VPDDMZa9jj4COihV38ZQZ8YS31SApvzxuWnI+OyxC0JYLj7
         g7tMEGaxHOtCfHMdfR3SPqJzf+KGXNjfdVM72cgEGDN3cEmOmtIFbE2aYg+Od5N1ok
         mi+2t2Vpige2eJvhdOJa3H3XTif2ys7GiC+3c8QGqDXS4EWclhaOhtwiWhI4z4lETs
         xOntasFKtsl2tpJUN2p4SC4rLSelPYE6bQ7sA+4zFezvS8FU4NvdYvcE1+mLeREGVB
         T26mkPPoX0Q/lORyJZj/BXJGc2xUroUoV9wtQK1TVXjMNZ16qy/ySIE3w8JKLv8zoN
         FYuEpF8Ne87ww==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     Avri Altman <Avri.Altman@wdc.com>, Arnd Bergmann <arnd@arndb.de>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH v3] mmc-utils: fix warning on uninitialized 'cnt'
Date:   Sun, 18 Sep 2022 18:17:51 +0200
Message-Id: <20220918161751.1132590-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <21dc5b78-c0e9-4664-83f9-1a6cbe76159f@www.fastmail.com>
References: <21dc5b78-c0e9-4664-83f9-1a6cbe76159f@www.fastmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDJM91uwQuw1OCER+XZMGr2YZM/fBKUYNx+HFIXMNPLcHFhEINTIM5sQVkq9stWtAspRPOlp8GzyffCyt9syiBPhrjnG85WRY2/ygV/nrGdEgDKRzsaN
 GaUC/ZiHGBYmTLhzM6TyaUSK60NUZQLHwV3fn6V2aQ8l7llmxWHwmKy6lcMjKHvjaDyRnP+WrXt5oEzNc2WGSlAxBrJxXK5TtM05MsUZdfXXCb24qeHLpgr8
 bAC6hJ2wyAn3lAzrwlYPOnPU7mjJpbzKVxhZhp3Ku7BWNTky8xJ/e9jyt2XcOIbTuZA9Jw4XYTq5NfRh5fX+YHaj3bUSZP/lvEtOq1ON5+8=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When building following warning shows up:
```
In function '__bswap_32',
    inlined from 'do_rpmb_write_block' at mmc_cmds.c:2293:27:
/home/autobuild/autobuild/instance-15/output-1/host/aarch64-buildroot-linux-gnu/sysroot/usr/include/bits/byteswap.h:52:10: error: 'cnt' may be used uninitialized [-Werror=maybe-uninitialized]
   52 |   return __builtin_bswap32 (__bsx);
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~
mmc_cmds.c: In function 'do_rpmb_write_block':
mmc_cmds.c:2270:22: note: 'cnt' was declared here
2270 |         unsigned int cnt;
      |                      ^~~
cc1: all warnings being treated as errors
```
This is due to function rpmb_read_counter() that doesn't set its
argument 'unsigned int *cnt' in all return points. So let's set
*cnt to 0 in the return point that misses to initialize it.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
V1->V2:
* prefix subject with 'mmc-utils:' as pointed by Avri Altman
V2->V3:
* add missing commit as pointed by Avri Altman
* initialize pointer inside rpmb_read_counter() as suggested by Arnd Bergmann
---
 mmc_cmds.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 12b7802..4d203ef 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2238,8 +2238,10 @@ int rpmb_read_counter(int dev_fd, unsigned int *cnt)
 	}
 
 	/* Check RPMB response */
-	if (frame_out.result != 0)
+	if (frame_out.result != 0) {
+		*cnt = 0;
 		return be16toh(frame_out.result);
+	}
 
 	*cnt = be32toh(frame_out.write_counter);
 
-- 
2.34.1

