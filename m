From: Ziji Hu <huziji@marvell.com>
Subject: Re: [PATCH 6/10] mmc: sdhci-xenon: Add Marvell Xenon SDHC core
 functionality
Date: Thu, 24 Nov 2016 23:00:55 +0800
Message-ID: <76ce72f8-4b86-3b83-544f-b9a7ef871393@marvell.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <0390e7a05b6163deabb545f93729ea615eeaaee2.1477911954.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFpqPSqiEi=0UW5LoZmy+y-KHm9nbcGKBSy3RzchdLU9cA@mail.gmail.com>
 <dd230463-04f6-df31-7056-1a185eb6cfc7@marvell.com>
 <CAPDyKFr9uEjVQmTNP0KK8Zj9mxCW3i564E=47vTK0RLvXCjw3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFr9uEjVQmTNP0KK8Zj9mxCW3i564E=47vTK0RLvXCjw3Q@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Jimmy Xu <zmxu@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Romain Perier <romain.perier@free-electrons.com>, Hanna Hawa <hannah@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Zhen Huang <huangzh@marvell.com>, Victor Gu <xigu@marvell.com>, Doug Jones <dougj@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Rob Herring <robh+dt@kernel.org>, Ryan Gao <ygao@marvell.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Marcin Wojtas <mw@semihalf.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-mmc@vger.
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On 2016/11/24 21:34, Ulf Hansson wrote:
> On 24 November 2016 at 13:41, Ziji Hu <huziji@marvell.com> wrote:
>> Hi Ulf,
>>
>> On 2016/11/24 18:43, Ulf Hansson wrote:
>>> On 31 October 2016 at 12:09, Gregory CLEMENT
>>> <gregory.clement@free-electrons.com> wrote:
>>>> From: Ziji Hu <huziji@marvell.com>
>>>>
>> <snip>
>>>> +static int xenon_emmc_signal_voltage_switch(struct mmc_host *mmc,
>>>> +                                           struct mmc_ios *ios)
>>>> +{
>>>> +       unsigned char voltage = ios->signal_voltage;
>>>> +
>>>> +       if ((voltage == MMC_SIGNAL_VOLTAGE_330) ||
>>>> +           (voltage == MMC_SIGNAL_VOLTAGE_180))
>>>> +               return __emmc_signal_voltage_switch(mmc, voltage);
>>>> +
>>>> +       dev_err(mmc_dev(mmc), "Unsupported signal voltage: %d\n",
>>>> +               voltage);
>>>> +       return -EINVAL;
>>>
>>> This wrapper function seems unnessarry. It only adds a dev_err(), so
>>> then might as well do that in __emmc_signal_voltage_switch().
>>>
>>      Sure. Will merge it back to __emmc_signal_voltage_switch().
>>
>>>> +}
>>>> +
>>>> +static int xenon_start_signal_voltage_switch(struct mmc_host *mmc,
>>>> +                                            struct mmc_ios *ios)
>>>> +{
>>>> +       struct sdhci_host *host = mmc_priv(mmc);
>>>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>> +       struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>>>> +
>>>> +       /*
>>>> +        * Before SD/SDIO set signal voltage, SD bus clock should be
>>>> +        * disabled. However, sdhci_set_clock will also disable the Internal
>>>> +        * clock in mmc_set_signal_voltage().
>>>
>>> If that's the case then that is wrong in the generic sdhci code.
>>> What's the reason why it can't be fixed there instead of having this
>>> workaround?
>>>
>>     In my very own opinion, SD Spec doesn't specify whether SDCLK should be
>>     enabled or not during power setting.
>>     Enabling SDCLK might be a special condition only required by our SDHC.
>>     I try to avoid breaking other vendors' SDHC functionality
>>     if their SDHCs require SDCLK disabled.
>>     Thus I prefer to keep it inside our SDHC driver.
> 
> I let Adrian comment on this.
> 
> For sure we should avoid breaking other sdhci variant, but on the
> other hand *if* the generic code is wrong we should fix it!
> 
    Of course.

>>
>>>> +        * If Internal clock is disabled, the 3.3V/1.8V bit can not be updated.
>>>> +        * Thus here manually enable internal clock.
>>>> +        *
>>>> +        * After switch completes, it is unnecessary to disable internal clock,
>>>> +        * since keeping internal clock active obeys SD spec.
>>>> +        */
>>>> +       enable_xenon_internal_clk(host);
>>>> +
>>>> +       if (priv->emmc_slot)
>>>> +               return xenon_emmc_signal_voltage_switch(mmc, ios);
>>>> +
>>>> +       return sdhci_start_signal_voltage_switch(mmc, ios);
>>>> +}
>>>> +
>>>> +/*
>>>> + * After determining which slot is used for SDIO,
>>>> + * some additional task is required.
>>>> + */
>>>> +static void xenon_init_card(struct mmc_host *mmc, struct mmc_card *card)
>>>> +{
>>>> +       struct sdhci_host *host = mmc_priv(mmc);
>>>> +       u32 reg;
>>>> +       u8 slot_idx;
>>>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>> +       struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>>>> +
>>>> +       /* Link the card for delay adjustment */
>>>> +       priv->card_candidate = card;
>>>> +       /* Set tuning functionality of this slot */
>>>> +       xenon_slot_tuning_setup(host);
>>>
>>> This looks weird. I assume this can be done as a part of the regular
>>> tuning seqeunce!?
>>>
>>     It is our SDHC specific preparation prior to tuning, rather than a
>>     standard step in spec.
>>     Thus I leave it inside our driver.
> 
> My point is that this isn't the purpose of ->init_card(). thus you are
> abusing it.
> 
> Try to make it work in another way, please. I think you can.
> 
   Got it.
   I will move it to our host specific probe function.

>>
>>>> +
>>>> +       slot_idx = priv->slot_idx;
>>>> +       if (!mmc_card_sdio(card)) {
>>>> +               /* Clear SDIO Card Inserted indication */
>>>
>>> Why do you need this?
>>>
>>> If you need to reset this, I think it's better to do it from
>>> ->set_ios() at MMC_POWER_OFF.
>>>
>>     This field indicates SDIO card and controls async interrupt feature
>>     of SDIO in our SDHC.
>>     This async interrupt feature is enabled when SDIO card is inserted.
>>     It should be disabled if SD card is inserted instead.
> 
> What do you mean by SDIO async interupts? Are you talking about SDIO
> irqs on DAT1 line?
> 
> Those is supposed to be enabled when someone explicitly requests them,
> not when the card is inserted.
> In other words when an SDIO func driver have called sdio_claim_irq().
> 
> Moreover, we have ->enable_sdio_irq() ops that deals with this.
> 
   Yes. I mean the SDIO irqs on DAT1 line in async mode.
   This field enables our host to recognize the async SDIO irq from SDIO device.
   It controls our host side behavior, other than the SDIO device.

   I think ->enable_sdio_irq() is a more reasonable place to put this workraound.
   I will export sdhci_enable_sdio_irq() and implement out host own
   enable_sdio_irq() calling sdhci_enable_sdio)irq() plus this workaround.
   Does it sound reasonable to you?

> [...]
> 
>>>> +
>>>> +       /*
>>>> +        * Xenon Specific property:
>>>> +        * emmc: explicitly indicate whether this slot is for eMMC
>>>> +        * slotno: the index of slot. Refer to SDHC_SYS_CFG_INFO register
>>>> +        * tun-count: the interval between re-tuning
>>>> +        * PHY type: "sdhc phy", "emmc phy 5.0" or "emmc phy 5.1"
>>>> +        */
>>>> +       if (of_property_read_bool(np, "marvell,xenon-emmc"))
>>>> +               priv->emmc_slot = true;
>>>
>>> So, you need this because of the eMMC voltage switch behaviour, right?
>>>
>>> Then I would rather like to describe this a generic DT bindings for
>>> the eMMC voltage level support. There have acutally been some earlier
>>> discussions for this, but we haven't yet made some changes.
>>>
>>> I think what is missing is a mmc-ddr-3_3v DT binding, which when set,
>>> allows the host driver to accept I/O voltage switches to 3.3V. If not
>>> supported the  ->start_signal_voltage_switch() ops may return -EINVAL.
>>> This would inform the mmc core to move on to the next supported
>>> voltage level. There might be some minor additional changes to the mmc
>>> card initialization sequence, but those should be simple.
>>>
>>> I can help out to look into this, unless you want to do it yourself of course!?
>>>
>>    Yes. One of the reasons is to provide eMMC specific voltage setting.
>>    But in my very own opinion, it should be irrelevant to voltage level.
>>    The eMMC voltage setting on our SDHC is different from SD/SDIO voltage switch.
>>    It will become more complex with different SOC implementation details.
> 
> Got it. Although I think we can cope with that fine just by using the
> different SD/eMMC speed modes settings defined in DT (or from the
> SDHCI caps register)
> 
    In my very opinion, I'm not sure if there is any corner case that driver cannot
    determine the eMMC card type from DT and SDHC caps.

>>    Unfortunately, MMC driver cannot determine the card type yet when eMMC voltage
>>    setting should be executed.
>>    Thus an flag is required here to tell driver to execute eMMC voltage setting.
>>
>>    Besides, additional eMMC specific settings might be implemented in future, besides
>>    voltage setting. Most of them should be completed before MMC driver recognizes the
>>    card type. Thus I have to keep this flag to indicate current SDHC is for eMMC.
> 
> I doubt you will need a generic "eMMC" flag, but let's see when we go forward.
> 
> Currently it's clear you don't need such a flag, so I will submit a
> change adding a DT binding for "mmc-ddr-3_3v" then we can take it from
> there, to see if it suits your needs.
> 

    Actually, our eMMC is usually fixed as 1.8V.

    The pair "no-sd" + "no-sdio" can provide the similar information.
    But I'm not sure if it is proper to use those two property in such a way.

    Thank you.

Best regards
Hu Ziji

> [...]
> 
> Kind regards
> Uffe
> 
