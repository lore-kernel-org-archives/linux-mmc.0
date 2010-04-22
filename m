From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 6/8] SH: Add SDHI DMA support to ms7724se
Date: Thu, 22 Apr 2010 08:20:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1004220813110.4655@axis700.grange>
References: <Pine.LNX.4.64.1004211715050.5292@axis700.grange>
 <Pine.LNX.4.64.1004211735180.5292@axis700.grange>
 <m2xaec7e5c31004211718t85936386k6c0f09684b17b10f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:33697 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752313Ab0DVGUs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Apr 2010 02:20:48 -0400
In-Reply-To: <m2xaec7e5c31004211718t85936386k6c0f09684b17b10f@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>

On Wed, 21 Apr 2010, Magnus Damm wrote:

> On Wed, Apr 21, 2010 at 11:37 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > @@ -456,11 +458,20 @@ static struct resource sdhi0_cn7_resources[] =
=3D {
> > =A0 =A0 =A0 =A0},
> > =A0};
> >
> > +static struct sh_mobile_sdhi_info sh7724_sdhi0_data =3D {
> > + =A0 =A0 =A0 .dma_slave_tx =A0 =3D SHDMA_SLAVE_SDHI0_TX,
> > + =A0 =A0 =A0 .dma_slave_rx =A0 =3D SHDMA_SLAVE_SDHI0_RX,
> > + =A0 =A0 =A0 .tmio_flags =A0 =A0 =3D TMIO_IMMEDIATE_RX_COMPLETE,
> > +};
> > +
> > =A0static struct platform_device sdhi0_cn7_device =3D {
> > =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "sh_mobile_sdhi",
> > =A0 =A0 =A0 =A0.id =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
> > =A0 =A0 =A0 =A0.num_resources =A0=3D ARRAY_SIZE(sdhi0_cn7_resources=
),
> > =A0 =A0 =A0 =A0.resource =A0 =A0 =A0 =3D sdhi0_cn7_resources,
> > + =A0 =A0 =A0 .dev =3D {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =A0=3D &sh7724_sdhi0_d=
ata,
> > + =A0 =A0 =A0 },
> > =A0 =A0 =A0 =A0.archdata =3D {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.hwblk_id =3D HWBLK_SDHI0,
> > =A0 =A0 =A0 =A0},
> > @@ -479,11 +490,19 @@ static struct resource sdhi1_cn8_resources[] =
=3D {
> > =A0 =A0 =A0 =A0},
> > =A0};
> >
> > +static struct sh_mobile_sdhi_info sh7724_sdhi1_data =3D {
> > + =A0 =A0 =A0 .dma_slave_tx =3D SHDMA_SLAVE_SDHI1_TX,
> > + =A0 =A0 =A0 .dma_slave_rx =3D SHDMA_SLAVE_SDHI1_RX,
>=20
> And these two are the opposite of Ecovec even though both are sh7724?=
 Hm..

Right, that's wrong. I mean, yes, they did behave differently in my tes=
ts.=20
On both boards I only could test one slot, so, I just presume the other=
=20
one should behave equally. So, this flag should be present on SE and no=
t=20
on ecovec. Will fix in the next revision, thanks.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
=46reelance Open-Source Software Developer
http://www.open-technology.de/
