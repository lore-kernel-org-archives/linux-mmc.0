From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v8 0/2] sDMA descriptor autoloading feature
Date: Wed, 5 May 2010 15:02:00 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C52D16D0@dbde02.ent.ti.com>
References: <i2x618f0c911004291034g7f5b377ds5efaf74c901bc036@mail.gmail.com>
	 <00ea01caebdf$affcb8d0$544ff780@am.dhcp.ti.com>
 <q2r618f0c911005042138t81e86b09g444d2772ddc30b29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50921 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab0EEJcM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 May 2010 05:32:12 -0400
In-Reply-To: <q2r618f0c911005042138t81e86b09g444d2772ddc30b29@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@nokia.com>

> -----Original Message-----
> From: svenkatr@gmail.com [mailto:svenkatr@gmail.com] On Behalf Of S, =
Venkatraman
> Sent: Wednesday, May 05, 2010 10:09 AM
> To: Chikkature Rajashekar, Madhusudhan
> Cc: linux-omap@vger.kernel.org; linux-mmc@vger.kernel.org; linux-arm-=
kernel@lists.infradead.org; Tony
> Lindgren; Adrian Hunter; Shilimkar, Santosh
> Subject: Re: [PATCH v8 0/2] sDMA descriptor autoloading feature
>=20
> On Wed, May 5, 2010 at 4:45 AM, Madhusudhan <madhu.cr@ti.com> wrote:
> >> -----Original Message-----
> >> From: svenkatr@gmail.com [mailto:svenkatr@gmail.com] On Behalf Of
> >> Venkatraman S
> >> Sent: Thursday, April 29, 2010 12:35 PM
> >> To: linux-omap@vger.kernel.org; linux-mmc@vger.kernel.org; linux-a=
rm-
> >> kernel@lists.infradead.org
> >> Cc: Madhusudhan Chikkature; Tony Lindgren; Adrian Hunter; Santosh
> >> Shilimkar
> >> Subject: [PATCH v8 0/2] sDMA descriptor autoloading feature
> >>
> >> =A0 =A0 This patch series is the introduction of new sDMA feature:=
 descriptor
> >> autoloading (v8) and it's adoption by the OMAP HSMMC driver.
> >>
> >> =A0 =A0The previous version (v7) was blocked on achieving proper i=
nterrupt
> >> syncronisation
> >> between the MMC and DMA callback in the HSMMC driver.
> >> =A0 Thanks to Adrian Hunter's patch,
> >> https://patchwork.kernel.org/patch/94670/
> >> this has been cleaned up.
> >>
> >> Current version is based on for-next branch + Adrian Hunter's
> >> interrupt syncronisation patch
> >> (https://patchwork.kernel.org/patch/94670)
> >>
> >> Changes since v7:
> >> =A0 * Removed the 'fix race condition between DMA and HSMMC callba=
ck'
> >> part of the series
> >> =A0 * Added memory barries in start and resume sglist transfer for=
 cpu
> >> buffer syncronization
> >> =A0 * Cleanup and comments
> >>
> >> This has been tested on OMAP3430, OMAP3630 and OMAP4430 SDP
> >> for MMC file transfer and as boot file system.
> >>
> >
> > The HSMMC driver changes look good to me. I can ACK that but am not=
 a DMA
> > expert to review your changes to the DMA driver.
> >
Venkat,=20
Sorry for late comments on your series.
=20
