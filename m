From: akpm@linux-foundation.org
Subject: [patch 181/196] mmc: let tmio-mmc use dev_name() with request_irq()
Date: Mon, 14 Dec 2009 18:01:33 -0800
Message-ID: <200912150201.nBF21XHY023032@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60178 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758242AbZLOCB5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2009 21:01:57 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, damm@opensource.se, lethal@linux-sh.org, linux-mmc@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Improve the /proc/interrupts output so the irq number can be mapped to
platform device on boards with multiple tmio_mmc instances.

Signed-off-by: Magnus Damm <damm@opensource.se>
Cc: <linux-mmc@vger.kernel.org>
Cc: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/tmio_mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/mmc/host/tmio_mmc.c~mmc-let-tmio-mmc-use-dev_name-with-request_irq drivers/mmc/host/tmio_mmc.c
--- a/drivers/mmc/host/tmio_mmc.c~mmc-let-tmio-mmc-use-dev_name-with-request_irq
+++ a/drivers/mmc/host/tmio_mmc.c
@@ -591,7 +591,7 @@ static int __devinit tmio_mmc_probe(stru
 	disable_mmc_irqs(host, TMIO_MASK_ALL);
 
 	ret = request_irq(host->irq, tmio_mmc_irq, IRQF_DISABLED |
-		IRQF_TRIGGER_FALLING, "tmio-mmc", host);
+		IRQF_TRIGGER_FALLING, dev_name(&dev->dev), host);
 	if (ret)
 		goto unmap_cnf;
 
_
