From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: MMC card removal in suspend state
Date: Thu, 5 Aug 2010 18:32:55 -0500
Message-ID: <61142068C0884F3F94BEC17BB99DCE14@am.dhcp.ti.com>
References: <621C9491683D48E5992B340E62198CD6@am.dhcp.ti.com> <1281048198.7148.6.camel@maxim-laptop> <A266C3A14F5641A3A138034913176B7D@am.dhcp.ti.com> <1281050449.7148.14.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50305 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754007Ab0HEXdB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 Aug 2010 19:33:01 -0400
In-Reply-To: <1281050449.7148.14.camel@maxim-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Maxim Levitsky' <maximlevitsky@gmail.com>
Cc: linux-mmc@vger.kernel.org, 'Pierre Ossman' <pierre@ossman.eu>



> -----Original Message-----
> From: Maxim Levitsky [mailto:maximlevitsky@gmail.com]
> Sent: Thursday, August 05, 2010 6:21 PM
> To: Madhusudhan
> Cc: linux-mmc@vger.kernel.org; 'Pierre Ossman'
> Subject: RE: MMC card removal in suspend state
> 
> On Thu, 2010-08-05 at 17:54 -0500, Madhusudhan wrote:
> >
> > > -----Original Message-----
> > > From: Maxim Levitsky [mailto:maximlevitsky@gmail.com]
> > > Sent: Thursday, August 05, 2010 5:43 PM
> > > To: Madhusudhan
> > > Cc: linux-mmc@vger.kernel.org; 'Pierre Ossman'
> > > Subject: Re: MMC card removal in suspend state
> > >
> > > On Thu, 2010-08-05 at 16:45 -0500, Madhusudhan wrote:
> > > > Hi,
> > > >
> > > > Recently, while looking at some stuff I saw the below patch done by
> > > Pierre
> > > > which is part of the drivers/mmc/card/queue.c file. I wonder if
> someone
> > > can
> > > > through more light on this to understand where could be a potential
> > > deadlock
> > > > without calling mmc_queue_resume.
> > > >
> > > > Is there a need for the mmc queue to be resumed before calling
> > > > del_gendisk(md->disk) in the card removal path??
> > >
> > > Very recently I have seen that memstick core hangs if queue is
> > > suspended, and del_gendisk is called, so that hang is real.
> >
> > Sorry, I have no clue what is memstick core. Do mean that calling
> > del_gendisk when the queue is suspended could potentially hang?
> I think so.
> 
Hmm... 

Currently, in mmc that is the sequence.

                /* Stop new requests from getting into the queue */
                del_gendisk(md->disk);

                /* Then flush out any already in there */
                mmc_cleanup_queue(&md->queue);

The queue is resumed only in mmc_cleanup_queue. Did your recent patch alter
this sequence in any way?

Regards,
Madhu

> 
> Best regards,
> Maxim Levitsky
> 


