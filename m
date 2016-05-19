From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: Consider HLE errors to be data and command
 errors
Date: Thu, 19 May 2016 22:07:49 +0900
Message-ID: <573DBAA5.2070706@samsung.com>
References: <1426002490-2014-1-git-send-email-dianders@chromium.org>
 <5502CA4E.9060401@samsung.com>
 <CAD=FV=VX3ix-j4y95W1q8b-aVuVEN+4xsd8WLx2xcE7KPNJwRw@mail.gmail.com>
 <5506707D.40708@samsung.com> <55189F04.8000404@samsung.com>
 <CAD=FV=WFAZqAsXOqunt0fxw87M-FruwUrxuzW0MJsG6UvfSjzA@mail.gmail.com>
 <CAD=FV=UJGcwa_biSCGhD=kS-T+fppCniBFfOHb5ohnwSwSwMMA@mail.gmail.com>
 <573BCC8D.5090606@kernel-upstream.org>
 <CAD=FV=VneQR3wurjezBkRhtQiH+q-FfhDN8=Ym=XqtZpVmsdUw@mail.gmail.com>
 <573C3283.1040606@rock-chips.com>
 <CAD=FV=UoT2GRYWJWXEn_ccvKGgC+PzQM_BCtLHAa7jxzbaQ9SA@mail.gmail.com>
 <10b3dc0e-aebf-664b-b36b-c54692cd9983@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:49347 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190AbcESNHy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 May 2016 09:07:54 -0400
In-reply-to: <10b3dc0e-aebf-664b-b36b-c54692cd9983@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Doug Anderson <dianders@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Alexandru Stan <amstan@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 05/19/2016 08:31 PM, Shawn Lin wrote:
> Hi,
>=20
> On 2016/5/19 1:37, Doug Anderson wrote:
>> Hi,
>>
>> On Wed, May 18, 2016 at 2:14 AM, Shawn Lin <shawn.lin@rock-chips.com=
> wrote:
>>> Hi
>>>
>>>
>>> On 2016-5-18 12:12, Doug Anderson wrote:
>>>>
>>>> Hi,
>>>>
>>>> On Tue, May 17, 2016 at 6:59 PM, Shawn Lin
>>>> <shawn.lin@kernel-upstream.org> wrote:
>>>>>
>>>>> Could you try this patch to see if you can still find HLE?
>>>>>
>>>>> @@ -2356,12 +2356,22 @@ static void dw_mci_cmd_interrupt(struct d=
w_mci
>>>>> *host, u32 status)
>>>>>   static void dw_mci_handle_cd(struct dw_mci *host)
>>>>>   {
>>>>>          int i;
>>>>> +       int present;
>>>>>
>>>>>          for (i =3D 0; i < host->num_slots; i++) {
>>>>>                  struct dw_mci_slot *slot =3D host->slot[i];
>>>>>
>>>>>                  if (!slot)
>>>>>                          continue;
>>>>>
>>>>> +               present =3D !(mci_readl(slot->host, CDETECT) & (1=
 <<
>>>>> slot->id));
>>>>> +               if (present)
>>>>> +                       set_bit(DW_MMC_CARD_PRESENT, &slot->flags=
);
>>>>> +               else
>>>>> +                       clear_bit(DW_MMC_CARD_PRESENT, &slot->fla=
gs);
>>>>
>>>>
>>>> No, because we don't use the builtin card detect on veyron.  ;)
>>>>
>>>> We use GPIO card detect because we didn't like the way JTAG and SD
>>>> interacted.  Also on rk3288 the builtin card detect line had the w=
rong
>>>> voltage domain (you couldn't detect a card when the IO lines were
>>>> powered off).  The builtin card detect line is always driven low o=
n
>>>> veyron.
>>>
>>>
>>> Okay, I see.
>>>
>>>>
>>>>
>>>> I'm nearly certain that the root cause of my HLE errors is actuall=
y
>>>> related to the same problem addressed by the commit 7c5209c315ea
>>>> ("mmc: core: Increase delay for voltage to stabilize from 3.3V to
>>>> 1.8V").  I think that on minnie we're still on the hairy edge and
>>>> sometimes the line doesn't transition fast enough.
>>>
>>>
>>> Things are not so simple from your details.
>>>
>>> I was not enabling SD3.0 support, then I also found HLE sometimes.
>>> So it seems commit 7c5209c315ea does not contibute to this phenomen=
on.
>>
>> Just to clarify, in my case commit 7c5209c315ea didn't make the
>> problem worse, but made it better.  Just not better enough.  ;)
>>
>>
>>> The scenario looks like:
>>> remove sd-card -> mmc_sd_detect -> send status(CMD13) ->power_off -=
>
>>> set_ios -> setup_bus -> disabled clk , then HLE irq storm coming
>>>
>>> From the code of dw_mci_prepare_command:
>>> SDMMC_CMD_PRV_DAT_WAIT will not be used for CMD13, so we don't
>>> wait_busy here, then cmd code is loding into queue of dw_mmc but
>>> still failing send out because it's in busy?
>>>
>>> With my patch, things go well:
>>> remove sd-card -> clear bit of DW_MMC_CARD_PRESENT  -> send
>>> status(CMD13) return directly -> power_off -> set_ios -> setup_bus =
->
>>> disable clk
>>>
>>> So why should we allow inquiry of card status if we sure the card i=
s
>>> removed? I mean no any further cmds should be delivered.
>>
>> Quite honestly just dealing with the HLE error (my patch or
>> equivalent) might be a sane solution for the problem you describe.
>=20
> Yes, your patch looks good to me, so it should be merged firstly. :)
> Then let's push it a bit further more that when HLEs are coming,
> somethings must be wrong(currently I don't see a obvious clue from
> the code itself although, I'm prone to think it belongs to the
> software issue).

We don't know what's main cause for HLE..But i also think it's relevant=
 to SW issue.
But we need to consider all possibilities..

>=20
>=20
>>
>> dw_mmc needs to be able to work with an external card detect GPIO.
>> It's been part of the dw_mmc driver for a long time and is (in fact)
>> in use upstream at least by rk3288-veyron.  Any solution that only
>> works for internal card detect is not enough.  Just handling the HLE
>> error to deal with the interrupt storm and then letting Linux remove
>> the card (because of the card detect interrupt) seems totally OK to
>> me.
>>
>=20
> Sure, some of rockchip Socs use gpio for CD because they don't
> have a internal CD, such as RK3036, right?
>=20
>> Note: I'd be very curious if your problems get better if you disable
>=20
> Not at all.
>=20
>> the "grf_force_jtag" bit in the GRF.  If you're using the builtin ca=
rd
>> detect and you use the boot default of "grf_force_jtag" then your pi=
ns
>> will be unmuxed behind your back when the card is ejected.  This cou=
ld
>> be causing the dw_mmc controller to get confused.
>=20
> Right, grf_force_jtag is also not a friend of mine. :)
> So I had disabled this function before I was debugging it.
>=20
>>
>>
>>> And another question: should we wait busy for cmd13?
>>
>> I don't think so.  As I understand it CMD13 uses only the CMD line f=
or
>> communication and it should be appropriate to send this when the bus
>> is "busy" (which means that the DATA lines are low).
>=20
> Ahh... take back my question.. I was just considering a wired situati=
on
> that pins are unmuxed on the background(cmd line as well) when cmd13 =
is
> delivering....
>=20
>=20
>>
>> Also: it seems odd that the HLE IRQ storm didn't come right after th=
e
>> CMD 13 in your description above.  Are you sure it was the CMD 13 th=
at
>> caused the HLEs, or could it has been something else?
>=20
> Actually no. Any cmds be issued can trigger HLEs, I think, after sd c=
ard is removed When I hacked mmc_sd_detecd to send other cmds intead
> of cmd13.
>=20
> From dw_mmc databook v270a(7.2.3 Clock Programming) we can see:
> The DWC_mobile_storage loads each of these registers only when the
> start_cmd bit and the Update_clk_regs_only bit in the CMD register ar=
e
> set. When a command is successfully loaded, the DWC_mobile_storage
> clears this bit, unless the DWC_mobile_storage already has another
> command in the queue, at which point it gives an HLE (Hardware Locked
> Error); for details on HLEs, refer to =E2=80=9CError Handling=E2=80=9D=
 on page 233.
> Software should look for the start_cmd and the Update_clk_regs_only
> bits, and should also set the wait_prvdata_complete bit to ensure tha=
t
> clock parameters do not change during data transfer.
>=20
> Maybe the cmd is trying to load(or somethings wrong with the
> controller?) when we disable the clk? That may explain my observation
> that HLEs came after disabling clk.

I agreed.

To Disable clock, it sends cmd with update_clk_regs_only and wait_prvda=
ta_complete bit.
I think it's problem..(waiting for prvdata..)

If there are ongoing some data(read/write), then before disabling clock=
, waiting for completing previous data.
(But card was already removed, and it couldn't do anything.)
It's difficult to analyze the HLE..So After applying first, then we can=
 solve this problem, step by step.

Best Regards,
Jaehoon Chung

>=20
>=20
>>
>>
>> -Doug
>>
>>
>>
>=20
>=20

