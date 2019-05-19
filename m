From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/3] mmc: core: API for temporarily disabling
 auto-retuning due to errors
Date: Sun, 19 May 2019 11:06:42 +0200
Message-ID: <20190519090642.GA2279@kunai>
References: <20190517225420.176893-1-dianders@chromium.org>
 <20190517225420.176893-3-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4212091236098525067=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190517225420.176893-3-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Madhan Mohan R <madhanmohan.r-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Martin Hicks <mort-THxEKynEWHc@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Double Lo <double.lo-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chi-Hsien Lin <chi-hsien.lin-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arend van Spriel <arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Avri Altman <avri.altman-Sjgp3cTcYWE@public.gmane.org>, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Wright Feng <wright.feng-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Jiong Wu <lohengrin1024-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--===============4212091236098525067==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Let's add an API that the SDIO card drivers can call that will
> temporarily disable the auto-tuning functionality.  Then we can add a
> call to this in the Broadcom WiFi driver and any other driver that
> might have similar needs.

Can't you fix the WiFi driver to return something else than -EILSEQ
before calling mmc_request_done() to skip the retuning?


--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlzhHJ4ACgkQFA3kzBSg
KbbeARAAjRwuYMVRg9/KiLaxQrOgOKoCgflbt6sCKz+IWQYwpHqy/NMeXxogeaZp
y/kpClhWulThbXbH5kiV59qh55aSNFsNM0yA+IZFwbye0fKtXEtkJIjBVAOfQDdz
PY2Jx2nNSJWWJeUzcfbW1LwvygH2a3Hon2p1/UubaqYvLPoZPCZmwVC/1LFdJPPN
fv2uN5ukpVcfmNBSbQUUaoMPZp6oeuAxHa1+58aQzpCMo3h329ERrcgkDDcw4WP9
K20azhSC961CnA7Syj84BsmlMnARaCyZ9S8atXXCtX6R5hbgUXLkBIcqtbfB+npd
j0sTjbHGDh7eaQ0l14Xh3FVSeHZiepGlupQ1wW6HuHkR1Be1mL6nEdCvSqT0mNHf
TsHkuq9Loh/95/eInWqtpGVM2XOpwDkN8czDOwwiO4ejRHaIEaoZX6FWeV80lDnX
emtFSLifF0VaH5GqM4HwOu3iXFBxpuj6zwnADaxYZqwnFNyi0+nvhp9W2tHyaLey
fcB6sw/i+2Knu5k2JnaSHZutc2hqY6lhoLaJyjQKMfk2fxRBmdimnt3u6bNV9U+N
Qo4IQM5w5wgRGUbUAcfo9/aLXnEdVbEuSy6QJdLgp7pZUBaIj4c5U7XROP6RQRFJ
6XB4ckAS0xBjDQ/mFNM/W2+Keu+9dcqNtDrAEn3vchAKecUJdO0=
=k7qP
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--


--===============4212091236098525067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============4212091236098525067==--
