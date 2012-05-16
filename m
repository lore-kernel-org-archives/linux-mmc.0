From: <sonic.zhang@analog.com>
Subject: [PATCH 1/5] mmc: bfin_sdh: limit mmc DMA segment len to 1 for bf518.
Date: Wed, 16 May 2012 15:50:33 +0800
Message-ID: <1337154637-11724-1-git-send-email-sonic.zhang@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>
List-Id: linux-mmc@vger.kernel.org

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
