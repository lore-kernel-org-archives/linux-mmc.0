From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH v3 1/3] mmc: sdhci: Set DMA mask when adding host
Date: Mon, 7 Mar 2016 11:06:06 +0900
Message-ID: <CAAVeFuLgzh===H3oVuwRVgv+rUX6hFAgion9AjKYP+kcu-dsXg@mail.gmail.com>
References: <1457087925-992-1-git-send-email-acourbot@nvidia.com>
 <1457087925-992-2-git-send-email-acourbot@nvidia.com> <2562091.6cJRuD3dK9@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37006 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbcCGCG0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Mar 2016 21:06:26 -0500
In-Reply-To: <2562091.6cJRuD3dK9@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Mar 5, 2016 at 12:57 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 04 March 2016 19:38:43 Alexandre Courbot wrote:
>> Set the DMA mask in sdhci_add_host() after we determined the
>> capabilities of the device. 64-bit devices in particular are given the
>> proper mask that ensures bounce buffers are not used.
>>
>> Also disable DMA if no proper DMA mask can be set, as the DMA-API
>> documentation specifies.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  drivers/mmc/host/sdhci.c | 46 +++++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 39 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index fd9139947fa3..00fb45ba6f39 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2857,6 +2857,34 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
>>
>>  EXPORT_SYMBOL_GPL(sdhci_alloc_host);
>>
>> +static int sdhci_set_dma_mask(struct sdhci_host *host)
>> +{
>> +     struct mmc_host *mmc = host->mmc;
>> +     struct device *dev = mmc_dev(mmc);
>> +     int ret = -EINVAL;
>> +
>> +     if (host->quirks2 & SDHCI_QUIRK2_BROKEN_64_BIT_DMA)
>> +             host->flags &= ~SDHCI_USE_64_BIT_DMA;
>> +
>> +     /* Try 64-bit mask if hardware is capable  of it */
>> +     if (host->flags & SDHCI_USE_64_BIT_DMA) {
>> +             ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>> +             if (ret)
>> +                     pr_warn("%s: Failed to set 64-bit DMA mask.\n",
>> +                             mmc_hostname(mmc));
>> +     }
>> +
>
> I think you need to disable the SDHCI_USE_64_BIT_DMA flag when
> dma_set_mask_and_coherent() fails here. Otherwise looks good.

Ah, you're right, thanks. v4 is on the way.
