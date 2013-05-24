From: Oleg Matcovschi <olegm@lab126.com>
Subject: [PATCH 1/2] mmc-utils: Remove dependency on linux/major.h.
Date: Thu, 23 May 2013 17:11:06 -0700
Message-ID: <1369354267-18632-1-git-send-email-olegm@lab126.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:56747 "EHLO
	smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757551Ab3EXALl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 May 2013 20:11:41 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: Oleg Matcovschi <olegm@lab126.com>

We require only MMC_BLOCK_MAJOR which is constant.

Signed-off-by: Oleg Matcovschi <olegm@lab126.com>
---
 mmc.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/mmc.h b/mmc.h
index c863751..48a221c 100644
--- a/mmc.h
+++ b/mmc.h
@@ -16,11 +16,13 @@
 
 #include <asm-generic/int-ll64.h>
 #include <linux/mmc/ioctl.h>
-#include <linux/major.h>
 #include <stdio.h>
 
 #define CHECK(expr, msg, err_stmt) { if (expr) { fprintf(stderr, msg); err_stmt; } }
 
+/* From kernel linux/major.h */
+#define MMC_BLOCK_MAJOR			179
+
 /* From kernel linux/mmc/mmc.h */
 #define MMC_SWITCH		6	/* ac	[31:0] See below	R1b */
 #define MMC_SEND_EXT_CSD	8	/* adtc				R1  */
-- 
1.7.4.1

