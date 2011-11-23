From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: sh_mmcif: simplify clock divisor calculation
Date: Wed, 23 Nov 2011 15:52:30 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1111231551100.5635@axis700.grange>
References: <1321473366-31053-1-git-send-email-andreiw@vmware.com>
 <20111117150549.15528e81.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20111117150549.15528e81.akpm@linux-foundation.org>
Sender: linux-sh-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrei Warkentin <andreiw@vmware.com>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Replace ilog2(__rounddown_pow_of_two(x)) with the equivalent but much
simpler fls(x) - 1.

Reported-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index c021482..824fee5 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -16,6 +16,7 @@
  *
  */
 
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
@@ -386,7 +387,7 @@ static void sh_mmcif_clock_control(struct sh_mmcif_host *host, unsigned int clk)
 		sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL, CLK_SUP_PCLK);
 	else
 		sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL, CLK_CLEAR &
-			(ilog2(__rounddown_pow_of_two(host->clk / clk)) << 16));
+				((fls(host->clk / clk) - 1) << 16));
 
 	sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL, CLK_ENABLE);
 }
-- 
1.7.2.5

