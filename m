From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 2/8] SH: add DMA slave IDs for two SDHI controllers, add
  slaves to sh7722
Date: Thu, 22 Apr 2010 08:28:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1004220824200.4655@axis700.grange>
References: <Pine.LNX.4.64.1004211715050.5292@axis700.grange>
 <Pine.LNX.4.64.1004211732340.5292@axis700.grange>
 <j2xaec7e5c31004211702v9ba71743jedd24562f8dea0a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:60175 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752032Ab0DVG2S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Apr 2010 02:28:18 -0400
In-Reply-To: <j2xaec7e5c31004211702v9ba71743jedd24562f8dea0a5@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>

On Wed, 21 Apr 2010, Magnus Damm wrote:

> Hi Guennadi,
>=20
> On Wed, Apr 21, 2010 at 11:36 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > SuperH SDHI controllers can use DMA, add slave IDs to the header an=
d slave
> > definitions to sh7722.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > =A0arch/sh/include/asm/dmaengine.h =A0 =A0 =A0 =A0| =A0 =A04 ++++
> > =A0arch/sh/kernel/cpu/sh4a/setup-sh7722.c | =A0 10 ++++++++++
> > =A02 files changed, 14 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/sh/include/asm/dmaengine.h b/arch/sh/include/asm/=
dmaengine.h
> > index 2a02b61..876e601 100644
> > --- a/arch/sh/include/asm/dmaengine.h
> > +++ b/arch/sh/include/asm/dmaengine.h
> > @@ -29,6 +29,10 @@ enum {
> > =A0 =A0 =A0 =A0SHDMA_SLAVE_SIUA_RX,
> > =A0 =A0 =A0 =A0SHDMA_SLAVE_SIUB_TX,
> > =A0 =A0 =A0 =A0SHDMA_SLAVE_SIUB_RX,
> > + =A0 =A0 =A0 SHDMA_SLAVE_SDHI0_RX,
> > + =A0 =A0 =A0 SHDMA_SLAVE_SDHI0_TX,
> > + =A0 =A0 =A0 SHDMA_SLAVE_SDHI1_RX,
> > + =A0 =A0 =A0 SHDMA_SLAVE_SDHI1_TX,
> > =A0};
> >
> > =A0#endif
>=20
> Thanks for your work on this. Two SDHIs may be enough for most
> processor types, but I think the G3 processor actually has three. Wit=
h
> that in mind, I think it makes more sense to keep the slave ids
> together with the processor specific bits in for instance
> arch/sh/include/cpu-sh4/cpu/sh7722.h.
>=20
> If you have time, can you please make a patch that moves the slave id=
s
> into the processor specific header files? This on top of the other
> code in the sh/dmaengine topic branch.

Ok, yes, first, I forgot to mention - this patch series is based on you=
r=20
earlier SH dmaengine patches. Secondly - sure, we can move these define=
s=20
in cpu-specific headers, otoh - why? This is just an enum, it doesn't t=
ake=20
space in binaries, and having them all together helps uniformity and=20
avoids duplication, I think. So, I would just add those SDHI2 macros to=
=20
this list. The important thing is, the actual slave definition array ar=
e=20
per-CPU. Which is now the case after your patch series.

> With that in place it will be easy to extend each processor type by
> itself without having to tie in dependencies on a single asm file.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
=46reelance Open-Source Software Developer
http://www.open-technology.de/
