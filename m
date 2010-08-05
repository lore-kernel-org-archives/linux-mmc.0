From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: RE: MMC card removal in suspend state
Date: Fri, 06 Aug 2010 02:20:49 +0300
Message-ID: <1281050449.7148.14.camel@maxim-laptop>
References: <621C9491683D48E5992B340E62198CD6@am.dhcp.ti.com>
	 <1281048198.7148.6.camel@maxim-laptop>
	 <A266C3A14F5641A3A138034913176B7D@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42580 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933276Ab0HEXU4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Aug 2010 19:20:56 -0400
Received: by fxm14 with SMTP id 14so3373997fxm.19
        for <linux-mmc@vger.kernel.org>; Thu, 05 Aug 2010 16:20:55 -0700 (PDT)
In-Reply-To: <A266C3A14F5641A3A138034913176B7D@am.dhcp.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: linux-mmc@vger.kernel.org, 'Pierre Ossman' <pierre@ossman.eu>

On Thu, 2010-08-05 at 17:54 -0500, Madhusudhan wrote: 
> 
> > -----Original Message-----
> > From: Maxim Levitsky [mailto:maximlevitsky@gmail.com]
> > Sent: Thursday, August 05, 2010 5:43 PM
> > To: Madhusudhan
> > Cc: linux-mmc@vger.kernel.org; 'Pierre Ossman'
> > Subject: Re: MMC card removal in suspend state
> > 
> > On Thu, 2010-08-05 at 16:45 -0500, Madhusudhan wrote:
> > > Hi,
> > >
> > > Recently, while looking at some stuff I saw the below patch done by
> > Pierre
> > > which is part of the drivers/mmc/card/queue.c file. I wonder if someone
> > can
> > > through more light on this to understand where could be a potential
> > deadlock
> > > without calling mmc_queue_resume.
> > >
> > > Is there a need for the mmc queue to be resumed before calling
> > > del_gendisk(md->disk) in the card removal path??
> > 
> > Very recently I have seen that memstick core hangs if queue is
> > suspended, and del_gendisk is called, so that hang is real.
> 
> Sorry, I have no clue what is memstick core. Do mean that calling
> del_gendisk when the queue is suspended could potentially hang?
I think so.


Best regards,
Maxim Levitsky


