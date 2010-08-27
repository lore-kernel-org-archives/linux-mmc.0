From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] sdio: add MMC_PM_SKIP_RESUME_PROBE to workaround powered
 resume
Date: Fri, 27 Aug 2010 18:19:18 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1008271818110.8130@xanadu.home>
References: <1279763215-17574-1-git-send-email-bzhao@marvell.com>
 <m339tz6agq.fsf@pullcord.laptop.org>
 <alpine.LFD.2.00.1008271812490.8130@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:18093 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753538Ab0H0WTT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Aug 2010 18:19:19 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L7U006JU0O6RFW1@VL-MR-MR001.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Fri, 27 Aug 2010 18:19:18 -0400 (EDT)
In-reply-to: <alpine.LFD.2.00.1008271812490.8130@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Bing Zhao <bzhao@marvell.com>, linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Fri, 27 Aug 2010, Nicolas Pitre wrote:

> On Fri, 27 Aug 2010, Chris Ball wrote:
> 
> > Hi,
> > 
> > Any comments on this patch from the list?
> 
> Looks rather hackish to me.  There should be a more elegant way to 
> achieve the same result.  I have no time to look at it and propose an 
> alternative solution though.

... at the moment that is.


Nicolas
