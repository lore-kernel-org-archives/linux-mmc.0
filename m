From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v12 0/6] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Sun, 11 May 2014 19:08:43 +0200
Message-ID: <20140511170843.GT7047@lukather>
References: <1399794417-9291-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uc+LCsvbRhlIZa01"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRB2W5X2NQKGQESW4EFLA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1399794417-9291-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--uc+LCsvbRhlIZa01
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Sun, May 11, 2014 at 09:46:51AM +0200, Hans de Goede wrote:
> Hi All,
>=20
> Here is v12 of the sunxi-mmc patch-set David Lanzend=F6rfer and I have be=
en
> working on, the mmc driver itself is unchanged from v11. New this version=
 are
> some dts patch changes, see below.
>=20
> The first patch in this series is the patch adding the actual mmc driver =
and
> should go in through the mmc tree.
>=20
> All the other patches are devicetree patches adding / using the new fixed
> reg_vcc3v3 supply to all sunxi board files, and should go upstream through
> Maxime's sunxi-dts tree.

I just merged the last 5 patches.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--uc+LCsvbRhlIZa01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTb66bAAoJEBx+YmzsjxAgTU4P/1Eexy8NCvbZGMQnK+fKgESW
XKE3MQn/RibyUJkQdsTFf8FQ6Sx56y1yQ+ZiFfXjAPz2RjjGVuqnZwCVFquaRohm
xaty83t1Dvb8LbjJa5pKQd3NHJkDl3uHuR0kX9fEVafdiE/93m7A9l4rcWn7yBAf
dSY4Pgp/r62TPWh418R/FSl84TpvKgGc0gtEkKly/xdlo/k+fYNw7LcgXsJGAeVb
37dO9tLzckpJZwbwrCPRk2rssPmabTWHPeKTTNiasS3CiEj8Y90YUbIJIE+MYcI/
c4loZUZC9/5XWyr7d1P+lheBqwDLFBrS7ak555WAIlTGLnvppuMNwELRw2OGbl5H
i5X0305d1wBgbX41jGTY9vu/PHpjo4xhC7Bce1sTc4Gks0cXLow36N7S3ekzgdRJ
CYVoEm9MoCvGLAA6NvGhKvlZ1gEu7/W90Ny14GN2KAP5AaMhMlqlyMkYZSAinMvr
MF1ZyvX6xav8eS53MaC5rJgd7aKt1SiQYPOR+fMUDAFiTWejJXJofUwGzs/0nrfI
0Pgc9SwfpDLaMhsKWtuWA7iJy2I0QAOmTPMCdFsp7iAKDNRS0M+selPmjrgewg/C
nJoM2JrxZO+GZGAy9Z9oqR16dp1d3oQbjxuSbbF1jkwE2VTSgk1AqE39TMLTfhOf
JAal5GLPFXZl/xVg//Vt
=EiU0
-----END PGP SIGNATURE-----

--uc+LCsvbRhlIZa01--
