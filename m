From: Chris Ball <cjb@laptop.org>
Subject: Re: kernel 2.6.38.6 MMC controller problem (fwd)
Date: Mon, 16 May 2011 11:56:19 -0400
Message-ID: <m38vu6k5b0.fsf@pullcord.laptop.org>
References: <Pine.LNX.4.64.1105160830420.4131@axis700.grange>
	<BANLkTinbJfDLp5nfkq-VTYLJvihT1thXvA@mail.gmail.com>
	<Pine.LNX.4.64.1105161044260.4131@axis700.grange>
	<m3d3jik88n.fsf@pullcord.laptop.org>
	<BANLkTin-wiP9ukmPJPo3n5SWqsd=j9rjBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59495 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756299Ab1EPPy2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 16 May 2011 11:54:28 -0400
In-Reply-To: <BANLkTin-wiP9ukmPJPo3n5SWqsd=j9rjBg@mail.gmail.com> (David
	Strobach's message of "Mon, 16 May 2011 17:15:08 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Strobach <lalochcz@gmail.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, Greg KH <greg@kroah.com>, horms@verge.net.au, damm@opensource.se, Andrei Warkentin <andreiw@motorola.com>, Linus Walleij <linus.walleij@linaro.org>

Hi,

On Mon, May 16 2011, David Strobach wrote:
> I don't always end up with the divide error either. See the log in the
> OP. We can also ask for logs on the archlinux forum thread, I
> referenced in the OP.

Oh, that's interesting -- https://bugs.archlinux.org/task/23778 was
opened on April 15th with the divide error crash, but I didn't send
Guennadi's patch to Linus until May 9th.  So this patch can't be the
whole story.

David, are you very confident in the bisection being correct?
Also, perhaps you could confirm that setting CONFIG_MMC_CLKGATE=n
makes all of the problems go away, even with the bad patch applied?

Thanks.  I'll plan on sending Linus a revert of Guennadi's patch today,
assuming he doesn't release 2.6.39 within a few hours..

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
