From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 09/10] mmc: mvsdio: Cleanup mmc-mvsdio.h header
Date: Tue, 25 Feb 2014 15:18:27 +0530
Message-ID: <1393321708-9719-9-git-send-email-sachin.kamat@linaro.org>
References: <1393321708-9719-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:54312 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbaBYJyc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Feb 2014 04:54:32 -0500
Received: by mail-pa0-f50.google.com with SMTP id kp14so7903553pab.37
        for <linux-mmc@vger.kernel.org>; Tue, 25 Feb 2014 01:54:31 -0800 (PST)
In-Reply-To: <1393321708-9719-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, sachin.kamat@linaro.org

Commit c02cecb92ed4 ("ARM: orion: move platform_data definitions")
moved the file to the current location but forgot to remove the pointer
to its previous location. Clean it up. While at it also change the header
file protection macros appropriately.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 include/linux/platform_data/mmc-mvsdio.h |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/platform_data/mmc-mvsdio.h b/include/linux/platform_data/mmc-mvsdio.h
index 1190efedcb94..d02704cd3695 100644
--- a/include/linux/platform_data/mmc-mvsdio.h
+++ b/include/linux/platform_data/mmc-mvsdio.h
@@ -1,13 +1,11 @@
 /*
- * arch/arm/plat-orion/include/plat/mvsdio.h
- *
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
 
-#ifndef __MACH_MVSDIO_H
-#define __MACH_MVSDIO_H
+#ifndef __MMC_MVSDIO_H
+#define __MMC_MVSDIO_H
 
 #include <linux/mbus.h>
 
-- 
1.7.9.5

