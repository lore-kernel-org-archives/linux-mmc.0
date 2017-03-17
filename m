From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v12 2/9] mmc: cavium: Add core MMC driver for Cavium SOCs
Date: Fri, 17 Mar 2017 14:47:16 +0100
Message-ID: <CAPDyKFrkvDx-xNwxCFEq5zck-kB2guTpK_Vg8LSHaGudPtNbwA@mail.gmail.com>
References: <20170310132507.32025-1-jglauber@cavium.com> <20170310132507.32025-3-jglauber@cavium.com>
 <CAPDyKFqW7-JiNZTpCEUv+=Hf_rLh4x89h+i7_9UUwmxRERg_5A@mail.gmail.com> <20170317133453.GA2739@hardcore>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f174.google.com ([209.85.217.174]:35936 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbdCQNsl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Mar 2017 09:48:41 -0400
Received: by mail-ua0-f174.google.com with SMTP id 72so44222923uaf.3
        for <linux-mmc@vger.kernel.org>; Fri, 17 Mar 2017 06:47:18 -0700 (PDT)
In-Reply-To: <20170317133453.GA2739@hardcore>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, David Daney <david.daney@cavium.com>

[...]

>> > +
>> > +const char *cvm_mmc_irq_names[] = {
>> > +       "MMC Buffer",
>> > +       "MMC Command",
>> > +       "MMC DMA",
>> > +       "MMC Command Error",
>> > +       "MMC DMA Error",
>> > +       "MMC Switch",
>> > +       "MMC Switch Error",
>> > +       "MMC DMA int Fifo",
>> > +       "MMC DMA int",
>> > +};
>>
>> Debug-leftover?
>>
>> [...]
>
> No, this is used by both Octeon and ThunderX drivers. Maybe I should
> have put it into an extra patch.

No, it's fine let's keep here.

>
>> > +
>> > +static void cvm_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>> > +{
>> > +       struct cvm_mmc_slot *slot = mmc_priv(mmc);
>> > +       struct cvm_mmc_host *host = slot->host;
>> > +       int clk_period = 0, power_class = 10, bus_width = 0;
>> > +       u64 clock, emm_switch;
>> > +
>> > +       host->acquire_bus(host);
>> > +       cvm_mmc_switch_to(slot);
>> > +
>> > +       /* Set the power state */
>> > +       switch (ios->power_mode) {
>> > +       case MMC_POWER_ON:
>> > +               break;
>> > +
>> > +       case MMC_POWER_OFF:
>> > +               cvm_mmc_reset_bus(slot);
>> > +
>> > +               if (host->global_pwr_gpiod)
>> > +                       gpiod_set_value_cansleep(host->global_pwr_gpiod, 0);
>>
>> If I have understood the changelog correctly this GPIO is shared for
>> all slots, right?
>
> Yes.
>
>> In such case, this doesn't work. You need to centralize the management
>> of this GPIO pin (to enable reference counting), as otherwise one slot
>> can decide to power off its card while another still uses their card
>> and expecting the power to be on.
>
> OK. I could create a function in the shared part with ref counting.
> On the other side, only the existing Octeon HW will use the global_pwr_gpiod,
> and this HW only has one slot. For all new HW we'll use the GPIO regulator,
> so I think it is not worth changing it. I'll add a comment.

In such case, let's not make it part of the cavium core set ios
function. Instead leave it to the octeon variant to deal with this.

>
>> Another option would be to model it as GPIO regulator (using a device
>> tree overlay as we discussed earlier), then you get the reference
>> counting for free - and easily get ocr_avail mask from the mmc core's
>> regulator API. :-)
>>
>
> No, this is what I already do in case host->global_pwr_gpiod is not set.

Yes, that was my point. You would be able to remove some code both in
cavium core and octeon variant.

>
>> Moreover, I didn't find this GPIO being documented as a DT binding, it
>> should and it should also be marked as deprecated.
>
> Good point, I'll add it.

Great!

[...]

>> > +               break;
>> > +       case 4:
>> > +               slot->bus_width = 1;
>> > +               slot->mmc->caps = MMC_CAP_4_BIT_DATA;
>> > +               break;
>> > +       case 1:
>> > +               slot->bus_width = 0;
>> > +               break;
>> > +       }
>>
>> I would rather make the deprecated bindings to take the lowest
>> precedence and besides, this bus_width setup looks messy. How about
>> something like this instead:
>
> Previously you said I should parse deprecated bindings first, so I did
> that ;-

Yes, I remember that now. Sorry! :-)

However, my point is about which binding that has the highest precedence.

>
>> mmc_of_parse();
>>
>> if (!(mmc->caps & (MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA))) {
>>     of_property_read_u32(node, "cavium,bus-max-width", &bus_width);
>>     if (bus_width == 8)
>>           mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA;
>>     else if (bus_width == 4)
>>           mmc->caps |= MMC_CAP_4_BIT_DATA;
>> }
>
> OK.
>
>> > +
>> > +       /* Set maximum and minimum frequency */
>> > +       if (f_max)
>> > +               mmc->f_max = f_max;
>>
>> Again, let's make sure the deprecated bindings takes lower precedence.
>> Thus if mmc->f_max has a value let's use that and if not, then parse
>> the deprecated DT binding and use that value instead.
>
> OK.
>

Great!

>> > +       if (!mmc->f_max || mmc->f_max > 52000000)
>> > +               mmc->f_max = 52000000;
>> > +       mmc->f_min = 400000;
>> > +
>> > +       /* Sampling register settings, period in picoseconds */
>> > +       clock_period = 1000000000000ull / slot->host->sys_freq;
>> > +       slot->cmd_cnt = (cmd_skew + clock_period / 2) / clock_period;
>> > +       slot->dat_cnt = (dat_skew + clock_period / 2) / clock_period;
>> > +
>> > +       return id;
>> > +}
>>
>> [...]
>>
>> > diff --git a/drivers/mmc/host/cavium-mmc.h b/drivers/mmc/host/cavium-mmc.h
>> > new file mode 100644
>> > index 0000000..c3843448
>> > --- /dev/null
>> > +++ b/drivers/mmc/host/cavium-mmc.h
>>
>> [...]
>>
>>  +
>> > +/* Protoypes */
>> > +irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id);
>> > +int cvm_mmc_of_slot_probe(struct device *dev, struct cvm_mmc_host *host);
>> > +int cvm_mmc_of_slot_remove(struct cvm_mmc_slot *slot);
>> > +extern const char *cvm_mmc_irq_names[];
>>
>> Debug leftover?
>
> No, as I said before this is the interface I need for sharing
> cavium-mmc.c and using it from the Octeon and ThunderX drivers.
>
> Should I put the interface into a separate patch (together with the
> interrupt names)?

No, it's fine!

Kind regards
Uffe
