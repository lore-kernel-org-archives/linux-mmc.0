From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [RFC 2/2] mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8
 and Meson8b SoCs
Date: Fri, 9 Jun 2017 23:51:36 +0200
Message-ID: <CAFBinCD=uH=oQmWAcsMpxtbJCnJZernZx3XoNaPixUUQ7pk76w@mail.gmail.com>
References: <20170506171857.16492-1-martin.blumenstingl@googlemail.com>
 <20170506171857.16492-3-martin.blumenstingl@googlemail.com>
 <CAPDyKFrrSLCjbXO9R4VqPpabiFsbE6_RqR=U7otVF4Ncv0jHjQ@mail.gmail.com>
 <CAFBinCD3modyyOpi3OY5XLhjX0UCuV+WPY2Z=mdvwdMCyeGoqg@mail.gmail.com> <CAPDyKFptXRPk7mVUiRHf=hECDbeyhTxuf3K1M6NkZcVEF0Enww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:34892 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbdFIVv7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jun 2017 17:51:59 -0400
In-Reply-To: <CAPDyKFptXRPk7mVUiRHf=hECDbeyhTxuf3K1M6NkZcVEF0Enww@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-amlogic@lists.infradead.org, Carlo Caione <carlo@endlessm.com>

Hi Ulf,

On Wed, Jun 7, 2017 at 6:15 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> [...]
>>>
>>>> +static void meson_mx_mmc_apply_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>> +{
>>>> +       struct meson_mx_mmc_slot *slot = mmc_priv(mmc);
>>>> +       unsigned long clk_rate = ios->clock;
>>>> +       int ret;
>>>> +
>>>> +       switch (ios->bus_width) {
>>>> +       case MMC_BUS_WIDTH_1:
>>>> +               meson_mx_mmc_mask_bits(mmc, MESON_MX_SDIO_CONF,
>>>> +                                      MESON_MX_SDIO_CONF_BUS_WIDTH, 0);
>>>> +               break;
>>>> +
>>>> +       case MMC_BUS_WIDTH_4:
>>>> +               meson_mx_mmc_mask_bits(mmc, MESON_MX_SDIO_CONF,
>>>> +                                      MESON_MX_SDIO_CONF_BUS_WIDTH,
>>>> +                                      MESON_MX_SDIO_CONF_BUS_WIDTH);
>>>> +               break;
>>>> +
>>>> +       case MMC_BUS_WIDTH_8:
>>>> +       default:
>>>> +               dev_err(mmc_dev(mmc), "unsupported bus width: %d\n",
>>>> +                       ios->bus_width);
>>>> +               slot->error = -EINVAL;
>>>> +               return;
>>>> +       }
>>>> +
>>>> +       if (clk_rate) {
>>>> +               if (WARN_ON(clk_rate > mmc->f_max))
>>>> +                       clk_rate = mmc->f_max;
>>>> +               else if (WARN_ON(clk_rate < mmc->f_min))
>>>> +                       clk_rate = mmc->f_min;
>>>> +
>>>> +               ret = clk_set_rate(slot->host->cfg_div_clk, ios->clock);
>>>> +               if (ret) {
>>>> +                       dev_warn(mmc_dev(mmc),
>>>> +                                "failed to set MMC clock to %lu: %d\n",
>>>> +                               clk_rate, ret);
>>>> +                       slot->error = ret;
>>>> +                       return;
>>>> +               }
>>>> +
>>>> +               mmc->actual_clock = clk_get_rate(slot->host->cfg_div_clk);
>>>> +       }
>>>
>>> In some cases the mmc core request the clock rate to be zero (to gate
>>> the clock) which is needed to for example switch to UHS speed mode. If
>>> you intend to support that, you need to manage this at this point.
>> thanks for the explanation - unfortunately the lack of a datasheet
>> which properly describes the clocks makes this a bit hard to
>> implement.
>> the vendor driver simply ignores any set_ios request with clock = 0
>> it seems that there is also no dedicated "stop clock" bit (and we only
>> have a clock divider). all I could find is FORCE_HALT (bit 30 in the
>> IRQC register), where the vendor driver explains: "Force halt SDIO by
>> software. Halt in this sdio host controller means stop to transmit or
>> receive data from sd card. and then sd card clock will be shutdown.
>> Software can force to halt anytime, and hardware will automatically
>> halt the sdio when reading fifo is full or writing fifo is empty"
>>
>> should I simply remove that if (...) and try to assign 0 to the clock anyways?
>
> I am not sure. Perhaps you are left with clk_disable_unprepare(), and
> hope no other is using the clock.
>
> Although, I suggest you address this as separate change on top.
OK, getting the basic thing working first sounds like a good idea

> [...]
>
>>>> +       if (!(cmd->flags & MMC_RSP_CRC))
>>>> +               send |= MESON_MX_SDIO_SEND_RESP_WITHOUT_CRC7;
>>>> +
>>>> +       if (cmd->flags & MMC_RSP_BUSY)
>>>> +               send |= MESON_MX_SDIO_SEND_CHECK_DAT0_BUSY;
>>>
>>> In case the controller has HW support of busy detection, please
>>> consider to enable MMC_CAP_WAIT_WHILE_BUSY for this driver. Then also
>>> assign host->max_busy_timeout a good value.
>> the IRQS register has bit 4 (CMD_BUSY) - but apart from that there is
>> no other documentation (about timeout values, etc.). the vendor driver
>> also neither uses MMC_CAP_WAIT_WHILE_BUSY nor host->max_busy_timeout
>> should I leave this as it is?
>
> Please don't just leave it as is. This is an important thing to get right.
>
> You should be able to explore this area and see how the controller
> behaves without too much of documentation. Regarding timeouts, it may
> very well be that the controller don't have a timeout, which is why
> you need a software timeout. That's not so uncommon actually.
during my experiments I've never seen an interrupt when a command
timed out (nor could I find information about a timeout register in
the documentation). do you have any pointers (like a previous mail
where you've explained) how I can "explore the controller's timeout
behavior"?

> [...]
>
>>>
>>>> +static void meson_mx_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>> +{
>>>> +       struct meson_mx_mmc_slot *slot = mmc_priv(mmc);
>>>> +
>>>> +       if (spin_trylock(&slot->host->lock)) {
>>>> +               /*
>>>> +                * only apply the mmc_ios if we are idle to not break any
>>>> +                * ongoing transfer. in case we are busy meson_mx_mmc_start_cmd
>>>> +                * will take care of applying the mmc_ios later on.
>>>> +                */
>>>> +               if (slot->host->status == MESON_MX_MMC_STATUS_IDLE)
>>>> +                       meson_mx_mmc_apply_ios(mmc, ios);
>>>
>>> No this doesn't work!
>>>
>>> In case the status != MESON_MX_MMC_STATUS_IDLE or if the attempt to
>>> take the lock fails, you will just silently ignore to set the new ios
>>> settings.
>>>
>>> The mmc core implements the mmc/sd/sdio specifications, so when you
>>> return from the ->set_ios() host ops, the mmc core relies on the host
>>> to have applied the settings to conform the the specs. You can not
>>> delay that to a later point.
>> OK, I did not know that this was part of the mmc/sd/sdio spec
>> the problem I (and the vendor driver) was trying to solve here is the
>> fact that we could end up with a call chain like this:
>> - slot0.set_ios(400 kHz)
>> - slot1.set_ios(50 MHz)
>> - slot0.request(cmd)
>> - slot1.request(cmd)
>> (or anything else, where the IOS change between the .set_ios and
>> .request invocation of the same slot)
>>
>> the main problem here is that the clock divider register bits are
>> shared across all slots!
>>
>> can I simply always apply the IOS here in .set_ios and then still
>> re-apply them in .request() if needed?
>
> Thinking more about this, and the answer is unfortunately *no*.
>
> The mmc core uses mmc_claim|release_host() to get exclusive access to
> operate the host via the host ops callbacks.
>
> For some cases, that involves a sequence of commands/requests being
> carried out via invoking to the host ops. During some of these
> sequences, one can definitely not allow to change ios, because another
> host/slot needs it in between. That will break the protocol - for
> sure.
>
> This also make me realize that the few other host drivers. which tries
> to supports multiple slots are all broken. On the other side, that
> just confirms my doubt about this; this is just a theoretical thing
> one want to support or used in environments that doesn't requires
> "product quality".
>
> So to be able to support "multiple slots", we need to teach the mmc
> core about hosts that supports multiple slots. This needs to be done
> in a way that mmc_claim_host() gets exclusive right to run a host, but
> without other hosts sharing the same controller are allowed to run
> in-between.
>
> It shouldn't be that hard to implement, although I strongly recommend
> you to address this in a second step. In other words, I suggest you to
> drop the entire multiple slot support in the first step, then we can
> deal with that on top instead.
many thanks for the detailed explanation again!
I would be fine with dropping multiple slot support for the moment
*if* we can agree on the fact that the devicetree binding can support
multiple slots in theory (my idea here is: keep the child-nodes with
compatible = "mmc-slot" mandatory - but only allow one such child node
for now). I don't want to break DT compatibility after a few
weeks/months for a new driver. is that OK for you as well?

> [...]
>
>>>> +static void meson_mx_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
>>>> +{
>>>> +       struct meson_mx_mmc_slot *slot = mmc_priv(mmc);
>>>> +       unsigned long irqflags;
>>>> +
>>>> +       spin_lock_irqsave(&slot->host->irq_lock, irqflags);
>>>> +
>>>> +       meson_mx_mmc_mask_bits(mmc, MESON_MX_SDIO_MULT,
>>>> +                              MESON_MX_SDIO_MULT_PORT_SEL_MASK,
>>>> +                              FIELD_PREP(MESON_MX_SDIO_MULT_PORT_SEL_MASK,
>>>> +                                         slot->id));
>>>> +
>>>> +       /* ACK pending interrupt */
>>>> +       meson_mx_mmc_mask_bits(mmc, MESON_MX_SDIO_IRQS,
>>>> +                              MESON_MX_SDIO_IRQS_IF_INT,
>>>> +                              MESON_MX_SDIO_IRQS_IF_INT);
>>>> +
>>>> +       meson_mx_mmc_mask_bits(mmc, MESON_MX_SDIO_IRQC,
>>>> +                              MESON_MX_SDIO_IRQC_ARC_IF_INT_EN,
>>>> +                              enable ? MESON_MX_SDIO_IRQC_ARC_IF_INT_EN : 0);
>>>> +
>>>> +       if (enable)
>>>> +               slot->host->sdio_irq_slot = slot;
>>>> +       else
>>>> +               slot->host->sdio_irq_slot = NULL;
>>>
>>> This looks weird. You support up to three slots per host, but only one
>>> can do sdio_irq?
>>>
>>> BTW, what happens if there are is a ongoing data transfer on an SD
>>> card slot, while there is an SDIO irq raised on the SDIO card slot? Do
>>> you cope with this correctly?
>> good question indeed. I guess I'll remove SDIO interrupt support for
>> now as I am not sure how this is supposed to work in the vendor driver
>> (which just uses the last active slot to figure out if there was an
>> SDIO interrupt)
>
> If you drop the multiple slot support, this should be easier to
> verify. However, if you prefer adding it in step on top, I am of
> course fine with that as well.
I guess I'll postpone this until I have a working wifi driver (the
rtl8723bs driver doesn't seem to work for me due to whatever reason)

> [...]
>
>>> [...]
>>>
>>> Another overall comment, which relates to the host locking mechanism
>>> and the problem with ->set_ios(). Perhaps you can look into how the
>>> cavium mmc driver has solved the similar problems as it also manages
>>> several slots per host.
>> thank your for the hint with the cavium driver. using a semaphore to
>> serialize the requests of multiple slots seems a good idea too.
>> to avoid a "broken by design" RFC v2, can you please give me some more
>> details how the cavium driver code matches with the mmc/sd/sdio spec
>> and the mmc framework?
>
> Unfortunate no, you will have to ask the cavium folkz about these
> details. However, it may very well be that this is also broken,
> according to my comments about multiple slot support.
OK, I guess (like you explained above) it's easier to not look at any
maybe-broken (existing) implementations and try to add multi slot
support to the MMC core instead (I will open a separate topic for this
on linux-mmc once I have a bit more time)

>>
>> as I explained above the clock divider and bus-width register bits are
>> shared across all slots. so if one device operates in 1-bit mode while
>> the other uses 4-bit mode (or different clock rates, it just doesn't
>> matter) then we need to make sure that these settings stay the same
>> between .set_ios() and .request, until the request is completed
>> (regardless of whether that was successful or not/a timeout occurred).
>>
>> from what I can read in the cavium driver (where the situation seems
>> to be the same), it uses acquire_bus() at the beginning of
>> .set_ios/.request and release_bus() at the end of it and keeping a
>> backup of the registers which are modified during .set_ios. once it
>> switches to a different slot it restores the register values for the
>> new slot (this can also happen in .request). this solves the problem
>> of keeping the correct IOS when switching slots at any point
>
> Yes, then it seems like also this driver is broken.
>
>>
>> however, what I don't understand so far is how it synchronizes the
>> access to the CMD response bits which are read in the interrupt. what
>> if slot0 sends a command, then right after that (before the the card
>> in slot0 replied) slot1 sends a command -> how is it going to know to
>> which slot the response belongs? (I am facing the same problem with
>> the the meson-mx-sdio driver, the solution is to allow only one
>> request at a time and queue all other requests -> I am not sure if
>> this is good solution though)
>
> I assume the lock is held throughout the entire period serving a
> request. However that doesn't cover all scenarios, as explained above.
OK, I guess we're done with that topic now - let's skip multi slot
support for version one of my driver


Regards,
Martin
