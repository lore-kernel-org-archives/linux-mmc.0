Return-Path: <SRS0=WFPw=3U=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844E7C33CB2
	for <linux-mmc@archiver.kernel.org>; Fri, 31 Jan 2020 03:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093112082E
	for <linux-mmc@archiver.kernel.org>; Fri, 31 Jan 2020 03:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Cs7/HSdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgAaDZo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 30 Jan 2020 22:25:44 -0500
Received: from condef-05.nifty.com ([202.248.20.70]:52561 "EHLO
        condef-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbgAaDZo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Jan 2020 22:25:44 -0500
Received: from conuserg-07.nifty.com ([10.126.8.70])by condef-05.nifty.com with ESMTP id 00V3LxWk027184
        for <linux-mmc@vger.kernel.org>; Fri, 31 Jan 2020 12:21:59 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 00V3KKVL029358;
        Fri, 31 Jan 2020 12:20:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 00V3KKVL029358
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1580440821;
        bh=eFZjQTAM4Jf1Oa2IWLxB9egp2D2IZfHWDyrvqr4Dwn4=;
        h=From:To:Cc:Subject:Date:From;
        b=Cs7/HSdC+LIgm0BDF2g8TX8jiYT6gfaJtaun9myEL7xlAEzcURyseputtFPBE1EGf
         giECg1mlGgAnBUnwLvm9MwGIMFd7LrKuyVX74nF0D6qyUXtgheAHlVQO1aUnTglSOh
         2cuPKeAfpM0cyQUIPQcEmuvsgbR0dDweWB2kSojefnX7AienVQdQ7TSVQi0meQC6N4
         v2L/YlPIDnz69YrVYyONd1uRojZNrj6i0kZwMt/DurWbGA7nfG3FHXhqG5uc79axN8
         cFKQmG93HdcTk1E53Ok9yUZCdmRjxFMgaMM8gKxShyUQ1m6WNsPIVwvMwZcUXlzBJ4
         CICiplJVFqjxw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Avri Altman <avri.altman@wdc.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ming Lei <ming.lei@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Zachary Hays <zhays@lexmark.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: make ext_csd dump more human-readable
Date:   Fri, 31 Jan 2020 12:20:08 +0900
Message-Id: <20200131032008.21354-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The current ext_csd in the debugfs shows 1024 chars in one line,
which is unreadable at least for humans (but perhaps it could be
handier if somebody is processing it by a tool).

This commit makes the output format more human-readable; shows 8 byte
in each line, with address in the left-most column:

  0: 00 00 00 00 00 00 00 00
  8: 00 00 00 00 00 00 00 00
 16: 01 01 00 c0 6a 02 00 00
 24: 00 00 00 00 00 00 00 00
 32: 00 01 01 00 00 00 00 00
     <snip>
496: 05 00 03 01 20 3c 01 01
504: 01 00 00 00 00 00 00 00

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/core/block.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 663d87924e5e..79044b3cbd84 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2728,8 +2728,8 @@ static int mmc_dbg_card_status_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(mmc_dbg_card_status_fops, mmc_dbg_card_status_get,
 			 NULL, "%08llx\n");
 
-/* That is two digits * 512 + 1 for newline */
-#define EXT_CSD_STR_LEN 1025
+/* 3 chars (2 digits + space) for each byte, 5 additional chars for each line */
+#define EXT_CSD_STR_LEN		(512 * 3 + 512 / 8 * 5)
 
 static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
 {
@@ -2740,7 +2740,7 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
 	char *buf;
 	ssize_t n = 0;
 	u8 *ext_csd;
-	int err, i;
+	int err, i, j;
 
 	buf = kmalloc(EXT_CSD_STR_LEN + 1, GFP_KERNEL);
 	if (!buf)
@@ -2762,9 +2762,12 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
 		goto out_free;
 	}
 
-	for (i = 0; i < 512; i++)
-		n += sprintf(buf + n, "%02x", ext_csd[i]);
-	n += sprintf(buf + n, "\n");
+	for (i = 0; i < 512; i += 8) {
+		n += sprintf(buf + n, "%3d:", i);
+		for (j = i; j < i + 8; j++)
+			n += sprintf(buf + n, " %02x", ext_csd[j]);
+		n += sprintf(buf + n, "\n");
+	}
 
 	if (n != EXT_CSD_STR_LEN) {
 		err = -EINVAL;
-- 
2.17.1

