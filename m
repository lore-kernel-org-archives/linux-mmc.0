From: Dmitry Shmidt <dimitrysh@android.com>
Subject: Re: [PATCH] mmc: Add "ignore mmc pm notify" functionality
Date: Wed, 13 Oct 2010 13:48:52 -0700
Message-ID: <AANLkTik-9M3vW6CyscDQTAfxhyex4PEH_fkJEYXkv__B@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44160 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641Ab0JMUsx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Oct 2010 16:48:53 -0400
Received: by gxk6 with SMTP id 6so1168484gxk.19
        for <linux-mmc@vger.kernel.org>; Wed, 13 Oct 2010 13:48:52 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1010122037040.2764@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-mmc@vger.kernel.org

On Tue, Oct 12, 2010 at 5:53 PM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
>> > Yes, but in this case the suspend methods are inappropriate when t=
he
>> > phone is in live usage. =A0They are meant to be used, say, when th=
e phone
>> > becomes unused and its flap is folded. =A0Otherwise, what is suppo=
sed to
>> > happen when you actually want the SDIO card to be suspended if the
>> > suspend method is cut out?
>>
>> "Flap is folded"... It is not the case for usual smartphones anymore=
=2E :)
>> Simple scenario - you are siting in chat, wait like 15 sec and your
>> screen goes Off, after another 5 sec kernel gets suspend command and
>> tries to suspend. And you are getting new message - you want to resu=
me
>> quickly and process this packet with no delay.
>
> OK... and how do you want to achieve that?
>
> Why isn't MMC_PM_KEEP_POWER suitable for this?
It just allows to keep power for SDC controller. It doesn't change
suspend/resume behavior from SDIO device
perspective.

>
>> Maybe what I am describing seems weird, but phone developers are
>> fighting for every mA.
>
> How can you save power when the WIFI interface is not in use if you
> disabled the suspend method with your patch?
You see, we are not talking about wlan chip power. CPU is consuming in
average more energy, so
we are talking about overall savings or consumption and not
specifically wlan. I mean, definitely
turn off SDC controller and remove device will save power, BUT we will
spend much more time on resume
meaning - more power for CPU...

>
>> And mmc card resume if usually deferred - to reduce tiem and save
>> power, but this is a different issue.
>
> How much time are we talking about?
The best thing is to defer resume till it will be needed.

>
> Nicolas
>
Dmitry
