From: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH v1 1/5] ARM: imx28: add basic dt support
Date: Thu, 15 Mar 2012 12:24:19 +0100
Message-ID: <20120315112419.GA3852@pengutronix.de>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
 <1331628428-24017-2-git-send-email-b29396@freescale.com>
 <20120313172351.97C5E3E053B@localhost>
 <20120314124512.GG1180@shlinux2.ap.freescale.net>
 <20120314141643.GP3852@pengutronix.de>
 <20120315030206.GB13022@shlinux2.ap.freescale.net>
 <20321.37353.63115.664975@ipc1.ka-ro>
 <20120315105927.GE13022@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34339 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910Ab2COLYe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 07:24:34 -0400
Content-Disposition: inline
In-Reply-To: <20120315105927.GE13022@shlinux2.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@freescale.com>
Cc: Lothar =?iso-8859-15?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Dong Aisheng-B29396 <B29396@freescale.com>, Guo Shawn-R65073 <r65073@freescale.com>, "vinod.koul@linux.intel.com" <vinod.koul@linux.intel.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, "rdunlap@xenotime.net" <rdunlap@xenotime.net>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "cjb@laptop.org" <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Mar 15, 2012 at 06:59:28PM +0800, Dong Aisheng wrote:
> On Thu, Mar 15, 2012 at 02:53:29PM +0800, Lothar Wa=DFmann wrote:
> > Hi,
> >=20
> > Dong Aisheng writes:
> > > On Wed, Mar 14, 2012 at 10:16:43PM +0800, s.hauer@pengutronix.de =
wrote:
> > > > On Wed, Mar 14, 2012 at 08:45:23PM +0800, Dong Aisheng wrote:
> > > > > On Wed, Mar 14, 2012 at 01:23:51AM +0800, Grant Likely wrote:
> > [...]
> > > > > But it seems this needs pass mac address to fec driver via pl=
atforom data which is
> > > > > not friendly to dt.
> > > > >=20
> > > > > Another way may be changing fec driver to get the fixed part =
of mac address(first
> > > > > two bytes) from device tree and read the left dynamical part =
from otp which i'm not
> > > > > sure is better enough.
> > > > >=20
> > > > > BTW, filling with zeros seems not work since it's invalid mac=
 address.
> > > >=20
> > > > Yes, that's the idea of using this value...
> > > >=20
> > > But comparing to use an invalid value, why not just do not define=
 that
> > > local-mac-address property?
> > >=20
> > Because a MAC address is by definition a GLOBALLY UNIQUE IDENTIFIER
> > which is contrary to coding a "valid" default value for it somewher=
e!
> > The owner of a certain MAC address range (OUI) is responsible for
> > ensuring the uniqueness. Thus only they may assign a specific MAC
> > address to a specific device.
> >=20
> Yes, you're correct.
> So i propose to read the MAC address from MX28 OTP in fec driver inst=
ead of
> define it in device tree in my last mail.
> http://www.spinics.net/lists/arm-kernel/msg165040.html
> Do you have any comment on that way?

Yes, you could do that. Otherwise it's perfectly fine to pass the MAC
address in the device tree, it's just not ok to put specific values
into the kernel source. You could leave the values blank and let the
bootloader fill them in. Or you could fill in valid values before you
compile the devicetree, but be prepared for surprises once you have
two boards in your network and use the devicetree for both.

Sascha

--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
