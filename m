From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: dw_mmc: Consider HLE errors to be data and command
 errors
Date: Wed, 18 May 2016 17:14:43 +0800
Message-ID: <573C3283.1040606@rock-chips.com>
References: <1426002490-2014-1-git-send-email-dianders@chromium.org>
 <5502CA4E.9060401@samsung.com>
 <CAD=FV=VX3ix-j4y95W1q8b-aVuVEN+4xsd8WLx2xcE7KPNJwRw@mail.gmail.com>
 <5506707D.40708@samsung.com> <55189F04.8000404@samsung.com>
 <CAD=FV=WFAZqAsXOqunt0fxw87M-FruwUrxuzW0MJsG6UvfSjzA@mail.gmail.com>
 <CAD=FV=UJGcwa_biSCGhD=kS-T+fppCniBFfOHb5ohnwSwSwMMA@mail.gmail.com>
 <573BCC8D.5090606@kernel-upstream.org>
 <CAD=FV=VneQR3wurjezBkRhtQiH+q-FfhDN8=Ym=XqtZpVmsdUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:43158 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbcERJPx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 May 2016 05:15:53 -0400
In-Reply-To: <CAD=FV=VneQR3wurjezBkRhtQiH+q-FfhDN8=Ym=XqtZpVmsdUw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Alexandru Stan <amstan@chromium.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi

On 2016-5-18 12:12, Doug Anderson wrote:
> Hi,
>
> On Tue, May 17, 2016 at 6:59 PM, Shawn Lin
> <shawn.lin@kernel-upstream.org> wrote:
>> Could you try this patch to see if you can still find HLE?
>>
>> @@ -2356,12 +2356,22 @@ static void dw_mci_cmd_interrupt(struct dw_mci
>> *host, u32 status)
>>   static void dw_mci_handle_cd(struct dw_mci *host)
>>   {
>>          int i;
>> +       int present;
>>
>>          for (i = 0; i < host->num_slots; i++) {
>>                  struct dw_mci_slot *slot = host->slot[i];
>>
>>                  if (!slot)
>>                          continue;
>>
>> +               present = !(mci_readl(slot->host, CDETECT) & (1 <<
>> slot->id));
>> +               if (present)
>> +                       set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
>> +               else
>> +                       clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
>
> No, because we don't use the builtin card detect on veyron.  ;)
>
> We use GPIO card detect because we didn't like the way JTAG and SD
> interacted.  Also on rk3288 the builtin card detect line had the wrong
> voltage domain (you couldn't detect a card when the IO lines were
> powered off).  The builtin card detect line is always driven low on
> veyron.

Okay, I see.

>
>
> I'm nearly certain that the root cause of my HLE errors is actually
> related to the same problem addressed by the commit 7c5209c315ea
> ("mmc: core: Increase delay for voltage to stabilize from 3.3V to
> 1.8V").  I think that on minnie we're still on the hairy edge and
> sometimes the line doesn't transition fast enough.

Things are not so simple from your details.

I was not enabling SD3.0 support, then I also found HLE sometimes.
So it seems commit 7c5209c315ea does not contibute to this phenomenon.

The scenario looks like:
remove sd-card -> mmc_sd_detect -> send status(CMD13) ->power_off ->
set_ios -> setup_bus -> disabled clk , then HLE irq storm coming

 From the code of dw_mci_prepare_command:
SDMMC_CMD_PRV_DAT_WAIT will not be used for CMD13, so we don't
wait_busy here, then cmd code is loding into queue of dw_mmc but
still failing send out because it's in busy?

With my patch, things go well:
remove sd-card -> clear bit of DW_MMC_CARD_PRESENT  -> send
status(CMD13) return directly -> power_off -> set_ios -> setup_bus -> 
disable clk

So why should we allow inquiry of card status if we sure the card is
removed? I mean no any further cmds should be delivered.

And another question: should we wait busy for cmd13?

>
> It appears that increasing this to 30ms avoids the HLE errors.
>
> I _think_ I can actually fully fix this properly by temporarily
> engaging the internal pull-ups while the voltage switch is happening.
> This will bleed away the voltage just a little bit faster (since lines
> are driven low here).  I'll try to confirm that.
>
>
> In any case, it seems like we should take this patch since (without
> this patch) the failure case when you get HLE errors is that the
> interrupt controller fires over and over again (with no printouts) and
> your system stalls with no error messages.

Sure, at least we need to address this irq storm...

>
> -Doug
>
>
>

