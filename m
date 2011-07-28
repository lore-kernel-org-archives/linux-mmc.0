From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] MMC / TMIO: Fix build issue related to struct scatterlist
Date: Thu, 28 Jul 2011 23:07:31 +0200
Message-ID: <201107282307.31564.rjw@sisk.pl>
References: <201107262049.15333.rjw@sisk.pl> <201107272356.16817.rjw@sisk.pl> <Pine.LNX.4.64.1107282205110.20737@axis700.grange>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60241 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754611Ab1G1VGa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Jul 2011 17:06:30 -0400
In-Reply-To: <Pine.LNX.4.64.1107282205110.20737@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Thursday, July 28, 2011, Guennadi Liakhovetski wrote:
> On Wed, 27 Jul 2011, Rafael J. Wysocki wrote:
> 
> > On Wednesday, July 27, 2011, Guennadi Liakhovetski wrote:
> > > (added MMC maintainer to CC:)
> > > 
> > > On Tue, 26 Jul 2011, Rafael J. Wysocki wrote:
> > > 
> > > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > > 
> > > > Fix build issue caused by undefined struct scatterlist in
> > > > drivers/mmc/host/tmio_mmc.c.
> > > > 
> > > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > A nitpick, if I may: sCatterlist comes before sPinlock in my versions of 
> > > most popular alphabets;-) Please, fix (or maybe Chris can fix it himself), 
> > 
> > I'm not sure what you mean exactly (perhaps it's too late).
> 
> I mean, that the headers are atm sorted alphabetically and should remain 
> so, therefore you should add the new header one line higher.

Ah.  Well, as I said the patch had been merged already, so obviously
Linus didn't care. :-)

> As for compile failure or not: I haven't seen any compile failures myself, but 
> the patch is academically correct, because structs, declared in tmio_mmc.h 
> embed struct scatterlist, therefore the header has to be included in that 
> header too.

Exactly.  I've seen a real failure, though.

Thanks,
Rafael
