From: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH] Revert "sdhci-of-esdhc: Support 8BIT bus width."
Date: Fri, 15 May 2015 15:36:17 +0800
Message-ID: <20150515073617.GO8870@pek-khao-d1.corp.ad.wrs.com>
References: <1431671349-12759-1-git-send-email-haokexin@gmail.com>
 <1431673364.13197.10.camel@transmode.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jx/LfW4V5TfZLeq7"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35379 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932092AbbEOHg0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 May 2015 03:36:26 -0400
Received: by qkgy4 with SMTP id y4so65342817qkg.2
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2015 00:36:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1431673364.13197.10.camel@transmode.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


--jx/LfW4V5TfZLeq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2015 at 07:02:44AM +0000, Joakim Tjernlund wrote:
> Reverting this seem a bit to much. Looking in the log it seems commit
>  2317f56c055fcad524bf6a873df48a754e7ebc4d=20
> introduced the error by not checking for host->ops->set_bus_width before
> calling it.
>=20
> How does this work for you?

No. My sd card still don't work with this change.

>=20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c80287a..23603b2 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1528,7 +1528,10 @@ static void sdhci_do_set_ios(struct sdhci_host *ho=
st, struct mmc_ios *ios)
>         if (host->ops->platform_send_init_74_clocks)
>                 host->ops->platform_send_init_74_clocks(host, ios->power_=
mode);
> =20
> -       host->ops->set_bus_width(host, ios->bus_width);
> +       if (host->ops->set_bus_width)
> +               host->ops->set_bus_width(host, ios->bus_width);
> +       else
> +               sdhci_set_bus_width(host, ios->bus_width);

The default sdhci_set_bus_width() doesn't apply to the esdhc controller on =
my
board (p2020rdb). This controller is compatible with the sd host specificat=
ion
2.0 and the implementation of sdhci_set_bus_width() can't set the bus width
correctly for it.

Thanks,
Kevin

--jx/LfW4V5TfZLeq7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVVaHxAAoJEJNY7TDerrFxA4EIAM16Ks8JkHuwdHnSdjuQyPmT
UHY2atPPnCCRZ5dcAW+rcN6oRYvu07L+7TWmA6R4vrH7g2KiZDJFkIkPPFAnukdc
adMQoUNEVhCXZ2ZY+NtlPzKc+VfKDk/82R3oAsrN7IE1IIEv1O7J17JOq29gcK0L
4MnQEYDpBRQ+stNimzzGTtE6+B3h8hSC4CwaM2JSWfyKlm+IHN2rxAVDPoc9lrEO
cTM3GoMuCJxOG7BVgwZCrB3d3ClhLC8U0nrsBHmc48dNuWTxtbSgwaENYIGrtoM4
ocpqKI+LLAlR1z6tolvSGatrfJJbK2hohHSEBQS3hAbInkWccUO+7SPWvKiwWMQ=
=SDLA
-----END PGP SIGNATURE-----

--jx/LfW4V5TfZLeq7--
