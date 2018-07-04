From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: set proper dma mask for ls104x chips
Date: Wed, 4 Jul 2018 12:55:00 +0200
Message-ID: <CAPDyKFrabODyn4qgprFS4+Pfg0Xvy1tBzqDofJOwWuM7HK=0ZQ@mail.gmail.com>
References: <20180628084509.19646-1-laurentiu.tudor@nxp.com>
 <CAPDyKFoNmcg+7JbWq1eeb2Dx7GKSh=FWpZcEeB8RORaBbrr=qA@mail.gmail.com> <61a16c6b-9158-17ea-51f9-2ee5b85ccb78@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <61a16c6b-9158-17ea-51f9-2ee5b85ccb78@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Y.b. Lu" <yangbo.lu@nxp.com>
List-Id: linux-mmc@vger.kernel.org

On 3 July 2018 at 13:15, Laurentiu Tudor <laurentiu.tudor@nxp.com> wrote:
> Hi Uffe,
>
> On 02.07.2018 17:37, Ulf Hansson wrote:
>> On 28 June 2018 at 10:45, Laurentiu Tudor <laurentiu.tudor@nxp.com> wrote:
>>> SDHCI controller in ls1043a and ls1046a generate 40-bit wide addresses
>>> when doing DMA. Make sure that the corresponding dma mask is correctly
>>> configured.
>>>
>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>
>> Thanks, applied for next!
>
> Thanks for picking this up!
> I just realized that maybe I should have provided some context around
> this patch. I'm working on enabling smmu on these chips and encountered
> the following problem: the smmu input address size is 48 bits so the dma
> mappings for sdhci end up 48-bit wide. However, on these chips sdhci
> only use 40-bits of that address size when doing dma.
> So you end up with a 48-bit address translation in smmu but the device
> generates transactions with clipped 40-bit addresses, thus smmu context
> faults are triggered. Setting up the correct dma mask fixes this situation.

That's perfect data for the changelog. Care to send a v2, then I
re-place the one I have just applied!

Kind regards
Uffe

>
> ---
> Best Regards, Laurentiu
>
>>
>>> ---
>>>   drivers/mmc/host/sdhci-of-esdhc.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
>>> index 4ffa6b173a21..8332f56e6c0d 100644
>>> --- a/drivers/mmc/host/sdhci-of-esdhc.c
>>> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
>>> @@ -22,6 +22,7 @@
>>>   #include <linux/sys_soc.h>
>>>   #include <linux/clk.h>
>>>   #include <linux/ktime.h>
>>> +#include <linux/dma-mapping.h>
>>>   #include <linux/mmc/host.h>
>>>   #include "sdhci-pltfm.h"
>>>   #include "sdhci-esdhc.h"
>>> @@ -427,6 +428,11 @@ static void esdhc_of_adma_workaround(struct sdhci_host *host, u32 intmask)
>>>   static int esdhc_of_enable_dma(struct sdhci_host *host)
>>>   {
>>>          u32 value;
>>> +       struct device *dev = mmc_dev(host->mmc);
>>> +
>>> +       if (of_device_is_compatible(dev->of_node, "fsl,ls1043a-esdhc") ||
>>> +           of_device_is_compatible(dev->of_node, "fsl,ls1046a-esdhc"))
>>> +               dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
>>>
>>>          value = sdhci_readl(host, ESDHC_DMA_SYSCTL);
>>>          value |= ESDHC_DMA_SNOOP;
>>> --
>>> 2.17.1
>>>
