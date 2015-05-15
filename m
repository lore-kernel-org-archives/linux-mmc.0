From: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH] Revert "sdhci-of-esdhc: Support 8BIT bus width."
Date: Fri, 15 May 2015 15:42:54 +0800
Message-ID: <20150515074254.GP8870@pek-khao-d1.corp.ad.wrs.com>
References: <1431671349-12759-1-git-send-email-haokexin@gmail.com>
 <1431673364.13197.10.camel@transmode.se>
 <1431674695.13197.14.camel@transmode.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bd2KlmcTHfsQFEJ+"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:36598 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932335AbbEOHnF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 May 2015 03:43:05 -0400
Received: by qgg76 with SMTP id 76so23202498qgg.3
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2015 00:43:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1431674695.13197.14.camel@transmode.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


--Bd2KlmcTHfsQFEJ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2015 at 07:24:55AM +0000, Joakim Tjernlund wrote:
> Ahh, now I see. Drivers are supposed to call sdhci_set_bus_width instead =
of NULL:
> Instead of reverting this add:
>=20
>  diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-=
of-esdhc.c
> index 7a98a22..07b9df2 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -283,6 +283,7 @@ static const struct sdhci_ops sdhci_esdhc_ops =3D {
>         .get_min_clock =3D esdhc_of_get_min_clock,
>         .platform_init =3D esdhc_of_platform_init,
>         .adma_workaround =3D esdhci_of_adma_workaround,
> +       .set_bus_width =3D sdhci_set_bus_width,
>         .reset =3D esdhc_reset,
>         .set_uhs_signaling =3D sdhci_set_uhs_signaling,
>  };
>=20
> Should I repost the full "sdhci-of-esdhc: Support 8BIT bus width." with t=
his fix added
> of just the above fix?

Sorry, this still don't work.

Thanks,
Kevin

--Bd2KlmcTHfsQFEJ+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVVaN+AAoJEJNY7TDerrFx/iwH+wQx1Tz1+/YdkX2hFRhhS8rm
vzEOglfFJQfkNfHhJGCMTjQEGDh1DDfbQky+xiBFG1n95GFCL3gabj3PQYIYiwUh
jyVkulLK7L5M5UgGPzQJ8N6JDZ8ht1qNVNQbrdvo4aZn/5KJRGCVg4PzHwpgdZfm
gmI7kcDVQ+1o4H2PvRKmJyD4+niYQKSsR8XmfPwWBGq8r1+2QWWoLOmj7MdXSg82
K2c4PcfPTxx20R6EkjYDSTV6vuZpN9DYIYjHNk0Gkf4zer6XlW6YtRsTWoD/FvYQ
9s7EgciTq/BIywJt7L9gU6NZv/ErNm7vDOvsib5QsSj1hEYhM9QGb4SUXPRxSaU=
=6p5c
-----END PGP SIGNATURE-----

--Bd2KlmcTHfsQFEJ+--
