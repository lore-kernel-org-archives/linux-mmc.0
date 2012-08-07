From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH 1/4] mmc: bfin_sdh: limit mmc DMA segment len to 1 for bf518.
Date: Tue, 7 Aug 2012 11:10:12 +0800
Message-ID: <1344309015-13248-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe006.messaging.microsoft.com ([216.32.180.189]:41092
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932447Ab2HGDBI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Aug 2012 23:01:08 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Bob Liu <liubbo@gmail.com>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

bf518 RSI dma doesn't work in array mode.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/mmc/host/bfin_sdh.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
index 0366617..fd25b0c 100644
--- a/drivers/mmc/host/bfin_sdh.c
+++ b/drivers/mmc/host/bfin_sdh.c
@@ -469,7 +469,11 @@ static int __devinit sdh_probe(struct platform_device *pdev)
 	}
 
 	mmc->ops = &sdh_ops;
+#if defined(CONFIG_BF54x)
 	mmc->max_segs = 32;
+#elif defined(CONFIG_BF51x)
+	mmc->max_segs = 1;
+#endif
 	mmc->max_seg_size = 1 << 16;
 	mmc->max_blk_size = 1 << 11;
 	mmc->max_blk_count = 1 << 11;
-- 
1.7.0.4


