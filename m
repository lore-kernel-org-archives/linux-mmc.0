From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: Re: [PATCH v1 1/5] ARM: imx28: add basic dt support
Date: Wed, 21 Mar 2012 19:06:15 +0800
Message-ID: <20120321110613.GA4905@shlinux2.ap.freescale.net>
References: <20120315105927.GE13022@shlinux2.ap.freescale.net>
 <20321.53468.310199.875966@ipc1.ka-ro>
 <20120316030134.GA5161@shlinux2.ap.freescale.net>
 <20120318184749.BB15D3E07BF@localhost>
 <20326.55337.249575.289067@ipc1.ka-ro>
 <20120319150601.B783A3E05A5@localhost>
 <20327.25470.723875.916422@ipc1.ka-ro>
 <20120319220224.ABF5A3E0A04@localhost>
 <CAA+hA=R8hLZMyRASRim28MNzX4jyE3nsaJ3DPzgxDtUmqtH62w@mail.gmail.com>
 <20328.33660.472382.117901@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:20573
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758454Ab2CUKzB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Mar 2012 06:55:01 -0400
Content-Disposition: inline
In-Reply-To: <20328.33660.472382.117901@ipc1.ka-ro>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Dong Aisheng <dongas86@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Dong Aisheng-B29396 <B29396@freescale.com>, "vinod.koul@linux.intel.com" <vinod.koul@linux.intel.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Guo Shawn-R65073 <r65073@freescale.com>, "rdunlap@xenotime.net" <rdunlap@xenotime.net>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "cjb@laptop.org" <cjb@laptop.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Mar 20, 2012 at 09:17:48PM +0800, Lothar Wa=DFmann wrote:
> Hi,
>=20
> Dong Aisheng writes:
> > On Mon, Mar 19, 2012 at 3:02 PM, Grant Likely <grant.likely@secretl=
ab.ca> wrote:
> > > On Mon, 19 Mar 2012 17:49:02 +0100, Lothar Wa=DFmann <LW@KARO-ele=
ctronics.de> wrote:
> > >> Hi,
> > >>
> > >> Grant Likely writes:
> > >> > On Mon, 19 Mar 2012 07:54:33 +0100, Lothar Wa=DFmann <LW@KARO-=
electronics.de> wrote:
> > >> > > Grant Likely writes:
> > >> > > > On Fri, 16 Mar 2012 11:01:35 +0800, Dong Aisheng <aisheng.=
dong@freescale.com> wrote:
> > >> > > > > On Thu, Mar 15, 2012 at 07:22:04PM +0800, Lothar Wa=DFma=
nn wrote:
> > >> > > > > > Dong Aisheng writes:
> > >> > > > > > > On Thu, Mar 15, 2012 at 02:53:29PM +0800, Lothar Wa=DF=
mann wrote:
> > >> > > > > > Anyway there is no definite spec how the MAC address(e=
s) are stored
> > >> > > > > > in the fuse map. Thus reading the MAC from there is mo=
re or less
> > >> > > > > > platform specific.
> > >> > > > > >
> > >> > > > > It's just provide one more option since there are custom=
ers storing the MAC
> > >> > > > > in the fuse map.
> > >> > > >
> > >> > > > That should be straight forward to support; have a propert=
y that
> > >> > > > specifies the method used for fetching/calculating the MAC=
=2E
> > >> > > >
> > >> > > Executable code stored inside a DT blob? ;)
> > >> >
> > >> > I know you're joking here, but I'm going to answer seriously
> > >> > anyway... Absolutely not. =A0What I'm suggesting is a property=
 that
> > >> > specifies the method used to determine the mac address. =A0Som=
ething
> > >> > like (off the top of my head):
> > >> >
> > >> > =A0 =A0 local-mac-address =3D [01 02 03 00 00 00];
> > >> > =A0 =A0 local-mac-mask =3D [0xff 0xff 0xff 0 0 0];
> > >> > =A0 =A0 mac-encoding =3D "append-serial-number";
> > >> >
> > >> That still does not specify where the remaining part of the MAC =
is
> > >> stored and how it should be retrieved.
> > >
> > > I'm suggesting that you define a string that means something spec=
ific;
> > > that hopefully can be shared by multiple platforms. =A0For exampl=
e,
> > > "append-serial-number" might mean start with the values selected =
by
> > > AND of local-mac-address and local-mac-mask, and OR in the board'=
s
> > > serial number. =A0You would need to define something that worked =
if this
> > > was the solution you used.
> > >
> > I'm intend to Grant's this suggestion.
> > This can be shared by all other imx platforms which stores mac addr=
ess in
> > fuse map and this is commonly used by customer.
> > Then we do not need keep writing repeat code for different platform=
s
> > via platform
> > data.
> >=20
> > For Lothar's question, we can add a property fuse_mac_offset to ind=
icate
> > read mac from fuse map and where to read it.
> >
> That's not really enough. The format (big-endian vs. little-endian)
> may also differ. But it's not really necessary, if the solution with
> prom_update_property() works, since then platform code has full
> control over the MAC.
>=20
> > For how many bytes to read, we can calculate it from the local-mac-=
mask.
> > For example, local-mac-mask =3D [0xff 0xff 0xff 0 0 0], we can get =
the size
> > as 3 bypes.
> >=20
> > Then we have three properties:
> > local-mac-address =3D [01 02 03 00 00 00];
> > local-mac-mask =3D [0xff 0xff 0xff 0 0 0];
> > fuse_mac_offset =3D <1>;
> >=20
> > In fec driver, the final mac address can be got by:
> > local-mac-address & local-mac-mask | (read_fuse(1) & 0xffffff)
> >=20
> > Lathar,
> > Do you think if this is ok?
> >
> No. IMO the FEC driver itself should not read any fuses.
> Reading fuses is a SoC specific thing and the FEC driver should not
> depend on the idiosyncrasies of some SoC wrt. anything else but the
> implementation of the FEC itself.
>=20
Yes, i think i'm agree with this point.
Okay, i will do that with prom_update_property.
Thanks for suggestion.

Regards
Dong Aisheng

