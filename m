From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [RFC] MMC: Proposals on reworking clock and power management
Date: Thu, 28 Oct 2010 22:10:32 +0530
Message-ID: <AANLkTi=556hdm7SSc9j8FF9F37M6A8Q2P7mJsD1mq5Lo@mail.gmail.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B0356A579AF@dbde02.ent.ti.com>
	<alpine.LFD.2.00.1010271551500.29484@xanadu.home>
	<AANLkTin3eMgnBjyOE1xzVtJkH7=7Ueaa1qtb5kyw_RWG@mail.gmail.com>
	<AANLkTi=wMWGJVP0YHZzjXjeEyVYrxBFEx9_T0a5GLNCn@mail.gmail.com>
	<AANLkTimAfVhz80SDifeF2EgZ=3Hz-Mvye9GhyTLQpa19@mail.gmail.com>
	<alpine.LFD.2.00.1010281206480.2647@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51398 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951Ab0J1Qkd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Oct 2010 12:40:33 -0400
Received: by wyf28 with SMTP id 28so2145975wyf.19
        for <linux-mmc@vger.kernel.org>; Thu, 28 Oct 2010 09:40:32 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1010281206480.2647@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, "Ghorai, Sukumar" <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.ml.walleij@gmail.com>, Adrian Hunter <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "S, Venkatraman" <svenkatr@ti.com>

On Thu, Oct 28, 2010 at 9:43 PM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Thu, 28 Oct 2010, Ohad Ben-Cohen wrote:
>
>> On Thu, Oct 28, 2010 at 5:39 PM, Kishore Kadiyala
>> <kishorek.kadiyala@gmail.com> wrote:
>> > Wouldn't adapting the host driver just to PM-Runtime will answer t=
he
>> > above issues?
>>
>> It's not enough.
>>
>> When the card is runtime suspended, sure, the host controller will
>> immediately get idle notification by runtime PM core.
>>
>> But you may still want to gate the clock to the host controller on b=
us
>> inactivity, even if the card is not runtime suspended. The decision =
to
>> do this should come from the mmc core.
>
> This is not clear that this is something that the core can effectivel=
y
> help with. =A0Opportunistic power saving at the host controller level=
 is
> pretty much hardware dependent and may wildly vary in capabilities...
> and bugs. =A0So in this later case I think the driver for the host
> controller is the best place to just set up a timer and gate the cloc=
k
> after a certain period of inactivity for example.

Agree,
So briefly, calling pm_runtime_put_sync using a activity based timer
in the host Controller
driver will gate the clock to the controller .
On idle notification to PM runtime core, which will trigger a call to
the runtime_suspend hook in bus.c
[https://patchwork.kernel.org/patch/226671/ ] which will perform
powering off the Card

Regards,
Kishore
