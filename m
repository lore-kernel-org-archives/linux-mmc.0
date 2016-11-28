From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 7/10] mmc: sdhci-xenon: Add support to PHYs of Marvell
 Xenon SDHC
Date: Mon, 28 Nov 2016 16:16:34 +0100
Message-ID: <CAPDyKFr8rX04iY92OeQpSkS+3HN2-FxijCCiDb2sSKvP+TZPog@mail.gmail.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <a05ffd140f4edc02fc3128db8445b2264cf38723.1477911954.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFpkcoVMKbVOwjX1WDyNgc1vvUX60D6XRX6=YHGvkvHvnA@mail.gmail.com>
 <3cd05a26-d340-476e-bab1-8be9d5446f47@marvell.com> <CAPDyKFrskyZvMwhmj8ioyaowU8GL5=d-6ipGQcmmig_a9E9AQQ@mail.gmail.com>
 <436c6925-cb0d-afe7-e3a2-384eca15ff42@marvell.com> <8359307d-5f44-3db9-aae1-eb1fe8e1141d@marvell.com>
 <CAPDyKFo3ezYOywtSZ8GGQ1XK9KPsxCgQNbaiz45EVgbgtnUxjg@mail.gmail.com> <10a885f0-82e9-a35c-f62f-3fc4518ea8b4@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <10a885f0-82e9-a35c-f62f-3fc4518ea8b4-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Jimmy Xu <zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ryan Gao <ygao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Doug Jones <dougj-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Wei(SOCP) Liu" <liuw-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 28 November 2016 at 12:38, Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org> wrote:
> Hi Ulf,
>
> On 2016/11/28 19:13, Ulf Hansson wrote:
>>>
>>>     As you suggest, I replace mmc_wait_for_cmd() with mmc_send_tuning(), to
>>>     send commands for testing current sampling point set in our host PHY.
>>>
>>>     According to my test result, it shows that mmc_send_tuning() can only support
>>>     tuning command (CMD21/CMD19).
>>>     As a result, we cannot use mmc_send_tuning() when card is in the speed modes
>>>     which doesn't support tuning, such as eMMC HS SDR, eMMC HS DRR and
>>>     SD SDR 12/SDR25/DDR50. Card will not response to tuning commands in those
>>>     speed modes.
>>>
>>>     Could you please provide suggestions for the speed mode in which tuning is
>>>     not available?
>>>
>>
>> Normally the mmc host driver shouldn't have to care about what the
>> card supports, as that is the responsibility of the mmc core to
>> manage.
>>
>> The host should only need to implement the ->execute_tuning() ops,
>> which gets called when the card supports tuning (CMD19/21). Does it
>> make sense?
>>
>    I think it is irrelevant to tuning procedure.
>
>    Our host requires to adjust PHY setting after each time ios setting
>    (SDCLK/bus width/speed mode) is changed.
>    The simplified sequence is:
>    mmc change ios --> mmc_set_ios() --> ->set_ios() --> after sdhci_set_ios(),
>    adjust PHY setting.
>    During PHY setting adjustment, out host driver has to send commands to
>    test current sampling point. Tuning is another independent step.

For those speed modes (or other ios changes) that *don't* requires
tuning, then what will you do when you send the command to confirm the
change of PHY setting and it fails?

My assumption is that you will fail anyway, by propagating the error
to the mmc core. At least that what was my understanding from your
earlier replies, right!?

Then, I think there are no point having the host driver sending a
command to confirm the PHY settings, as the mmc core will anyway
discover if something goes wrong when the next command is sent.

Please correct me if I am wrong!

>
>    Thus our host needs a valid command in PHY setting adjustment. Tuning command
>    can be borrowed to complete this task in SD SDR50. But for other speed mode,
>    we have to find out a valid command.

I thought we agreed on this wasn't necessary? Please see my upper response.

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
