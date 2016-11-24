From: Ziji Hu <huziji@marvell.com>
Subject: Re: [PATCH 7/10] mmc: sdhci-xenon: Add support to PHYs of Marvell
 Xenon SDHC
Date: Thu, 24 Nov 2016 23:37:37 +0800
Message-ID: <436c6925-cb0d-afe7-e3a2-384eca15ff42@marvell.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <a05ffd140f4edc02fc3128db8445b2264cf38723.1477911954.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFpkcoVMKbVOwjX1WDyNgc1vvUX60D6XRX6=YHGvkvHvnA@mail.gmail.com>
 <3cd05a26-d340-476e-bab1-8be9d5446f47@marvell.com>
 <CAPDyKFrskyZvMwhmj8ioyaowU8GL5=d-6ipGQcmmig_a9E9AQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:52690 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965802AbcKXPig (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2016 10:38:36 -0500
In-Reply-To: <CAPDyKFrskyZvMwhmj8ioyaowU8GL5=d-6ipGQcmmig_a9E9AQQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>

Hi Ulf,

On 2016/11/24 22:33, Ulf Hansson wrote:
> [...]
> 
>>>
>>>>
>>>> +
>>>> +static int __xenon_emmc_delay_adj_test(struct mmc_card *card)
>>>> +{
>>>> +       int err;
>>>> +       u8 *ext_csd = NULL;
>>>> +
>>>> +       err = mmc_get_ext_csd(card, &ext_csd);
>>>> +       kfree(ext_csd);
>>>
>>> Why do you read the ext csd here?
>>>
>>    I would like to simply introduce the PHY setting of our SDHC.
>>    The target of the PHY setting is to achieve a perfect sampling
>>    point for transfers, during card initialization.
> 
> Okay, so the phy is involved when running the tuning sequence.
> 
    Actually, all the transfers pass our host PHY.

>>
>>    For HS200/HS400/SDR104 whose SDCLK is more than 50MHz, SDHC HW
>>    will search for this sampling point with DLL's help.
> 
> Apologize for my ignorance, but what is a "DLL" in this case?
> 
   DLL is Delay-locked Loop. It is a HW module similar to PLL.

>>
>>    For other speed mode whose SDLCK is less than or equals to 50MHz,
>>    SW has to scan the PHY delay line to find out this perfect sampling
>>    point. Our driver sends a command to verify a sampling point
>>    in current environment.
> 
> Ahh, okay! I guess the important part here is to not only send a
> command, but also to make sure data becomes transferred on the DAT
> lines, as to confirm your tuning sequence!?

   Yes.
   It is the best if the test command can transfer on DAT lines.

> 
> In cases of HS200/HS400/SDR104 you should be able to use the
> mmc_send_tuning() API, don't you think?

   For HS200/HS400/SDR104, we finally call sdhci_execute_tuning() to
   execute tuning. Those test commands are not used.
   In HS200/HS400/SDR104, HW will provide our host driver with suitable
   tuning step. Our host driver set the tuning step in SDHCI register and
   then start standard tuning sequence. The tuning step value provided
   by our host HW will enhance tuning. 

> 
> For the other cases (lower speed modes) which cards doesn't support
> the tuning command, perhaps you can just assume the PHY scan succeeded
> and then allow to core to continue with the card initialization
> sequence? Or do you foresee any issues with that? My point is that, if
> it will fail - it will fail anyway.

  Usually, our host driver will always successfully scan and select a
  perfect sampling point.
  If driver cannot find any suitable sampling point, it is likely that
  transfers will also fail after init. But usually it is a issue, caused by
  incorrect setting on boards/SOC/other PHY parameters, especially in development.
  We will fix the issue and then scan will succeed in final product.

> 
>>
>>    As result, our SDHC driver has to implement the functionality to
>>    send commands and check the results, in host layer.
>>    If directly calling mmc_wait_for_cmd() is improper, could you please
>>    give us some suggestions?
>>
>>    For eMMC, CMD8 is used to test current sampling point set in PHY.
> 
> Try to use mmc_send_tuning().
> 

    Could you please tell me the requirement of "op_code" parameter in
    mmc_send_tuning()?
    According to mmc_send_tuning(),it seems that tuning command(CMD19/CMD21)
    is required. Thus device will not response mmc_send_tuning() if current
    speed mode doesn't support tuning command.
    Please correct me if I am wrong.
    
>>
>>>> +
>>>> +       return err;
>>>> +}
>>>> +
>>>> +static int __xenon_sdio_delay_adj_test(struct mmc_card *card)
>>>> +{
>>>> +       struct mmc_command cmd = {0};
>>>> +       int err;
>>>> +
>>>> +       cmd.opcode = SD_IO_RW_DIRECT;
>>>> +       cmd.flags = MMC_RSP_R5 | MMC_CMD_AC;
>>>> +
>>>> +       err = mmc_wait_for_cmd(card->host, &cmd, 0);
>>>> +       if (err)
>>>> +               return err;
>>>> +
>>>> +       if (cmd.resp[0] & R5_ERROR)
>>>> +               return -EIO;
>>>> +       if (cmd.resp[0] & R5_FUNCTION_NUMBER)
>>>> +               return -EINVAL;
>>>> +       if (cmd.resp[0] & R5_OUT_OF_RANGE)
>>>> +               return -ERANGE;
>>>> +       return 0;
>>>
>>> No thanks! MMC/SD/SDIO protocol code belongs in the core.
>>>
>>    For SDIO, SD_IO_RW_DIRECT command is sent to test current sampling point
>>    in PHY.
>>    Please help provide some suggestion to implement the command transfer.
> 
> Again, I think mmc_send_tuning() should be possible for you to use.
> 
> [...]
> 
>>>> +       if (mmc->card)
>>>> +               card = mmc->card;
>>>> +       else
>>>> +               /*
>>>> +                * Only valid during initialization
>>>> +                * before mmc->card is set
>>>> +                */
>>>> +               card = priv->card_candidate;
>>>> +       if (unlikely(!card)) {
>>>> +               dev_warn(mmc_dev(mmc), "card is not present\n");
>>>> +               return -EINVAL;
>>>> +       }
>>>
>>> That your host need to hold a copy of the card pointer, tells me that
>>> something is not really correct.
>>>
>>> I might be wrong, if this turns out to be a special case, but I doubt
>>> it. Although, if it *is* a special such case, we shall most likely try
>>> to extend the the mmc core layer instead of adding all these hacks in
>>> your host driver.
>>>
>>     This card pointer copies the temporary structure mmc_card
>>     used in mmc_init_card(), mmc_sd_init_card() and mmc_sdio_init_card().
>>     Since we call mmc_wait_for_cmd() to send test commands, we need a copy
>>     of that temporary mmc_card here in our host driver.
> 
> I see, thanks for clarifying.
> 
>>
>>     During PHY setting in card initialization, mmc_host->card is not updated
>>     yet with that temporary mmc_card. Thus we are not able to directly use
>>     mmc_host->card. Instead, this card pointer is introduced to enable
>>     mmc_wait_for_cmd().
>>
>>     If we can improve our host driver to send test commands without mmc_card,
>>     this card pointer can be removed.
>>     Could you please share your opinion please?
> 
> The mmc_send_tuning() API takes the mmc_host as parameter. If you
> convert to that, perhaps you would be able to remove the need to hold
> the card pointer.
> 
> BTW, the reason why mmc_send_tuning() doesn't take the card as a
> parameter, is exactly those you just described above.
> 
   Got it.
   Thanks a lot for the information.

   Thank you for the great help.

Best regards,
Hu Ziji

> [...]
> 
> Kind regards
> Uffe
> 
