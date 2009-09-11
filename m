From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Regression in suspend to ram in 2.6.31-rc kernels
Date: Sat, 12 Sep 2009 00:36:41 +0200
Message-ID: <200909120036.41725.rjw@sisk.pl>
References: <20090903232317.GA6760@lst.de> <c4e36d110909111445nb6592cfue01543f5d04c2cda@mail.gmail.com> <m3eiqdqfnm.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46304 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757131AbZIKWfd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 11 Sep 2009 18:35:33 -0400
In-Reply-To: <m3eiqdqfnm.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Zdenek Kabelac <zdenek.kabelac@gmail.com>, Pavel Machek <pavel@ucw.cz>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, viro@zeniv.linux.org.uk

On Saturday 12 September 2009, Chris Ball wrote:
> Hi,
> 
>    > Well system could check basic card ids if they match after resume
> 
> No.  That (arguably) guarantees that it's the same card, but not that
> it wasn't modified in another machine during the suspend.

Generally speaking, we'd also need to check superblocks for this to work.
 
>    > if some users wants to crash his card by randomly swapping it
>    > during suspend/resume - I'd have no problem with that....
> 
> You should have a problem with it.  Taking a card from a suspended
> machine and working on it with a different machine is not a bizarre
> thing to want to do.

Agreed.

Thanks,
Rafael
