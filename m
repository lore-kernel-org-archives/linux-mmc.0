From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: [PATCH] MMC: Standardize header file multiple inclusion
 checks.
Date: Fri, 27 May 2011 12:51:05 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1105271250300.9194@localhost6.localdomain6>
References: <alpine.DEB.2.00.1105270803340.3939@localhost6.localdomain6> <m3aae8rswu.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:37485 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433Ab1E0QvL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 May 2011 12:51:11 -0400
In-Reply-To: <m3aae8rswu.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Fri, 27 May 2011, Chris Ball wrote:

> Hi,
>
> On Fri, May 27 2011, Robert P. J. Day wrote:
> > Standardize the form of MMC header file inclusion checks, add missing
> > comments at end, fix one incorrect comment at end of file.
> >
> > Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> >
> > ---
> >
> >   obviously just aesthetic changes but they do conform to the norm for
> > header file inclusion checks.  someone here can decide whether or not
> > to apply them.  not compile-tested as they are all fairly
> > self-evident.
>
> Thanks, works for me.  Your two-spaces-after-endif style is not the
> norm, though -- want to resubmit with that changed to one space?
>
> ~/git/mmc/include/linux% git grep "endif /*" | wc -l
> 1497
> ~/git/mmc/include/linux% git grep "endif  /*" | wc -l
> 24

  i was actually trying to remember the norm, and thought it was two
spaces.  easy enough to fix.  coming soon.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
