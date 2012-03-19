From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH v1 1/5] ARM: imx28: add basic dt support
Date: Mon, 19 Mar 2012 07:54:33 +0100
Message-ID: <20326.55337.249575.289067@ipc1.ka-ro>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:51224 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab2CSGzL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Mar 2012 02:55:11 -0400
In-Reply-To: <20120318184749.BB15D3E07BF@localhost>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Dong Aisheng <aisheng.dong@freescale.com>, Dong Aisheng-B29396 <B29396@freescale.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, Guo Shawn-R65073 <r65073@freescale.com>, "vinod.koul@linux.intel.com" <vinod.koul@linux.intel.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "rdunlap@xenotime.net" <rdunlap@xenotime.net>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "cjb@laptop.org" <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

Grant Likely writes:
> On Fri, 16 Mar 2012 11:01:35 +0800, Dong Aisheng <aisheng.dong@freesc=
ale.com> wrote:
> > On Thu, Mar 15, 2012 at 07:22:04PM +0800, Lothar Wa=C3=9Fmann wrote=
:
> > > Hi,
> > >=20
> > > Dong Aisheng writes:
> > > > On Thu, Mar 15, 2012 at 02:53:29PM +0800, Lothar Wa=C3=9Fmann w=
rote:
> > > > > Hi,
> > > > >=20
> > > > > Dong Aisheng writes:
> > > > > > On Wed, Mar 14, 2012 at 10:16:43PM +0800, s.hauer@pengutron=
ix.de wrote:
> > > > > > > On Wed, Mar 14, 2012 at 08:45:23PM +0800, Dong Aisheng wr=
ote:
> > > > > > > > On Wed, Mar 14, 2012 at 01:23:51AM +0800, Grant Likely =
wrote:
> > > > > [...]
> > > > > > > > But it seems this needs pass mac address to fec driver =
via platforom data which is
> > > > > > > > not friendly to dt.
> > > > > > > >=20
> > > > > > > > Another way may be changing fec driver to get the fixed=
 part of mac address(first
> > > > > > > > two bytes) from device tree and read the left dynamical=
 part from otp which i'm not
> > > > > > > > sure is better enough.
> > > > > > > >=20
> > > > > > > > BTW, filling with zeros seems not work since it's inval=
id mac address.
> > > > > > >=20
> > > > > > > Yes, that's the idea of using this value...
> > > > > > >=20
> > > > > > But comparing to use an invalid value, why not just do not =
define that
> > > > > > local-mac-address property?
> > > > > >=20
> > > > > Because a MAC address is by definition a GLOBALLY UNIQUE IDEN=
TIFIER
> > > > > which is contrary to coding a "valid" default value for it so=
mewhere!
> > > > > The owner of a certain MAC address range (OUI) is responsible=
 for
> > > > > ensuring the uniqueness. Thus only they may assign a specific=
 MAC
> > > > > address to a specific device.
> > > > >=20
> > > > Yes, you're correct.
> > > > So i propose to read the MAC address from MX28 OTP in fec drive=
r instead of
> > > > define it in device tree in my last mail.
> > > > http://www.spinics.net/lists/arm-kernel/msg165040.html
> > > > Do you have any comment on that way?
> > > >=20
> > > That patch sets the OUI to the Freescale owned MAC range. Thus on=
ly
> > > Freescale products may be able to use the driver.
> > >=20
> > No.
> > My proposal is only set the fixed part(first two octets) in board d=
ts file,
> > each board knows it's value, and read the left 4 octets from OCOTP =
dynamically.
> > Obviously the freeescale board dts file is only for FSL platforms.
> > Other platforms can define their fix part of MAC address in their d=
ts file.
> >=20
> > > Anyway there is no definite spec how the MAC address(es) are stor=
ed
> > > in the fuse map. Thus reading the MAC from there is more or less
> > > platform specific.
> > >=20
> > It's just provide one more option since there are customers storing=
 the MAC
> > in the fuse map.
>=20
> That should be straight forward to support; have a property that
> specifies the method used for fetching/calculating the MAC.
>=20
Executable code stored inside a DT blob? ;)

> > > Currently I'm setting up the MAC address for our TX28 from the fu=
ses
> > > in the platform code passed via platform_data, but that will obvi=
ously
> > > not work with DT.
> > >=20
> > Non-dt can also use my proposal, then you only need to pass the fix=
ed part of
> > MAC via platfrom data, the left will be read by fec driver.
> >=20
> > > The correct way would probably be to pass the MAC from the bootlo=
ader
> > > via a DT blob. But that would require all bootloaders to be updat=
ed
> > > first to support DTS. :(
> > >=20
> > But uboot will face the same problem that can not define a valid MA=
C
> > in dts, did i undertand correctly?
> >=20
> > > An intermediate solution could be using OF_DEV_AUXDATA to pass a
> > > platform_data struct that may contain a MAC address set up by the
> > > platform code.
> > >=20
> > Yes, it's a way but i'm afraid will not get accepted by dt people.
>=20
> The problem remains; where does the platform code get the MAC address
> from?  The kernel has to devise it from *somewhere* and the best plac=
e
> for that should be in the MAC driver itself.
>=20
The platform code knows how and where the MAC is stored on a specific
platform. The driver has no business in knowing platform details like
this. Thus only platform code (or the bootloader) can provide the MAC
to the driver.

> I've got no problem with the idea of only specifying the OUI in the D=
T
> and the driver extracting the remaining 3 bytes from the hardware.
>=20
> In principle, that's the design intent for DT systems anyway; it
> describes things which cannot be probed from the hardware, or tells
> the OS how the data is encoded in the hardware.
>=20
If all bootloaders were aware of DT this wouldn't be a problem,
because they could place the correct MAC inside the DT blob right
away.
But in the mean time (AKA forever) we need some other solution.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
