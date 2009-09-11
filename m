From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Regression in suspend to ram in 2.6.31-rc kernels
Date: Sat, 12 Sep 2009 00:22:10 +0200
Message-ID: <200909120022.10808.rjw@sisk.pl>
References: <c4e36d110909040213t4d4258b4w3e2d4725e0b2a161@mail.gmail.com> <c4e36d110909111445nb6592cfue01543f5d04c2cda@mail.gmail.com> <20090911215117.GA11441@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46252 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343AbZIKWVE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 11 Sep 2009 18:21:04 -0400
In-Reply-To: <20090911215117.GA11441@elf.ucw.cz>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Zdenek Kabelac <zdenek.kabelac@gmail.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, viro@zeniv.linux.org.uk

On Friday 11 September 2009, Pavel Machek wrote:
> On Fri 2009-09-11 23:45:01, Zdenek Kabelac wrote:
> > 2009/9/11 Pavel Machek <pavel@ucw.cz>:
> > >
> > >> And why suspend of mmc should generate card removal ??
> > >
> > > Card is powered down during suspend -> mmc can't guarantee the card is
> > > same and unchanged -> it makes some sense to simulate
> > > removal/reinsert.
> > 
> > But how is this going to work when I keep the device mounted and
> > blockdev is basically destroyed -  what if I'm reading file from card
> > during suspend ?
> 
> "Don't do it".
> 
> > >> if I suspend and resume my laptop and I keep the card inside - all
> > >> those step looks plain wrong.
> > >
> > > Unfortunately system can't tell.
> > 
> > Well system could check basic card ids if they match after resume - if
> > some users wants to crash his card by randomly swapping it during
> > suspend/resume - I'd have no problem with that....
> 
> Well, I do have small problem with that :-).
> 
> Anyway, patch for rechecking IDs would probably be accepted,

By whom exactly?

> but that's not how it works now.

Indeed.

Thanks,
Rafael
