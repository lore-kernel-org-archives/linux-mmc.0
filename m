From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [linux-sunxi] Re: [RFC] mmc: core: Set clock before switching to
 highspeed mode.
Date: Mon, 7 Sep 2015 08:16:24 +0800
Message-ID: <55ECD758.90900@rock-chips.com>
References: <1441448358-13129-1-git-send-email-yszhou4tech@gmail.com>
 <55EAF712.8090203@rock-chips.com> <55EB02FD.5040403@redhat.com>
 <55EB8508.9030009@rock-chips.com>
 <CAECwjAhe3g0T2icEExE_tBbZ2D1z+BpVNCd0dGZVNU=7zH-LHw@mail.gmail.com>
 <55EC4A31.4060605@rock-chips.com>
 <CAECwjAg2pgN0UOaa8Gv=4622uTcKtwbAs+UE6X9=DXX6SBEgMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:59498 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837AbbIGAQr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Sep 2015 20:16:47 -0400
In-Reply-To: <CAECwjAg2pgN0UOaa8Gv=4622uTcKtwbAs+UE6X9=DXX6SBEgMA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yousong Zhou <yszhou4tech@gmail.com>
Cc: shawn.lin@rock-chips.com, Hans de Goede <hdegoede@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, dev@linux-sunxi.org

On 2015/9/6 22:51, Yousong Zhou wrote:
>>>> all of this is under control of the mmc core.
>>>> So if Yongsong does want this card to work for any linux-based mmc=
 stack,
>>>> I
>>>> guess something like that should be "better"?
>>>>
>>>> if (switch to HS fail) {
>>>>           set_bus_clk
>>>>           goto retry switch to HS
>>>> }
>>>>
>>>> BUT...I admit it seems strange as well.
>>>>
>>>
>>> The SD Specification (simplified version) says "If CRC error occurs=
 on
>>> the status data, the host should issue a power cycle.", so I guess =
the
>>> above approach is anti-spec in some way :)
>>>
>>
>> Right=EF=BC=8CI was guessing that way from your intention.
>>
>>> In case it may help debug this problem, I'd like to add that the ca=
rd
>>> previously worked fine with U-Boot before commit [1].  This can als=
o
>>> be confirmed by Debian Jessie installer image with which the old
>>> U-Boot there worked fine while the kernel (3.16) did not.
>>>
>>>    [1] sunxi: mmc: Properly setup mod-clk and clock sampling phases=
,
>>>
>>> http://git.denx.de/?p=3Du-boot.git;a=3Dcommit;h=3Dfc3a832576ce7bb59=
7b1823935bfb7dcca235c3c
>>>
>>
>> Interesting... but that at least prove your patch is a workaround bu=
t not
>> find the root cause.
>>
>> Anyway, look into commit-sha [1], can you have a test by restoring m=
od-clk
>> and clock sampling phases before jump to kernel.
>>
>
> Maybe my statement about U-Boot commit [1] above was a little
> ambiguous, sorry.  I meant to say that with that commit applied,
> U-Boot failed initialising the card the same way as the kernel, i.e.
> response crc error.
>
> The Debian Jessie installer image's U-Boot worked fine and booted the
> kernel because it was before commit [1] happened.  However after that
> the 3.16 kernel failed initialising the card.
>

So I undertand your point:  Uboot w/o commit[1] + 3.16 kernel failed=20
that way just as Uboot w/ commit[1] + pre-3.16 kernel, right?

If that is it, could you check sunxi-platform's patches merged into=20
v3.16 for sure whether there is any patch do the same things just like=20
what commit[1] did for uboot or not?

> So, with commit [1], U-Boot failed right away without any chance at
> all jumping to kernel.
>
> OpenWrt ticket 20387 has more info about the U-Boot failure.
>
> https://dev.openwrt.org/ticket/20387
>
> Anyway, I have no idea what's the effect of those magic numbers on
> "sampling phases".  Never played with such things before :)
>
>                  yousong
>
>> I happended to fix some problems which seems *similar* to yours(but =
I'm not
>> sure just from commit[1]'s msg):
>>
>> https://patchwork.kernel.org/patch/7119661/
>
>
>


--=20
Best Regards
Shawn Lin

