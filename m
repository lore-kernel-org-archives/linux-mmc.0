From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v8 2/2] omap hsmmc: adaptation of sdma descriptor
 autoloading feature
Date: Thu, 6 May 2010 13:19:07 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C538736D@dbde02.ent.ti.com>
References: <w2y618f0c911004291035qfec16290re9e236ae1e13a970@mail.gmail.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C52D16D2@dbde02.ent.ti.com>
 <v2i618f0c911005050919m600f069ex34ba1175315cde5a@mail.gmail.com>
 <003901caec77$5a69d8b0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58782 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198Ab0EFHth convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 May 2010 03:49:37 -0400
In-Reply-To: <003901caec77$5a69d8b0$544ff780@am.dhcp.ti.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "S, Venkatraman" <svenkatr@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, 'Adrian Hunter' <adrian.hunter@nokia.com>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, 'Tony Lindgren' <tony@atomide.com>

> -----Original Message-----
> From: Chikkature Rajashekar, Madhusudhan
> Sent: Wednesday, May 05, 2010 10:51 PM
> To: S, Venkatraman; Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; linux-mmc@vger.kernel.org; linux-arm-=
kernel@lists.arm.linux.org.uk;
> 'Adrian Hunter'; Kadiyala, Kishore; 'Tony Lindgren'
> Subject: RE: [PATCH v8 2/2] omap hsmmc: adaptation of sdma descriptor=
 autoloading feature
>=20
> <snip>
>=20
> > >> + =A0 =A0 if (cpu_is_omap44xx() || cpu_is_omap3630()) {
> > > Can we avoid above by passing this part of platform data??
> > > devices.c
> >
> > I am not clear about the method. The board files export the
> > omap_mmc_platform_data.
> > Does it imply that all board files have to change and export
> > the capability so that it can be queried ?
> >
>=20
> I don=92t see why this capability needs to be passed from the platfor=
m data.
> As this feature is dependant on omap it is okay to have a cpu check i=
n the
> driver as the patch is doing it.
>=20
Because Descriptor load feature is not MMC IP capability but SDMA capab=
ility.
To make MMC driver portable we should avoid cluttering with CPU specifi=
c checks.

This is recommended way unless and until you think otherwise.

Regards,
Santosh
