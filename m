From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH mmc-utils 4/6] mmc-utils: expand .gitignore
Date: Thu, 21 Dec 2017 14:33:14 +0100
Message-ID: <20171221133316.19466-5-u.kleine-koenig@pengutronix.de>
References: <20171221133316.19466-1-u.kleine-koenig@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51643 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753127AbdLUNwK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Dec 2017 08:52:10 -0500
In-Reply-To: <20171221133316.19466-1-u.kleine-koenig@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc@vger.kernel.org, kernel@pengutronix.de

Instead of adding .o and .o.d files for the files that are not
explicitly mentioned, add a pattern matching also all future files of
these types. This makes git status stop to mention

	3rdparty/hmac_sha/.hmac_sha2.o.d
	3rdparty/hmac_sha/.sha2.o.d
	3rdparty/hmac_sha/hmac_sha2.o
	3rdparty/hmac_sha/sha2.o
	.lsmmc.o.d
	lsmmc.o
---
 .gitignore | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/.gitignore b/.gitignore
index 5a94d4731f72..2a0cb3034cdb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,5 +1,3 @@
-.mmc.o.d
-.mmc_cmds.o.d
-mmc
-mmc.o
-mmc_cmds.o
+.*.o.d
+*.o
+/mmc
-- 
2.15.1

