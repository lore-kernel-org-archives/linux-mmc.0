From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: kernel 2.6.38.6 MMC controller problem (fwd)
Date: Mon, 16 May 2011 18:07:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105161801100.28668@axis700.grange>
References: <Pine.LNX.4.64.1105160830420.4131@axis700.grange>
 <BANLkTinbJfDLp5nfkq-VTYLJvihT1thXvA@mail.gmail.com>
 <Pine.LNX.4.64.1105161044260.4131@axis700.grange> <m3d3jik88n.fsf@pullcord.laptop.org>
 <BANLkTin-wiP9ukmPJPo3n5SWqsd=j9rjBg@mail.gmail.com> <m38vu6k5b0.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:56955 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756547Ab1EPQHX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 May 2011 12:07:23 -0400
In-Reply-To: <m38vu6k5b0.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: David Strobach <lalochcz@gmail.com>, linux-mmc@vger.kernel.org, Greg KH <greg@kroah.com>, horms@verge.net.au, damm@opensource.se, Andrei Warkentin <andreiw@motorola.com>, Linus Walleij <linus.walleij@linaro.org>

On Mon, 16 May 2011, Chris Ball wrote:

> Hi,
> 
> On Mon, May 16 2011, David Strobach wrote:
> > I don't always end up with the divide error either. See the log in the
> > OP. We can also ask for logs on the archlinux forum thread, I
> > referenced in the OP.
> 
> Oh, that's interesting -- https://bugs.archlinux.org/task/23778 was
> opened on April 15th with the divide error crash, but I didn't send
> Guennadi's patch to Linus until May 9th.  So this patch can't be the
> whole story.
> 
> David, are you very confident in the bisection being correct?
> Also, perhaps you could confirm that setting CONFIG_MMC_CLKGATE=n
> makes all of the problems go away, even with the bad patch applied?
> 
> Thanks.  I'll plan on sending Linus a revert of Guennadi's patch today,
> assuming he doesn't release 2.6.39 within a few hours..

Hm, don't know... The patch _definitely_ fixes problems in some 
configurations, and _maybe_ causes problems in others. You cannot 
reproduce the problem. Have you got a .config from the OP? We can also fix 
the problem in stable - whether it turns out to be my patch or not. Can 
you maybe wait for about 6 hours, until I get a chance to test this on my 
laptop? No, I don't have archlinux on it. What distro(s) have you tried? 
Do all reporters use archlinux?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
