From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Regression in suspend to ram in 2.6.31-rc kernels
Date: Fri, 18 Sep 2009 23:39:14 +0200
Message-ID: <200909182339.14374.rjw@sisk.pl>
References: <20090903232317.GA6760@lst.de> <200909120036.41725.rjw@sisk.pl> <87fxaksdve.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50133 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432AbZIRViI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 18 Sep 2009 17:38:08 -0400
In-Reply-To: <87fxaksdve.fsf@devron.myhome.or.jp>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Chris Ball <cjb@laptop.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, Pavel Machek <pavel@ucw.cz>, Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, viro@zeniv.linux.org.uk

On Friday 18 September 2009, OGAWA Hirofumi wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Saturday 12 September 2009, Chris Ball wrote:
> >> Hi,
> >> 
> >>    > Well system could check basic card ids if they match after resume
> >> 
> >> No.  That (arguably) guarantees that it's the same card, but not that
> >> it wasn't modified in another machine during the suspend.
> >
> > Generally speaking, we'd also need to check superblocks for this to work.
> >  
> >>    > if some users wants to crash his card by randomly swapping it
> >>    > during suspend/resume - I'd have no problem with that....
> >> 
> >> You should have a problem with it.  Taking a card from a suspended
> >> machine and working on it with a different machine is not a bizarre
> >> thing to want to do.
> >
> > Agreed.
> 
> Um...
> 
> What happen if we moved remove event to resume sequence?  I.e. The
> resume generates remove and insert event (or such revalidate).  With
> this, I hope the suspend is not bothered by complex one, and the resume
> just ignores (if needed) previous state and notify it to userland by
> remove/insert event.
> 
> And, userland process should unmount for removal devices before suspend
> process (as part of userland preparation)?
> 
> If we assumed the removable device can be changed before resume, fs
> would need to recover process, to make sure in-core and on-disk state
> has consistent.
> 
> Um..., for now, I feel the umount before suspend is only safe way.

Yes, with the current design it's the only really safe way.

Thanks,
Rafael
