From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: TMIO MMC: full patchset.
Date: Thu, 1 Oct 2009 11:19:55 +0100
Message-ID: <c09aa50a0910010319w5c613063j699a02d3a786c34f@mail.gmail.com>
References: <c09aa50a0909290552j1c371ddfpc7444d5d87e66f76@mail.gmail.com>
	<aec7e5c30909300441w6ca07dd9o889590c6100b846b@mail.gmail.com>
	<c09aa50a0909301315o683322e4k4b85e21ab473341e@mail.gmail.com>
	<aec7e5c30909301830s2d3ba9r39cce5cd57e87025@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:43640 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756171AbZJAKUM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Oct 2009 06:20:12 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1688875fge.1
        for <linux-mmc@vger.kernel.org>; Thu, 01 Oct 2009 03:20:15 -0700 (PDT)
In-Reply-To: <aec7e5c30909301830s2d3ba9r39cce5cd57e87025@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, sameo@openedhand.com, pb@handhelds.org, philipp.zabel@gmail.com, akpm@linux-foundation.org

2009/10/1 Magnus Damm <magnus.damm@gmail.com>:
>
>> Passing struct clk pointers about is _not the right way_ its not the
>> way the clk api was designed to be used. clocks are _got and _put by
>> name and device references, and the pointers should not be getting
>> passed from platform code to modular drivers.
>
> Right, I agree that passing a struct clk pointer is far from perfect.

It isnt imperfect, its a violation of the API.
> So you mean that the platform code should do clk_enable() and
> clk_get_rate(), then feed the rate to the driver using hclk? That is
> doable, but..
>
> The downside of this is that the clock will be enabled regardless if
> the tmio-mmc driver is enabled or not. From that perspective I would
> prefer that the clock would be enabled in the actual tmio-mmc driver
> itself.

Thats unfortunate - but realistically thee only good fix for that is
fixing the clk API so  that its not cpu tied.  I've altered tmio-mmc.c
as much as I am comfortable with already.

> Or I could add some ugly #ifdefs around the platform device code.

No.

> Maybe the best option is to hack up a mfd driver for just the
> superh-mobile specific sdhi part.

I dont see why not - the MFD layer is quite lightweight and you only
need to provide enable and disable hooks.

Your current implementation is broken in that if as you say the clock
rate can vary prior to loading the MMC  driver then you will end up
with f_max being set to whatever random clock was set when the driver
probes.

> At some point I'd like to add runtime pm support to the tmio-mmc
> driver as well. With such a change it should be possible to power down
> the hardware block while the system is idle and re-setup everything
> when next access happens.

it does stop the clock already when its not in use. (just not the input clock).

> You are right that other boards and processor will want to use this.
>
> Regarding duplicated code, please have a second look. The platform
> data is similar but not identical.

The resources are...

> Any chance we can get at least the ian-0001 patch and the kconfig bit
> merged in 2.6.32-rc? I realize it's a bit late in the merge cycle
> though.

I have a complete set of patches here, I'd like to send them in
together, so just waiting on ASIC3 stuff to settle now.

> If we stick to 2.6.33 then this little change took more than
> one year from initial patches to inclusion in a stable kernel....

That happens. No point in rushing things, lets get it _right_.

btw, tc6387xb is a very 'thin' MFD layer for a similar sounding
device, you might use that?

-- 
Ian Molton
Linux, Automotive, and other hacking:
http://www.mnementh.co.uk/
