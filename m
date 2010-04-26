From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH v2] omap_hsmmc: improve interrupt synchronisation
Date: Mon, 26 Apr 2010 10:20:43 -0500
Message-ID: <002801cae554$09ac97c0$544ff780@am.dhcp.ti.com>
References: <4BD19BBB.40701@nokia.com> <p2r618f0c911004260200vb501a429m8ad243826c05d367@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59005 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753235Ab0DZPUv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Apr 2010 11:20:51 -0400
In-Reply-To: <p2r618f0c911004260200vb501a429m8ad243826c05d367@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Venkatraman S' <svenkatr@ti.com>, 'Adrian Hunter' <adrian.hunter@nokia.com>
Cc: 'linux-mmc Mailing List' <linux-mmc@vger.kernel.org>, 'linux-omap Mailing List' <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: svenkatr@gmail.com [mailto:svenkatr@gmail.com] On Behalf Of
> Venkatraman S
> Sent: Monday, April 26, 2010 4:01 AM
> To: Adrian Hunter
> Cc: Madhusudhan Chikkature; linux-mmc Mailing List; linux-omap Mailin=
g
> List
> Subject: Re: [PATCH v2] omap_hsmmc: improve interrupt synchronisation
>=20
> Adrian Hunter <adrian.hunter@nokia.com> wrote:
> > From ad2e1cd024ccf9144b6620cfe808893719db738f Mon Sep 17 00:00:00 2=
001
> > From: Adrian Hunter <adrian.hunter@nokia.com>
> > Date: Wed, 14 Apr 2010 16:26:45 +0300
> > Subject: [PATCH] omap_hsmmc: improve interrupt synchronisation
> >
> > The following changes were needed:
> > =A0 =A0 =A0 =A0- do not use in_interrupt() because it will not work
> > =A0 =A0 =A0 =A0with threaded interrupts
> >
> > In addition, the following improvements were made:
> > =A0 =A0 =A0 =A0- ensure DMA is unmapped only after the final DMA in=
terrupt
> > =A0 =A0 =A0 =A0- ensure a request is completed only after the final=
 DMA
> interrupt
> > =A0 =A0 =A0 =A0- disable controller interrupts when a request is no=
t in progress
> > =A0 =A0 =A0 =A0- remove the spin-lock protecting the start of a new=
 request from
> > =A0 =A0 =A0 =A0an unexpected interrupt because the locking was comp=
licated and
> > =A0 =A0 =A0 =A0a 'req_in_progress' flag suffices (since the spin-lo=
ck only
> defers
> > =A0 =A0 =A0 =A0the unexpected interrupts anyway)
> > =A0 =A0 =A0 =A0- instead use the spin-lock to protect the MMC inter=
rupt handler
> > =A0 =A0 =A0 =A0from the DMA interrupt handler
> > =A0 =A0 =A0 =A0- remove the semaphore preventing DMA from being sta=
rted while
> > =A0 =A0 =A0 =A0the previous DMA is still in progress - the other ch=
anges make
> that
> > =A0 =A0 =A0 =A0impossible, so it is now a BUG_ON condition
> > =A0 =A0 =A0 =A0- ensure the controller interrupt status is clear be=
fore exiting
> > =A0 =A0 =A0 =A0the interrrupt handler
> >
> > In general, these changes make the code safer but do not fix any
> specific
> > bugs so backporting is not necessary.
> >
> > Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> > ---
> >
> >
> > Changes from version 1:
> > =A0 =A0 =A0 =A0- use a spin-lock to protect the MMC interrupt handl=
er
> > =A0 =A0 =A0 =A0from the DMA interrupt handler
> > =A0 =A0 =A0 =A0- use do {} while loop instead of goto in omap_hsmmc=
_irq
> >
> > S Venkatraman's request to use omap_hsmmc_dma_cleanup(host, 0) in
> > omap_hsmmc_dma_cb() was not done because the code was not
> > sufficiently the same.

<snip>

> This looks good and I don't have any other comments.
>      I have tested, on MMC and SD cards which I have,
> a) Basic file read / write
> b) boot with filesystem on ext3 partition on SD card
>  on OMAP3 and OMAP4 SDP.
>=20
> So you can add,
> Tested-by: Venkatraman S <svenkatr@ti.com>

I reviewed the V2 patch. I don=92t have any comments too.

Acked-by: Madhusudhan Chikkature <madhu.cr@ti.com>

