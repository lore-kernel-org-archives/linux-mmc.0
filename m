From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH 2/5 v2] mmc: bfin_sdh: Move descriptor array structure into blackfin dma.h head file.
Date: Thu, 14 Jun 2012 17:22:20 +0800
Message-ID: <1339665743-7947-2-git-send-email-sonic.adi@gmail.com>
References: <1339665743-7947-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:22206
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755400Ab2FNJ0S (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jun 2012 05:26:18 -0400
In-Reply-To: <1339665743-7947-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

The descriptor array is common among all blackfin dma channels.
Depends on commit b5affb0147cee0ea05d909396f8e389092729236

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/mmc/host/bfin_sdh.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
index fd25b0c..56a1093 100644
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


