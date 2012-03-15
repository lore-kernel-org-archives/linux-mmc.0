From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH v1 1/5] ARM: imx28: add basic dt support
Date: Thu, 15 Mar 2012 07:53:29 +0100
Message-ID: <20321.37353.63115.664975@ipc1.ka-ro>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
	<1331628428-24017-2-git-send-email-b29396@freescale.com>
	<20120313172351.97C5E3E053B@localhost>
	<20120314124512.GG1180@shlinux2.ap.freescale.net>
	<20120314141643.GP3852@pengutronix.de>
	<20120315030206.GB13022@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120315030206.GB13022@shlinux2.ap.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dong Aisheng <aisheng.dong@freescale.com>
Cc: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, Guo Shawn-R65073 <r65073@freescale.com>, "vinod.koul@linux.intel.com" <vinod.koul@linux.intel.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, "rdunlap@xenotime.net" <rdunlap@xenotime.net>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "cjb@laptop.org" <cjb@laptop.org>, Dong Aisheng-B29396 <B29396@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

Dong Aisheng writes:
> On Wed, Mar 14, 2012 at 10:16:43PM +0800, s.hauer@pengutronix.de wrot=
e:
> > On Wed, Mar 14, 2012 at 08:45:23PM +0800, Dong Aisheng wrote:
> > > On Wed, Mar 14, 2012 at 01:23:51AM +0800, Grant Likely wrote:
[...]
> > > But it seems this needs pass mac address to fec driver via platfo=
rom data which is
> > > not friendly to dt.
> > >=20
> > > Another way may be changing fec driver to get the fixed part of m=
ac address(first
> > > two bytes) from device tree and read the left dynamical part from=
 otp which i'm not
> > > sure is better enough.
> > >=20
> > > BTW, filling with zeros seems not work since it's invalid mac add=
ress.
> >=20
> > Yes, that's the idea of using this value...
> >=20
> But comparing to use an invalid value, why not just do not define tha=
t
> local-mac-address property?
>=20
Because a MAC address is by definition a GLOBALLY UNIQUE IDENTIFIER
which is contrary to coding a "valid" default value for it somewhere!
The owner of a certain MAC address range (OUI) is responsible for
ensuring the uniqueness. Thus only they may assign a specific MAC
address to a specific device.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
