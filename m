From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] mmc: sh_mmcif: remove some cruft
Date: Mon,  5 Feb 2018 14:28:22 +0100
Message-ID: <20180205132822.14529-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:60968 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752316AbeBEN2b (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 5 Feb 2018 08:28:31 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>

The TODO section from 2010 is obsolete. We have DMA and PM meanwhile and
we always want to handle errors better, if possible. Also DRIVER_VERSION
is not used anymore these days.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/sh_mmcif.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 7bb00c68a7561a..4c2a1f8ddbf324 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -7,13 +7,6 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License.
- *
- *
- * TODO
- *  1. DMA
- *  2. Power management
- *  3. Handle MMC errors better
- *
  */
 
 /*
@@ -67,7 +60,6 @@
 #include <linux/module.h>
 
 #define DRIVER_NAME	"sh_mmcif"
-#define DRIVER_VERSION	"2010-04-28"
 
 /* CE_CMD_SET */
 #define CMD_MASK		0x3f000000
-- 
2.11.0

