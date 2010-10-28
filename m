From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC] MMC: Proposals on reworking clock and power management
Date: Thu, 28 Oct 2010 22:51:16 +0200
Message-ID: <AANLkTi=SAwgaR5ugPZw-Nf4JRJMqgLAmZbKPJpkyRSGg@mail.gmail.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B0356A579AF@dbde02.ent.ti.com>
 <alpine.LFD.2.00.1010271551500.29484@xanadu.home> <AANLkTin3eMgnBjyOE1xzVtJkH7=7Ueaa1qtb5kyw_RWG@mail.gmail.com>
 <AANLkTi=wMWGJVP0YHZzjXjeEyVYrxBFEx9_T0a5GLNCn@mail.gmail.com>
 <AANLkTimAfVhz80SDifeF2EgZ=3Hz-Mvye9GhyTLQpa19@mail.gmail.com>
 <alpine.LFD.2.00.1010281206480.2647@xanadu.home> <AANLkTi=556hdm7SSc9j8FF9F37M6A8Q2P7mJsD1mq5Lo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48464 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756156Ab0J1Uvi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Oct 2010 16:51:38 -0400
Received: by iwn10 with SMTP id 10so2778492iwn.19
        for <linux-mmc@vger.kernel.org>; Thu, 28 Oct 2010 13:51:37 -0700 (PDT)
In-Reply-To: <AANLkTi=556hdm7SSc9j8FF9F37M6A8Q2P7mJsD1mq5Lo@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, "Ghorai, Sukumar" <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.ml.walleij@gmail.com>, Adrian Hunter <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "S, Venkatraman" <svenkatr@ti.com>

On Thu, Oct 28, 2010 at 6:40 PM, Kishore Kadiyala
<kishorek.kadiyala@gmail.com> wrote:
> On Thu, Oct 28, 2010 at 9:43 PM, Nicolas Pitre <nico@fluxnic.net> wro=
te:
>> This is not clear that this is something that the core can effective=
ly
>> help with. =A0Opportunistic power saving at the host controller leve=
l is
>> pretty much hardware dependent and may wildly vary in capabilities..=
=2E
>> and bugs. =A0So in this later case I think the driver for the host
>> controller is the best place to just set up a timer and gate the clo=
ck
>> after a certain period of inactivity for example.

makes sense, thanks.

> Agree,
> So briefly, calling pm_runtime_put_sync using a activity based timer
> in the host Controller
> driver will gate the clock to the controller .

Just make sure you call pm_suspend_ignore_children(), because you want
to be able to gate that clock even when the card is still active

> On idle notification to PM runtime core, which will trigger a call to
> the runtime_suspend hook in bus.c
> [https://patchwork.kernel.org/patch/226671/ ] which will perform
> powering off the Card

Kishore, I'm not sure what you meant in the last sentence ?
