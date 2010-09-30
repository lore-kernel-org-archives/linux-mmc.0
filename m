From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [RFC RESEND] sdhci-s3c: support clock enable/disable (clock-gating)
Date: Thu, 30 Sep 2010 09:30:46 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009300927490.1146@xanadu.home>
References: <4C91BD5A.1040804@samsung.com>
 <20100929233751.GA31473@void.printf.net>
 <alpine.LFD.2.00.1009292334050.1146@xanadu.home>
 <20100930040958.GA3170@void.printf.net>
 <AANLkTin=9KwC0Paa8yAhG-OBXFrfJDKJSYokzLLa6jPN@mail.gmail.com>
 <AANLkTikywfU_C4QTQet64aQJgQyyDdTh4xRpaYu6q0di@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:21864 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264Ab0I3Nar (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Sep 2010 09:30:47 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L9K000G8AVAB240@VL-MH-MR002.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Thu, 30 Sep 2010 09:30:46 -0400 (EDT)
In-reply-to: <AANLkTikywfU_C4QTQet64aQJgQyyDdTh4xRpaYu6q0di@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc@vger.kernel.org, matt@console-pimps.org, Andrew Morton <akpm@linux-foundation.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Pierre Ossman <pierre-list@ossman.eu>, Kukjin Kim <kgene.kim@samsung.com>

On Thu, 30 Sep 2010, Linus Walleij wrote:

> 2010/9/30 Kyungmin Park <kyungmin.park@samsung.com>:
> > So try to find another method and implemente it at SDHCI drivers.
> 
> Why? The only difference between this solution and the one
> that is inside the kernel now is that this will use set_ios() with
> a zero argument to gate off the clock after a timeout instead
> of special callbacks. (A features especially requested by Pierre.)

Good!  I didn't look at your solution before, but in my mind that always 
been how it should be done.


Nicolas
