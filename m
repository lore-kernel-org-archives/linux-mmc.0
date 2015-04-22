From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH] mmc-utils: change .gitignore file to hide temporal files in sub folders
Date: Wed, 22 Apr 2015 20:42:24 +0300
Message-ID: <1429724545-3174-2-git-send-email-leon@leon.nu>
References: <1429724545-3174-1-git-send-email-leon@leon.nu>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:33464 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbbDVRmd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Apr 2015 13:42:33 -0400
Received: by wgin8 with SMTP id n8so254335389wgi.0
        for <linux-mmc@vger.kernel.org>; Wed, 22 Apr 2015 10:42:32 -0700 (PDT)
In-Reply-To: <1429724545-3174-1-git-send-email-leon@leon.nu>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net
Cc: linux-mmc@vger.kernel.org, Leon Romanovsky <leon@leon.nu>

Signed-off-by: Leon Romanovsky <leon@leon.nu
Signed-off-by: Leon Romanovsky <leon@leon.nu>
---
 .gitignore |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/.gitignore b/.gitignore
index 5a94d47..f95fc99 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,5 +1,3 @@
-.mmc.o.d
-.mmc_cmds.o.d
+*.o
+.*.o.*
 mmc
-mmc.o
-mmc_cmds.o
-- 
1.7.9.5

