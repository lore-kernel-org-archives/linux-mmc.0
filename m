From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH] mmc-utils: delete dependency files after make clean invocation
Date: Wed, 22 Apr 2015 20:42:25 +0300
Message-ID: <1429724545-3174-3-git-send-email-leon@leon.nu>
References: <1429724545-3174-1-git-send-email-leon@leon.nu>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34889 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbbDVRmf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Apr 2015 13:42:35 -0400
Received: by widdi4 with SMTP id di4so187007072wid.0
        for <linux-mmc@vger.kernel.org>; Wed, 22 Apr 2015 10:42:34 -0700 (PDT)
In-Reply-To: <1429724545-3174-1-git-send-email-leon@leon.nu>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net
Cc: linux-mmc@vger.kernel.org, Leon Romanovsky <leon@leon.nu>

Make clean didn't remove dependency files (.*.o.d) which were generated
by GCC. This change deletes these files in all sub folders.

Signed-off-by: Leon Romanovsky <leon@leon.nu>
---
 Makefile |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 0533be3..bef6c82 100644
--- a/Makefile
+++ b/Makefile
@@ -45,6 +45,7 @@ install-man:
 
 clean:
 	rm -f $(progs) $(objects)
+	find . -name .\*.o.d -type f -delete
 	$(MAKE) -C man clean
 
 install: $(progs) install-man
-- 
1.7.9.5

