From: Chris Ball <cjb@laptop.org>
Subject: Re: kernel 2.6.38.6 MMC controller problem (fwd)
Date: Mon, 16 May 2011 12:37:02 -0400
Message-ID: <m34o4uk3f5.fsf@pullcord.laptop.org>
References: <Pine.LNX.4.64.1105160830420.4131@axis700.grange>
	<BANLkTinbJfDLp5nfkq-VTYLJvihT1thXvA@mail.gmail.com>
	<Pine.LNX.4.64.1105161044260.4131@axis700.grange>
	<m3d3jik88n.fsf@pullcord.laptop.org>
	<BANLkTin-wiP9ukmPJPo3n5SWqsd=j9rjBg@mail.gmail.com>
	<m38vu6k5b0.fsf@pullcord.laptop.org>
	<Pine.LNX.4.64.1105161801100.28668@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39744 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956Ab1EPQfK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 16 May 2011 12:35:10 -0400
In-Reply-To: <Pine.LNX.4.64.1105161801100.28668@axis700.grange> (Guennadi
	Liakhovetski's message of "Mon, 16 May 2011 18:07:05 +0200 (CEST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: David Strobach <lalochcz@gmail.com>, linux-mmc@vger.kernel.org, Greg KH <greg@kroah.com>, horms@verge.net.au, damm@opensource.se, Andrei Warkentin <andreiw@motorola.com>, Linus Walleij <linus.walleij@linaro.org>

Hi,

On Mon, May 16 2011, Guennadi Liakhovetski wrote:
>> Thanks.  I'll plan on sending Linus a revert of Guennadi's patch today,
>> assuming he doesn't release 2.6.39 within a few hours..
>
> Hm, don't know... The patch _definitely_ fixes problems in some 
> configurations, and _maybe_ causes problems in others. You cannot 
> reproduce the problem.

It looks like around six different people on:
   https://bbs.archlinux.org/viewtopic.php?id=118751

say that moving from 38.5 to 38.6 makes their system crash at boot
or resume time if they have an SD card inserted -- this seems like
reasonably strong evidence, and the problem being seen after the
patch (full system crash) is significantly worse than the problem
being seen before the patch (occasional misdetection of insertion).

> Have you got a .config from the OP?

Yes, http://projects.archlinux.org/svntogit/packages.git/tree/kernel26/repos/core-x86_64/config.x86_64.
I checked that it does indeed have CLKGATE=y.

> We can also fix the problem in stable - whether it turns out to be my
> patch or not.

It would be a shame to release with a boot crash, though.

> Can you maybe wait for about 6 hours, until I get a chance to test
> this on my laptop?

My intuition is that we should revert it now -- it's been a week since
the final -rc, so you'd expect .39 to be released today, and we can
always add your patch back into stable via .40-rc1 if it's not related
to the crashes.

> No, I don't have archlinux on it. What distro(s) have you tried?  Do
> all reporters use archlinux?

I've tried Ubuntu.  All reporters so far use Archlinux, but it's quite
plausible that we're only seeing the bug from Archlinux users because
only Archlinux has pushed out 2.6.38.6 to its users already..

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
