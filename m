From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH mmc-utils 6/6] mmc-utils: remove unused #includes
Date: Thu, 21 Dec 2017 14:33:16 +0100
Message-ID: <20171221133316.19466-7-u.kleine-koenig@pengutronix.de>
References: <20171221133316.19466-1-u.kleine-koenig@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:40169 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751808AbdLUNwK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Dec 2017 08:52:10 -0500
In-Reply-To: <20171221133316.19466-1-u.kleine-koenig@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc@vger.kernel.org, kernel@pengutronix.de

I didn't find any functions used for which the documentation specifies to
use (at least) one of the dropped headers.

The only Linux specific header <linux/fs.h> is needed for BLKGETSIZE,
document that.
---
 mmc_cmds.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index cec947da1d4a..038dbd42e6bf 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -22,17 +22,13 @@
 #include <string.h>
 #include <sys/ioctl.h>
 #include <sys/types.h>
-#include <dirent.h>
 #include <sys/stat.h>
 #include <unistd.h>
 #include <fcntl.h>
-#include <libgen.h>
-#include <limits.h>
-#include <ctype.h>
 #include <errno.h>
 #include <stdint.h>
 #include <assert.h>
-#include <linux/fs.h>
+#include <linux/fs.h> /* for BLKGETSIZE */
 
 #include "mmc.h"
 #include "mmc_cmds.h"
-- 
2.15.1

