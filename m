From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: Re: [PATCH v1 1/5] ARM: imx28: add basic dt support
Date: Fri, 16 Mar 2012 16:22:44 +0800
Message-ID: <20120316082243.GA13065@shlinux2.ap.freescale.net>
References: <1331628428-24017-2-git-send-email-b29396@freescale.com>
 <20120313172351.97C5E3E053B@localhost>
 <20120314124512.GG1180@shlinux2.ap.freescale.net>
 <20120314141643.GP3852@pengutronix.de>
 <20120315030206.GB13022@shlinux2.ap.freescale.net>
 <20321.37353.63115.664975@ipc1.ka-ro>
 <20120315105927.GE13022@shlinux2.ap.freescale.net>
 <20321.53468.310199.875966@ipc1.ka-ro>
 <20120316030134.GA5161@shlinux2.ap.freescale.net>
 <20322.61501.432329.124466@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:58728
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965186Ab2CPIVg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 16 Mar 2012 04:21:36 -0400
Content-Disposition: inline
In-Reply-To: <20322.61501.432329.124466@ipc1.ka-ro>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Dong Aisheng-B29396 <B29396@freescale.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, Guo Shawn-R65073 <r65073@freescale.com>, "vinod.koul@linux.intel.com" <vinod.koul@linux.intel.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, "rdunlap@xenotime.net" <rdunlap@xenotime.net>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "cjb@laptop.org" <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Mar 16, 2012 at 03:48:13PM +0800, Lothar Wa=DFmann wrote:
> Hi,
>=20
> Dong Aisheng writes:
> > On Thu, Mar 15, 2012 at 07:22:04PM +0800, Lothar Wa=DFmann wrote:
> [...]
> > My proposal is only set the fixed part(first two octets) in board d=
ts file,
> > each board knows it's value, and read the left 4 octets from OCOTP =
dynamically.
> >
> The OUI part is three bytes, not two! But anyway, since there is no
> definition on how the MAC has to be stored in OCOTP there is no way
> for the driver to know how to interpret the data it may read from
> there.
>=20
I may miss this, i will double check it.
Thanks for the info. :-)

> > > Anyway there is no definite spec how the MAC address(es) are stor=
ed
> > > in the fuse map. Thus reading the MAC from there is more or less
> > > platform specific.
> > >=20
> > It's just provide one more option since there are customers storing=
 the MAC
> > in the fuse map.
> >=20
> How would the driver know, whether and how the customer has stored th=
e
> MAC address in OCOTP? E.g. on our TX28 modules the FULL MAC is stored
> in the CUSTOM registers in OCOTP.
>=20
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
> Reading the MAC from fuses is platform sepcific. The driver cannot
> know how the MAC is stored there and needs to rely on platform
> specific code to do this.
>=20
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
> That's why I said "would require all bootloaders to be updated first
> to support DTS".

Regards
Dong Aisheng

