From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: how to unbind current mmc driver to bind mmc-test driver?
Date: Wed, 25 May 2011 19:14:34 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1105251913300.4104@localhost6.localdomain6>
References: <alpine.DEB.2.00.1105251346490.12045@localhost6.localdomain6> <20110525231132.GA30458@void.printf.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:33775 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754299Ab1EYXOl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 May 2011 19:14:41 -0400
In-Reply-To: <20110525231132.GA30458@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Thu, 26 May 2011, Chris Ball wrote:

> Hi Robert,
>
> On Wed, May 25, 2011 at 01:58:13PM -0400, Robert P. J. Day wrote:
> >
> >   ever willing to embarrass myself in public, i'm going to ask how to
> > load and invoke the mmc_test driver on my ubuntu laptop, which is
> > currently running my hand-rolled super-recent, 2.6.39+ kernel.
> >
> >   i'm following along in the script here:
> >
> > http://www.spinics.net/lists/linux-mmc/msg05835.html
> >
> > and it seems pretty straightforward -- i interpret all of that as that
> > one needs first to find the driver that is currently bound to the
> > device (mmc-block?), unbind it, then bind to the mmc test driver.
> > that seems easy enough except that this loop in the script:
> >
> > ...
> >
> > is clearly looking for the *current* driver but, on my system, there
> > is none.  on this laptop, the MMC card slot appears to be managed by
> > the SCSI driver and USB storage, so there is no symlink there; hence,
> > the script fails in the next check:
>
> You don't actually have a drivers/mmc device, then -- a controller
> somewhere is making your SD slot look like a mass storage device, in
> hardware.  The drivers/mmc stack is for devices that aren't being
> mediated in this way.

  i'd eventually come to that conclusion.  i guess it's time to drag
out one of my embedded systems, which will probably behave the way i
was expecting.  thanks.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
