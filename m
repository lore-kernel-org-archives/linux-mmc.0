From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH mmc-utils 5/6] mmc-utils: move offsetof from mmc.h to only user
Date: Thu, 21 Dec 2017 14:33:15 +0100
Message-ID: <20171221133316.19466-6-u.kleine-koenig@pengutronix.de>
References: <20171221133316.19466-1-u.kleine-koenig@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47947 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752998AbdLUNwK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Dec 2017 08:52:10 -0500
In-Reply-To: <20171221133316.19466-1-u.kleine-koenig@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc@vger.kernel.org, kernel@pengutronix.de

offsetof isn't mmc specific, so remove it from mmc.h. As there is only a single user
define it there.
---
 mmc.h      | 4 ----
 mmc_cmds.c | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/mmc.h b/mmc.h
index d01a55f18805..285c1f1c9423 100644
--- a/mmc.h
+++ b/mmc.h
@@ -19,10 +19,6 @@
 
 #include <linux/mmc/ioctl.h>
 
-#ifndef offsetof
-#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
-#endif
-
 /* From kernel linux/major.h */
 #define MMC_BLOCK_MAJOR			179
 
diff --git a/mmc_cmds.c b/mmc_cmds.c
index f1c70fb5fe55..cec947da1d4a 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -38,6 +38,10 @@
 #include "mmc_cmds.h"
 #include "3rdparty/hmac_sha/hmac_sha2.h"
 
+#ifndef offsetof
+#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
+#endif
+
 #define WP_BLKS_PER_QUERY 32
 
 #define USER_WP_PERM_PSWD_DIS	0x80
-- 
2.15.1

