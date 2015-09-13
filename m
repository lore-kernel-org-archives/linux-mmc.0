From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [BUG] Kernel error when first driver unbind with empty MMC slot
Date: Sun, 13 Sep 2015 11:56:12 +0200
Message-ID: <87pp1mskw3.fsf@belgarion.home>
References: <55F4EA4F.4050204@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:19503 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbbIMKBM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Sep 2015 06:01:12 -0400
In-Reply-To: <55F4EA4F.4050204@tul.cz> (Petr Cvek's message of "Sun, 13 Sep
	2015 05:15:27 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Petr Cvek <petr.cvek@tul.cz> writes:

> During testing of these patches
>
> 	[PATCH] mmc: pxamci: fix card detect threaded interrupt
> 	[PATCH 1/3] dmaengine: virt-dma: don't always free descriptor upon completion
>
> I have found unrelated error.	
>
> How to reproduce:
>
> 1) Remove any SD card
> 2) No CPLD initial power for card (in magician.c, probably irrelevant)
> 3) Boot into an initrd filesystem
> 4) Run command echo -n "pxa2xx-mci.0" > /sys/class/mmc_host/mmc0/device/driver/unbind
> 5) Error message will be printed:
>
> [ 97.877519] irq 39: nobody cared (try booting with the "irqpoll" option)

To go forward, I need to either :
 - see the debug messages activated, especially the one pxamci_irq()
 - or apply this patch [1] to see if it fixes the issue :

Cheers.

--
Robert

[1] Patch, totally untested/not compiled
---8<---
diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 67c9d1443597..3e0a7dd8da84 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -890,9 +890,7 @@ static int pxamci_remove(struct platform_device *pdev)
                        host->pdata->exit(&pdev->dev, mmc);
 
                pxamci_stop_clock(host);
-               writel(TXFIFO_WR_REQ|RXFIFO_RD_REQ|CLK_IS_OFF|STOP_CMD|
-                      END_CMD_RES|PRG_DONE|DATA_TRAN_DONE,
-                      host->base + MMC_I_MASK);
+               pxamci_disable_irq(host,  MMC_I_MASK_ALL);
 
                free_irq(host->irq, host);
                dmaengine_terminate_all(host->dma_chan_rx);

