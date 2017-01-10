From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 6/6] arm64: allwinner: a64: Increase the MMC max
 frequency
Date: Tue, 10 Jan 2017 20:15:14 +0100
Message-ID: <20170110191514.kgbesffn3xqltnol@lukather>
References: <cover.493dc67855a5f1837e875d37307319a03d14d1d0.1483980339.git-series.maxime.ripard@free-electrons.com>
 <3689701f93c8426bfa476e9a5f31c3642a8a898e.1483980339.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v67JoOAtHjMJboNUdCDX=+=Hf+zOWr234rT7GEiUmPb=nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7247130931091763651=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGb2v67JoOAtHjMJboNUdCDX=+=Hf+zOWr234rT7GEiUmPb=nQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: devicetree <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Andre Przywara <andre.przywara@arm.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org


--===============7247130931091763651==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uvkf5zt67xpihfzl"
Content-Disposition: inline


--uvkf5zt67xpihfzl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 10, 2017 at 01:01:20AM +0800, Chen-Yu Tsai wrote:
> On Tue, Jan 10, 2017 at 12:46 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > All the controllers can have a maximum frequency of 200MHz.
> >
> > Since older SoCs cannot go that high, we cannot change the default maxi=
mum
> > frequency, but fortunately for us we have a property for that in the DT.
> >
> > This also has the side effect of allowing to use the MMC HS200 mode for=
 the
> > boards that support it (with either 1.2v or 1.8v IOs).
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 3 +++
> >  1 file changed, 3 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64=
/boot/dts/allwinner/sun50i-a64.dtsi
> > index 8e149498e096..f46ae965cf5b 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > @@ -332,6 +332,7 @@
> >                         resets =3D <&ccu RST_BUS_MMC0>;
> >                         reset-names =3D "ahb";
> >                         interrupts =3D <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> > +                       max-frequency =3D <200000000>;
>=20
> You also have to set one of MMC_CAP2_HS200* in the driver,
> or mmc-hs200-1_8v or mmc-hs200-1_2v in the device tree to
> actually use HS200, right?

Yes, but that requires a board with 1.8V IOs to work properly, which
not all board use, so it's probably best to enable it in the board
DTS.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--uvkf5zt67xpihfzl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYdTK+AAoJEBx+YmzsjxAgq+oP/1OBvGLYw/SI/Ugdj9G3B0Nc
mXEJsi6inDmPpgtUcS3CmiKv7ZhYwCkx1hEoBcLSGp+laQ55PNGWartAhYUC0bwu
i3vUmlhuvcTa9xPKOz/VnU2hpKULT9NKuJ6AzjzIAfGwgYmaMRmYdAHUoQzPKNoP
rjhjvEJjfjmfu5vPBnGbkyZXPf51qKqU7euP6poi1q/SwgoQW4KKCZAKMjO4ujTS
ivpykZ4VwEL2FqBMiicoGxtC9rVQuqounGMOqFS3yWZu521DOTBMJOAXIeDp+3vx
VcjutFOkoYV5JQqd7lOtgCt81uvx8umOX66QXLiaazWPESPr6E8gXkWgiH03FyvX
4uPaR1U5MHmsFRzhLzllSwf5ybs2BepOuQjU4rRVfDna8hIS3a5pF5h4O9FpL8z0
MFIEtc6c0RELq2uFyFmlEiAv+GqCDwQEgHUTECiMDAa7RTaQlvQnRq9aioN/uB/v
Y0GYMwnoZHKeMYOoj6ldqeByxmZwj0soyaDZjSIcwX5in+XJol/UEiqifTLXPZd2
2hUCsXf07vBlQGNQLpcx9+nREOfC7CQkWF3PbbcyKih9W3BigY5Zjawro8LxWyd0
Ymj8Kgovn4UQD7eoQDJalpnVATwP8r9vIX1OvVQVxL99eeeretMtVp6e1W6l3MbE
+/Ja2ROD/BeOr9HwMF6d
=dys/
-----END PGP SIGNATURE-----

--uvkf5zt67xpihfzl--


--===============7247130931091763651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7247130931091763651==--
