From: Yousong Zhou <yszhou4tech@gmail.com>
Subject: Re: [linux-sunxi] Re: [RFC] mmc: core: Set clock before switching to
 highspeed mode.
Date: Mon, 7 Sep 2015 23:37:58 +0800
Message-ID: <CAECwjAhVsD5BbW9QTAxpkR0uGWrK++RB7bs=0g26EV-k2h18VA@mail.gmail.com>
References: <1441448358-13129-1-git-send-email-yszhou4tech@gmail.com>
 <55EAF712.8090203@rock-chips.com> <55EB02FD.5040403@redhat.com>
 <55EB8508.9030009@rock-chips.com> <CAECwjAhe3g0T2icEExE_tBbZ2D1z+BpVNCd0dGZVNU=7zH-LHw@mail.gmail.com>
 <55EC4A31.4060605@rock-chips.com> <CAECwjAgLuskgyHv50GOVN8fGOmQz+jo9PLCAr-POpYH6AszWSg@mail.gmail.com>
 <55ED3695.2030101@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:35518 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbbIGPiY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Sep 2015 11:38:24 -0400
Received: by lbpo4 with SMTP id o4so40994351lbp.2
        for <linux-mmc@vger.kernel.org>; Mon, 07 Sep 2015 08:38:22 -0700 (PDT)
In-Reply-To: <55ED3695.2030101@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, dev@linux-sunxi.org

Hi

On 7 September 2015 at 15:02, Hans de Goede <hdegoede@redhat.com> wrote=
:
> Hi,
>
>
> On 06-09-15 16:47, Yousong Zhou wrote:
>>
>> On Sep 6, 2015 10:14 PM, "Shawn Lin" <shawn.lin@rock-chips.com> wrot=
e:
>>>
>>>
>>> =E5=9C=A8 2015/9/6 20:09, Yousong Zhou =E5=86=99=E9=81=93:
>>>>
>>>>
>>>> Hi,
>>>>
>>>> On 6 September 2015 at 08:12, Shawn Lin <shawn.lin@rock-chips.com>
>>>> wrote:
>>>>>
>>>>>
>>>>> On 2015/9/5 22:58, Hans de Goede wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> Hi Shawn Lin,
>>>>>>
>>>>>> On 05-09-15 16:07, Shawn Lin wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 2015/9/5 18:19, Yousong Zhou wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> A SD card with sunxi-mmc can fail with the following error mes=
sage
>>>>>>>> (RCD for
>>>>>>>> response CRC error) when trying to switch to highspeed mode.
>>>>>>>> Setting
>>>>>>>> the bus
>>>>>>>> clock before the access mode switch fixed it.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> No, that's wrong!
>>>>>>>
>>>>>>> Before this card is switched to highspeed, it works under
>>>>>>> identification mode(From spec: bus clock <=3D 400KHz). How coul=
d you
>>>>>>> raise bus clock to higher clk rate which I _guess_ is 52MHz bef=
ore
>>>>>>> you
>>>>>>> notify sd cards to run into highspeed mode?
>>>>>>>
>>>>>>> Althought it works for this card, this patch will not please th=
e
>>>>>>> other
>>>>>>> cards that they might not reply CMDs any longer including the
>>>>>>> following CMD6.
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> Thanks for the feedback, this is exactly why I asked Yousong Zho=
u to
>>>>>> take this
>>>>>> to the mmc list.
>>>>>>
>>>>>> So if this is not the proper fix for the problem that Yousong Zh=
ou is
>>>>>> seeing, then
>>>>>> what might be the proper fix ?
>>>>>>
>>>>>
>>>>>   From my knowledge of mmc, there hadn't have a way to deal with =
this
>>
>> "broken"
>>>>>
>>>>> case. In another word, IMO,it's ANTI-SPEC. We can't be too spec
>>
>> sometimes,
>>>>>
>>>>> but at least we shouldn't violate it.
>>>>>
>>>>
>>>> Maybe the fix is anti-spec.  But the fact is that the card works o=
n
>>>> many other platforms with the builtin card reader (not through an =
USB
>>>> adapter), including Mac OS X, my old Nokia Symbian phone, and Wind=
ows.
>>>>
>>>>>> Could it be that the sunxi-mmc is doing some things in the wrong=
 order
>>>>>> when
>>>>>> changing the clock, or is this all under control of the mmc core=
 ?
>>>>>>
>>>>>
>>>>> all of this is under control of the mmc core.
>>>>> So if Yongsong does want this card to work for any linux-based mm=
c
>>
>> stack, I
>>>>>
>>>>> guess something like that should be "better"?
>>>>>
>>>>> if (switch to HS fail) {
>>>>>           set_bus_clk
>>>>>           goto retry switch to HS
>>>>> }
>>>>>
>>>>> BUT...I admit it seems strange as well.
>>>>>
>>>>
>>>> The SD Specification (simplified version) says "If CRC error occur=
s on
>>>> the status data, the host should issue a power cycle.", so I guess=
 the
>>>> above approach is anti-spec in some way :)
>>>>
>>>
>>> Right=EF=BC=8CI was guessing that way from your intention.
>>>
>>>
>>>> In case it may help debug this problem, I'd like to add that the c=
ard
>>>> previously worked fine with U-Boot before commit [1].  This can al=
so
>>>> be confirmed by Debian Jessie installer image with which the old
>>>> U-Boot there worked fine while the kernel (3.16) did not.
>>>>
>>>>    [1] sunxi: mmc: Properly setup mod-clk and clock sampling phase=
s,
>>>>
>>
>> http://git.denx.de/?p=3Du-boot.git;a=3Dcommit;h=3Dfc3a832576ce7bb597=
b1823935bfb7dcca235c3c
>
>
> Interesting, one thing that patch does is introduce a switch from par=
ent pll
> when switching from 400KHz to higher clocks. Can you try the attached=
 patch
> ?
>

Previously I tried inserting udelay(1000) immediately after many
writel calls: the result were all the same.  I just tried that patch
adding mdelay(100) after mmc_set_mod_clk(), still no luck, the same
error message just as before.

> If reverting u-boot commit fc3a832576ce7bb597b1823935bfb7dcca235c3c f=
ixes
> things, then it is probably best to focus on fixing u-boot first, and=
 then
> we can likely apply the same fix to the kernel.
>
> With which SoC(s) are you seeing this problem ? I believe that there
> may be some differences between the mmc controller used in the A10/13=
 vs
> later SoCs so this may be a SoC specific issue.

It's a Cubieboard2 with Allwinner A20.

Regards,

                yousong

>
> Regards,
>
> Hans
>
>
>
>> OpenWrt ticket 20387 has more info about the U-Boot failure.
>>
>> https://dev.openwrt.org/ticket/20387
>>
>> Anyway, I have no idea what's the effect of those magic numbers on
>> "sampling phases".  Never played with such things before :)
>>
>>> I happended to fix some problems which seems *similar* to yours(but=
 I'm
>>
>> not sure just from commit[1]'s msg):
>>>
>>>
>>> https://patchwork.kernel.org/patch/7119661/
>>>
>>>> Cheers
>>>>
>>>>                   yousong
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mm=
c" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>>>
>>>
>>>
>>> --
>>> Best Regards
>>> Shawn Lin
>>>
>>> --
>>> You received this message because you are subscribed to the Google =
Groups
>>
>> "linux-sunxi" group.
>>>
>>> To unsubscribe from this group and stop receiving emails from it, s=
end an
>>
>> email to linux-sunxi+unsubscribe@googlegroups.com.
>>>
>>> For more options, visit https://groups.google.com/d/optout.
>>
>>
>
