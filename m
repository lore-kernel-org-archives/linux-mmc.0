From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v10 15/15] ARM: dts: sun7i: Add basic support for the
 Cubietruck WiFi module
Date: Mon, 5 May 2014 17:45:20 -0500
Message-ID: <20140505224520.GB9464@lukather>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
 <1399046249-19472-16-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1399046249-19472-16-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2014 at 05:57:29PM +0200, Hans de Goede wrote:
> From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
>=20
> The CubieTruck has an AMPAK AP6210 WiFi+Bluetooth module. The WiFi
> part is a BCM43362 IC connected to MMC3 in the A20 SoC via SDIO.
> The IC also takes a power enable signal via GPIO.
>=20
> The WiFi module supports out-of-band interrupt signaling via GPIO,
> but this is not supported in this patch.
>=20
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Applied with Chen-Yu SoB.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTaBSAAAoJEBx+YmzsjxAgViQQAIQz01UO42cj8NSm6kfkFdzu
t1duWA/Ncc8qtOduOubaCSekqG049+Xykpx+Ievuisha6Xo8SrrOkiMBfKKgSTxq
MPYGjMnfxxQYiJqoM91ySttBZr8lj3guviz0hQ/n32454gCGDWOuFMFSAyLftzVV
qvj7KN7v9iOrjS+j8xft4BY60AH7nNhGPRm0eDRS+4CsehkUWXuHzzp2Yhw/za1t
Z0y45E0Kxw/HB6fhZJGKy5Ql2hyM14wnt0gZwH9jIuOcMpzJB1JZkOcUjG14/3np
1vb+mrAvOHtYR0pRSnCWRAZaccNZ1twRP9PSB2eWg4SSnqbnWaIw2tQuXSLPB/0u
Cy6D/G3fld8Vo70kLebnkhIldINFZ9owJIj0HPUkC9ZH8snbp58avZBPQRpywLaU
OftY4CuGcJM5zrae4zJU7yf3oROdfMpOt5nUqK+hs7RvFhXBIrI2W/eJkSj+PMif
v6A55xzeijQPUw61HUpBdh+up1lnaHMmyXDj0LhmYB85o6QrdRakGINMvvvOQPtX
V6iRYPf24ZWbCieMcJUMleOk6PtKoaCTXTj6AP1/JCroUtWecULS8mBYEG52WIMM
S/2CiqRZ/QJdnstY4VGr8Jroj0rnf5g3Wr8c5sn5PTrO4mflWEMTCNHdvMuV8RjJ
fEXAQG9v/UnvNdmnya+v
=DAVu
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
