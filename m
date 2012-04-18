From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/8] ARM: OMAP: fix DMA vs memory ordering
Date: Wed, 18 Apr 2012 13:18:55 +0300
Message-ID: <20120418101854.GV13842@arwen.pp.htv.fi>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
 <E1SKRqN-0004b4-Me@rmk-PC.arm.linux.org.uk>
 <20120418101519.GU13842@arwen.pp.htv.fi>
 <20120418101733.GL25053@n2100.arm.linux.org.uk>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i483Pv/KqyjCUwB1"
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120418101733.GL25053@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org


--i483Pv/KqyjCUwB1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2012 at 11:17:33AM +0100, Russell King - ARM Linux wrote:
> On Wed, Apr 18, 2012 at 01:15:20PM +0300, Felipe Balbi wrote:
> > On Wed, Apr 18, 2012 at 11:10:35AM +0100, Russell King wrote:
> > > Using coherent DMA memory with the OMAP DMA engine results in
> > > unpredictable behaviour due to memory ordering issues; as things stan=
d,
> > > there is no guarantee that data written to coherent DMA memory will be
> > > visible to the DMA hardware.
> > >=20
> > > This is because the OMAP dma_write() accessor contains no barriers,
> > > necessary on ARMv6 and above.  The effect of this can be seen in comm=
ents
> > > in the OMAP serial driver, which incorrectly talks about cache flushi=
ng
> > > for the coherent DMA stuff.
> > >=20
> > > Rather than adding barriers to the accessors, add it in the DMA suppo=
rt
> > > code just before we enable DMA, and just after we disable DMA.  This
> > > avoids having barriers for every DMA register access.
> > >=20
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> >=20
> > cool, should this go to stable too ?
>=20
> Has anyone seen a problem (other than me when trying to get DMA engine
> working with omap-serial transmit paths) ?

probably not since omap-serial isn't using DMA anyway. Nevermind

--=20
balbi

--i483Pv/KqyjCUwB1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPjpUOAAoJEIaOsuA1yqRExMoQALYvaIXSAIaKhjadLiROd9F4
h4gK2/lh1c+4n6EO+vP3aV/L3njUzjgTKrrD7HeXEyR9J/vtRh1D9V3zy/mg+2En
5ZFHKH/vJ9qSWiB4m1iSAWgMfhMKW4//QDu48hKOTieuHYz836vqczIFpOd48Pm3
GwezH1g+st2XWE3E2nbi0zvjPVAlfxpn8cN0APJE6jGJfrycT3aZFp50Ig/5NnrA
E3dSZswzzJJNdAnYzD/BwG2tXsYbKv56hMEEX50pPxY3PGSwzlllAW24CYIZIuf9
mmIfJJAeZG9jnqovLJ2GLHinQiHT3kHXkbjIqMG0rAaxXN7rPlu7jdAkD9DYiRnX
d+nuPZt+gU0xetahI2H4HUdmpF/t0odYQyUEF53XhBJY0QTKsEv5XZOQ7P/WgIOT
bpDYCeUjovAzRyIfVqdFCm6DEkZODQ4jD+MnGjrJzCgI2L1xKC9aNAEm8vw6HvA7
99VXWhPMk2mP04N+VKLkm063KDL8hZH20/82GWr714KMa8uywOqMOlW6ICGb5P5b
y/A4yiBPg4XJMTpBldJJKLYqcYzk3TPyftkXlI4YGkuQbxCjA2tsn4kOKHCqshcq
3/Lj71WIPFJfRdwkBxf46H22mGzXOvULSsdhdwiRUgwZk+firE4COGO6t3WFHKCH
GZdK3xNc96ZrSD1ULCiz
=mS11
-----END PGP SIGNATURE-----

--i483Pv/KqyjCUwB1--
