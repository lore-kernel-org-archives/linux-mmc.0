From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH 03/03] omap hsmmc: adaptation of sdma descriptor autoloading feature
Date: Thu, 11 Mar 2010 20:29:10 -0600
Message-ID: <009901cac18b$cc93e5a0$544ff780@am.dhcp.ti.com>
References: <618f0c911003010327s290fcce1ud665b5a16392aea1@mail.gmail.com> <011301cac0b6$542b1190$544ff780@am.dhcp.ti.com> <618f0c911003110252i36d6fc31wbaef4ad7a17565b1@mail.gmail.com> <004401cac137$cccbf0c0$544ff780@am.dhcp.ti.com> <618f0c911003110942s2f663928ie1203244fbd32da7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36251 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287Ab0CLC3S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Mar 2010 21:29:18 -0500
In-Reply-To: <618f0c911003110942s2f663928ie1203244fbd32da7@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Venkatraman S' <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org



> -----Original Message-----
> From: svenkatr@gmail.com [mailto:svenkatr@gmail.com] On Behalf Of
> Venkatraman S
> Sent: Thursday, March 11, 2010 11:43 AM
> To: Madhusudhan
> Cc: linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-omap@vger.kernel.org
> Subject: Re: [PATCH 03/03] omap hsmmc: adaptation of sdma descriptor
> autoloading feature
>=20
> Madhusudhan <madhu.cr@ti.com> wrote:
> >> -----Original Message-----
> >> From: svenkatr@gmail.com [mailto:svenkatr@gmail.com] On Behalf Of
> >> Venkatraman S
> >> Sent: Thursday, March 11, 2010 4:52 AM
> >> To: Madhusudhan
> >> Cc: linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.or=
g;
> >> linux-omap@vger.kernel.org
> >> Subject: Re: [PATCH 03/03] omap hsmmc: adaptation of sdma descript=
or
> >> autoloading feature
> >>
> >> Madhusudhan <madhu.cr@ti.com> wrote:
> >> >> -----Original Message-----
> >> >> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> >> >> owner@vger.kernel.org] On Behalf Of Venkatraman S
> >> >> Sent: Monday, March 01, 2010 5:27 AM
> >> >> To: linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead=
=2Eorg;
> >> >> linux-omap@vger.kernel.org
> >> >> Subject: [PATCH 03/03] omap hsmmc: adaptation of sdma descripto=
r
> >> >> autoloading feature
> >> >>
> >> >> Start to use the sDMA descriptor autoloading feature.
> >> >> For large datablocks, the MMC driver has to repeatedly setup,
> program
> >> >> and teardown the
> >> >> dma channel for each element of the sglist received in
> >> omap_hsmmc_request.
> >> >>
> >> >> By using descriptor autoloading, transfers from / to each eleme=
nt of
> >> >> the sglist is pre programmed
> >> >> into a linked list. The sDMA driver completes the entire transa=
ction
> >> >> and provides a single interrupt.
> >> >>
> >> >> Due to this, number of dma interrupts for a typical 100MB trans=
fer
> on
> >> the
> >> >> MMC is
> >> >> reduced from 25000 to about 400 (approximate). Transfer speeds =
are
> >> >> improved by ~5%
> >> >> (Though it varies on the size of read / write & improves on hug=
e
> >> >> transfers)
> >> >>
> >> >> Descriptor autoloading is available only in 3630 and 4430 (as o=
f
> now).
> >> >> Hence normal DMA
> >> >> mode is also retained.
> >> >>
> >> >> Tested on omap4430 sdp.
> >> >>
> >> >> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> >> >
> >> > I don't see any issues with this patch except the concern I had =
on
> the
> >> first
> >> > patch in the series. Why is that change linked to this series?
> >> >
> >> =A0 Thanks. The problem was seen only in the context of using desc=
riptor
> >> load. Would
> >> you prefer that I post it as a separate patch ?
> >
> > My point is why that change is needed for this feature to work?
> >
> > When DMA is completed and a callback is received the ch can be free=
d.
> Once
> > TC is received the core is notified of the same.
> >
> > Can the first patch be dropped? Or do you see issues?
> Yes there are issues without this patch when the scatterlist is large
> (300+ blocks), where the dma completion interrupt is received but the
> mmc driver hangs waiting for TC. I don't see the issue if I delay the
> execution of omap_free_dma inside the dma callback.

This is strange. Ideally after the dma cb is received the transfer comp=
lete
interrupt should fire.

Your first patch would break a corner erroneous case the driver is alre=
ady
handling. A scenario where TC was received before DMA cb came. There is
timeout logic in the driver which handles this case to let the request
succeed if a dma cb was received after a while otherwise err out. See t=
he
function omap_hsmmc_start_dma_transfer.

Is there a way to keep both the cases handled? If not we have to make
changes based on which of these scenario is very odd.

Regards,
Madhu

