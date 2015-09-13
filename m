From: Petr Cvek <petr.cvek@tul.cz>
Subject: Re: [BUG] Kernel error when first driver unbind with empty MMC slot
Date: Sun, 13 Sep 2015 22:51:56 +0200
Message-ID: <55F5E1EC.60602@tul.cz>
References: <55F4EA4F.4050204@tul.cz> <87pp1mskw3.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87pp1mskw3.fsf@belgarion.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Dne 13.9.2015 v 11:56 Robert Jarzmik napsal(a):
> Petr Cvek <petr.cvek@tul.cz> writes:
> 
>> During testing of these patches
>>
>> 	[PATCH] mmc: pxamci: fix card detect threaded interrupt
>> 	[PATCH 1/3] dmaengine: virt-dma: don't always free descriptor upon completion
>>
>> I have found unrelated error.	
>>
>> How to reproduce:
>>
>> 1) Remove any SD card
>> 2) No CPLD initial power for card (in magician.c, probably irrelevant)
>> 3) Boot into an initrd filesystem
>> 4) Run command echo -n "pxa2xx-mci.0" > /sys/class/mmc_host/mmc0/device/driver/unbind
>> 5) Error message will be printed:
>>
>> [ 97.877519] irq 39: nobody cared (try booting with the "irqpoll" option)
> 
> To go forward, I need to either :
>  - see the debug messages activated, especially the one pxamci_irq()
>  - or apply this patch [1] to see if it fixes the issue :
> 
> Cheers.
> 
> --
> Robert
> 
> [1] Patch, totally untested/not compiled
> ---8<---
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 67c9d1443597..3e0a7dd8da84 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -890,9 +890,7 @@ static int pxamci_remove(struct platform_device *pdev)
>                         host->pdata->exit(&pdev->dev, mmc);
>  
>                 pxamci_stop_clock(host);
> -               writel(TXFIFO_WR_REQ|RXFIFO_RD_REQ|CLK_IS_OFF|STOP_CMD|
> -                      END_CMD_RES|PRG_DONE|DATA_TRAN_DONE,
> -                      host->base + MMC_I_MASK);
> +               pxamci_disable_irq(host,  MMC_I_MASK_ALL);
>  
>                 free_irq(host->irq, host);
>                 dmaengine_terminate_all(host->dma_chan_rx);
> 

Yes, the patch fixes it. Log on unfixed version with debugging information enabled consists of many of a line:

	[  125.016666] PXAMCI: irq 00000200 stat 00002042

Petr Cvek
