Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05400E7E635
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Sep 2023 13:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbjIZNLl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Sep 2023 09:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbjIZNLj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Sep 2023 09:11:39 -0400
Received: from smtpcmd0756.aruba.it (smtpcmd0756.aruba.it [62.149.156.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5755FC9
        for <linux-mmc@vger.kernel.org>; Tue, 26 Sep 2023 06:11:32 -0700 (PDT)
Received: from localhost.localdomain ([146.241.127.78])
        by Aruba Outgoing Smtp  with ESMTPSA
        id l7qbqH345pIihl7qcqJZmv; Tue, 26 Sep 2023 15:11:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1695733890; bh=yFFvuerJuQhHARx0KMqMXYfIH3clCQ5I2JAE7vC0m64=;
        h=From:To:Subject:Date:MIME-Version:Content-Type;
        b=DK49E+A8UYxkJ9KNHQH9ctS8R5Fz41j3R0iGCj8CB68jw/5UJyKN5VJEKCryMFJGQ
         kKtq/K4VtvHTS7xP9PLn1Tiu68DibiW5+8NBhHnBjxl+773HNRP10Vmd61CrrR3yYD
         KvRo2C0H/sLwbyRi5jYVtcWjqL4eB6dqqg/tTMg8/jnsxI9lFP7WB1TdZws08kivjv
         5nT/7CJfDTFV4k0JK1QaqjNu5HBfaNxJLFlP1qBgjbUnyBFTOWvY1YLMZkooSAWwuD
         l1XdFS0Ui6QOJfiCqO+p9+srGqTjJArZ4OTb4MBHH6Nl2TnaONxOpjVf3re8r4aGGT
         Aw1Tfaygw7YIg==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     linux-mmc@vger.kernel.org,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH v2] mmc-utils: fix potential overflow
Date:   Tue, 26 Sep 2023 15:11:28 +0200
Message-Id: <20230926131128.3771508-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAQJF7KOwOZxJpELjGP7UACEBO4uNhAzyWYT90JmmhQF0GUHnfjhYX4Z6e7NHWxwoeDIKke5qO1OPFdw/LMmjVB+PTv9nW/dN2ycutU5jhPddAciGn5j
 2uHjZgBkhufDw2YS7vztrBbB0fK0rvY38GJYxORzz6hxDAHnaPM2SI1oAjJfNIztMoJGVte6ILoZ+cvZxAkuszw8GI21K1pKUGk6JPGwaIFjeRARv8lr2WRs
 lFjwCKgYihc4N0RvepkINI+XtJfbkWUj7nUS2rq4ul7YTnmtysF3hzsZi2NPNFyD2xRtwMDr8xpP9XkhPzwGXQ==
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Building with _FORTIFY_SOURCE=3 results in:
                 from mmc_cmds.c:20:
In function ‘read’,
    inlined from ‘do_rpmb_write_key’ at mmc_cmds.c:2233:8:
/home/giuliobenetti/br_reproduce/a53922c5db3e605a5e81e53c034f45017ebb7db7/output/host/mipsel-buildroot-linux-gnu/sysroot/usr/include/bits/unistd.h:38:10: error: ‘__read_alias’ writing 228 or more bytes into a region of size 32 overflows the destination [-Werror=stringop-overflow=]
   38 |   return __glibc_fortify (read, __nbytes, sizeof (char),
      |          ^~~~~~~~~~~~~~~
mmc_cmds.c: In function ‘do_rpmb_write_key’:
mmc_cmds.c:2087:19: note: destination object ‘key_mac’ of size 32
 2087 |         u_int8_t  key_mac[32];
      |                   ^~~~~~~
/home/giuliobenetti/br_reproduce/a53922c5db3e605a5e81e53c034f45017ebb7db7/output/host/mipsel-buildroot-linux-gnu/sysroot/usr/include/bits/unistd.h:26:16: note: in a call to function ‘__read_alias’ declared with attribute ‘access (write_only, 2, 3)’
   26 | extern ssize_t __REDIRECT (__read_alias, (int __fd, void *__buf,
      |                ^~~~~~~~~~

To work around this let's check if the return of read() is lower than
the nbyte requested instead of not equal.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
V1->V2:
* corrected commit log
---
 mmc_cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 10d063d..ae7b876 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2065,7 +2065,7 @@ int do_sanitize(int nargs, char **argv)
 			}										\
 			else if (r > 0)							\
 				ret += r;							\
-		} while (r != 0 && (size_t)ret != nbyte);	\
+		} while (r != 0 && (size_t)ret < nbyte);	\
 													\
 		ret;										\
 	})
-- 
2.34.1

