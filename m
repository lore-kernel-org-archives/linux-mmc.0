From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 03/15] ARM: sunxi: Add driver for SD/MMC hosts found
 on Allwinner sunxi SoCs
Date: Mon, 5 May 2014 22:33:00 +0200
Message-ID: <CAPDyKFpAGNLaKagJ_RPt1vbz70pNWJzo-s6Ao50Mh0gFrRLN0g@mail.gmail.com>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
	<1399046249-19472-4-git-send-email-hdegoede@redhat.com>
	<CAPDyKFoinhyob7GZLgH4Dm7KdHCxj1+OpuZYKDK3OkU8RFsY8A@mail.gmail.com>
	<53678DB4.60209@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:35687 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755370AbaEEUdB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 May 2014 16:33:01 -0400
Received: by mail-qa0-f53.google.com with SMTP id ih12so3640203qab.26
        for <linux-mmc@vger.kernel.org>; Mon, 05 May 2014 13:33:00 -0700 (PDT)
In-Reply-To: <53678DB4.60209@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Chris Ball <chris@printf.net>, Emilio Lopez <emilio@elopez.com.ar>, Mike Turquette <mturquette@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com

[snip]

> On 05/05/2014 02:41 PM, Ulf Hansson wrote:
>>> +struct sunxi_mmc_host {
>>> +       struct mmc_host *mmc;
>>> +       struct regulator *vmmc;
>>
>> Instead of having a specific regulator for this driver, please use the
>> mmc_regulator_get_supply API.
>
> We cannot use mmc_regulator_get_supply because for the sunxi mmc controller
> not only vqmmc but also vmmc itself is optional, and mmc_regulator_get_supply
> calls devm_regulator_get rather then devm_regulator_get_optional for vmmc.

Is that because the mmc controller handle the power to the card or
because you have a fixed supply?

Having a fixed regulator supply could easily be set up in DT, which
then also dynamically gives you the ocr mask instead of having a them
"hard coded".

>
> Using mmc_regulator_get_supply would lead to false postive errors being logged
> on 99/100 boards.

I was kind of expecting a response like this. :-) Actually I would
prefer if we could make the API suit drivers like this one as well.

For reference, there are currently a patch being discussed which
relates to this topic.
"mmc: core: Improve support for deferred regulators"

>
>>
>>> +       struct reset_control *reset;
>>> +
>>> +       /* IO mapping base */
>>> +       void __iomem    *reg_base;
>>> +
>>> +       spinlock_t      lock;
>>> +       struct tasklet_struct manual_stop_tasklet;
>>
>> Any reason why you can't use a threaded IRQ handler instead of a tasklet?
>
> AFAIK IRQ threaded handlers always have the highest priority. When
> the manual_stop_tasklet runs we disable irqs and start polling to
> recover from an error condition, which is nothing something I want
> todo with the highest priority on the system.

To me, that seems like a good match for a threaded irq handler.

I suppose you could change priority of the kthread that executes the
threaded irq handler, if you need that.

[snip]

>>> +static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>> +{
>>> +       struct sunxi_mmc_host *host = mmc_priv(mmc);
>>> +       u32 rval;
>>> +       s32 err;
>>> +
>>> +       /* Set the power state */
>>> +       switch (ios->power_mode) {
>>> +       case MMC_POWER_ON:
>>> +               break;
>>> +
>>> +       case MMC_POWER_UP:
>>> +               if (!IS_ERR(host->vmmc)) {
>>> +                       mmc_regulator_set_ocr(host->mmc, host->vmmc, ios->vdd);
>>> +                       udelay(200);
>>> +               }
>>> +
>>> +               err = sunxi_mmc_init_host(mmc);
>>
>> So, sunxi_mmc_init_host() will ungate the clocks - but you shouldn't
>> use ->set_ios() callback to implement power save.
>>
>> Clocks should be ungated at ->probe() and gated at ->remove().
>>
>> If fine grained power save is wanted, I advise you to rework the clock
>> handling - and to build it upon runtime PM instead. Typically you
>> would do these adaptations:
>>
>> 1. Besides enabling the clocks at ->probe(), also enable runtime PM
>> and use the runtime PM auto-suspend feature.
>> 2. Add pm_runtime_get|put at the proper places in the driver.
>> 3. Implement the runtime PM callbacks (suspend|resume) and do clock
>> gating|ungating from there.
>>
>> You may refer to drivers/mmc/host/mmci.c to get an example.
>
> I'll just move the enable / disable to probe / remove for now.

Seems reasonable!

While you do that, it would be nice to have some understanding whether
the reset sequence, also performed by sunxi_mmc_init_host(), is
connected to clk gating|ungating, or a power cycle. I guess you will
find out during testing. :-)

>
>>> +               if (err) {
>>> +                       host->ferror = 1;
>>> +                       return;
>>> +               }
>>> +
>>> +               enable_irq(host->irq);

Just realize that I also think you should move the enable|disable_irq
to ->probe|remove().

That will mean you will be better prepared to implement runtime PM
support and thus make it possible to disable irqs during request
inactivity.

>>> +
>>> +               dev_dbg(mmc_dev(host->mmc), "power on!\n");
>>> +               host->ferror = 0;
>>> +               break;
>>> +
>>> +       case MMC_POWER_OFF:
>>> +               dev_dbg(mmc_dev(host->mmc), "power off!\n");
>>> +               disable_irq(host->irq);
>>> +               sunxi_mmc_exit_host(host);
>>
>> See comment above for sunxi_mmc_init_host().
>>
>>> +               if (!IS_ERR(host->vmmc))
>>> +                       mmc_regulator_set_ocr(host->mmc, host->vmmc, 0);
>>> +
>>> +               host->ferror = 0;
>>> +               break;
>>> +       }
>>> +
>>> +       /* set bus width */
>>> +       switch (ios->bus_width) {
>>> +       case MMC_BUS_WIDTH_1:
>>> +               mci_writel(host, REG_WIDTH, SDXC_WIDTH1);
>>> +               host->bus_width = 1;
>>> +               break;
>>> +       case MMC_BUS_WIDTH_4:
>>> +               mci_writel(host, REG_WIDTH, SDXC_WIDTH4);
>>> +               host->bus_width = 4;
>>> +               break;
>>> +       case MMC_BUS_WIDTH_8:
>>> +               mci_writel(host, REG_WIDTH, SDXC_WIDTH8);
>>> +               host->bus_width = 8;
>>> +               break;
>>> +       }
>>> +
>>> +       /* set ddr mode */
>>> +       rval = mci_readl(host, REG_GCTRL);
>>> +       if (ios->timing == MMC_TIMING_UHS_DDR50) {
>>> +               rval |= SDXC_DDR_MODE;
>>> +               host->ddr = 1;
>>> +       } else {
>>> +               rval &= ~SDXC_DDR_MODE;
>>> +               host->ddr = 0;
>>> +       }
>>> +       mci_writel(host, REG_GCTRL, rval);
>>> +
>>> +       /* set up clock */
>>> +       if (ios->clock && ios->power_mode) {
>>> +               dev_dbg(mmc_dev(host->mmc), "ios->clock: %d\n", ios->clock);
>>> +               sunxi_mmc_clk_set_rate(host, ios->clock);
>>> +               usleep_range(50000, 55000);
>>
>> Is those values for usleep really correct? I am not sure how many
>> times we execute this path while detecting/powering the card, but
>> quite a few.
>> Detecting/powering the card is also done during each system
>> suspend/resume cycle - thus this will heavily affect these cycles.
>
> The problem is we've no docs, so this is all based on android code, the
> android code has 2 drivers, lets call them the old and the new one.
>
> This works is based on the new driver as that one was significantly
> cleaner then the old driver. This bit comes directly from the new driver,
> but it seems that the old driver has no delay at all. And clk_set_rate
> already does a busy-wait waiting for the hardware to acknowledge the
> clock rate change, so I think this is not really necessary. I'll run
> some tests with it removed and if everything still works I'll drop it.

Okay, great!

Maybe we could add some comments, no matter what!?

[snip]

>>> +       if (cmd->opcode == MMC_GO_IDLE_STATE) {
>>> +               cmd_val |= SDXC_SEND_INIT_SEQUENCE;
>>> +               imask |= SDXC_COMMAND_DONE;
>>
>> This seems really strange! Please elaborate on why need specific
>> handling of this CMD.
>
> I've no clue, again no docs.

I see the problem. :-)

[snip]

Kind regards
Ulf Hansson
