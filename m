Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AF9C54EE9
	for <linux-mmc@archiver.kernel.org>; Sun, 18 Sep 2022 12:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiIRMRp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 18 Sep 2022 08:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIRMRn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Sep 2022 08:17:43 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 18 Sep 2022 05:17:40 PDT
Received: from smtpcmd10101.aruba.it (smtpcmd10101.aruba.it [62.149.156.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FDE11D0E2
        for <linux-mmc@vger.kernel.org>; Sun, 18 Sep 2022 05:17:40 -0700 (PDT)
Received: from localhost.localdomain ([146.241.46.240])
        by Aruba Outgoing Smtp  with ESMTPSA
        id ZtDyo2GoAeVWJZtDyoUqzh; Sun, 18 Sep 2022 14:16:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1663503398; bh=E3zz/WuGnklhyPeOUiCtYz9MvAMfAaGTWHklbehytXI=;
        h=From:To:Subject:Date:MIME-Version;
        b=CHAgtA/5g3v8M8AQAoICpsjIz4FLiZ8UjdbTLHnAjWUdDtwoK4cYxS1N9fEUZw1AS
         QV/RdZu9ml405ZqssK5vsDLvZv+8z2SLZVfzu7s4BzrB/q/SR4o17t6xXlAY0zJCAo
         K7lvCWPLWIjX33kDMaUpPGiTpoJe/8K4xVa0SlGdIoM1tDL9pJrxUefytzPiEmfYIb
         TOZ/lPiAguFnIrlkSIKO6zPqGMcBriMIRGmos84Hk0IBWi8IoEaAGep+et0ma0nNK/
         VscX3xIrM38ldcjYapi4U4n2aPgFUucIF6a4/8Rp5Kbx+acmOk1Yol638u752b3dNC
         1YpRndtYRJf7A==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH] mmc_cmds.c: fix warning on uninitialized 'cnt'
Date:   Sun, 18 Sep 2022 14:16:37 +0200
Message-Id: <20220918121637.1101135-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLF0JDdhi/2xvHQUFsv/vsYNE4gWEIod1lrjPrjV+Ym+GNrSpNEwEqzuZg9JquFe/An8SJOR0WY3flexKJP7v54+8BmjXdrYJIgZKICUE5RhbRgKnAb4
 tw3NT5Tu2MDASA5M2t/a+fnSjxtmlXQkyfag2DCTCJrASG9XN0YXuTWjsdAWclYpCC+drAArwH9/98E6uqKG4MmCdxCzsb6HlEwRl42Y7EjezaWXIgtGJtmg
 h3AHdvp0FsEeUH3mdPb1Cn1s2rrrhPx89NPDfPqDrt3gnzlcEKx/kwKfDDVqQjSa
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Since -Werror is enabled by default build fails with:
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
So let's fix the warning by initializing cnt local variable.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 mmc_cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 12b7802..777d649 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2436,7 +2436,7 @@ int do_rpmb_write_block(int nargs, char **argv)
 	int ret, dev_fd, key_fd, data_fd;
 	unsigned char key[32];
 	uint16_t addr;
-	unsigned int cnt;
+	unsigned int cnt = 0;
 	struct rpmb_frame frame_in = {
 		.req_resp    = htobe16(MMC_RPMB_WRITE),
 		.block_count = htobe16(1)
-- 
2.34.1

