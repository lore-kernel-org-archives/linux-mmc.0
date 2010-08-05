From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: MMC card removal in suspend state
Date: Thu, 5 Aug 2010 17:54:39 -0500
Message-ID: <A266C3A14F5641A3A138034913176B7D@am.dhcp.ti.com>
References: <621C9491683D48E5992B340E62198CD6@am.dhcp.ti.com> <1281048198.7148.6.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58622 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934849Ab0HEWyo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 Aug 2010 18:54:44 -0400
In-Reply-To: <1281048198.7148.6.camel@maxim-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Maxim Levitsky' <maximlevitsky@gmail.com>
Cc: linux-mmc@vger.kernel.org, 'Pierre Ossman' <pierre@ossman.eu>



> -----Original Message-----
> From: Maxim Levitsky [mailto:maximlevitsky@gmail.com]
> Sent: Thursday, August 05, 2010 5:43 PM
> To: Madhusudhan
> Cc: linux-mmc@vger.kernel.org; 'Pierre Ossman'
> Subject: Re: MMC card removal in suspend state
> 
> On Thu, 2010-08-05 at 16:45 -0500, Madhusudhan wrote:
> > Hi,
> >
> > Recently, while looking at some stuff I saw the below patch done by
> Pierre
> > which is part of the drivers/mmc/card/queue.c file. I wonder if someone
> can
> > through more light on this to understand where could be a potential
> deadlock
> > without calling mmc_queue_resume.
> >
> > Is there a need for the mmc queue to be resumed before calling
> > del_gendisk(md->disk) in the card removal path??
> 
> Very recently I have seen that memstick core hangs if queue is
> suspended, and del_gendisk is called, so that hang is real.

Sorry, I have no clue what is memstick core. Do mean that calling
del_gendisk when the queue is suspended could potentially hang?

Regards,
Madhu

> It probably so happens that disk queue is already running at that point
> so that users don't hit that hang.
> 
> Best regards,
> Maxim Levitsky
> 
> 
> >
> > Regards,
> > Madhu
> >
> > commit d2b46f66b4b342be07a4194bd5e82384d07e470d
> > Author: Pierre Ossman <drzeus@drzeus.cx>
> > Date:   Sat Apr 28 16:52:12 2007 +0200
> >
> >     mmc: allow suspended block driver to be removed
> >
> >     Make sure we don't deadlock when removing a suspended block
> >     queue, something that might happen if the card is removed during
> >     suspend.
> >
> >     Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
> >
> > diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> > index aa75ac1..2e77963 100644
> > --- a/drivers/mmc/card/queue.c
> > +++ b/drivers/mmc/card/queue.c
> > @@ -191,6 +191,9 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
> >         q->queuedata = NULL;
> >         spin_unlock_irqrestore(q->queue_lock, flags);
> >
> > +       /* Make sure the queue isn't suspended, as that will deadlock */
> > +       mmc_queue_resume(mq);
> > +
> >         /* Then terminate our worker thread */
> >         kthread_stop(mq->thread);
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


