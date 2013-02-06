From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
Date: Wed, 6 Feb 2013 09:45:08 +0200
Message-ID: <20130206074508.GB22064@arwen.pp.htv.fi>
References: <1359742975-10421-1-git-send-email-mporter@ti.com>
 <20130204154153.GA18237@arwen.pp.htv.fi>
 <20130205182848.GJ25185@atomide.com>
 <201302052226.30754.arnd@arndb.de>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8912946262857323859=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <201302052226.30754.arnd-r2nGTMty4D4@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

--===============8912946262857323859==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline

--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2013 at 10:26:30PM +0000, Arnd Bergmann wrote:
> On Tuesday 05 February 2013, Tony Lindgren wrote:
> > * Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [130204 07:46]:
> > >=20
> > > Current DMA abstraction is quite poor, for example there's no way to
> > > compile support for multiple DMA engines. Code also makes certain, IMO
> > > unnecessary, assumptions about the underlying DMA engine (abstraction=
 is
> > > poor, as said above but it we could follow MUSB's programming guide w=
hen
> > > it comes to programming DMA transfers).
> > >=20
> > > Considering all of the above, it's far better to use DMA engine and g=
et
> > > rid of all the mess.
> >=20
> > How about just disable MUSB DMA support if ARCH_MULTIPLATFORM for now?
> > That way MUSB can be fixed up first to support ARCH_MULTIPLATFORM
> > using PIO while sorting out the DMA related issues.
>=20
> Sounds ok to me. Someone still needs to do the work to make the non-DMA
> variants of MUSB coexist in one kernel, but as we discussed erlier, that
> should be much simpler.

Yeah, I'm cooking some patches to at least make it buildable. Dropping
unnecessary dependencies and marking da8xx and davinci as depending on
BROKEN seems to be the easiest way; those two glues hasn't seen a real
patch since 2010 or so.

--=20
balbi

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJREgoEAAoJEIaOsuA1yqRE1usP/R//BpO3v7devKDdQBLwvF8l
phPe3rz8ETV1nVYLYYrbmBtfDf5DBMD0D0FcehZyPDXcXUeQnlijhTRXVFpyH0Zy
SIE5djOk1Tn16H06zw0igs5BOo9ErOLL3lBu5wg3fkXehdd81pmGBJKAooEkj2jw
GSJlsvId2MST7VOuzA0ZX+4hwE0GWSD9H4L0qPiShZXT4fPtLB0KdYWINYe5ydsU
h1Doapg3ur93Hvaz1otV+a219TMBa3zmtORPnKDeTMKgZmuAPIKJBX2fCY1CmYuh
c6C5F6xKS6iYsqO+TsDXFM9r2gN0qUG2Y/2nhTsRDP5wNZVqVTQcLlUeSjPPCrI6
TCp6uQyBjvyMWY8U+sBO0Rvq181PQytCujeH5rcwT5V4Y1Yq0dp+2466jk3STesY
9Md48ZZYIboKmjkXcN0gE1Ypge79Cdofrxt/fFvPrAro8jw+mSb7GA2nMD8Jts/D
eKsd6r53u6dBRcrYhTXroWuHKv+lyEffxbmSWmSk3SBM0+LIgEgCyhLycwYq1MyG
Y12kgteqKgMJlGJbpWmYDJ1szi7KUIrMRwUviRWIKt8NebZrvEcAPyxWy521uKYe
1gTYGDyw05BP0VlWff8JRAWF027uUBac1tacfpnCg9LtAA0HSTK6gZ2Gb7EYGG81
NyGEb7Y2apxrUalPd+aF
=J3m8
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--

--===============8912946262857323859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============8912946262857323859==--
