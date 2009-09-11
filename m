From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Regression in suspend to ram in 2.6.31-rc kernels
Date: Fri, 11 Sep 2009 23:51:17 +0200
Message-ID: <20090911215117.GA11441@elf.ucw.cz>
References: <c4e36d110909040213t4d4258b4w3e2d4725e0b2a161@mail.gmail.com> <87iqfx5mss.fsf@devron.myhome.or.jp> <20090907125130.GA1595@ucw.cz> <87ljko5k3v.fsf@devron.myhome.or.jp> <20090910192354.GD23356@elf.ucw.cz> <87bplim1ce.fsf@devron.myhome.or.jp> <20090911200922.GF8137@elf.ucw.cz> <c4e36d110909111414n716a06b1mdd0cd741230595b5@mail.gmail.com> <20090911213204.GC25544@elf.ucw.cz> <c4e36d110909111445nb6592cfue01543f5d04c2cda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49481 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755992AbZIKVvW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Sep 2009 17:51:22 -0400
Content-Disposition: inline
In-Reply-To: <c4e36d110909111445nb6592cfue01543f5d04c2cda@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zdenek Kabelac <zdenek.kabelac@gmail.com>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Christoph Hellwig <hch@lst.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, viro@zeniv.linux.org.uk

On Fri 2009-09-11 23:45:01, Zdenek Kabelac wrote:
> 2009/9/11 Pavel Machek <pavel@ucw.cz>:
> >
> >> And why suspend of mmc should generate card removal ??
> >
> > Card is powered down during suspend -> mmc can't guarantee the card is
> > same and unchanged -> it makes some sense to simulate
> > removal/reinsert.
> 
> But how is this going to work when I keep the device mounted and
> blockdev is basically destroyed -  what if I'm reading file from card
> during suspend ?

"Don't do it".

> >> if I suspend and resume my laptop and I keep the card inside - all
> >> those step looks plain wrong.
> >
> > Unfortunately system can't tell.
> 
> Well system could check basic card ids if they match after resume - if
> some users wants to crash his card by randomly swapping it during
> suspend/resume - I'd have no problem with that....

Well, I do have small problem with that :-).

Anyway, patch for rechecking IDs would probably be accepted, but
that's not how it works now.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
