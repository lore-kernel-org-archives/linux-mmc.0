From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v9 05/17] ARM: dts: sun4i: Add pin-muxing
 info for the mmc0 controller
Date: Mon, 28 Apr 2014 12:32:10 -0700
Message-ID: <20140428193210.GF3134@lukather>
References: <1398507381-5614-1-git-send-email-hdegoede@redhat.com>
 <1398507381-5614-6-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f61P+fpdnY2FZS1u"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBAO37KNAKGQE6RKGO7Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1398507381-5614-6-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--f61P+fpdnY2FZS1u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Sat, Apr 26, 2014 at 12:16:09PM +0200, Hans de Goede wrote:
> mmc0 is the only controller actually being used on boards, so limit the
> pin-muxing options to that.
>=20
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a=
10.dtsi
> index dce074b..29fd4f5 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -565,6 +565,20 @@
>  				allwinner,drive =3D <0>;
>  				allwinner,pull =3D <0>;
>  			};
> +
> +			mmc0_pins_a: mmc0@0 {
> +				allwinner,pins =3D "PF0","PF1","PF2","PF3","PF4","PF5";
> +				allwinner,function =3D "mmc0";
> +				allwinner,drive =3D <2>;
> +				allwinner,pull =3D <0>;
> +			};
> +
> +			mmc0_cd_pin_a: mmc0_cd_pin@0 {
> +				allwinner,pins =3D "PH1";
> +				allwinner,function =3D "gpio_in";
> +				allwinner,drive =3D <0>;
> +				allwinner,pull =3D <1>;
> +			};

Actually, I like very much the reference_pin mention you had in your
bindings documentation. Could you use it for this and the other
patches?

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--f61P+fpdnY2FZS1u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTXqy6AAoJEBx+YmzsjxAgqvQQAImSangXW6g9tY1n54r12xUy
OLrPt6AKWagMhM4LBbwwAiP45aXSLkTI5uQeBNLHocy1RpqxQLhf8IjoGi11Hs7W
vXTSMdqNvzUGUEHuCYuZJZMja1Ku8dy+V14McgdFMiZCFsunQbM90Md/4rZ4Wgh+
nafSlUi3QMLhM5HR9YtURHzrrUgtHsb+hl9LCzVnfUtnbGulS5+ENjUbYE9jAxHM
AoWaPyulZ9RKpVoUFXIRSI+cLshsUOtpKHLeLi3LZTnx8ToMItWA6+a8PBfQ+YVi
Jiu+ddHRuUJ2Zt7yRZ+FbNRua5yNAvmwfm4MG9cvZZIIAekY8F9y0tylbI+BO9kK
iHDYVaauhoRRlqgFGwoBaNuCzL2iniOmppU4eq1Wjv0yBJthsCaT5DGwB41rSCVT
3Ia9teukwUPZ0FygvBREEyVxhC1apK46vQyDLDQgsNEeEyE3tezQDfdNlSF/XOfo
TM8L+RSHFKwieal0YMoVqVc2yov22O5wqh8SiNtobtzBov6Ujx30PfdfuPTOCmKl
GH1IRNMYnWXktluNFUb2C9YnQMxgaOb2+y49V2byG7TFsA+Pf35L+3PA59XN3psu
wlkSIdebMVQ+BdTSkBIKtdxHIFVZlKeAAIX4Bz3rANpALdyLsDwaHg+JPgedtHze
074GnMksE4KNCbQN9UzW
=Im/d
-----END PGP SIGNATURE-----

--f61P+fpdnY2FZS1u--
