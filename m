From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v10 02/15] clk: sunxi: Implement MMC phase control
Date: Tue, 6 May 2014 13:53:01 -0500
Message-ID: <20140506185301.GJ9464@lukather>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
 <1399046249-19472-3-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2VXyA7JGja7B50zs"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1399046249-19472-3-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--2VXyA7JGja7B50zs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Fri, May 02, 2014 at 05:57:16PM +0200, Hans de Goede wrote:
> From: Emilio L=F3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
>=20
> HdG: add header exporting clk_sunxi_mmc_phase_control
>=20
> Signed-off-by: Emilio L=F3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Do you agree with Hans proposal to merge this, and then convert to the
clk_set_phase proposal whenever we will have the details of the phase
values?

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--2VXyA7JGja7B50zs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTaS+NAAoJEBx+YmzsjxAgD58QAL3JAqDUzPIPQAL29U1vZWc1
zVinxdcbhtvmrPaSA2pidRDt2nKvoeHrV8qJKUcc4dPOw3dYVn23VLC9jzZlcyQb
PUr2402XLIOkkc62KHKMJ+AduyNrsqkr5AvJUAcYRpCYrchehTlpV1awJsQATQI8
3ZqgpEBx83LfdVYRyy4EZwPwdOYm1SnjJl/EfVcu4ne3wmHZ2bpjF0n9tuQg1fcO
wcuYAMKiftZL+uK3J5lSW9A4DhXgAQE16KKkEcp5f04VliTRow4WiiwJCFRI5aIA
tHJHpjQ3ICY3Oqax1bcOBb89/35FwA0aWgmrGifDW2H2vGAZOMr1pQvA4Bt3yMrJ
e8HeoqQlv6uI30p+HOEJ5r1+9FVR6co/DBQNeQR6tQop5Pp+f31VTH7+yvOSyBF0
KT/V3A8XGVzCSeR6Sd3Svx9qQazPyUtJqQRG6KSAGilGxqpkFbeplo6R1ndopnhW
S7n/dMoJP8cNNeelMMjy/RR2/WqUOZLNglAxlytQeImhbeqWT1CfMSr3GE75obw3
ujhXjyDb+MSTtN/W4lwjTGxzc8z0jxXglz/XZhM9o+slTUYzcHbHKJCjuDK+sQAz
yowIpu8+XcwhaEhree6Lkn+RYmUnu11pn3tQvwaGwXCaaaqPHvbIAUO1+crhyG5Z
8HWhl4zsTZcPTaFetnBR
=z9fK
-----END PGP SIGNATURE-----

--2VXyA7JGja7B50zs--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
