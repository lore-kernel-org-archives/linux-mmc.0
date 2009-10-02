From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: TMIO MMC: full patchset.
Date: Fri, 2 Oct 2009 14:46:46 +0900
Message-ID: <aec7e5c30910012246r1c452606w149f18d9fe825737@mail.gmail.com>
References: <c09aa50a0909290552j1c371ddfpc7444d5d87e66f76@mail.gmail.com>
	 <aec7e5c30909300441w6ca07dd9o889590c6100b846b@mail.gmail.com>
	 <c09aa50a0909301315o683322e4k4b85e21ab473341e@mail.gmail.com>
	 <aec7e5c30909301830s2d3ba9r39cce5cd57e87025@mail.gmail.com>
	 <c09aa50a0910010319w5c613063j699a02d3a786c34f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f199.google.com ([209.85.210.199]:40192 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756317AbZJBFqn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Oct 2009 01:46:43 -0400
Received: by yxe37 with SMTP id 37so850226yxe.33
        for <linux-mmc@vger.kernel.org>; Thu, 01 Oct 2009 22:46:46 -0700 (PDT)
In-Reply-To: <c09aa50a0910010319w5c613063j699a02d3a786c34f@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: linux-mmc@vger.kernel.org, sameo@openedhand.com, pb@handhelds.org, philipp.zabel@gmail.com, akpm@linux-foundation.org, Paul Mundt <lethal@linux-sh.org>

[CC Paul Mundt]

On Thu, Oct 1, 2009 at 7:19 PM, Ian Molton <ian@mnementh.co.uk> wrote:
> 2009/10/1 Magnus Damm <magnus.damm@gmail.com>:

>> Maybe the best option is to hack up a mfd driver for just the
>> superh-mobile specific sdhi part.
>
> I dont see why not - the MFD layer is quite lightweight and you only
> need to provide enable and disable hooks.

Right, the MFD driver approach is probably the best one.

> Your current implementation is broken in that if as you say the clock
> rate can vary prior to loading the MMC =A0driver then you will end up
> with f_max being set to whatever random clock was set when the driver
> probes.

No, it's not broken. When the clock is enabled the frequency stays
fixed. How would things work at all if that wasn't the case? The clock
rate comes from whatever bus frequency that is used for the bus that
the SDHI block is hooked up to. So it's far from random.

>> At some point I'd like to add runtime pm support to the tmio-mmc
>> driver as well. With such a change it should be possible to power do=
wn
>> the hardware block while the system is idle and re-setup everything
>> when next access happens.
>
> it does stop the clock already when its not in use. (just not the inp=
ut clock).

Yes, the external clock. That's good.

I'm talking about the clock driving the SDHI block. The clock stopping
is not so exciting though, the real power savings come when we can
disable the power to the hardware block as well dynamically.

>> Any chance we can get at least the ian-0001 patch and the kconfig bi=
t
>> merged in 2.6.32-rc? I realize it's a bit late in the merge cycle
>> though.
>
> I have a complete set of patches here, I'd like to send them in
> together, so just waiting on ASIC3 stuff to settle now.

I only need the first patch to get SuperH Mobile SDHI up and running.

Andrew, Paul, please let me know if you need anything else from me.

Cheers,

/ magnus
