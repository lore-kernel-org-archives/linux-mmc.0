From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: TMIO MMC: full patchset.
Date: Fri, 2 Oct 2009 19:14:01 +0100
Message-ID: <c09aa50a0910021114h1a84703dt4f168b9fee1b723a@mail.gmail.com>
References: <c09aa50a0909290552j1c371ddfpc7444d5d87e66f76@mail.gmail.com>
	<aec7e5c30909300441w6ca07dd9o889590c6100b846b@mail.gmail.com>
	<c09aa50a0909301315o683322e4k4b85e21ab473341e@mail.gmail.com>
	<aec7e5c30909301830s2d3ba9r39cce5cd57e87025@mail.gmail.com>
	<c09aa50a0910010319w5c613063j699a02d3a786c34f@mail.gmail.com>
	<aec7e5c30910012246r1c452606w149f18d9fe825737@mail.gmail.com>
	<c09aa50a0910020031x1c6f1fceo4740a3edc9592cbe@mail.gmail.com>
	<aec7e5c30910020057w38e72894p9ffed291f3fc1d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:39229 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757502AbZJBSOS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Oct 2009 14:14:18 -0400
Received: by fxm27 with SMTP id 27so1298742fxm.17
        for <linux-mmc@vger.kernel.org>; Fri, 02 Oct 2009 11:14:21 -0700 (PDT)
In-Reply-To: <aec7e5c30910020057w38e72894p9ffed291f3fc1d1@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, sameo@openedhand.com, pb@handhelds.org, philipp.zabel@gmail.com, akpm@linux-foundation.org, Paul Mundt <lethal@linux-sh.org>

2009/10/2 Magnus Damm <magnus.damm@gmail.com>:

>> I asked if the clock freq. changes - you said 'Well, the goal is
>> dynamic clocks, but at this point it's dynamic until the clock is
>> enabled'.
>>
>> Since your code doesnt set the clock frequency, that means the MMC
>> drivers f_max will be set to whatever the clock was running at when
>> you grab it.
>
> Yes?

Well if its set to 512kHz prior to being claimed, that means the MMC
clock will run between 1kHz and 512kHz

tmio_mmc will work like that but it seems kinda daft...

> You can call it whatever you want. On SuperH we can do clock scaling
> which seems very dynamic to me. But before changing the clock we need
> to make sure that all drivers and =A0hardware blocks support changing
> the frequency. Changing the clock frequency while the driver or
> hardware needs it fixed is of course a programming error.

exactly - which is one reason why I said your clk based implementation
is broken - tmio_mmc has no logic for coping with a clock that changed
frequency. Since all tmio-based devices appear to have the
frequency-divider  built in, I suspect that all tmio units expect to
have a host (input) clock in the 20-30MHz range. Since the superH tmio
blocks clock divider is missing the unity divisor, varying the imput
clock speed to change the MMC bus frequency seems like a bad idea. If
you could do unity-divisor then you might be able to save a little
power disabling the TMIO divisor and adjusting the input clock
frequency

>> Well the tmio MFD drivers do just that, if you take a look. The hook=
s
>> are already there.
>
> Do you mean powering off the SD-Card?

Well the CNF area controls card clocking and power.
but the MFD code provides enable and disable hooks. Cutting the clock
and sleeping the chip is the best the toshiba hardware can do, but
theres no reason not to turn off the chip when its not in use (as
opposed to suspended / idle - or the registers will lose state)

> I don't think your MFD drivers do that,

Actually they do provide provision for that by means of the enable /
disable hooks.

if you unload the driver, the disable hook will get called and you can
power it off there.

> especially since the Runtime
> PM framework was merged quite recently and I doubt that there are any
> ARM implementations available upstream at this point.

Thats something for the future - right now tmio-mmc wont take power
being interrupted whilst it runs.

> I've already tested the first patch with my series that that I posted
> earlier today. So from the SuperH side things are ok.

Great - as soon as Philipp gets back to us with the ASIC3 update I'll
re-do my patchset to include ASIC3 - if the changes to tmio-mmc and
submitted seperately, it will break ASIC3 so that needs to go in the
same patchset. Philipp will be ready this weekend, not long to wait.

--=20
Ian Molton
Linux, Automotive, and other hacking:
http://www.mnementh.co.uk/
