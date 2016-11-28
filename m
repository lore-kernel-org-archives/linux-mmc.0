From: Ziji Hu <huziji@marvell.com>
Subject: Re: [PATCH 7/10] mmc: sdhci-xenon: Add support to PHYs of Marvell
 Xenon SDHC
Date: Mon, 28 Nov 2016 18:10:56 +0800
Message-ID: <8359307d-5f44-3db9-aae1-eb1fe8e1141d@marvell.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <a05ffd140f4edc02fc3128db8445b2264cf38723.1477911954.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFpkcoVMKbVOwjX1WDyNgc1vvUX60D6XRX6=YHGvkvHvnA@mail.gmail.com>
 <3cd05a26-d340-476e-bab1-8be9d5446f47@marvell.com>
 <CAPDyKFrskyZvMwhmj8ioyaowU8GL5=d-6ipGQcmmig_a9E9AQQ@mail.gmail.com>
 <436c6925-cb0d-afe7-e3a2-384eca15ff42@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <436c6925-cb0d-afe7-e3a2-384eca15ff42@marvell.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jimmy Xu <zmxu@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Romain Perier <romain.perier@free-electrons.com>, Hanna Hawa <hannah@marvell.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Doug Jones <dougj@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Rob Herring <robh+dt@kernel.org>, Ryan Gao <ygao@marvell.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Marcin Wojtas <mw@semihalf.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-ele>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On 2016/11/24 23:37, Ziji Hu wrote:
> Hi Ulf,
> 
> On 2016/11/24 22:33, Ulf Hansson wrote:
<snip>
>>>
>>>    As result, our SDHC driver has to implement the functionality to
>>>    send commands and check the results, in host layer.
>>>    If directly calling mmc_wait_for_cmd() is improper, could you please
>>>    give us some suggestions?
>>>
>>>    For eMMC, CMD8 is used to test current sampling point set in PHY.
>>
>> Try to use mmc_send_tuning().
>>
> 
>     Could you please tell me the requirement of "op_code" parameter in
>     mmc_send_tuning()?
>     According to mmc_send_tuning(),it seems that tuning command(CMD19/CMD21)
>     is required. Thus device will not response mmc_send_tuning() if current
>     speed mode doesn't support tuning command.
>     Please correct me if I am wrong.
>

    As you suggest, I replace mmc_wait_for_cmd() with mmc_send_tuning(), to
    send commands for testing current sampling point set in our host PHY.

    According to my test result, it shows that mmc_send_tuning() can only support
    tuning command (CMD21/CMD19).
    As a result, we cannot use mmc_send_tuning() when card is in the speed modes
    which doesn't support tuning, such as eMMC HS SDR, eMMC HS DRR and
    SD SDR 12/SDR25/DDR50. Card will not response to tuning commands in those
    speed modes.

    Could you please provide suggestions for the speed mode in which tuning is
    not available?

    Thank you.

Best regards,
Hu Ziji

>>>
>>>>> +
>>>>> +       return err;
>>>>> +}
>>>>> +
>>>>> +static int __xenon_sdio_delay_adj_test(struct mmc_card *card)
>>>>> +{
>>>>> +       struct mmc_command cmd = {0};
>>>>> +       int err;
>>>>> +
>>>>> +       cmd.opcode = SD_IO_RW_DIRECT;
>>>>> +       cmd.flags = MMC_RSP_R5 | MMC_CMD_AC;
>>>>> +
>>>>> +       err = mmc_wait_for_cmd(card->host, &cmd, 0);
>>>>> +       if (err)
>>>>> +               return err;
>>>>> +
>>>>> +       if (cmd.resp[0] & R5_ERROR)
>>>>> +               return -EIO;
>>>>> +       if (cmd.resp[0] & R5_FUNCTION_NUMBER)
>>>>> +               return -EINVAL;
>>>>> +       if (cmd.resp[0] & R5_OUT_OF_RANGE)
>>>>> +               return -ERANGE;
>>>>> +       return 0;
>>>>
>>>> No thanks! MMC/SD/SDIO protocol code belongs in the core.
>>>>
>>>    For SDIO, SD_IO_RW_DIRECT command is sent to test current sampling point
>>>    in PHY.
>>>    Please help provide some suggestion to implement the command transfer.
>>
>> Again, I think mmc_send_tuning() should be possible for you to use.
>>
>> [...]
>>
>>>>> +       if (mmc->card)
>>>>> +               card = mmc->card;
>>>>> +       else
>>>>> +               /*
>>>>> +                * Only valid during initialization
>>>>> +                * before mmc->card is set
>>>>> +                */
>>>>> +               card = priv->card_candidate;
>>>>> +       if (unlikely(!card)) {
>>>>> +               dev_warn(mmc_dev(mmc), "card is not present\n");
>>>>> +               return -EINVAL;
>>>>> +       }
>>>>
>>>> That your host need to hold a copy of the card pointer, tells me that
>>>> something is not really correct.
>>>>
>>>> I might be wrong, if this turns out to be a special case, but I doubt
>>>> it. Although, if it *is* a special such case, we shall most likely try
>>>> to extend the the mmc core layer instead of adding all these hacks in
>>>> your host driver.
>>>>
>>>     This card pointer copies the temporary structure mmc_card
>>>     used in mmc_init_card(), mmc_sd_init_card() and mmc_sdio_init_card().
>>>     Since we call mmc_wait_for_cmd() to send test commands, we need a copy
>>>     of that temporary mmc_card here in our host driver.
>>
>> I see, thanks for clarifying.
>>
>>>
>>>     During PHY setting in card initialization, mmc_host->card is not updated
>>>     yet with that temporary mmc_card. Thus we are not able to directly use
>>>     mmc_host->card. Instead, this card pointer is introduced to enable
>>>     mmc_wait_for_cmd().
>>>
>>>     If we can improve our host driver to send test commands without mmc_card,
>>>     this card pointer can be removed.
>>>     Could you please share your opinion please?
>>
>> The mmc_send_tuning() API takes the mmc_host as parameter. If you
>> convert to that, perhaps you would be able to remove the need to hold
>> the card pointer.
>>
>> BTW, the reason why mmc_send_tuning() doesn't take the card as a
>> parameter, is exactly those you just described above.
>>
>    Got it.
>    Thanks a lot for the information.
> 
>    Thank you for the great help.
> 
> Best regards,
> Hu Ziji
> 
>> [...]
>>
>> Kind regards
>> Uffe
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
