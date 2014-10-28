From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2] mmc: sdhci-acpi: Add 64-bit DMA support
Date: Tue, 28 Oct 2014 16:14:46 +0200
Message-ID: <544FA4D6.50100@intel.com>
References: <26081691.uIqsxnCCe6@wuerfel> <2887027.N2hzKfpC9E@wuerfel> <544F80EA.6040403@intel.com> <2273272.zEkVARee9K@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:17059 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428AbaJ1OOw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Oct 2014 10:14:52 -0400
In-Reply-To: <2273272.zEkVARee9K@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 28/10/2014 3:54 p.m., Arnd Bergmann wrote:
> On Tuesday 28 October 2014 13:41:30 Adrian Hunter wrote:
>> On 28/10/14 12:18, Arnd Bergmann wrote:
>>> On Tuesday 28 October 2014 12:05:30 Adrian Hunter wrote:
>>>> On 28/10/14 11:43, Arnd Bergmann wrote:
>>>>> On Tuesday 28 October 2014 10:37:20 Adrian Hunter wrote:
>>>>>>   static int sdhci_acpi_enable_dma(struct sdhci_host *host)
>>>>>>   {
>>>>>> -       return 0;
>>>>>> +       struct sdhci_acpi_host *c = sdhci_priv(host);
>>>>>> +       struct device *dev = &c->pdev->dev;
>>>>>> +       int err = -1;
>>>>>> +
>>>>>> +       if (c->dma_setup)
>>>>>> +               return 0;
>>>>>> +
>>>>>> +       if (host->flags & SDHCI_USE_64_BIT_DMA) {
>>>>>> +               if (host->quirks2 & SDHCI_QUIRK2_BROKEN_64_BIT_DMA) {
>>>>>> +                       host->flags &= ~SDHCI_USE_64_BIT_DMA;
>>>>>> +               } else {
>>>>>> +                       err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>>>>>> +                       if (err)
>>>>>> +                               dev_warn(dev, "Failed to set 64-bit DMA mask\n");
>>>>>> +               }
>>>>>> +       }
>>>>>> +
>>>>>> +       if (err)
>>>>>> +               err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>>>>>> +
>>>>>> +       c->dma_setup = !err;
>>>>>> +
>>>>>> +       return err;
>>>>>>   }
>>>>>>
>>>>>
>>>>> I don't think it's worth a dev_warn() message (maybe dev_info), there is nothing
>>>>
>>>> It is worth a dev_warn because 32-bit DMA can allocate memory for bounce
>>>> buffers which jeopardizes memory reclaim.
>>>
>>> Then you should also warn if SDHCI_USE_64_BIT_DMA isn't or if
>>> SDHCI_QUIRK2_BROKEN_64_BIT_DMA is set I guess.
>>
>> The warning is for when the controller supports 64-bit, not when it doesn't.
>
> But why warn about a feature of the controller being present? You just
> said it's a problem for memory reclaim if 64-bit DMA is not supported.

The warning is for when the controller supports 64-bit but it can't
get a 64-bit DMA mask, and might therefore need to bounce things.
