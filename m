From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 13/15] mmc: sdhci-acpi: Add 64-bit DMA support
Date: Tue, 21 Oct 2014 13:45:20 +0300
Message-ID: <54463940.2070301@intel.com>
References: <1413883585-16299-1-git-send-email-adrian.hunter@intel.com> <1413883585-16299-14-git-send-email-adrian.hunter@intel.com> <2094662.tX3Mh5xduV@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48562 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755052AbaJUKqs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Oct 2014 06:46:48 -0400
In-Reply-To: <2094662.tX3Mh5xduV@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 21/10/14 12:33, Arnd Bergmann wrote:
> On Tuesday 21 October 2014 12:26:23 Adrian Hunter wrote:
>> +               return 0;
>> +
>> +       if (host->flags & SDHCI_USE_64_BIT_DMA) {
>> +               if (host->quirks2 & SDHCI_QUIRK2_BROKEN_64_BIT_DMA) {
>> +                       host->flags &= ~SDHCI_USE_64_BIT_DMA;
>> +               } else {
>> +                       err = dma_coerce_mask_and_coherent(dev,
>> +                                                          DMA_BIT_MASK(64));
>> +                       if (err)
>> +                               dev_warn(dev, "Failed to set 64-bit DMA mask\n");
>> +               }
>> +       }
>> +
>> +       if (err)
>> +               err = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
>> +
>> +       c->dma_setup = !err;
>>
> 
> Never use dma_coerce_mask_and_coherent(), it will ignore limitations of
> the upstream bus. Use dma_set_mask_and_coherent instead. If it fails,
> I think you need to clear the SDHCI_USE_64_BIT_DMA flag.

The sdhci-acpi device is a  platform devices created by acpi.  dev->dma_mask
is NULL so dma_set_mask_and_coherent will always fail
unless I add:

	if (!dev->dma_mask)
		dev->dma_mask = &dev->coherent_dma_mask;

