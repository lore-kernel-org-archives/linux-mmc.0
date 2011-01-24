From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] mmc: clear all interrupt in suspend before free_irq
Date: Sun, 23 Jan 2011 18:17:36 -0800
Message-ID: <AD81E867-067B-4031-9594-52CA45F2D0C9@marvell.com>
References: <AANLkTi=M5M=uaGJ-+8K0fLDssDR7bnD=K0Saxz-Gww6y@mail.gmail.com>
 <alpine.LFD.2.00.1101211431050.8580@xanadu.home>
 <AANLkTim-FiqiUM2Gc45VGHfPzMHDX20eGZMHBnkY=R4m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:39036 "HELO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751788Ab1AXCRt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 23 Jan 2011 21:17:49 -0500
In-Reply-To: <AANLkTim-FiqiUM2Gc45VGHfPzMHDX20eGZMHBnkY=R4m@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>, Bing Zhao <bzhao@marvell.com>, Chris Ball <cjb@laptop.org>


I am confused.  Your patch modifiies

sdhci_suspend_host () to  
>>> +     sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, 0);
>> 



#define SDHCI_INT_ALL_MASK	((unsigned int)-1)

static void sdhci_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
{
	u32 ier;

	ier = sdhci_readl(host, SDHCI_INT_ENABLE);
	ier &= ~clear;
	ier |= set;
	sdhci_writel(host, ier, SDHCI_INT_ENABLE);
	sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
}


The code clears all the interrupts.    How is a card insert detected ?




On Jan 23, 2011, at 6:10 PM, zhangfei gao wrote:

> On Fri, Jan 21, 2011 at 2:33 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> On Fri, 21 Jan 2011, zhangfei gao wrote:
>> 
>>>> From b7be39e0bbac3950057078ac66900ebc0871f77e Mon Sep 17 00:00:00 2001
>>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>>> Date: Fri, 21 Jan 2011 18:02:47 -0500
>>> Subject: [PATCH] mmc: clear all interrupt in suspend before free_irq
>>> 
>>>       When debugging wifi host sleep, race condition about
>>> SDHCI_INT_CARD_INT happens.
>>>       Host free_irq in suspend and request_irq when resume back.
>>>       However SDHCI_INT_CARD_INT is not cleared, so interrupt will
>>> immediately happen after request_irq.
>>>       mmc_signal_sdio_irq will be called and wakeup sdio_irq_thread.
>>>       As a result irq_handler in sdio driver is called even before host resume back.
>>> 
>>>       The correct case is mmc_sdio_resume calls mmc_signal_sdio_irq to
>>> wakeup sdio_irq_thread
>>> 
>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>> 
>> That makes sense, as long as the masking of interrupts doesn't prevent
>> a SDIO card interrupt from waking up the host system.
> 
> Thanks Nicolas for comments
> 
> Masking interrupt does not impact wake up cpu.
> 1. irq is already freed in suspend, and request again when resume backed
> 2. cpu is wake up first, then irq service is handled, so irq does not
> impact cpu wake up or not.
> 3. mmc_signal_sdio_irq is serviced in mmc_sdio_resume.
> 
>> 
>> 
>>> ---
>>>  drivers/mmc/host/sdhci.c |    1 +
>>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>> 
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index aacd78c..97074ae 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -1707,6 +1707,7 @@ int sdhci_suspend_host(struct sdhci_host *host,
>>> pm_message_t state)
>>>       ret = mmc_suspend_host(host->mmc);
>>>       if (ret)
>>>               return ret;
>>> +     sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, 0);
>>> 
>>>       free_irq(host->irq, host);
>>> 
>>> --
>>> 1.7.0.4
>>> 
>> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

