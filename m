Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980BBE7D242
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Sep 2023 07:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjIZHQi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Sep 2023 03:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjIZHQh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Sep 2023 03:16:37 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Sep 2023 00:16:30 PDT
Received: from smtpcmd01-g.aruba.it (smtpcmd01-g.aruba.it [62.149.158.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5227AFF
        for <linux-mmc@vger.kernel.org>; Tue, 26 Sep 2023 00:16:30 -0700 (PDT)
Received: from localhost.localdomain ([146.241.127.78])
        by Aruba Outgoing Smtp  with ESMTPSA
        id l2I2qCEHD4eZZl2I2qUW84; Tue, 26 Sep 2023 09:15:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1695712526; bh=OExhW2DgjmeiaHG/jb9dsLA8Whjyqh4y9yQrv2YMLzM=;
        h=From:To:Subject:Date:MIME-Version:Content-Type;
        b=emjADryJhcpQhTfxQXFpNIzrSALOlGS1EA1LjZSb2N0BNJ44YY9NgHvHl+ugc8ZId
         0lSLLTIRDDUQghnJriovPtHXBVpfn2y/u61x8j21gS4WHFsrxJFVtFqmKBoqbFXlO6
         U7voT+2q+HZSZ7XThie2c1K7vRgAJKbZfUOc39LPt5jaj66SgZuZMD7dOnU+a1Id6V
         AYUBertD846f3Soz8ET1eOhfp5KY0vNvs2kpJN3JmymTym9Kr784Qyin0rkpTSrntn
         G+6yIxhi2oaWJ7BmHNuc3EEgL095E9ICaUzqbS4NlZ8+hYbZ+XtJ5NRSHvUpKD5LqI
         MdksTP//e6Fgg==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH] mmc-utils: fix potential overflow
Date:   Tue, 26 Sep 2023 09:15:24 +0200
Message-Id: <20230926071524.3638706-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAFl05mLTrFUCtBOy7psjaOOqlCxS8AR0owtY/CsCQM0wsIgpo49h+79I5mYz4k3ODwnC+xUa+rqR0HQ2J3Zi0L7YdOtfQbWcok0SdPnJkyyp1H3fQ6c
 H6HHip0Mtu2GvifsBZsyowLhUgVvEBNRkUnfxewntcAtEFoIFFZzeJPE+CMRhHEAd/zq3batuDghUHasrCGYmDI8oLwKqfs5V/P8ZxicnEsiXNV4kfJKIctr
 3id21rLAV8TWZ0fCWvbo2Nc9zA0t+zPX+4LoUO6KN4s57wzrvvSNq2cSoEfAE59r
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

With fortify enabled gcc throws following error:
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

read() could potentially return more than nbyte so let's check for
ret < nbyte.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
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

