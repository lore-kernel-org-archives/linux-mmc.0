From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Get rid of of_have_populated_dt() usage
Date: Wed, 11 Apr 2012 13:09:57 +0300
Message-ID: <20120411100956.GT12064@arwen.pp.htv.fi>
References: <1334138593-9692-1-git-send-email-rnayak@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K0M4iRgkWWXhiQ9N"
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1334138593-9692-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: cjb@laptop.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, b-cousson@ti.com, Balaji TK <balajitk@ti.com>, Rob Herring <rob.herring@calxeda.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-mmc@vger.kernel.org


--K0M4iRgkWWXhiQ9N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2012 at 03:33:13PM +0530, Rajendra Nayak wrote:
> @@ -1564,7 +1564,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc=
, struct mmc_ios *ios)
>  			 * can't be allowed when booting with device
>  			 * tree.
>  			 */
> -			(!of_have_populated_dt())) {
> +			!host->dev->of_node) {

won't compile

--=20
balbi

--K0M4iRgkWWXhiQ9N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPhVh0AAoJEIaOsuA1yqRELSEQAIaznVwnAQiUkgH381ImiRsr
OsIc44D/Tc9BfsS8Ursu2ofDMOfzhtugiO1YL+o2KV90OhChEg6QWUj0jfkYher7
pLHGqQH5NjKQjKZz17UEA9AaQfab9VTcOX9r01JRCVRzUoXZljCjkeSonf8Rcgbo
2h12kvtMrFRnf+EEzXSt7CXGhnn3zL0l48jmSxCsP9VtKQvkNFGD5VSwFJbodTwA
PMZAJfysHnMNZRlrSMMZ/DSgyTyZMmC1mwMIhKH7kkJHjDThgExYta/Ry0aZSsL5
PKUaeKKzsjR6dOodB448CBqV7nPJVYxrK4xEEtPImXXcHlDXUhiSjGy/k9Y/WdpJ
zm+yQTnu6X8hyNbYvSEf9po+eiPw5CthXE87xNZyJkPqdnrOTAKJl+n/4NsU/0cV
uaHck3AGEuAmdUmLJFucEkSbZ1E0JI4RMIzdaKlyUN1nkodxrRUAv0E78IU/Ak/h
pNS3HqGFN3SA3VhtYTT+F5+wvoULMp/HU5O+cNzOWjJBTJPiHgd7l0J7gKoBCcJ+
wNfBGZa3K82ojo4UQDFfk7TAnat3iHxCLet1rgq68NT+mP2YoiYAUbftRUuHB+jG
FDOEsdezk/EISBxB/Neahp/Ze7rOYIyaYDzuv7o9OawiDaQQQAat3zJTbPr5A63G
whgCps9Q2V80YduARGRC
=i97D
-----END PGP SIGNATURE-----

--K0M4iRgkWWXhiQ9N--
