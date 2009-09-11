From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Regression in suspend to ram in 2.6.31-rc kernels
Date: Fri, 11 Sep 2009 23:32:05 +0200
Message-ID: <20090911213204.GC25544@elf.ucw.cz>
References: <20090903232317.GA6760@lst.de> <87ljkvmt71.fsf@devron.myhome.or.jp> <c4e36d110909040213t4d4258b4w3e2d4725e0b2a161@mail.gmail.com> <87iqfx5mss.fsf@devron.myhome.or.jp> <20090907125130.GA1595@ucw.cz> <87ljko5k3v.fsf@devron.myhome.or.jp> <20090910192354.GD23356@elf.ucw.cz> <87bplim1ce.fsf@devron.myhome.or.jp> <20090911200922.GF8137@elf.ucw.cz> <c4e36d110909111414n716a06b1mdd0cd741230595b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53948 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756711AbZIKVcI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Sep 2009 17:32:08 -0400
Content-Disposition: inline
In-Reply-To: <c4e36d110909111414n716a06b1mdd0cd741230595b5@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zdenek Kabelac <zdenek.kabelac@gmail.com>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Christoph Hellwig <hch@lst.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, viro@zeniv.linux.org.uk


> And why suspend of mmc should generate card removal ??

Card is powered down during suspend -> mmc can't guarantee the card is
same and unchanged -> it makes some sense to simulate
removal/reinsert.

> if I suspend and resume my laptop and I keep the card inside - all
> those step looks plain wrong.

Unfortunately system can't tell.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
