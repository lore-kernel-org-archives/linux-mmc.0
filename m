From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH] mmc: bfin_sdh: Move descriptor array structure into blackfin dma.h head file.
Date: Thu, 19 Jan 2012 14:50:04 +0800
Message-ID: <1326955804-31470-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:27711
	"EHLO AM1EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752396Ab2ASHFD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2012 02:05:03 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
Cc: uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

The descriptor array is common among all blackfin dma channels.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/mmc/host/bfin_sdh.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
index 97182ca..c0090af 100644
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
1.7.0.4


