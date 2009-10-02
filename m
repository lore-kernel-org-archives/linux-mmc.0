From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: TMIO MMC: full patchset.
Date: Fri, 2 Oct 2009 16:57:13 +0900
Message-ID: <aec7e5c30910020057w38e72894p9ffed291f3fc1d1@mail.gmail.com>
References: <c09aa50a0909290552j1c371ddfpc7444d5d87e66f76@mail.gmail.com>
	 <aec7e5c30909300441w6ca07dd9o889590c6100b846b@mail.gmail.com>
	 <c09aa50a0909301315o683322e4k4b85e21ab473341e@mail.gmail.com>
	 <aec7e5c30909301830s2d3ba9r39cce5cd57e87025@mail.gmail.com>
	 <c09aa50a0910010319w5c613063j699a02d3a786c34f@mail.gmail.com>
	 <aec7e5c30910012246r1c452606w149f18d9fe825737@mail.gmail.com>
	 <c09aa50a0910020031x1c6f1fceo4740a3edc9592cbe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f199.google.com ([209.85.210.199]:55988 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757088AbZJBH5J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Oct 2009 03:57:09 -0400
Received: by yxe37 with SMTP id 37so923478yxe.33
        for <linux-mmc@vger.kernel.org>; Fri, 02 Oct 2009 00:57:13 -0700 (PDT)
In-Reply-To: <c09aa50a0910020031x1c6f1fceo4740a3edc9592cbe@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: linux-mmc@vger.kernel.org, sameo@openedhand.com, pb@handhelds.org, philipp.zabel@gmail.com, akpm@linux-foundation.org, Paul Mundt <lethal@linux-sh.org>

On Fri, Oct 2, 2009 at 4:31 PM, Ian Molton <ian@mnementh.co.uk> wrote:
> 2009/10/2 Magnus Damm <magnus.damm@gmail.com>:
>> [CC Paul Mundt]
>>
>> Right, the MFD driver approach is probably the best one.
>
> :-)

I'm glad we can agree on that one at least. =3D)

>>> Your current implementation is broken in that if as you say the clo=
ck
>>> rate can vary prior to loading the MMC =A0driver then you will end =
up
>>> with f_max being set to whatever random clock was set when the driv=
er
>>> probes.
>>
>> No, it's not broken. When the clock is enabled the frequency stays
>> fixed. How would things work at all if that wasn't the case?
>
> I asked if the clock freq. changes - you said 'Well, the goal is
> dynamic clocks, but at this point it's dynamic until the clock is
> enabled'.
>
> Since your code doesnt set the clock frequency, that means the MMC
> drivers f_max will be set to whatever the clock was running at when
> you grab it.

Yes?

>> The clock
>> rate comes from whatever bus frequency that is used for the bus that
>> the SDHI block is hooked up to. So it's far from random.
>
> As long as it has no other users that try to change it. What you are
> describing isnt a dynamic clock. its a fixed clock that is diifferent
> on different platforms.

You can call it whatever you want. On SuperH we can do clock scaling
which seems very dynamic to me. But before changing the clock we need
to make sure that all drivers and  hardware blocks support changing
the frequency. Changing the clock frequency while the driver or
hardware needs it fixed is of course a programming error.

>>> it does stop the clock already when its not in use. (just not the i=
nput clock).
>>
>> Yes, the external clock. That's good.
>
> I think you mean bus clock there.
>
>> I'm talking about the clock driving the SDHI block.
>
> The *input* clock, yes.

This conversation is giving me headache. We obviously talk about
different clocks. I want to control the clock that drives the SDHI
hardware block. So when the system is idle, both the clock driving the
SDHI block and the clock driving the SD Card will be stopped.

>> The clock stopping
>> is not so exciting though, the real power savings come when we can
>> disable the power to the hardware block as well dynamically.
>
> Well the tmio MFD drivers do just that, if you take a look. The hooks
> are already there.

Do you mean powering off the SD-Card? I'm talking about cutting power
to the MMC controller driven by tmio-mmc. All register state will be
gone. This while the system is kept running from a user point of view.

I don't think your MFD drivers do that, especially since the Runtime
PM framework was merged quite recently and I doubt that there are any
ARM implementations available upstream at this point.

>> I only need the first patch to get SuperH Mobile SDHI up and running=
=2E
>
> IMHO the first patch is not ready until superH and ASIC3 have been
> tested and working without modifying it. Thats why I've asked Philipp
> to test my changes to it.

I've already tested the first patch with my series that that I posted
earlier today. So from the SuperH side things are ok.

/ magnus
