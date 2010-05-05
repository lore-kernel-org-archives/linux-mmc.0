From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH v8 2/2] omap hsmmc: adaptation of sdma descriptor autoloading feature
Date: Wed, 5 May 2010 12:21:09 -0500
Message-ID: <003901caec77$5a69d8b0$544ff780@am.dhcp.ti.com>
References: <w2y618f0c911004291035qfec16290re9e236ae1e13a970@mail.gmail.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C52D16D2@dbde02.ent.ti.com> <v2i618f0c911005050919m600f069ex34ba1175315cde5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55709 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254Ab0EERV3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 May 2010 13:21:29 -0400
In-Reply-To: <v2i618f0c911005050919m600f069ex34ba1175315cde5a@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Venkatraman S' <svenkatr@ti.com>, "'Shilimkar, Santosh'" <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, 'Adrian Hunter' <adrian.hunter@nokia.com>, "'Kadiyala, Kishore'" <kishore.kadiyala@ti.com>, 'Tony Lindgren' <tony@atomide.com>

<snip>

> >> + =A0 =A0 if (cpu_is_omap44xx() || cpu_is_omap3630()) {
> > Can we avoid above by passing this part of platform data??
> > devices.c
>=20
> I am not clear about the method. The board files export the
> omap_mmc_platform_data.
> Does it imply that all board files have to change and export
> the capability so that it can be queried ?
>=20

I don=92t see why this capability needs to be passed from the platform =
data.
As this feature is dependant on omap it is okay to have a cpu check in =
the
driver as the patch is doing it.

> >> + =A0 =A0 =A0 =A0 =A0 =A0 host->dma_ctrl_buf =3D dma_alloc_coheren=
t(NULL,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 DMA_CTRL_BUF_SIZE,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 &host->dma_ctrl_buf_phy,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 0);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (host->dma_ctrl_buf !=3D NULL)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_caps |=3D DMA_=
TYPE_SDMA_DLOAD;
> >> + =A0 =A0 }
> >> +
> >> =A0 =A0 =A0 /* Since we do only SG emulation, we can have as many =
segs
> >> =A0 =A0 =A0 =A0* as we want. */
> > Not your patch but above commenting style isn't right
> OK

