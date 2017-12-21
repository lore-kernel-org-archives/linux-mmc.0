From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH mmc-utils 2/6] mmc-utils: drop unused header
Date: Thu, 21 Dec 2017 14:33:12 +0100
Message-ID: <20171221133316.19466-3-u.kleine-koenig@pengutronix.de>
References: <20171221133316.19466-1-u.kleine-koenig@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48553 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753137AbdLUNwL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Dec 2017 08:52:11 -0500
In-Reply-To: <20171221133316.19466-1-u.kleine-koenig@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc@vger.kernel.org, kernel@pengutronix.de

---
 mmc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mmc.h b/mmc.h
index 4beb4fd1a819..d01a55f18805 100644
--- a/mmc.h
+++ b/mmc.h
@@ -17,7 +17,6 @@
  * those modifications are Copyright (c) 2016 SanDisk Corp.
  */
 
-#include <asm-generic/int-ll64.h>
 #include <linux/mmc/ioctl.h>
 
 #ifndef offsetof
-- 
2.15.1

