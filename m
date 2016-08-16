From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH RFCv2 10/10] mmc: sdhci: add command queue support to
 sdhci
Date: Tue, 16 Aug 2016 09:40:13 +0530
Message-ID: <793bb5d6-16c2-173d-229f-2863edce97d8@codeaurora.org>
References: <1467033757-32498-1-git-send-email-riteshh@codeaurora.org>
 <1467033757-32498-11-git-send-email-riteshh@codeaurora.org>
 <577B96E2.5050009@intel.com>
 <3ab7727b-2cb2-5f54-f4c9-4f011b43ef7d@codeaurora.org>
 <2029ff76-87a0-a74b-80e0-d22cfb0d9345@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <2029ff76-87a0-a74b-80e0-d22cfb0d9345@intel.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, jh80.chung@samsung.com, dongas86@gmail.com, asutoshd@codeaurora.org, zhangfei.gao@gmail.com, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, shawn.lin@rock-chips.com, Subhash Jadavani <subhashj@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,

Thanks for replying to queries.
I will work on your comments. Mostly after
http://www.spinics.net/lists/linux-mmc/msg38467.html


Regards
Ritesh


On 8/10/2016 4:58 PM, Adrian Hunter wrote:
> On 25/07/16 13:24, Ritesh Harjani wrote:
>> Sorry about this long delay, was pulled into some release.
>> Will be more responsive from now.
>
> Well, I was away, so now it is my delay, sorry.
>
>> We have gone through your comments. We had some queries and wanted to
>> discuss more about your initial comments before going onto individual
>> comments in the code. It would be great if you could help us understand more
>> on your initial comments by answering to our queries.
>>
>>
>> On 7/5/2016 4:45 PM, Adrian Hunter wrote:
>>> On 27/06/16 16:22, Ritesh Harjani wrote:
>>>> From: Asutosh Das <asutoshd@codeaurora.org>
>>>>
>>>> Adds command-queue support to SDHCi compliant drivers.
>>>
>>> CQHCI is not recognized in the SDHCI specification,
>> Yes. Not sure about future plan though.
>
> SD Association and JEDEC are different bodies and I have never seen a SD
> Association Spec. that mentions eMMC, so I would not expect the SDHCI spec.
> ever to recognize CQHCI.
>
>>
>>> and SDHCI should
>>> facilitate any CQE driver implementation not just CQHCI.  That means there
>>> are 2 options:
>>
>> Are we aware of any other vendor specific implementation of CQHCI? Or do you
>> foresee this coming through?
>
> No
>
>> Actually CQ host controller interface(CQHCI) is what is proposed in emmc
>> JEDEC5.1 which is mentioned as extension to HCI in block diagram. (Fig B.110
>> in emmc-5.1 JEDEC).
>>
>>
>>>
>>> 1. Provide minimal support to allow individual host drivers to deal with
>>> CQHCI directly.
>>>
>>> 2. Create explicit support for a CQE companion driver and use that to
>>> provide common support for CQHCI.
>>>
>>> I started looking at option 2 and concluded that it was taking SDHCI in the
>>> wrong direction because it made drivers more dependent on SDHCI and gave
>>> them less flexibility, and it seemed inconsistent with the aim of making
>>> SDHCI more like a library.
>>>
>>> Consequently, I suggest the following:
>>>
>>> 1. Individual drivers are responsible for initializing and setting up CQHCI
>>> and its callbacks, and shutting it down.
>>
>> CQHCI callbacks is what the concern is. Currently the callbacks are placed
>> in SDHCI, because these callbacks are doing nothing other than setting up
>> SDHCI registers itself for CQHCI. There is nothing platform specific which
>> is happening in these.
>> So why do you think that these should be implemented in individual platform
>> specific drivers?
>> Will that not result into same code duplication in all SDHCI compliant
>> platform drivers?
>
> Common functions that do not need CQHCI definitions can still be in sdhci.c.
> Some amount of code duplication is the cost of allowing drivers to be able
> to do whatever the need to.
>
> Linking CQHCI and SDHCI goes in the opposite direction of making SDHCI more
> like a library.  It means more callbacks and more potential issues if
> drivers need to do anything differently.
>
>>
>>
>>>
>>> 2. SDHCI provides a new callback so that individual drivers can process
>>> interrupts and pass them to CQHCI.
>> This again will depend upon the initial ask on - do you foresee SDHCI
>> facilitating other CQE implementations? Or if you are already aware of
>> something else other than CQHCI?
>
> No I don't know if there will ever be another implementation, however it is
> not impossible.  Obviously it would be much messier for SDHCI to support
> different CQE implementations than for individual drivers to support just
> the one they use.
>
>>
>>
>>>
>>> 3. SDHCI provides and exports any common helper functions that do not depend
>>> directly on CQHCI.  For example the functions to set interrupts, timeout,
>>> blocks size and dump registers.
>>>
>>>>
>>>> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
>>>> Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
>>>> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>>>> [subhashj@codeaurora.org: fixed trivial merge conflicts and
>>>> compilation error]
>>>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>>>> [riteshh@codeaurora.org: fixed merge conflicts]
>>>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>>>> ---
>>>>  drivers/mmc/host/sdhci.c | 146
>>>> +++++++++++++++++++++++++++++++++++++++++++++--
>>>>  drivers/mmc/host/sdhci.h |   6 ++
>>>>  2 files changed, 148 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>> index 9f5cdaa..0ed9c45 100644
>>>> --- a/drivers/mmc/host/sdhci.c
>>>> +++ b/drivers/mmc/host/sdhci.c
>>>> @@ -32,6 +32,7 @@
>>>>  #include <linux/mmc/slot-gpio.h>
>>>>
>>>>  #include "sdhci.h"
>>>> +#include "cmdq_hci.h"
>>>
>>> As discussed above, SDHCI should not have any references to CQHCI
>>>
>>>>
>>>>  #define DRIVER_NAME "sdhci"
>>>>
>>>> @@ -2474,6 +2475,20 @@ static void sdhci_data_irq(struct sdhci_host
>>>> *host, u32 intmask)
>>>>      }
>>>>  }
>>>>
>>>> +#ifdef CONFIG_MMC_CQ_HCI
>>>
>>> This won't work if CQHCI is a module.  If you fix the dependencies then you
>>> can use:
>>>
>>> #if IS_ENABLED(CONFIG_MMC_CQ_HCI)
>>>
>>> Or if you select CONFIG_MMC_CQ_HCI in Kconfig then you don't need ifdef at
>>> all.
>>>
>>>> +static irqreturn_t sdhci_cmdq_irq(struct mmc_host *mmc, u32 intmask)
>>>> +{
>>>> +    return cmdq_irq(mmc, intmask);
>>>
>>> This will give a linker error if the driver is built-in but CQHCI is a
>>> module.  Probably drivers that use CQHCI should just select it in Kconfig.
>>>
>>> Another issue is that CQHCI won't be able to interpret SDHCI interrupt bits.
>>>  I suggest you define a generic set of bit flags not dependent on SDHCI or
>>> CQHCI and then we can create a function to convert the SDHCI interrupt
>>> status.
>>>
>>>> +}
>>>> +
>>>> +#else
>>>> +static irqreturn_t sdhci_cmdq_irq(struct mmc_host *mmc, u32 intmask)
>>>> +{
>>>> +    pr_err("%s: rxd cmdq-irq when disabled !!!!\n", mmc_hostname(mmc));
>>>> +    return IRQ_NONE;
>>>> +}
>>>> +#endif
>>>> +
>>>>  static irqreturn_t sdhci_irq(int irq, void *dev_id)
>>>>  {
>>>>      irqreturn_t result = IRQ_NONE;
>>>> @@ -2495,6 +2510,15 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>>>>      }
>>>>
>>>>      do {
>>>> +        if (host->mmc->card && mmc_card_cmdq(host->mmc->card) &&
>>>> +            !mmc_host_halt(host->mmc)) {
>>>> +            pr_debug("*** %s: cmdq intr: 0x%08x\n",
>>>> +                    mmc_hostname(host->mmc),
>>>> +                    intmask);
>>>> +            result = sdhci_cmdq_irq(host->mmc, intmask);
>>>> +            goto out;
>>>> +        }
>>>> +
>>>
>>> We need to create a new SDHCI host op to enable individual drivers to
>>> handle the IRQ if they choose.  Then it is up to individual drivers to call
>>> into CQHCI.
>>>
>>>>          /* Clear selected interrupts. */
>>>>          mask = intmask & (SDHCI_INT_CMD_MASK | SDHCI_INT_DATA_MASK |
>>>>                    SDHCI_INT_BUS_POWER);
>>>> @@ -2823,6 +2847,106 @@ static int sdhci_set_dma_mask(struct sdhci_host
>>>> *host)
>>>>      return ret;
>>>>  }
>>>>
>>>> +#ifdef CONFIG_MMC_CQ_HCI
>>>> +static void sdhci_cmdq_clear_set_irqs(struct mmc_host *mmc, bool clear)
>>>> +{
>>>> +    struct sdhci_host *host = mmc_priv(mmc);
>>>> +    u32 ier = 0;
>>>> +
>>>> +    ier &= ~SDHCI_INT_ALL_MASK;
>>>> +
>>>> +    if (clear) {
>>>> +        ier = SDHCI_INT_CMDQ_EN | SDHCI_INT_ERROR_MASK;
>>>
>>> SDHCI_INT_ERROR_MASK is not ideal here.  I would expect to set only the bits
>>> we know and want.
>>>
>>>> +        sdhci_writel(host, ier, SDHCI_INT_ENABLE);
>>>> +        sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
>>>> +    } else {
>>>> +        ier = SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
>>>> +                 SDHCI_INT_DATA_CRC | SDHCI_INT_DATA_TIMEOUT |
>>>> +                 SDHCI_INT_INDEX | SDHCI_INT_END_BIT |
>>>> +                 SDHCI_INT_CRC | SDHCI_INT_TIMEOUT |
>>>> +                 SDHCI_INT_DATA_END | SDHCI_INT_RESPONSE |
>>>> +                 SDHCI_INT_ACMD12ERR;
>>>
>>> We ought to have the default interrupts defined, so that the same ones are
>>> set here.
>>>
>>>> +        sdhci_writel(host, ier, SDHCI_INT_ENABLE);
>>>> +        sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
>>>> +    }
>>>> +}
>>>> +
>>>> +static void sdhci_cmdq_set_data_timeout(struct mmc_host *mmc, u32 val)
>>>
>>> Do we really need different callbacks for ->clear_set_irqs(),
>>> ->set_data_timeout(), ->set_block_size() and ->clear_set_dumpregs()?  It
>>> looks like we could consolidate them all into just 2 i.e. to start and stop
>>> CQ mode.
>>>
>>>> +{
>>>> +    struct sdhci_host *host = mmc_priv(mmc);
>>>> +
>>>> +    sdhci_writeb(host, val, SDHCI_TIMEOUT_CONTROL);
>>>> +}
>>>
>>> We can't expect CQHCI to provide the SDHCI register value.  Ideally we don't
>>> want to set the highest value but instead calculate the value based on the
>>> maximum sized transfer.
>>>
>>>> +
>>>> +static void sdhci_cmdq_dump_vendor_regs(struct mmc_host *mmc)
>>>> +{
>>>> +    struct sdhci_host *host = mmc_priv(mmc);
>>>> +
>>>> +    sdhci_dumpregs(host);
>>>> +}
>>>
>>> Instead you should export sdhci_dumpregs() and let the individual drivers
>>> connect it to CQHCI.
>>>
>>>> +
>>>> +static int sdhci_cmdq_init(struct sdhci_host *host, struct mmc_host *mmc,
>>>> +               bool dma64)
>>>> +{
>>>> +    return cmdq_init(host->cq_host, mmc, dma64);
>>>> +}
>>>
>>> Individual drivers should initialize their CQE driver implementation.  It is
>>> not necessarily CQHCI.
>>>
>>>> +
>>>> +static void sdhci_cmdq_set_block_size(struct mmc_host *mmc)
>>>> +{
>>>> +    struct sdhci_host *host = mmc_priv(mmc);
>>>> +
>>>> +    sdhci_set_blk_size_reg(host, 512, 0);
>>>> +}
>>>> +
>>>> +static void sdhci_cmdq_clear_set_dumpregs(struct mmc_host *mmc, bool set)
>>>> +{
>>>> +    struct sdhci_host *host = mmc_priv(mmc);
>>>> +
>>>> +    if (host->ops->clear_set_dumpregs)
>>>> +        host->ops->clear_set_dumpregs(host, set);
>> This is vendor specific callback for platform drivers to enable/disable (say
>> some TEST bus) registers for debugging purposes.
>>
>>
>>>> +}
>>>
>>> As questioned further below, what is this for?
>>>
>>>> +#else
>>>> +static void sdhci_cmdq_clear_set_irqs(struct mmc_host *mmc, bool clear)
>>>> +{
>>>> +
>>>> +}
>>>> +
>>>> +static void sdhci_cmdq_set_data_timeout(struct mmc_host *mmc, u32 val)
>>>> +{
>>>> +
>>>> +}
>>>> +
>>>> +static void sdhci_cmdq_dump_vendor_regs(struct mmc_host *mmc)
>>>> +{
>>>> +
>>>> +}
>>>> +
>>>> +static int sdhci_cmdq_init(struct sdhci_host *host, struct mmc_host *mmc,
>>>> +               bool dma64)
>>>> +{
>>>> +    return -ENOSYS;
>>>> +}
>>>> +
>>>> +static void sdhci_cmdq_set_block_size(struct mmc_host *mmc)
>>>> +{
>>>> +
>>>> +}
>>>> +
>>>> +static void sdhci_cmdq_clear_set_dumpregs(struct mmc_host *mmc, bool set)
>>>> +{
>>>> +
>>>> +}
>>>> +
>>>> +#endif
>>>> +
>>>> +static const struct cmdq_host_ops sdhci_cmdq_ops = {
>>>> +    .clear_set_irqs = sdhci_cmdq_clear_set_irqs,
>>>> +    .set_data_timeout = sdhci_cmdq_set_data_timeout,
>>>> +    .dump_vendor_regs = sdhci_cmdq_dump_vendor_regs,
>>>> +    .set_block_size = sdhci_cmdq_set_block_size,
>>>> +    .clear_set_dumpregs = sdhci_cmdq_clear_set_dumpregs,
>>>> +};
>>>
>>> It would be up to individual drivers to provide CQHCI ops.
>>>
>>>> +
>>>>  int sdhci_add_host(struct sdhci_host *host)
>>>>  {
>>>>      struct mmc_host *mmc;
>>>> @@ -3341,11 +3465,25 @@ int sdhci_add_host(struct sdhci_host *host)
>>>>      if (ret)
>>>>          goto unled;
>>>>
>>>> -    pr_info("%s: SDHCI controller on %s [%s] using %s\n",
>>>> -        mmc_hostname(mmc), host->hw_name, dev_name(mmc_dev(mmc)),
>>>> +    if (mmc->caps2 &  MMC_CAP2_CMD_QUEUE) {
>>>> +        bool dma64 = (host->flags & SDHCI_USE_ADMA_64BIT) ?
>>>> +            true : false;
>>>> +        ret = sdhci_cmdq_init(host, mmc, dma64);
>>>
>>> You must initialize before mmc_add_host() because mmc_add_host() also starts
>>> the host.  If you re-base on top of the SDHCI patches, then individual
>>> drivers can take advantage of the new sdhci_setup_host() /
>>> __sdhci_add_host() split.
>>>
>>>> +        if (ret)
>>>> +            pr_err("%s: CMDQ init: failed (%d)\n",
>>>> +                   mmc_hostname(host->mmc), ret);
>>>> +        else
>>>> +            host->cq_host->ops = &sdhci_cmdq_ops;
>>>> +    }
>>>> +
>>>> +    pr_info("%s: SDHCI controller on %s [%s] using %s in %s mode\n",
>>>> +    mmc_hostname(mmc), host->hw_name, dev_name(mmc_dev(mmc)),
>>>>          (host->flags & SDHCI_USE_ADMA) ?
>>>> -        (host->flags & SDHCI_USE_64_BIT_DMA) ? "ADMA 64-bit" : "ADMA" :
>>>> -        (host->flags & SDHCI_USE_SDMA) ? "DMA" : "PIO");
>>>> +        ((host->flags & SDHCI_USE_ADMA_64BIT) ?
>>>> +        "64-bit ADMA" : "32-bit ADMA") :
>>>> +        ((host->flags & SDHCI_USE_SDMA) ? "DMA" : "PIO"),
>>>> +        ((mmc->caps2 &  MMC_CAP2_CMD_QUEUE) && !ret) ?
>>>> +        "CMDQ" : "legacy");
>>>
>>> It is probably better if CQHCI prints its own info.  That way it you get a
>>> consistent message irrespective of whether the driver uses SDHCI.  Also you
>>> can print other CQHCI details such as the version.
>>>
>>>>
>>>>      sdhci_enable_card_detection(host);
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>>> index 609f87c..fccc750 100644
>>>> --- a/drivers/mmc/host/sdhci.h
>>>> +++ b/drivers/mmc/host/sdhci.h
>>>> @@ -150,6 +150,8 @@
>>>>          SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_DATA_CRC | \
>>>>          SDHCI_INT_DATA_END_BIT | SDHCI_INT_ADMA_ERROR | \
>>>>          SDHCI_INT_BLK_GAP)
>>>> +
>>>> +#define SDHCI_INT_CMDQ_EN    (0x1 << 14)
>>>
>>> We can define this bit for convenience but we need a comment to say that it
>>> is non-standard.
>>>
>>>>  #define SDHCI_INT_ALL_MASK    ((unsigned int)-1)
>>>>
>>>>  #define SDHCI_ACMD12_ERR    0x3C
>>>> @@ -446,6 +448,7 @@ struct sdhci_host {
>>>>  #define SDHCI_PV_ENABLED    (1<<8)    /* Preset value enabled */
>>>>  #define SDHCI_SDIO_IRQ_ENABLED    (1<<9)    /* SDIO irq enabled */
>>>>  #define SDHCI_USE_64_BIT_DMA    (1<<12)    /* Use 64-bit DMA */
>>>> +#define SDHCI_USE_ADMA_64BIT    (1<<12)    /* Host is 64-bit ADMA
>>>> capable */
>>>
>>> SDHCI_USE_ADMA_64BIT looks redundant.
>>>
>>>>  #define SDHCI_HS400_TUNING    (1<<13)    /* Tuning for HS400 */
>>>>
>>>>      unsigned int version;    /* SDHCI spec. version */
>>>> @@ -509,6 +512,8 @@ struct sdhci_host {
>>>>      unsigned int        tuning_mode;    /* Re-tuning mode supported by
>>>> host */
>>>>  #define SDHCI_TUNING_MODE_1    0
>>>>
>>>> +    struct cmdq_host *cq_host;
>>>> +
>>>
>>> The individual drivers will have to have their own reference to CQHCI.
>>>
>>>>      unsigned long private[0] ____cacheline_aligned;
>>>>  };
>>>>
>>>> @@ -544,6 +549,7 @@ struct sdhci_ops {
>>>>      void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
>>>>      void    (*platform_init)(struct sdhci_host *host);
>>>>      void    (*card_event)(struct sdhci_host *host);
>>>> +    void    (*clear_set_dumpregs)(struct sdhci_host *host, bool set);
>>>
>>> What is this for?
>>
>> This is vendor specific callback to enable/disable some TEST bus registers
>> for debugging purposes.
>>
>>>
>>>>      void    (*voltage_switch)(struct sdhci_host *host);
>>>>      int    (*select_drive_strength)(struct sdhci_host *host,
>>>>                       struct mmc_card *card,
>>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
