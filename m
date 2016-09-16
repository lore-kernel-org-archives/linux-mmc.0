From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 08/11] arm64: dts: r8a7796: add SDHI nodes
Date: Fri, 16 Sep 2016 12:30:48 +0200
Message-ID: <20160916103048.GL1411@katana>
References: <1473764228-24768-1-git-send-email-horms+renesas@verge.net.au>
 <1473764228-24768-9-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oY1uq2ONqt5kuovO"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1473764228-24768-9-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--oY1uq2ONqt5kuovO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 13, 2016 at 12:57:05PM +0200, Simon Horman wrote:
> Add SDHI nodes to the DT of the r8a7796 SoC.
>=20
> Based on the DT of the r8a7795 SoC.
>=20
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

If you remove the two lines you removed from H3 already:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

> +		sdhi2: sd@ee140000 {
> +			compatible =3D "renesas,sdhi-r8a7796";
> +			reg =3D <0 0xee140000 0 0x2000>;
> +			interrupts =3D <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&cpg CPG_MOD 312>;
> +			max-frequency =3D <200000000>;
> +			power-domains =3D <&sysc R8A7796_PD_ALWAYS_ON>;
> +			cap-mmc-highspeed;
This one...

> +			status =3D "disabled";
> +		};
> +
> +		sdhi3: sd@ee160000 {
> +			compatible =3D "renesas,sdhi-r8a7796";
> +			reg =3D <0 0xee160000 0 0x2000>;
> +			interrupts =3D <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&cpg CPG_MOD 311>;
> +			max-frequency =3D <200000000>;
> +			power-domains =3D <&sysc R8A7796_PD_ALWAYS_ON>;
> +			cap-mmc-highspeed;

=2E.. and ditto.


--oY1uq2ONqt5kuovO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX28nYAAoJEBQN5MwUoCm2tLQP/1rE6Y0EB4aD/RFJNxeo+68n
8TZEPOCc4ebSCSB3qIBBZ4fQ9EgZeSHWpNNEUXMuw8FcngIS8ZEzbwBaMpjvO3GZ
sNr+8Nbgz5WJGsrlHr8Y2L7F1GC7VszG70KJd0Zh5DZ7XjH+ByZvbzZblmqKS0M7
7kmY2Xpcfa6zw6TeK6fdCgZGdIgVLi/o5QcVRipmvw0lAxNJuP78bZVuQw9uLA5r
h8BLC3znpbflDWmtzrmbgb2WMrNdAjVebkQlGyK298Jc1mCpB5d7+9Zh2x0CMZJ7
2+mErFPv9K1rqkWpOdbZubMkU9GL9aWWc/BmsK+7Me/na4vr5fNxe5Mkfk5m/EhK
/aZABFxuouoJOU2tTLo0IEZH0q3/2YXIZt8KapsLlDfOSRipB+EJmdzaMWIuyAG6
cDqypWj6N+s8Imnh6hEHQpn40ZtupaL5z2issGJmOEVSBNeUcf29P6Qpk6x7yYhI
GxsmpS37m5skIkC690nXFObLUD47qXCfROa+UD7e4LdEXCJuDKYCF7eNK2eHcygo
MOm0PqDrTKrRSIeiEapa0dwaeTKKveGMZn9w2Oxahv6378g1xMA1BnYVSD6akC5g
d5RkgXGCOji2rGes4VvLxTUCm2Homj+2PpbuD1zzVqELfC/87lpWNRoaNwiKYpd4
Y1wpgN9t6UBSpzFoiIe4
=sHEb
-----END PGP SIGNATURE-----

--oY1uq2ONqt5kuovO--
