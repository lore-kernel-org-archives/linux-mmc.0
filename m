From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 8/8] ARM: omap_hsmmc: remove platform data dma_mask and
 initialization
Date: Wed, 18 Apr 2012 13:02:15 -0700
Message-ID: <20120418200214.GP21106@atomide.com>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
 <E1SKRsg-0004bX-4w@rmk-PC.arm.linux.org.uk>
 <CANrkHUajRzoCp7K8L3cJArWN3xdqpft8L4k-o4gFTRTo8nmhmg@mail.gmail.com>
 <20120418152956.GP25053@n2100.arm.linux.org.uk>
 <CANrkHUYvKdBUZh9UmWcE30ywAAiqhN-KcnSAE2T56WJLFPX1gA@mail.gmail.com>
 <20120418194224.GS25053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:24430 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755000Ab2DRUCV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Apr 2012 16:02:21 -0400
Content-Disposition: inline
In-Reply-To: <20120418194224.GS25053@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "T Krishnamoorthy, Balaji" <balajitk@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120418 12:46]:
> On Wed, Apr 18, 2012 at 09:05:56PM +0530, T Krishnamoorthy, Balaji wr=
ote:
> > On Wed, Apr 18, 2012 at 8:59 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > On Wed, Apr 18, 2012 at 08:53:32PM +0530, T Krishnamoorthy, Balaj=
i wrote:
> > >> Hi,
> > >>
> > >> drivers/mmc/host/omap.c is also using dma_mask should that also =
be removed
> > >
> > > Does this driver make use of this platform data?
> > >
> > > If so, it needs converting to DMA engine _before_ this patch (whi=
ch is
> > > one reason why its a good idea to do these changes as separate pa=
tches...
> > > as I've done.) =C2=A0It means stuff like this can be slotted in a=
s necessary
> > > in the patch order.
> > >
> > > I'm told that driver is OMAP2 only - I don't have any OMAP2 platf=
orms to
> > > be able to test it on (I only have OMAP3 and OMAP4.)
> >=20
> > Yes, this driver is for omap2420 and omap1 devices.
>=20
> Looking at this driver, there seems to be some interaction between ho=
w
> the DMA is programmed for each part of the scatterlist, and how the
> MMC interface is programmed, specifically:
>=20
>         frame =3D data->blksz;
>         if (cpu_is_omap15xx() && frame > 32)
>                 frame =3D 32;
>         else if (frame > 64)
>                 frame =3D 64;
>         frame >>=3D 1;
>         if (!(data->flags & MMC_DATA_WRITE)) {
>                 buf =3D 0x800f | ((frame - 1) << 8);
>         } else {
>                 buf =3D 0x0f80 | ((frame - 1) << 0);
>         }
>         OMAP_MMC_WRITE(host, BUF, buf);
>=20
> Does this register have to be written on every scatterlist entry, or =
can
> it be written once at the start of request processing?

The scatterlist entries are separate DMA requests on omap1, there's no
chaining support in the DMA hardware on omap1. So yes, it's for every
scatterlist entry on omap1.

Regards,

Tony
