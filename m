From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [RFC RESEND] sdhci-s3c: support clock enable/disable (clock-gating)
Date: Wed, 29 Sep 2010 23:42:01 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009292334050.1146@xanadu.home>
References: <4C91BD5A.1040804@samsung.com>
 <20100929233751.GA31473@void.printf.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:29184 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978Ab0I3DmD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Sep 2010 23:42:03 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L9J00MZXJM1AFF0@VL-MR-MRZ22.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Wed, 29 Sep 2010 23:42:02 -0400 (EDT)
In-reply-to: <20100929233751.GA31473@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, matt@console-pimps.org, Andrew Morton <akpm@linux-foundation.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>

On Thu, 30 Sep 2010, Chris Ball wrote:

> Hi Jaehoon/Adrian,
> 
> On Thu, Sep 16, 2010 at 03:46:50PM +0900, Jaehoon Chung wrote:
> > Hi all,
> >   This is a RFC patch that support clock-gating for saving power consumption.
> >   I found mmc_host_enable/mmc_host_disable function in core.c
> >   (using MMC_CAP_DSIABLE. i think that use when host enable/disable)
> >   So, i used that functions and implemented some functions in sdhci-s3c.c & sdhci.c
> > 
> > i want any feedback. how do you think about this patch?
> > Plz let me know...
> 
> A few points:
>   * Have you tested this patch?  Did you see a decrease in power
>     consumption?  How large was the decrease?
>   * I don't understand exactly how/when you're expecting to save power
>     with this approach of defining .{enable,disable}() without then
>     calling them from your driver code.  Under which circumstances do
>     you think this will power down the clock?
>   * CC'ing Adrian for help with review, since he wrote these callbacks.

As I already said here: 

	http://article.gmane.org/gmane.linux.ports.arm.omap/39411

I find those callbacks rather problematic.  Currently, 
mmc_host_disable() is called by the host driver (currently OMAP) and 
that's wrong.  Such decision cannot be made in the controller driver -- 
it has to be made higher up the stack.


Nicolas
