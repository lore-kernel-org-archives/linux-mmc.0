From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: Consider HLE errors to be data and command errors
Date: Wed, 18 May 2016 10:37:52 -0700
Message-ID: <CAD=FV=UoT2GRYWJWXEn_ccvKGgC+PzQM_BCtLHAa7jxzbaQ9SA@mail.gmail.com>
References: <1426002490-2014-1-git-send-email-dianders@chromium.org>
 <5502CA4E.9060401@samsung.com> <CAD=FV=VX3ix-j4y95W1q8b-aVuVEN+4xsd8WLx2xcE7KPNJwRw@mail.gmail.com>
 <5506707D.40708@samsung.com> <55189F04.8000404@samsung.com>
 <CAD=FV=WFAZqAsXOqunt0fxw87M-FruwUrxuzW0MJsG6UvfSjzA@mail.gmail.com>
 <CAD=FV=UJGcwa_biSCGhD=kS-T+fppCniBFfOHb5ohnwSwSwMMA@mail.gmail.com>
 <573BCC8D.5090606@kernel-upstream.org> <CAD=FV=VneQR3wurjezBkRhtQiH+q-FfhDN8=Ym=XqtZpVmsdUw@mail.gmail.com>
 <573C3283.1040606@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <573C3283.1040606@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Alexandru Stan <amstan@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, May 18, 2016 at 2:14 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Hi
>
>
> On 2016-5-18 12:12, Doug Anderson wrote:
>>
>> Hi,
>>
>> On Tue, May 17, 2016 at 6:59 PM, Shawn Lin
>> <shawn.lin@kernel-upstream.org> wrote:
>>>
>>> Could you try this patch to see if you can still find HLE?
>>>
>>> @@ -2356,12 +2356,22 @@ static void dw_mci_cmd_interrupt(struct dw_mci
>>> *host, u32 status)
>>>   static void dw_mci_handle_cd(struct dw_mci *host)
>>>   {
>>>          int i;
>>> +       int present;
>>>
>>>          for (i = 0; i < host->num_slots; i++) {
>>>                  struct dw_mci_slot *slot = host->slot[i];
>>>
>>>                  if (!slot)
>>>                          continue;
>>>
>>> +               present = !(mci_readl(slot->host, CDETECT) & (1 <<
>>> slot->id));
>>> +               if (present)
>>> +                       set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
>>> +               else
>>> +                       clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
>>
>>
>> No, because we don't use the builtin card detect on veyron.  ;)
>>
>> We use GPIO card detect because we didn't like the way JTAG and SD
>> interacted.  Also on rk3288 the builtin card detect line had the wrong
>> voltage domain (you couldn't detect a card when the IO lines were
>> powered off).  The builtin card detect line is always driven low on
>> veyron.
>
>
> Okay, I see.
>
>>
>>
>> I'm nearly certain that the root cause of my HLE errors is actually
>> related to the same problem addressed by the commit 7c5209c315ea
>> ("mmc: core: Increase delay for voltage to stabilize from 3.3V to
>> 1.8V").  I think that on minnie we're still on the hairy edge and
>> sometimes the line doesn't transition fast enough.
>
>
> Things are not so simple from your details.
>
> I was not enabling SD3.0 support, then I also found HLE sometimes.
> So it seems commit 7c5209c315ea does not contibute to this phenomenon.

Just to clarify, in my case commit 7c5209c315ea didn't make the
problem worse, but made it better.  Just not better enough.  ;)


> The scenario looks like:
> remove sd-card -> mmc_sd_detect -> send status(CMD13) ->power_off ->
> set_ios -> setup_bus -> disabled clk , then HLE irq storm coming
>
> From the code of dw_mci_prepare_command:
> SDMMC_CMD_PRV_DAT_WAIT will not be used for CMD13, so we don't
> wait_busy here, then cmd code is loding into queue of dw_mmc but
> still failing send out because it's in busy?
>
> With my patch, things go well:
> remove sd-card -> clear bit of DW_MMC_CARD_PRESENT  -> send
> status(CMD13) return directly -> power_off -> set_ios -> setup_bus ->
> disable clk
>
> So why should we allow inquiry of card status if we sure the card is
> removed? I mean no any further cmds should be delivered.

Quite honestly just dealing with the HLE error (my patch or
equivalent) might be a sane solution for the problem you describe.

dw_mmc needs to be able to work with an external card detect GPIO.
It's been part of the dw_mmc driver for a long time and is (in fact)
in use upstream at least by rk3288-veyron.  Any solution that only
works for internal card detect is not enough.  Just handling the HLE
error to deal with the interrupt storm and then letting Linux remove
the card (because of the card detect interrupt) seems totally OK to
me.

Note: I'd be very curious if your problems get better if you disable
the "grf_force_jtag" bit in the GRF.  If you're using the builtin card
detect and you use the boot default of "grf_force_jtag" then your pins
will be unmuxed behind your back when the card is ejected.  This could
be causing the dw_mmc controller to get confused.


> And another question: should we wait busy for cmd13?

I don't think so.  As I understand it CMD13 uses only the CMD line for
communication and it should be appropriate to send this when the bus
is "busy" (which means that the DATA lines are low).

Also: it seems odd that the HLE IRQ storm didn't come right after the
CMD 13 in your description above.  Are you sure it was the CMD 13 that
caused the HLEs, or could it has been something else?


-Doug
