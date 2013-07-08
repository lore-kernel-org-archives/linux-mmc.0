From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 2/3] mmc: omap_hsmmc: debugfs entries for GPIO mode.
Date: Mon, 8 Jul 2013 10:51:47 +0300
Message-ID: <20130708075139.GF16635@arwen.pp.htv.fi>
References: <1365770307-19859-1-git-send-email-andreas.fenkart@streamunlimited.com>
 <1365770307-19859-3-git-send-email-andreas.fenkart@streamunlimited.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqCDj3hiknadvR6t"
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1365770307-19859-3-git-send-email-andreas.fenkart@streamunlimited.com>
Sender: linux-omap-owner@vger.kernel.org
To: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Cc: tony@atomide.com, cjb@laptop.org, arnd@arndb.de, balajitk@ti.com, grant.likely@secretlab.ca, linux-mmc@vger.kernel.org, rob@landley.net, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, zonque@gmail.com
List-Id: linux-mmc@vger.kernel.org

--AqCDj3hiknadvR6t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2013 at 02:38:26PM +0200, Andreas Fenkart wrote:
> Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>

-ENODESCRIPTION ??

Also, looking at the patch, I wonder if it really needs to be applied in
mainline. Seems like you only needed it to count how many times it went
into suspend and we already have generic pm_runtime counters for that.

--=20
balbi

--AqCDj3hiknadvR6t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR2m+TAAoJEIaOsuA1yqREUUcP/150X+RggbXWTC7OGwzkriYq
xz0lNpe0iXlqtRem/R4PFjhC+1BgZic31Gn9rI8dIFbY9jkqBouPwCc53aI6Qk0a
pCVyp0/YCGfCGmSkkw8gpZNLWj7mHkQzzkBVzxD5axR1wUkRiPtzV+KE1Q3B1JcD
/wpbwMNfSB+xc2Ppv687T/VJkwPuH+iIfYtufC+tuDBSwFy1g8D5HwLy8cKG5MjC
rstwXSb7Uc22ZwAq2iUIblv8OqmhEBLnkSg+YSbsrueLoOY0fFe33/GVs8jzK+Au
GKi4hPiEzwkcSFJX1MeGNCnjmnKx4em1xeeJ2NwunWBBDmrFWl8uWiFc52hqxHM0
f4+0p3hJps2i/vXckXpLZSwwtiKFmtJEQemb1I3l9gfoYhC9Yv07qRNzK8a3WRwo
DQJIyAKvH19p2A8qITY1p9pgmnBx44a76ATxorPhf4iiBxkiPPIfSf1cdCW2LHJo
iPCyzOCMRh8CJm0tcJr1rE+R7aRPWJcE9SvDtNLZJV2dsX0fkUf5ncD37Mi9/RZs
iy6XZdSr9WZwEADzm+/F24p9hL5FgP9+2qVO9xKbCjjx4UqwyP2J6ChwhOfLGtTi
VOL28NrvPn7Ky8oeIwgjH4y+gglmQiayReYTAqj+EGiRjet5N3LewJI20/HN1hHH
UNSczbkNGnFCXdMqdxTL
=gZjX
-----END PGP SIGNATURE-----

--AqCDj3hiknadvR6t--
