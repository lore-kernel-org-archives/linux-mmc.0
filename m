From: Andreas Fenkart <afenkart@gmail.com>
Subject: Re: [PATCH 3/3] mmc: host: omap_hsmmc: Add custom card detect irq handler
Date: Tue, 21 Jul 2015 10:16:02 +0200
Message-ID: <CALtMJEBnqzJsGgBoLDjkO+6iJ=67Cw1FXjQm0vfmcm1i3yZ5oA@mail.gmail.com>
References: <1434451039-18195-1-git-send-email-vigneshr@ti.com>
	<1434451039-18195-4-git-send-email-vigneshr@ti.com>
	<CALtMJEAy8p23dkqPYZT9wTfyvvjiwi6Swj9Fzpau9Y4K9dym5g@mail.gmail.com>
	<55880B24.9010906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55880B24.9010906@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, NeilBrown <neilb@suse.de>, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Vignesh,

Generally I don't like this patch, it will make it harder, not easier,
to maintain the omap hsmmc driver. Also given that the bug occurs
rarely, people will be reluctant to clean it up later or accept
patches.

see also comments below

2015-06-22 15:18 GMT+02:00 Vignesh R <vigneshr@ti.com>:
>
>
> On Sunday 21 June 2015 04:15 AM, Andreas Fenkart wrote:
>> I haven't managed to produce a hang without this patch
>
> Reproducing this hang is not straight forward. It takes 40-50 card
> insertion/removal to see this case (sometimes even 100 tries).
>
>>
>> see also comments below
>>
>> 2015-06-16 12:37 GMT+02:00 Vignesh R <vigneshr@ti.com>:
>>> Usually when there is an error in transfer, DTO/CTO or other error
>>> interrupts are raised. But if the card is unplugged in the middle of a
>>> data transfer, it is observed that, neither completion(success) or
>>> timeout(error) interrupts are raised. Hence, the mmc-core is waiting
>>> for-ever for the transfer to complete. This results failure to recognise
>>> sd card on the next insertion.
>>> The only way to solve this is to introduce code to detect this condition
>>> and recover on card insertion (in hsmmc specific cd_irq). Hence,
>>> introduce cd_irq and add code to clear mmc_request that is pending from
>>> the failed transaction.
>>>
>>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>>> ---
>>>  drivers/mmc/host/omap_hsmmc.c | 73 ++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 72 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>>> index fb4bfefd9250..ec1fff3c0c9c 100644
>>> --- a/drivers/mmc/host/omap_hsmmc.c
>>> +++ b/drivers/mmc/host/omap_hsmmc.c
>>> @@ -221,6 +221,12 @@ struct omap_hsmmc_host {
>>>  #define HSMMC_WAKE_IRQ_ENABLED (1 << 2)
>>>         struct omap_hsmmc_next  next_data;
>>>         struct  omap_hsmmc_platform_data        *pdata;
>>> +       /*
>>> +        * flag to determine whether card was removed during data
>>> +        * transfer
>>> +        */
>>> +       bool                    transfer_incomplete;
>>> +
>>>
>>>         /* return MMC cover switch state, can be NULL if not supported.
>>>          *
>>> @@ -867,6 +873,26 @@ static void omap_hsmmc_request_done(struct omap_hsmmc_host *host, struct mmc_req
>>>  }
>>>
>>>  /*
>>> + * Cleanup incomplete card removal sequence. This will make sure the
>>> + * next card enumeration is clean.
>>> + */
>>> +static void omap_hsmmc_request_clear(struct omap_hsmmc_host *host,
>>> +                                    struct mmc_request *mrq)
>>> +{
>>> +       unsigned long flags;
>>> +
>>> +       spin_lock_irqsave(&host->irq_lock, flags);
>>> +       host->req_in_progress = 0;
>>> +       host->dma_ch = -1;
>>> +       spin_unlock_irqrestore(&host->irq_lock, flags);
>>> +
>>> +       mmc_request_done(host->mmc, mrq);
>>> +       if (host->mmc->card)
>>> +               mmc_card_set_removed(host->mmc->card);
>>> +       host->mrq = NULL;
>>> +}
>>> +
>>> +/*
>>>   * Notify the transfer complete to MMC core
>>>   */
>>>  static void
>>> @@ -1248,6 +1274,47 @@ static irqreturn_t omap_hsmmc_cover_irq(int irq, void *dev_id)
>>>         return IRQ_HANDLED;
>>>  }
>>>
>>> +/*
>>> + * irq handler to notify the core about card insertion/removal
>>> + */
>>> +static irqreturn_t omap_hsmmc_cd_irq(int irq, void *dev_id)
>>> +{
>>
>> Move this code to 'omap_hsmmc_get_cd' function. Or rather clear
>> any pending transfer upon '.init_card/omap_hsmmc_init_card'
>
> I tried using omap_hsmmc_init initially, but here is the problem:
>
> card inserted --> cd_irq_isr--> schedule mmc_rescan()
> --- after some time ---
> mmc_rescan() -->
> mmc_sd_alive() -->
> -- card removed ---
> mmc_send_status -->
> mmc_wait_for_req()-->
> wait_for_completion()
> ^^^ Here the mmc_rescan thread waits forever because, it doesn't get
> timeout interrupt for the cmd/req it sent (because card was removed).

ok, I see

> But calls to omap_hsmmc_card_init or omap_hsmmc_get_cd are in the same
> mmc_rescan thread. Hence, moving the recovery code to init_card does not
> help.

what about clearing any pending transfer in
- mmc_gpio_cd_irqt, or
- mmc_detect_change

e.g. trigger the later mentioned .card_event callback from those
functions, instead mmc_rescan? Then you can install your
omap_hsmmc_request_clear as the card_event callback. This makes your
custom isr handler redundant, actually your isr handler became
standard.

>> I guess other hosts also have some housekeeping upon unexpected
>> card removals. So I guess there is some generic code to this problem.
>> Did you check?
>
> I did try to find generic code in mmc-core, but couldn't find any.
> However, I did see some driver specific cleanups related to unexpected
> card removal in sdhci.c. sdhci handles this in .card_event call back.
> This does not help in my case as .card_event  is also called from
> mmc_rescan. I think cleanup code (in sdhci driver) for unexpected card
> removal was introduced when .card_event call was outside mmc_rescan.

interesting

>>> +       struct omap_hsmmc_host *host = mmc_priv(dev_id);
>>> +       int carddetect = mmc_gpio_get_cd(host->mmc);
>>> +       struct mmc_request *mrq = host->mrq;
>>> +
>>> +       /*
>>> +        * If the card was removed in the middle of data transfer last
>>> +        * time, the TC/CC/timeout interrupt is not raised due to which
>>> +        * mmc_request is not cleared. Hence, this card insertion will
>>> +        * still see pending mmc_request. Clear the request to make sure
>>> +        * that this card enumeration is successful.
>>> +        */
>>> +       if (!carddetect && mrq && host->transfer_incomplete) {
>>> +               omap_hsmmc_disable_irq(host);
>>> +               dev_info(host->dev,
>>> +                        "card removed during transfer last time\n");
>>> +               hsmmc_command_incomplete(host, -ENOMEDIUM, 1);
>>> +               omap_hsmmc_request_clear(host, host->mrq);
>>> +               dev_info(host->dev, "recovery done\n");
>>> +       }
>>> +       host->transfer_incomplete = false;
>>> +
>>> +       mmc_detect_change(host->mmc, (HZ * 200) / 1000);
>>> +
>>> +       /*
>>> +        * The current mmc_request is usually null before card removal
>>> +        * sequence is complete. It may not be null if TC/CC interrupt
>>> +        * never happens due to removal of card during a data
>>> +        * transfer. Set a flag to indicate mmc_request was not null
>>> +        * in order to do cleanup on next card insertion.
>>> +        */
>>> +       if (carddetect && mrq)
>>> +               host->transfer_incomplete = true;
>>> +
>>> +       return IRQ_HANDLED;
>>> +}
>>> +
>>>  static void omap_hsmmc_dma_callback(void *param)
>>>  {
>>>         struct omap_hsmmc_host *host = param;
>>> @@ -1918,7 +1985,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>>>         struct mmc_host *mmc;
>>>         struct omap_hsmmc_host *host = NULL;
>>>         struct resource *res;
>>> -       int ret, irq;
>>> +       int ret, irq, len;
>>>         const struct of_device_id *match;
>>>         dma_cap_mask_t mask;
>>>         unsigned tx_req, rx_req;
>>> @@ -1980,6 +2047,10 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>>>         if (ret)
>>>                 goto err_gpio;
>>>
>>> +       /* register cd_irq, if cd-gpios property is specified in dt */
>>> +       if (of_find_property(host->dev->of_node, "cd-gpios", &len))
>>> +               mmc_gpio_set_cd_isr(mmc, omap_hsmmc_cd_irq);
>>> +
>>
>> nack, this is done by mmc_of_parse
>
> mmc_of_parse parses the cd-gpios and registers a generic cd_irq_isr but
> there is no way to set driver specific cd_irq. So, the above code is
> required.

I think we don't need a custom isr.

>>>         platform_set_drvdata(pdev, host);
>>>
>>>         if (pdev->dev.of_node)
>>> --
>>> 2.4.1
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>
>
> Regards
> Vignesh
