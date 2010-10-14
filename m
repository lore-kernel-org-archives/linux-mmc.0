From: Dmitry Shmidt <dimitrysh@android.com>
Subject: Re: [PATCH] mmc: Add "ignore mmc pm notify" functionality
Date: Thu, 14 Oct 2010 09:44:41 -0700
Message-ID: <AANLkTi=S22AF9jhbAK=Z06dnCFi0+oRcQ4M1=04q_8AX@mail.gmail.com>
References: <loom.20101011T202734-842@post.gmane.org>
	<alpine.LFD.2.00.1010112005300.2764@xanadu.home>
	<AANLkTi=QpZGrLutFBPRC29XuZ3oZATRPvD8+KaCFu0c7@mail.gmail.com>
	<alpine.LFD.2.00.1010112036540.2764@xanadu.home>
	<AANLkTimjgqMQdwWbJ0mZpsPO12k39Tbu4siCtT4JrECT@mail.gmail.com>
	<alpine.LFD.2.00.1010121341490.2764@xanadu.home>
	<AANLkTik016rDT1pu0U3RFRqj1XnhPK=U_t7WvzM=b+iP@mail.gmail.com>
	<alpine.LFD.2.00.1010121410150.2764@xanadu.home>
	<AANLkTi=K76xLSjMfYBn9VdhtaDjgP0DruPNhcAqZiq6D@mail.gmail.com>
	<alpine.LFD.2.00.1010121535460.2764@xanadu.home>
	<AANLkTi=ehRGN1QMD5pNFfChHUhp=oAbOueH9v+19GXcb@mail.gmail.com>
	<alpine.LFD.2.00.1010121630260.2764@xanadu.home>
	<AANLkTik1PPHgbvSEab6VQXUbCJrO91vgec6yb7+fWbBh@mail.gmail.com>
	<alpine.LFD.2.00.1010121732370.2764@xanadu.home>
	<AANLkTi=-7ynxokzQjKJ+pOQuBoC5whGW2sg1FX3yrCLB@mail.gmail.com>
	<alpine.LFD.2.00.1010122037040.2764@xanadu.home>
	<AANLkTik-9M3vW6CyscDQTAfxhyex4PEH_fkJEYXkv__B@mail.gmail.com>
	<alpine.LFD.2.00.1010131853260.2764@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35176 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146Ab0JNQom convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Oct 2010 12:44:42 -0400
Received: by yxm8 with SMTP id 8so1717203yxm.19
        for <linux-mmc@vger.kernel.org>; Thu, 14 Oct 2010 09:44:41 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1010131853260.2764@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-mmc@vger.kernel.org

On Wed, Oct 13, 2010 at 4:10 PM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Wed, 13 Oct 2010, Dmitry Shmidt wrote:
>
>> On Tue, Oct 12, 2010 at 5:53 PM, Nicolas Pitre <nico@fluxnic.net> wr=
ote:
>> >> > Yes, but in this case the suspend methods are inappropriate whe=
n the
>> >> > phone is in live usage. =A0They are meant to be used, say, when=
 the phone
>> >> > becomes unused and its flap is folded. =A0Otherwise, what is su=
pposed to
>> >> > happen when you actually want the SDIO card to be suspended if =
the
>> >> > suspend method is cut out?
>> >>
>> >> "Flap is folded"... It is not the case for usual smartphones anym=
ore. :)
>> >> Simple scenario - you are siting in chat, wait like 15 sec and yo=
ur
>> >> screen goes Off, after another 5 sec kernel gets suspend command =
and
>> >> tries to suspend. And you are getting new message - you want to r=
esume
>> >> quickly and process this packet with no delay.
>> >
>> > OK... and how do you want to achieve that?
>> >
>> > Why isn't MMC_PM_KEEP_POWER suitable for this?
>> It just allows to keep power for SDC controller. It doesn't change
>> suspend/resume behavior from SDIO device
>> perspective.
>
> I think you misunderstood the purpose of MMC_PM_KEEP_POWER.
>
> Let's assume the context of a WIFI card. =A0There are cases when you =
want
> the WIFI card to be suspended, and some other cases you want it to
> remain alive when the host CPU does suspend itself. =A0So the decisio=
n has
> to come from the WIFI driver not from the host controller as this is
> where the information about the device usage is. =A0And that's exactl=
y
> what MMC_PM_KEEP_POWER is about. =A0When the WIFI driver receives a
> suspend request, it can set that flag to tell the rest of the stack t=
hat
> it wants to remain alive regardless of what the rest of the system do=
es
> to go to sleep. =A0Then the firmware on the WIFI card can be notified=
 of
> that state and go on with its business until it decides it has data f=
or
> which the host CPU should pay attention. =A0Then the host resumes its=
elf
> as usual, except for the WIFI driver which simply has to continue
> operating the card without having to go through reconfiguration,
> firmware loading, and so on.

Everything is correct but I also want to skip sdio device
reinitialization from SDIO stack perspective.

>
>> >> Maybe what I am describing seems weird, but phone developers are
>> >> fighting for every mA.
>> >
>> > How can you save power when the WIFI interface is not in use if yo=
u
>> > disabled the suspend method with your patch?
>> You see, we are not talking about wlan chip power. CPU is consuming =
in
>> average more energy, so
>> we are talking about overall savings or consumption and not
>> specifically wlan. I mean, definitely
>> turn off SDC controller and remove device will save power, BUT we wi=
ll
>> spend much more time on resume
>> meaning - more power for CPU...
>
> I still disagree with your patch. =A0If you want to turn the CPU off =
and
> not the peripherals then this is more about some idle state than susp=
end
> state. =A0Or at least that's how you should conceptualize it.
>
> If some peripherals are not in use, they should always be powered off
> anyway, whether or not the CPU is suspended.

Agree 100% but this is not the case.

> But disabling suspend methods like your patch does is fundamentally
> the wrong approach.

Again, I am open for reasonable suggestions.

> Nicolas
>
Dmitry
