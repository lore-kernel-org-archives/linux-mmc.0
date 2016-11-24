From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 7/10] mmc: sdhci-xenon: Add support to PHYs of Marvell
 Xenon SDHC
Date: Thu, 24 Nov 2016 15:33:09 +0100
Message-ID: <CAPDyKFrskyZvMwhmj8ioyaowU8GL5=d-6ipGQcmmig_a9E9AQQ@mail.gmail.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <a05ffd140f4edc02fc3128db8445b2264cf38723.1477911954.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFpkcoVMKbVOwjX1WDyNgc1vvUX60D6XRX6=YHGvkvHvnA@mail.gmail.com> <3cd05a26-d340-476e-bab1-8be9d5446f47@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3cd05a26-d340-476e-bab1-8be9d5446f47-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Jimmy Xu <zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ryan Gao <ygao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Doug Jones <dougj-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Wei(SOCP) Liu" <liuw-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

[...]

>>
>>>
>>> +
>>> +static int __xenon_emmc_delay_adj_test(struct mmc_card *card)
>>> +{
>>> +       int err;
>>> +       u8 *ext_csd = NULL;
>>> +
>>> +       err = mmc_get_ext_csd(card, &ext_csd);
>>> +       kfree(ext_csd);
>>
>> Why do you read the ext csd here?
>>
>    I would like to simply introduce the PHY setting of our SDHC.
>    The target of the PHY setting is to achieve a perfect sampling
>    point for transfers, during card initialization.

Okay, so the phy is involved when running the tuning sequence.

>
>    For HS200/HS400/SDR104 whose SDCLK is more than 50MHz, SDHC HW
>    will search for this sampling point with DLL's help.

Apologize for my ignorance, but what is a "DLL" in this case?

>
>    For other speed mode whose SDLCK is less than or equals to 50MHz,
>    SW has to scan the PHY delay line to find out this perfect sampling
>    point. Our driver sends a command to verify a sampling point
>    in current environment.

Ahh, okay! I guess the important part here is to not only send a
command, but also to make sure data becomes transferred on the DAT
lines, as to confirm your tuning sequence!?

In cases of HS200/HS400/SDR104 you should be able to use the
mmc_send_tuning() API, don't you think?

For the other cases (lower speed modes) which cards doesn't support
the tuning command, perhaps you can just assume the PHY scan succeeded
and then allow to core to continue with the card initialization
sequence? Or do you foresee any issues with that? My point is that, if
it will fail - it will fail anyway.

>
>    As result, our SDHC driver has to implement the functionality to
>    send commands and check the results, in host layer.
>    If directly calling mmc_wait_for_cmd() is improper, could you please
>    give us some suggestions?
>
>    For eMMC, CMD8 is used to test current sampling point set in PHY.

Try to use mmc_send_tuning().

>
>>> +
>>> +       return err;
>>> +}
>>> +
>>> +static int __xenon_sdio_delay_adj_test(struct mmc_card *card)
>>> +{
>>> +       struct mmc_command cmd = {0};
>>> +       int err;
>>> +
>>> +       cmd.opcode = SD_IO_RW_DIRECT;
>>> +       cmd.flags = MMC_RSP_R5 | MMC_CMD_AC;
>>> +
>>> +       err = mmc_wait_for_cmd(card->host, &cmd, 0);
>>> +       if (err)
>>> +               return err;
>>> +
>>> +       if (cmd.resp[0] & R5_ERROR)
>>> +               return -EIO;
>>> +       if (cmd.resp[0] & R5_FUNCTION_NUMBER)
>>> +               return -EINVAL;
>>> +       if (cmd.resp[0] & R5_OUT_OF_RANGE)
>>> +               return -ERANGE;
>>> +       return 0;
>>
>> No thanks! MMC/SD/SDIO protocol code belongs in the core.
>>
>    For SDIO, SD_IO_RW_DIRECT command is sent to test current sampling point
>    in PHY.
>    Please help provide some suggestion to implement the command transfer.

Again, I think mmc_send_tuning() should be possible for you to use.

[...]

>>> +       if (mmc->card)
>>> +               card = mmc->card;
>>> +       else
>>> +               /*
>>> +                * Only valid during initialization
>>> +                * before mmc->card is set
>>> +                */
>>> +               card = priv->card_candidate;
>>> +       if (unlikely(!card)) {
>>> +               dev_warn(mmc_dev(mmc), "card is not present\n");
>>> +               return -EINVAL;
>>> +       }
>>
>> That your host need to hold a copy of the card pointer, tells me that
>> something is not really correct.
>>
>> I might be wrong, if this turns out to be a special case, but I doubt
>> it. Although, if it *is* a special such case, we shall most likely try
>> to extend the the mmc core layer instead of adding all these hacks in
>> your host driver.
>>
>     This card pointer copies the temporary structure mmc_card
>     used in mmc_init_card(), mmc_sd_init_card() and mmc_sdio_init_card().
>     Since we call mmc_wait_for_cmd() to send test commands, we need a copy
>     of that temporary mmc_card here in our host driver.

I see, thanks for clarifying.

>
>     During PHY setting in card initialization, mmc_host->card is not updated
>     yet with that temporary mmc_card. Thus we are not able to directly use
>     mmc_host->card. Instead, this card pointer is introduced to enable
>     mmc_wait_for_cmd().
>
>     If we can improve our host driver to send test commands without mmc_card,
>     this card pointer can be removed.
>     Could you please share your opinion please?

The mmc_send_tuning() API takes the mmc_host as parameter. If you
convert to that, perhaps you would be able to remove the need to hold
the card pointer.

BTW, the reason why mmc_send_tuning() doesn't take the card as a
parameter, is exactly those you just described above.

[...]

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
