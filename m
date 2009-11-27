From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 01/03] mmc: Let tmio-mmc use dev_name() with request_irq()
Date: Fri, 27 Nov 2009 14:00:05 +0900
Message-ID: <20091127050005.15251.64306.sendpatchset@rxone.opensource.se>
References: <20091127045956.15251.84958.sendpatchset@rxone.opensource.se>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751116AbZK0FFo@vger.kernel.org>
In-Reply-To: <20091127045956.15251.84958.sendpatchset@rxone.opensource.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, ian@mnementh.co.uk, lethal@linux-sh.org, philipp.zabel@gmail.com, Magnus Damm <magnus.damm@gmail.com>, pierre@ossman.eu
List-Id: linux-mmc@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This change improves the /proc/interrupts output so the
irq number can be mapped to platform device on boards
with multiple tmio_mmc instances.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/mmc/host/tmio_mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/drivers/mmc/host/tmio_mmc.c
+++ work/drivers/mmc/host/tmio_mmc.c	2009-11-26 18:58:08.000000000 +0900
@@ -582,7 +582,7 @@ static int __devinit tmio_mmc_probe(stru
 	disable_mmc_irqs(host, TMIO_MASK_ALL);
 
 	ret = request_irq(host->irq, tmio_mmc_irq, IRQF_DISABLED |
-		IRQF_TRIGGER_FALLING, "tmio-mmc", host);
+		IRQF_TRIGGER_FALLING, dev_name(&dev->dev), host);
 	if (ret)
 		goto unmap_ctl;
 
