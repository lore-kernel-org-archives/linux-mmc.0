From: Bob Liu <lliubbo@gmail.com>
Subject: [PATCH] drivers: mmc: bfin_sdh: fix build error
Date: Mon, 30 Jul 2012 15:03:02 +0800
Message-ID: <1343631782-24207-1-git-send-email-lliubbo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:33033
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753189Ab2G3HCo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jul 2012 03:02:44 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: adrian.hunter@intel.com, ludovic.desroches@atmel.com, rmk+kernel@arm.linux.org.uk, g.liakhovetski@gmx.de, cjb@laptop.org, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>, Bob Liu <lliubbo@gmail.com>

From: Sonic Zhang <sonic.zhang@analog.com>

Descriptor array structure has been moved into blackfin dma.h head file.
This patch fix below error:

drivers/mmc/host/bfin_sdh.c:52:8: error: redefinition of 'struct
dma_desc_array'
make[4]: *** [drivers/mmc/host/bfin_sdh.o] Error 1

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Bob Liu <lliubbo@gmail.com>
---
 drivers/mmc/host/bfin_sdh.c |   13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
index 0366617..a17dd73 100644
--- a/drivers/mmc/host/bfin_sdh.c
+++ b/drivers/mmc/host/bfin_sdh.c
@@ -49,13 +49,6 @@
 #define bfin_write_SDH_CFG		bfin_write_RSI_CFG
 #endif
 
-struct dma_desc_array {
-	unsigned long	start_addr;
-	unsigned short	cfg;
-	unsigned short	x_count;
-	short		x_modify;
-} __packed;
-
 struct sdh_host {
 	struct mmc_host		*mmc;
 	spinlock_t		lock;
-- 
1.7.9.5

