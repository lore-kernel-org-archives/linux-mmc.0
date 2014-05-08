From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 03/15] ARM: sunxi: Add driver for SD/MMC hosts found
 on Allwinner sunxi SoCs
Date: Thu, 8 May 2014 14:17:04 +0200
Message-ID: <CAPDyKFqbN61EgiTbktL-vm+L7q06OTeedCTVXJsP16ZZZd8g8A@mail.gmail.com>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
	<1399046249-19472-4-git-send-email-hdegoede@redhat.com>
	<CAPDyKFoinhyob7GZLgH4Dm7KdHCxj1+OpuZYKDK3OkU8RFsY8A@mail.gmail.com>
	<53678DB4.60209@redhat.com>
	<CAPDyKFpAGNLaKagJ_RPt1vbz70pNWJzo-s6Ao50Mh0gFrRLN0g@mail.gmail.com>
	<536B69FA.5090600@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:45938 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbaEHMRJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 May 2014 08:17:09 -0400
Received: by mail-qa0-f42.google.com with SMTP id j5so2496662qaq.1
        for <linux-mmc@vger.kernel.org>; Thu, 08 May 2014 05:17:08 -0700 (PDT)
In-Reply-To: <536B69FA.5090600@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Chris Ball <chris@printf.net>, Emilio Lopez <emilio@elopez.com.ar>, Mike Turquette <mturquette@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com

On 8 May 2014 13:26, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 05/05/2014 10:33 PM, Ulf Hansson wrote:
>> [snip]
>>
>>> On 05/05/2014 02:41 PM, Ulf Hansson wrote:
>>>>> +struct sunxi_mmc_host {
>>>>> +       struct mmc_host *mmc;
>>>>> +       struct regulator *vmmc;
>>>>
>>>> Instead of having a specific regulator for this driver, please use the
>>>> mmc_regulator_get_supply API.
>>>
>>> We cannot use mmc_regulator_get_supply because for the sunxi mmc controller
>>> not only vqmmc but also vmmc itself is optional, and mmc_regulator_get_supply
>>> calls devm_regulator_get rather then devm_regulator_get_optional for vmmc.
>>
>> Is that because the mmc controller handle the power to the card or
>> because you have a fixed supply?
>>
>> Having a fixed regulator supply could easily be set up in DT, which
>> then also dynamically gives you the ocr mask instead of having a them
>> "hard coded".
>
> It is because the sdcard slot power tends to be hooked directly to the 3.3V
> of the board. So in a sense this is a fixed regulator, but I really, REALLY
> don't want to add fixed regulator boilerplate to all sunxi dts files for this.

So, how would you then distinguish between let's say a 3.1V and 3.3V
fixed regulator? That is something that is board specific, thus I
don't think you can get away from not adding them to DT.

Don't forget, the ocr mask is needed to be able negotiate the voltage
level with the card at initialization.

>
> In other subsystems where there are similar cases (ie ahci-platform, supply for
> various ethernet phys), the regulator is always optional and does not need
> to be specified in the dts when the device is just hardwired to the power.

Maybe because the voltage level is not needed to be negotiated during
initialization?

>
>>
>>>
>>> Using mmc_regulator_get_supply would lead to false postive errors being logged
>>> on 99/100 boards.
>>
>> I was kind of expecting a response like this. :-) Actually I would
>> prefer if we could make the API suit drivers like this one as well.
>>
>> For reference, there are currently a patch being discussed which
>> relates to this topic.
>> "mmc: core: Improve support for deferred regulators"
>
> Ok, so that patch seems to replace the somewhat alarming message
> reported by devm_regulator_get by an acceptable:
>
> dev_info(dev, "No vmmc regulator found\n");
>
> I can live with that, so I'm going to assume that something like that
> patch will get merged in the near future and I'll switch to mmc_regulator_get_supply
> in the next version and just live with the error messages this causes for now.

Great! :-)

>
>>>>> +       struct reset_control *reset;
>>>>> +
>>>>> +       /* IO mapping base */
>>>>> +       void __iomem    *reg_base;
>>>>> +
>>>>> +       spinlock_t      lock;
>>>>> +       struct tasklet_struct manual_stop_tasklet;
>>>>
>>>> Any reason why you can't use a threaded IRQ handler instead of a tasklet?
>>>
>>> AFAIK IRQ threaded handlers always have the highest priority. When
>>> the manual_stop_tasklet runs we disable irqs and start polling to
>>> recover from an error condition, which is nothing something I want
>>> todo with the highest priority on the system.
>>
>> To me, that seems like a good match for a threaded irq handler.
>
> Ok, I've done some reading up on threaded irq handlers and I'll
> I'll convert this to a threaded irq handler (only using the thread for the error
> handling case).
>
> <snip>
>
>>>>> +               if (err) {
>>>>> +                       host->ferror = 1;
>>>>> +                       return;
>>>>> +               }
>>>>> +
>>>>> +               enable_irq(host->irq);
>>
>> Just realize that I also think you should move the enable|disable_irq
>> to ->probe|remove().
>>
>> That will mean you will be better prepared to implement runtime PM
>> support and thus make it possible to disable irqs during request
>> inactivity.
>
> Ok.
>
> <snip>
>
>>>>> +       /* set up clock */
>>>>> +       if (ios->clock && ios->power_mode) {
>>>>> +               dev_dbg(mmc_dev(host->mmc), "ios->clock: %d\n", ios->clock);
>>>>> +               sunxi_mmc_clk_set_rate(host, ios->clock);
>>>>> +               usleep_range(50000, 55000);
>>>>
>>>> Is those values for usleep really correct? I am not sure how many
>>>> times we execute this path while detecting/powering the card, but
>>>> quite a few.
>>>> Detecting/powering the card is also done during each system
>>>> suspend/resume cycle - thus this will heavily affect these cycles.
>>>
>>> The problem is we've no docs, so this is all based on android code, the
>>> android code has 2 drivers, lets call them the old and the new one.
>>>
>>> This works is based on the new driver as that one was significantly
>>> cleaner then the old driver. This bit comes directly from the new driver,
>>> but it seems that the old driver has no delay at all. And clk_set_rate
>>> already does a busy-wait waiting for the hardware to acknowledge the
>>> clock rate change, so I think this is not really necessary. I'll run
>>> some tests with it removed and if everything still works I'll drop it.
>>
>> Okay, great!
>>
>> Maybe we could add some comments, no matter what!?
>
> Yeah I'll add a comment that there used to be a usleep there :)
>
> Regards,
>
> Hans
