From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [BUG] dmaengine: pxa_dma: + mmc: pxamci: race condition with DMA error on tx channel
Date: Wed, 08 Mar 2017 17:43:19 +0100
Message-ID: <877f3zwwgo.fsf@belgarion.home>
References: <e749aff1-0ffc-c9ed-42b2-82397b4e8ba2@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:55897 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753766AbdCHQnZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Mar 2017 11:43:25 -0500
In-Reply-To: <e749aff1-0ffc-c9ed-42b2-82397b4e8ba2@tul.cz> (Petr Cvek's
        message of "Wed, 8 Mar 2017 07:57:08 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: vinod.koul@intel.com, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org

Petr Cvek <petr.cvek@tul.cz> writes:

Hi Petr,
> I wasn't able to track the problem to a single patch as the problem occurs at
> random time (from the boot to like a half an hour) and it's maybe dependent on a
> level of a battery charge (maybe because of kernel log writes of charging
> messages).
Mmmh, long reproduction time, that will be bad.

> It seems that most occurrency is during writes on an SD card. Using an SDHC
> card decreases the time to fail. After failure the OS is unavailable (rootfs
> in on the card).
Okay, let me try to make write loop on my SD card to see if I manage to
reproduce this.

> From my poking in the kernel source code it seems there is a probability that pxamci_irq() takes longer to call and its subsequent call pxamci_data_done() isn't fast enough to set [1]
> 	host->data = NULL;

> From the DMA side, the DMA done interrupt is generated:
> 	pxad_chan_handler() -> vchan_cookie_complete()
> ...where a tasklet for vchan_complete() is scheduled
At least that seems to hint the DMA part is sound so for.
The bothering part is the log error "mmc0: DMA error on tx channel". I would
need a bit of guidance here, with the same log with [1] applied.

> , where finally with interrupts enabled (can pxamci_irq() be called here?) the
> callback pxamci_dma_irq() is called.
When DMA completes, there is a tiny window, before pxamci_dma_irq() is called,
when pxamci_irq() can be called, yes. As soon as the spinlock is taken in
pxamci_dma_irq() is taken, no more races.

> From my tests it seems at this point [2] the host->data is always NULL and rest
> of the callback is never called. It is called once with a nonempty host->data
> only just before the failure.
>
> During the testing I put udelay(100) at the start of pxamci_dma_irq() and fail
> occurred after like 2 hours (when I for the first time tapped the touchscreen -
> higher CPU usage and interrupts).
Mmm I would need more data here.

The biggest help I could get would be the pxa dma traces here :
echo -n 'file pxa_dma.c +p' > /sys/kernel/debug/dynamic_debug/control
echo -n 'file virt-dma.c +p' > /sys/kernel/debug/dynamic_debug/control

And then capture the last traces and send them to me.

Cheers.

-- 
Robert

[1] Small debug patch
---8>---
diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index c763b404510f..ed3812b2a34d 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -571,8 +571,9 @@ static void pxamci_dma_irq(void *param)
 	if (likely(status == DMA_COMPLETE)) {
 		writel(BUF_PART_FULL, host->base + MMC_PRTBUF);
 	} else {
-		pr_err("%s: DMA error on %s channel\n", mmc_hostname(host->mmc),
-			host->data->flags & MMC_DATA_READ ? "rx" : "tx");
+		pr_err("%s: DMA error on %s channel: %d\n",
+		       mmc_hostname(host->mmc),
+		       host->data->flags & MMC_DATA_READ ? "rx" : "tx", status);
 		host->data->error = -EIO;
 		pxamci_data_done(host, 0);
 	}
