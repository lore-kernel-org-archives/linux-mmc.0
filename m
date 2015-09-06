From: Yousong Zhou <yszhou4tech@gmail.com>
Subject: Re: [linux-sunxi] Re: [RFC] mmc: core: Set clock before switching to
 highspeed mode.
Date: Sun, 6 Sep 2015 22:51:09 +0800
Message-ID: <CAECwjAg2pgN0UOaa8Gv=4622uTcKtwbAs+UE6X9=DXX6SBEgMA@mail.gmail.com>
References: <1441448358-13129-1-git-send-email-yszhou4tech@gmail.com>
 <55EAF712.8090203@rock-chips.com> <55EB02FD.5040403@redhat.com>
 <55EB8508.9030009@rock-chips.com> <CAECwjAhe3g0T2icEExE_tBbZ2D1z+BpVNCd0dGZVNU=7zH-LHw@mail.gmail.com>
 <55EC4A31.4060605@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:34586 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbbIFOv3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Sep 2015 10:51:29 -0400
Received: by obbda8 with SMTP id da8so18888909obb.1
        for <linux-mmc@vger.kernel.org>; Sun, 06 Sep 2015 07:51:29 -0700 (PDT)
In-Reply-To: <55EC4A31.4060605@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: shawn.lin@rock-chips.com
Cc: Hans de Goede <hdegoede@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, dev@linux-sunxi.org

>>> all of this is under control of the mmc core.
>>> So if Yongsong does want this card to work for any linux-based mmc =
stack,
>>> I
>>> guess something like that should be "better"?
>>>
>>> if (switch to HS fail) {
>>>          set_bus_clk
>>>          goto retry switch to HS
>>> }
>>>
>>> BUT...I admit it seems strange as well.
>>>
>>
>> The SD Specification (simplified version) says "If CRC error occurs =
on
>> the status data, the host should issue a power cycle.", so I guess t=
he
>> above approach is anti-spec in some way :)
>>
>
> Right=EF=BC=8CI was guessing that way from your intention.
>
>> In case it may help debug this problem, I'd like to add that the car=
d
>> previously worked fine with U-Boot before commit [1].  This can also
>> be confirmed by Debian Jessie installer image with which the old
>> U-Boot there worked fine while the kernel (3.16) did not.
>>
>>   [1] sunxi: mmc: Properly setup mod-clk and clock sampling phases,
>>
>> http://git.denx.de/?p=3Du-boot.git;a=3Dcommit;h=3Dfc3a832576ce7bb597=
b1823935bfb7dcca235c3c
>>
>
> Interesting... but that at least prove your patch is a workaround but=
 not
> find the root cause.
>
> Anyway, look into commit-sha [1], can you have a test by restoring mo=
d-clk
> and clock sampling phases before jump to kernel.
>

Maybe my statement about U-Boot commit [1] above was a little
ambiguous, sorry.  I meant to say that with that commit applied,
U-Boot failed initialising the card the same way as the kernel, i.e.
response crc error.

The Debian Jessie installer image's U-Boot worked fine and booted the
kernel because it was before commit [1] happened.  However after that
the 3.16 kernel failed initialising the card.

So, with commit [1], U-Boot failed right away without any chance at
all jumping to kernel.

OpenWrt ticket 20387 has more info about the U-Boot failure.

https://dev.openwrt.org/ticket/20387

Anyway, I have no idea what's the effect of those magic numbers on
"sampling phases".  Never played with such things before :)

                yousong

> I happended to fix some problems which seems *similar* to yours(but I=
'm not
> sure just from commit[1]'s msg):
>
> https://patchwork.kernel.org/patch/7119661/
