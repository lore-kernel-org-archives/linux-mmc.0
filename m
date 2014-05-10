From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v11 2/6] ARM: dts: sunxi: Add reg_vmmc0
 supply to sunxi-common-regulators.dtsi
Date: Sat, 10 May 2014 08:17:17 -0500
Message-ID: <20140510131717.GL7047@lukather>
References: <1399714443-12459-1-git-send-email-hdegoede@redhat.com>
 <1399714443-12459-3-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PFhoI1KhOsYPpkJR"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBUXZXONQKGQEGG4ONLI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1399714443-12459-3-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--PFhoI1KhOsYPpkJR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

Thanks for your follow up on this.

On Sat, May 10, 2014 at 11:33:59AM +0200, Hans de Goede wrote:
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/boot/dts/sunxi-common-regulators.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sunxi-common-regulators.dtsi b/arch/arm/bo=
ot/dts/sunxi-common-regulators.dtsi
> index 18eeac0..ebbba39 100644
> --- a/arch/arm/boot/dts/sunxi-common-regulators.dtsi
> +++ b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
> @@ -72,4 +72,12 @@
>  		gpio =3D <&pio 7 3 0>;
>  		status =3D "disabled";
>  	};
> +
> +	reg_vmmc0: vmmc0 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vmmc0";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		status =3D "disabled";
> +	};

I think you can rather define this as vcc-3.3v or something alike,
that would always be enabled. That would allow to reuse this in some
other nodes as well, you won't need to enable it on every board, and
this is actually more accurate.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--PFhoI1KhOsYPpkJR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTbibdAAoJEBx+YmzsjxAguzwQALMbJeFERswfr2KkePo+Ql3k
vG9S1EFLO7UcYp6jw3Gc9stYAaj9e4iCUdhdP3tpwo6wWMPjLc+JVRbdddhfIQCw
H9SR9DFo43x7zjLejaShz/0x5lk6eik3FmO4DrVSEaA48/66yD0L2LAiihWVQRWc
NNbxoiKDNh4K/Kh4FAW7suuryzzYsDBaccOgDGgcrV+zI9tNcPCe/i3cAeX5pY7T
E7ji8qSfSpyWbOSMJfiIsk5dYxCisiKFaE6HQpX8UdtalkIoyaHghbrr9nZTku4I
z/nDYGyOSoYzY7i4uK3g2OU5zLwEdMe3EiVUL0nuPx3LybYrGeLn0+l7mj9l3BMx
IP98s/QJcsp90YsN/ZTXxLXYspAdl/qbk5iImOqqvsRjeCKMsRMIIxOsUL3SgSTK
+yhwwE3FJdzCh2pJsm+POnNzpnfDnzwd5DNwq6NkdVXiyvT0nLseS+h46VCryaE3
1GuySYa04xAxtb6tj2ow6i0vCUgP3IJFcPx83GRHnDlr3n8SKUS5Xuhbf6sybCx/
UvSzut3tY0Da36MKyq4wpxBNel6QLJxOf/udAOywm/zChb5Pqqbyhe9Jyv6hjMv6
v0kcunk3j0WlKcm1CzWrj+8TVz9S33a1KvTlfgq8HEwQtKtsJiltlWfSJsexLzc/
q14ezKRBvjbzwSwOnHKt
=BFW/
-----END PGP SIGNATURE-----

--PFhoI1KhOsYPpkJR--
