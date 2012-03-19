From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH v1 1/5] ARM: imx28: add basic dt support
Date: Mon, 19 Mar 2012 17:49:02 +0100
Message-ID: <20327.25470.723875.916422@ipc1.ka-ro>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
	<1331628428-24017-2-git-send-email-b29396@freescale.com>
	<20120313172351.97C5E3E053B@localhost>
	<20120314124512.GG1180@shlinux2.ap.freescale.net>
	<20120314141643.GP3852@pengutronix.de>
	<20120315030206.GB13022@shlinux2.ap.freescale.net>
	<20321.37353.63115.664975@ipc1.ka-ro>
	<20120315105927.GE13022@shlinux2.ap.freescale.net>
	<20321.53468.310199.875966@ipc1.ka-ro>
	<20120316030134.GA5161@shlinux2.ap.freescale.net>
	<20120318184749.BB15D3E07BF@localhost>
	<20326.55337.249575.289067@ipc1.ka-ro>
	<20120319150601.B783A3E05A5@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:51531 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162159Ab2CSQt3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Mar 2012 12:49:29 -0400
In-Reply-To: <20120319150601.B783A3E05A5@localhost>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Dong Aisheng <aisheng.dong@freescale.com>, Dong Aisheng-B29396 <B29396@freescale.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, Guo Shawn-R65073 <r65073@freescale.com>, "vinod.koul@linux.intel.com" <vinod.koul@linux.intel.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "rdunlap@xenotime.net" <rdunlap@xenotime.net>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "cjb@laptop.org" <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

Grant Likely writes:
> On Mon, 19 Mar 2012 07:54:33 +0100, Lothar Wa=C3=9Fmann <LW@KARO-elec=
tronics.de> wrote:
> > Grant Likely writes:
> > > On Fri, 16 Mar 2012 11:01:35 +0800, Dong Aisheng <aisheng.dong@fr=
eescale.com> wrote:
> > > > On Thu, Mar 15, 2012 at 07:22:04PM +0800, Lothar Wa=C3=9Fmann w=
rote:
> > > > > Dong Aisheng writes:
> > > > > > On Thu, Mar 15, 2012 at 02:53:29PM +0800, Lothar Wa=C3=9Fma=
nn wrote:
> > > > > Anyway there is no definite spec how the MAC address(es) are =
stored
> > > > > in the fuse map. Thus reading the MAC from there is more or l=
ess
> > > > > platform specific.
> > > > >=20
> > > > It's just provide one more option since there are customers sto=
ring the MAC
> > > > in the fuse map.
> > >=20
> > > That should be straight forward to support; have a property that
> > > specifies the method used for fetching/calculating the MAC.
> > >=20
> > Executable code stored inside a DT blob? ;)
>=20
> I know you're joking here, but I'm going to answer seriously
> anyway... Absolutely not.  What I'm suggesting is a property that
> specifies the method used to determine the mac address.  Something
> like (off the top of my head):
>=20
> 	local-mac-address =3D [01 02 03 00 00 00];
> 	local-mac-mask =3D [0xff 0xff 0xff 0 0 0];
> 	mac-encoding =3D "append-serial-number";
>=20
That still does not specify where the remaining part of the MAC is
stored and how it should be retrieved.

> > > > > Currently I'm setting up the MAC address for our TX28 from th=
e fuses
> > > > > in the platform code passed via platform_data, but that will =
obviously
> > > > > not work with DT.
> > > > >=20
> > > > Non-dt can also use my proposal, then you only need to pass the=
 fixed part of
> > > > MAC via platfrom data, the left will be read by fec driver.
> > > >=20
> > > > > The correct way would probably be to pass the MAC from the bo=
otloader
> > > > > via a DT blob. But that would require all bootloaders to be u=
pdated
> > > > > first to support DTS. :(
> > > > >=20
> > > > But uboot will face the same problem that can not define a vali=
d MAC
> > > > in dts, did i undertand correctly?
> > > >=20
> > > > > An intermediate solution could be using OF_DEV_AUXDATA to pas=
s a
> > > > > platform_data struct that may contain a MAC address set up by=
 the
> > > > > platform code.
> > > > >=20
> > > > Yes, it's a way but i'm afraid will not get accepted by dt peop=
le.
> > >=20
> > > The problem remains; where does the platform code get the MAC add=
ress
> > > from?  The kernel has to devise it from *somewhere* and the best =
place
> > > for that should be in the MAC driver itself.
> > >=20
> > The platform code knows how and where the MAC is stored on a specif=
ic
> > platform. The driver has no business in knowing platform details li=
ke
> > this. Thus only platform code (or the bootloader) can provide the M=
AC
> > to the driver.
>=20
> Okay, if so then it would be wise to have a reliable function for the
> MAC driver to call to lookup it's address as determined by platform
> code.  Alternately, the platform code can write the correct mac
> address into the device tree node at init time (see
> prom_update_property() and prom_add_property()).
>=20
That sounds good. Didn't know about those functions. That could be
used to mimic the current behaviour of supplying the MAC via
platform_data.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
