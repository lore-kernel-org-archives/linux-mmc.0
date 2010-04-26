From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] omap_hsmmc: improve interrupt synchronisation
Date: Mon, 26 Apr 2010 14:17:41 -0700
Message-ID: <20100426211741.GO7225@atomide.com>
References: <4BD19BBB.40701@nokia.com>
 <p2r618f0c911004260200vb501a429m8ad243826c05d367@mail.gmail.com>
 <002801cae554$09ac97c0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63724 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895Ab0DZVRo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Apr 2010 17:17:44 -0400
Content-Disposition: inline
In-Reply-To: <002801cae554$09ac97c0$544ff780@am.dhcp.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: 'Venkatraman S' <svenkatr@ti.com>, 'Adrian Hunter' <adrian.hunter@nokia.com>, 'linux-mmc Mailing List' <linux-mmc@vger.kernel.org>, 'linux-omap Mailing List' <linux-omap@vger.kernel.org>

* Madhusudhan <madhu.cr@ti.com> [100426 08:17]:
>=20
>=20
> > -----Original Message-----
> > From: svenkatr@gmail.com [mailto:svenkatr@gmail.com] On Behalf Of
> > Venkatraman S
> > Sent: Monday, April 26, 2010 4:01 AM
> > To: Adrian Hunter
> > Cc: Madhusudhan Chikkature; linux-mmc Mailing List; linux-omap Mail=
ing
> > List
> > Subject: Re: [PATCH v2] omap_hsmmc: improve interrupt synchronisati=
on
> >=20
> > Adrian Hunter <adrian.hunter@nokia.com> wrote:
> > > From ad2e1cd024ccf9144b6620cfe808893719db738f Mon Sep 17 00:00:00=
 2001
> > > From: Adrian Hunter <adrian.hunter@nokia.com>
> > > Date: Wed, 14 Apr 2010 16:26:45 +0300
> > > Subject: [PATCH] omap_hsmmc: improve interrupt synchronisation
> > >
> > > The following changes were needed:
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0- do not use in_interrupt() because it=
 will not work
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0with threaded interrupts
> > >
> > > In addition, the following improvements were made:
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0- ensure DMA is unmapped only after th=
e final DMA interrupt
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0- ensure a request is completed only a=
fter the final DMA
> > interrupt
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0- disable controller interrupts when a=
 request is not in progress
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0- remove the spin-lock protecting the =
start of a new request from
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0an unexpected interrupt because the lo=
cking was complicated and
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0a 'req_in_progress' flag suffices (sin=
ce the spin-lock only
> > defers
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0the unexpected interrupts anyway)
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0- instead use the spin-lock to protect=
 the MMC interrupt handler
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0from the DMA interrupt handler
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0- remove the semaphore preventing DMA =
from being started while
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0the previous DMA is still in progress =
- the other changes make
> > that
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0impossible, so it is now a BUG_ON cond=
ition
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0- ensure the controller interrupt stat=
us is clear before exiting
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0the interrrupt handler
> > >
> > > In general, these changes make the code safer but do not fix any
> > specific
> > > bugs so backporting is not necessary.
> > >
> > > Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> > > ---
> > >
> > >
> > > Changes from version 1:
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0- use a spin-lock to protect the MMC i=
nterrupt handler
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0from the DMA interrupt handler
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0- use do {} while loop instead of goto=
 in omap_hsmmc_irq
> > >
> > > S Venkatraman's request to use omap_hsmmc_dma_cleanup(host, 0) in
> > > omap_hsmmc_dma_cb() was not done because the code was not
> > > sufficiently the same.
>=20
> <snip>
>=20
> > This looks good and I don't have any other comments.
> >      I have tested, on MMC and SD cards which I have,
> > a) Basic file read / write
> > b) boot with filesystem on ext3 partition on SD card
> >  on OMAP3 and OMAP4 SDP.
> >=20
> > So you can add,
> > Tested-by: Venkatraman S <svenkatr@ti.com>
>=20
> I reviewed the V2 patch. I don=C2=92t have any comments too.
>=20
> Acked-by: Madhusudhan Chikkature <madhu.cr@ti.com>

Nice work Adrian!

Acked-by: Tony Lindgren <tony@atomide.com>
