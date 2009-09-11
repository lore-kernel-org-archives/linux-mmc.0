From: Chris Ball <cjb@laptop.org>
Subject: Re: Regression in suspend to ram in 2.6.31-rc kernels
Date: Fri, 11 Sep 2009 18:29:17 -0400
Message-ID: <m3eiqdqfnm.fsf@pullcord.laptop.org>
References: <20090903232317.GA6760@lst.de>
	<c4e36d110909040213t4d4258b4w3e2d4725e0b2a161@mail.gmail.com>
	<87iqfx5mss.fsf@devron.myhome.or.jp> <20090907125130.GA1595@ucw.cz>
	<87ljko5k3v.fsf@devron.myhome.or.jp>
	<20090910192354.GD23356@elf.ucw.cz>
	<87bplim1ce.fsf@devron.myhome.or.jp>
	<20090911200922.GF8137@elf.ucw.cz>
	<c4e36d110909111414n716a06b1mdd0cd741230595b5@mail.gmail.com>
	<20090911213204.GC25544@elf.ucw.cz>
	<c4e36d110909111445nb6592cfue01543f5d04c2cda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45914 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857AbZIKWbo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 11 Sep 2009 18:31:44 -0400
In-Reply-To: <c4e36d110909111445nb6592cfue01543f5d04c2cda@mail.gmail.com>
	(Zdenek Kabelac's message of "Fri, 11 Sep 2009 23:45:01 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zdenek Kabelac <zdenek.kabelac@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Christoph Hellwig <hch@lst.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, viro@zeniv.linux.org.uk

Hi,

   > Well system could check basic card ids if they match after resume

No.  That (arguably) guarantees that it's the same card, but not that
it wasn't modified in another machine during the suspend.

   > if some users wants to crash his card by randomly swapping it
   > during suspend/resume - I'd have no problem with that....

You should have a problem with it.  Taking a card from a suspended
machine and working on it with a different machine is not a bizarre
thing to want to do.

-- 
Chris Ball   <cjb@laptop.org>
One Laptop Per Child
