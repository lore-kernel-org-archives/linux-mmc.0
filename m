From: Chris Ball <cjb@laptop.org>
Subject: Re: [RFC RESEND] sdhci-s3c: support clock enable/disable
	(clock-gating)
Date: Thu, 30 Sep 2010 05:09:58 +0100
Message-ID: <20100930040958.GA3170@void.printf.net>
References: <4C91BD5A.1040804@samsung.com> <20100929233751.GA31473@void.printf.net> <alpine.LFD.2.00.1009292334050.1146@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45123 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894Ab0I3EKE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Sep 2010 00:10:04 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1009292334050.1146@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, matt@console-pimps.org, Andrew Morton <akpm@linux-foundation.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Pierre Ossman <pierre-list@ossman.eu>, Kukjin Kim <kgene.kim@samsung.com>

Hi,

On Wed, Sep 29, 2010 at 11:42:01PM -0400, Nicolas Pitre wrote:
> As I already said here: 
> 
> 	http://article.gmane.org/gmane.linux.ports.arm.omap/39411
> 
> I find those callbacks rather problematic.  Currently, 
> mmc_host_disable() is called by the host driver (currently OMAP) and 
> that's wrong.  Such decision cannot be made in the controller driver -- 
> it has to be made higher up the stack.

I strongly agree.  I hadn't noticed that aspect of this design until
today.  It looked like Linus W had a nice core-integrated clocking
framework almost ready to go a year ago, but it lost out.  (Something
left to do was to give extra time after a request in case we're on a
broken card which requires the card clock to be present during its
writeback.)

I'm not sure where to go from here -- advice welcome.  It would
perhaps be ideal if Linus W and Adrian could work together to make
the current framework look more like Linus' original intent and then
move omap_hsmmc to it as painlessly as possible.  Of course I wouldn't
expect this to happen quickly.

In the meantime, I would suggest that we should not accept any more
users of this framework, which would be a NACK to Jaehoon's patch
(which appears to my reading not to achieve any power-saving anyway).

Adrian, I'm sorry that I'm suggesting reverting -- or at least strongly
modifying -- a framework after it's already shipped in a release; if
you think this is unreasonable, I'll consider your argument carefully.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
