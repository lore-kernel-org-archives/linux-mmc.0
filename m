From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
Date: Mon, 4 Feb 2013 17:41:53 +0200
Message-ID: <20130204154153.GA18237@arwen.pp.htv.fi>
References: <1359742975-10421-1-git-send-email-mporter@ti.com>
	<1359742975-10421-2-git-send-email-mporter@ti.com>
	<5022f635a527470dbd0be932063e9cd2@DFLE72.ent.ti.com>
	<20130201184915.GP2244@beef> <510C1D0E.6030401@mvista.com>
	<20130201185820.GE29898@arwen.pp.htv.fi>
	<510C2A47.1090607@mvista.com>
	<20130201205600.GA31762@arwen.pp.htv.fi>
	<20130201213003.GW2637@n2100.arm.linux.org.uk>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1364732793=="
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20130201213003.GW2637-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Cousson,  Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>L
List-Id: linux-mmc@vger.kernel.org

--===============1364732793==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 01, 2013 at 09:30:03PM +0000, Russell King - ARM Linux wrote:
> > > > I guess to make the MUSB side simpler we would need musb-dma-engine=
 glue
> > > > to map dmaengine to the private MUSB API. Then we would have some
> > > > starting point to also move inventra (and anybody else) to dmaengine
> > > > API.
> > >=20
> > >    Why? Inventra is a dedicated device's private DMA controller, why =
make
> > > universal DMA driver for it?
> >=20
> > because it doesn't make sense to support multiple DMA APIs. We can check
> > from MUSB's registers if it was configured with Inventra DMA support and
> > based on that we can register MUSB's own DMA Engine to dmaengine API.
>=20
> Hang on.  This is one of the DMA implementations which is closely
> coupled with the USB and only the USB?  If it is...
>=20
> I thought this had been discussed _extensively_ before.  I thought the
> resolution on it was:
> 1. It would not use the DMA engine API.
> 2. It would not live in arch/arm.
> 3. It would be placed nearby the USB driver it's associated with.
>=20
> (1) because we don't use APIs just for the hell of it - think.  Do we
> use the DMA engine API for PCI bus mastering ethernet controllers?  No.
> Do we use it for PCI bus mastering SCSI controllers?  No.  Because the
> DMA is integral to the rest of the device.

that's not really a fair comparison, however. MUSB is used with several
DMA engines.

The only DMA engine which is really coupled with MUSB is the Inventra
DMA engine which comes as an optional feature to the IP. Many users have
opted out of it. From the top of my head we have CPPI 3.x, CPPI 4.1,
Inventra DMA, OMAP sDMA and ux500 DMA engines supported by the driver.

Granted, CPPI 4.1 makes some assumptions about the fact that it's
handling USB tranfers, but nevertheless, the IP can be, and in fact is,
used with many different DMA engines and driver needs to cope with it.

Current DMA abstraction is quite poor, for example there's no way to
compile support for multiple DMA engines. Code also makes certain, IMO
unnecessary, assumptions about the underlying DMA engine (abstraction is
poor, as said above but it we could follow MUSB's programming guide when
it comes to programming DMA transfers).

Considering all of the above, it's far better to use DMA engine and get
rid of all the mess.

--=20
balbi

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRD9bBAAoJEIaOsuA1yqREHr0QAIN9sPE+HWMHWgt6/r5f97Wd
hlwJOmsHdNpy2Sr5DhUqBSTSAyC6F/6hmNAxJHt3ksg2sOHoxhF0MV1OWPAyeRym
DRiLJu3kC1y6NcxHofiEvW5lE3QkkdpMYipz9q2QVOuWw8mps67qimmk8Wj1zgID
zBOBWiWlq3NgYVXyBsjAUTpUuSt5ZGJ5qqLutzhJwm070rgqTsqcRnKgRvkmb6lE
nqhk3HTrkFrZ/zfO1vt4HFMcOriLRIVOvLxXzQsU+FJuzdlO8KtcknMch6CISVX3
viOPyxwutfs+XeWwwW7DlNn5pGWExW34HpJkAHB+tawpHkck9Obw+gxlvOu2HANY
XN9EPDrwZRZegWasrrQHXfOhVaPy0OCDUTjyzeBEHQg7sK1y4zRFWOHaJlrv30Jn
Bke7Tmj8kSuhRJkjOX7TbUhZa+plKr+YZN9VnUhz4KoiTfS8VsdgBzoDprO+R41W
k0pjIH/IG5b7bUxs5JnWmDFNhQ394WzCAshbKJQHfSGnf9C4p36ysTAaPnIuOXCv
pzWEu2Fbq9YASj5KE2xcFngnYwoz2+hsDATG4eMYzJXh+U00/GU9OvnY0WfnPyHO
JOeG2OVpTiI+cthakJ6ee2y4w2zMeBwJdR317Rm/0D+/KvbDnDx/QxLNa4L/FtN6
qO45LowEcZb5/rQEN7rV
=Dvxb
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--

--===============1364732793==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1364732793==--
