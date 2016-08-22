From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 5/5] ARM: dts: sunxi: Use new sun7i-a20-mmc compatible
 on sun7i and newer
Date: Mon, 22 Aug 2016 09:54:54 +0200
Message-ID: <20160822075454.GB7104@lukather>
References: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
 <1469888748-26085-6-git-send-email-hdegoede@redhat.com>
 <9b6ed836-27ff-c8c8-d886-d86c787605fc@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4043782391963838261=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <9b6ed836-27ff-c8c8-d886-d86c787605fc@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andre Przywara <andre.przywara@arm.com>
Cc: devicetree <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.xyz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--===============4043782391963838261==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 01, 2016 at 02:11:09PM +0100, Andre Przywara wrote:
> Hi Hans,
>=20
> On 30/07/16 15:25, Hans de Goede wrote:
> > Use the new sun7i-a20-mmc compatible for the mmc controllers on sun7i
> > and newer.
> >=20
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> > Changes in v2:
> > -New patch in v2 of this patch-set
> > ---
> >  arch/arm/boot/dts/sun6i-a31.dtsi     | 8 ++++----
> >  arch/arm/boot/dts/sun7i-a20.dtsi     | 8 ++++----
> >  arch/arm/boot/dts/sun8i-a23-a33.dtsi | 6 +++---
> >  arch/arm/boot/dts/sun8i-h3.dtsi      | 6 +++---
> >  4 files changed, 14 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i=
-a31.dtsi
> > index 1867af2..0d24f10 100644
> > --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> > +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> > @@ -469,7 +469,7 @@
> >  		};
> > =20
> >  		mmc0: mmc@01c0f000 {
> > -			compatible =3D "allwinner,sun5i-a13-mmc";
> > +			compatible =3D "allwinner,sun7i-a20-mmc";
>=20
> But that breaks systems with newer DTs on older kernels, which do not
> know about sun7i-a20-mmc.

That's not backward compatibility. That's the forward one, and that
has never been something we supported.

See https://www.kernel.org/doc/Documentation/devicetree/bindings/ABI.txt

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXuq/OAAoJEBx+YmzsjxAg31oP/AgDZi5biao/9jRsTmrrjdTj
ULa5IfngA4XziercfYkuLqh4rFeGMjsFxRCP8unUHnDvbrzv6KaGHZkwX8z6zal2
PNS2qPyjLry3mnAVzO9PMwZnhbewKfJvI+4T2Q/O8OMwlpOv7gPFquQeNTmLClBq
53gYxXz5YM8zp2cjsjS9vlV4t2otwzkS+HGg89AEG7b/lpZDsW/h3b7OltK+TdoU
0fsZc25At9+wx4cGcwHJC8BVa21uRl1Sny4NdlX/AoJoQKXvf4b0v1mx9TM4l80o
KIs4Fjh4/3pJ6DfHKkU8wIQGIxju1iaW5qOxFaCXRugDQTQ0teUodf2ZITduAlDO
MljH2g9lv3P8siwUZnyFnITggSp/aKnWCTtU4vLxar4ulUMU2+c4NctjxT7Dl8gL
KL6haamfYrvqriUaSWEnXllW4Z5JCzXBi8mGJeNSG4DrR9FbcZH9HxK6sT9abfrh
DpIsPiwUdBs22iHHB1yKZtkIrvtthJZRZM8d9URFdPYrueGf+kiFteOht6ncJk+V
HuakdspKIVblTmCUovDK7Ocaka2n6Ai+wXheplK+XAOXaLgqYpCC4wf10cokpiss
AigwXAZ20s3su87L7moqquCIOQiS60PClWsfyCulQoAPdr/YzAzTpkMgKNm+DNqQ
O2fj7yYF1zU5eHA2/GOv
=pqkd
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--


--===============4043782391963838261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4043782391963838261==--
