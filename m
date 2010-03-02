From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH 3/3] mmc: omap_hsmmc: enable SDIO card interrupts
Date: Tue, 2 Mar 2010 16:08:55 -0600
Message-ID: <00cf01caba54$f39dba60$544ff780@am.dhcp.ti.com>
References: <cover.1265801967.git.david.vrabel@csr.com> <f4f02c7875316b7f65466a5ac06f5b2b2960aa96.1265801967.git.david.vrabel@csr.com> <9ce6cf93ba1e6c3fd239f732ea5889a856948db3.1265801967.git.david.vrabel@csr.com> <004901cab001$6b19f6c0$544ff780@am.dhcp.ti.com> <4B7C4608.5010008@csr.com> <alpine.DEB.2.00.1002171254040.24812@utopia.booyaka.com> <4B7D3EAE.1010908@csr.com> <alpine.DEB.2.00.1002180951330.24812@utopia.booyaka.com> <004001cab0c9$b208b2b0$544ff780@am.dhcp.ti.com> <alpine.DEB.2.00.1002181231520.24812@utopia.booyaka.com> <5e088bd91002181416l33dc2fe4u8d2a09d12ea0344e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49083 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753208Ab0CBWJI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Mar 2010 17:09:08 -0500
In-Reply-To: <5e088bd91002181416l33dc2fe4u8d2a09d12ea0344e@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Steve Sakoman' <sakoman@gmail.com>, 'Paul Walmsley' <paul@pwsan.com>
Cc: 'David Vrabel' <david.vrabel@csr.com>, r-woodruff2@ti.com, sawant@ti.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org



> -----Original Message-----
> From: Steve Sakoman [mailto:sakoman@gmail.com]
> Sent: Thursday, February 18, 2010 4:16 PM
> To: Paul Walmsley
> Cc: Madhusudhan; David Vrabel; r-woodruff2@ti.com; sawant@ti.com; lin=
ux-
> mmc@vger.kernel.org; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 3/3] mmc: omap_hsmmc: enable SDIO card interrupts
>=20
> On Thu, Feb 18, 2010 at 12:21 PM, Paul Walmsley <paul@pwsan.com> wrot=
e:
>=20
> > (cc'ing Steve, Richard, Anand)
>=20
> > There appear to be least seven SDIO card drivers in 2.6.34-rc7. At =
least
> > one of these is for a TI chip - the wl1251. =A0I think some of the
> > Gumstix Overo OMAP3 boards are using an SDIO-connected Marvell Libe=
rtas:
> >
> > http://www.gumstix.com/store/catalog/product_info.php?products_id=3D=
252
>=20
> That is correct, a Wi2Wi wifi module is connected via mmc2 on the
> Overo Air and Fire products.
>=20

Steve,

A dumb question. Is this Wi2Wi wifi module available as a standard SDIO=
 card
which can be plugged into a SD card cage? Or is it specifically designe=
d for
the gumstix board?

Regards,
Madhu

> Data rates are pretty low with the existing OMAP SDIO driver.   Any
> chance this patch would improve that situation?
>=20
> Just added applying the patch and retesting data rates to my "to do" =
list
> :-)
>=20
> Steve
>=20
> > David is probably testing with a Bluetooth card - maybe he can comm=
ent
> > further.
> >
> >> And at least I don't see a way I can test any of these features my=
self.
> >
> > Could you clarify?
> >
> >
> > - Paul
> >

