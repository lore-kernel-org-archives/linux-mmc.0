From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [RESEND 3/7] mmc: omap: Remove duplicate host->irq assignment
Date: Sat, 22 Feb 2014 18:01:39 +0200
Message-ID: <1393084903-7194-4-git-send-email-jarkko.nikula@bitmer.com>
References: <1393084903-7194-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1393084903-7194-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-mmc@vger.kernel.org

host-irq is set twice so remove needless one.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/mmc/host/omap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 927ed24d0708..b438f0addb3c 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1375,7 +1375,6 @@ static int mmc_omap_probe(struct platform_device *pdev)
 	host->mem_res = res;
 	host->irq = irq;
 	host->use_dma = 1;
-	host->irq = irq;
 	host->phys_base = host->mem_res->start;
 	host->virt_base = ioremap(res->start, resource_size(res));
 	if (!host->virt_base)
-- 
1.8.5.3

