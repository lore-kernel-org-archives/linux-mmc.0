From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [RFC] MMC: Proposals on reworking clock and power management
Date: Fri, 29 Oct 2010 20:04:59 +0530
Message-ID: <AANLkTin6Ys8SJn0mR1L9pAhperA=_+gqixjWmrAJ6HAD@mail.gmail.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B0356A579AF@dbde02.ent.ti.com>
	<alpine.LFD.2.00.1010271551500.29484@xanadu.home>
	<AANLkTin3eMgnBjyOE1xzVtJkH7=7Ueaa1qtb5kyw_RWG@mail.gmail.com>
	<AANLkTi=wMWGJVP0YHZzjXjeEyVYrxBFEx9_T0a5GLNCn@mail.gmail.com>
	<AANLkTimAfVhz80SDifeF2EgZ=3Hz-Mvye9GhyTLQpa19@mail.gmail.com>
	<alpine.LFD.2.00.1010281206480.2647@xanadu.home>
	<AANLkTi=556hdm7SSc9j8FF9F37M6A8Q2P7mJsD1mq5Lo@mail.gmail.com>
	<AANLkTi=SAwgaR5ugPZw-Nf4JRJMqgLAmZbKPJpkyRSGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60536 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179Ab0J2OfB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Oct 2010 10:35:01 -0400
Received: by wyf28 with SMTP id 28so3203461wyf.19
        for <linux-mmc@vger.kernel.org>; Fri, 29 Oct 2010 07:35:00 -0700 (PDT)
In-Reply-To: <AANLkTi=SAwgaR5ugPZw-Nf4JRJMqgLAmZbKPJpkyRSGg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, "Ghorai, Sukumar" <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.ml.walleij@gmail.com>, Adrian Hunter <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "S, Venkatraman" <svenkatr@ti.com>

On Fri, Oct 29, 2010 at 2:21 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> On Thu, Oct 28, 2010 at 6:40 PM, Kishore Kadiyala
> <kishorek.kadiyala@gmail.com> wrote:
>> On Thu, Oct 28, 2010 at 9:43 PM, Nicolas Pitre <nico@fluxnic.net> wr=
ote:
>>> This is not clear that this is something that the core can effectiv=
ely
>>> help with. =A0Opportunistic power saving at the host controller lev=
el is
>>> pretty much hardware dependent and may wildly vary in capabilities.=
=2E.
>>> and bugs. =A0So in this later case I think the driver for the host
>>> controller is the best place to just set up a timer and gate the cl=
ock
>>> after a certain period of inactivity for example.
>
> makes sense, thanks.
>
>> Agree,
>> So briefly, calling pm_runtime_put_sync using a activity based timer
>> in the host Controller
>> driver will gate the clock to the controller .
>
> Just make sure you call pm_suspend_ignore_children(), because you wan=
t
> to be able to gate that clock even when the card is still active

Thanks will have a look into this
>
>> On idle notification to PM runtime core, which will trigger a call t=
o
>> the runtime_suspend hook in bus.c
>> [https://patchwork.kernel.org/patch/226671/ ] which will perform
>> powering off the Card
>
> Kishore, I'm not sure what you meant in the last sentence ?

I meant --> put_sync/get_sync [host driver]
                  --> runtime_suspend/runtime_resume
                        -->mmc_bus_suspend/resume [core.c]
                             --> card power OFF/ON [thorugh set_ios]
Regards,
Kishore
