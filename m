From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/4] mmc: tmio: remove obsolete TMIO_BBS
Date: Fri, 30 Jun 2017 12:56:46 +0200
Message-ID: <20170630105649.16137-2-wsa+renesas@sang-engineering.com>
References: <20170630105649.16137-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:34637 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752368AbdF3K5P (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 30 Jun 2017 06:57:15 -0400
In-Reply-To: <20170630105649.16137-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Since commit 10c7fcbd0f00a0 ("ARM: shmobile: sh7372: Remove ZBOOT
MMC/SDHI support"), this define is not needed anymore.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 2479f8e12faf5e..b161dfadfec25d 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -87,8 +87,6 @@
 #define CARD_OPT_WIDTH8		BIT(13)
 #define CARD_OPT_WIDTH		BIT(15)
 
-#define TMIO_BBS		512		/* Boot block size */
-
 /* Definitions for values the CTL_SDIO_STATUS register can take */
 #define TMIO_SDIO_STAT_IOIRQ	0x0001
 #define TMIO_SDIO_STAT_EXPUB52	0x4000
-- 
2.11.0

