From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH v4] mmc: Add ioctl to let userspace apps send ACMDs
Date: Mon, 18 Apr 2011 09:30:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104180929260.16629@peruna>
References: <alpine.DEB.2.00.1104111424140.32082@peruna> <201104130100.39810.arnd@arndb.de> <alpine.DEB.2.00.1104121604220.8483@peruna> <201104181639.48730.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-spurfowl.atl.sa.earthlink.net ([209.86.89.66]:55069
	"EHLO elasmtp-spurfowl.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755720Ab1DRQbL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2011 12:31:11 -0400
In-Reply-To: <201104181639.48730.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Andrei Warkentin <andreiw@motorola.com>

On Mon, 18 Apr 2011, Arnd Bergmann wrote:
> On Wednesday 13 April 2011, John Calixto wrote:
> > Gah!  OK, so much for the v5 I just sent then.  What do you think about
> > the compat_ioctl that I sent in v2?  It means having the extra 32-bit
> > compat structure, but at least all the compat overhead is conditional
> > upon CONFIG_COMPAT.  If you're not using CONFIG_COMPAT, you don't get
> > any compat cruft.
> > 
> 
> A single __u64 is sufficient, because the user space will do the correct
> conversion from pointer to 64-bit integer then. The only conversion
> you need to worry about is the actual pointer to the main structure,
> which needs the compat_ptr() magic.
> 

Yep.  Please see the v6 patch for my latest implementation.

John
