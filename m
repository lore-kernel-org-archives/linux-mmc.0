From: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH] Revert "sdhci-of-esdhc: Support 8BIT bus width."
Date: Sun, 17 May 2015 13:04:20 +0800
Message-ID: <20150517050420.GA23513@pek-khao-d1.corp.ad.wrs.com>
References: <1431671349-12759-1-git-send-email-haokexin@gmail.com>
 <1431673364.13197.10.camel@transmode.se>
 <20150515073617.GO8870@pek-khao-d1.corp.ad.wrs.com>
 <1431676168.13197.18.camel@transmode.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f66.google.com ([209.85.192.66]:35946 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbbEQFEa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 17 May 2015 01:04:30 -0400
Received: by qgdz60 with SMTP id z60so3408272qgd.3
        for <linux-mmc@vger.kernel.org>; Sat, 16 May 2015 22:04:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1431676168.13197.18.camel@transmode.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2015 at 07:49:29AM +0000, Joakim Tjernlund wrote:
> On Fri, 2015-05-15 at 15:36 +0800, Kevin Hao wrote:
> > On Fri, May 15, 2015 at 07:02:44AM +0000, Joakim Tjernlund wrote:
> > > Reverting this seem a bit to much. Looking in the log it seems commit
> > >  2317f56c055fcad524bf6a873df48a754e7ebc4d=20
> > > introduced the error by not checking for host->ops->set_bus_width bef=
ore
> > > calling it.
> > >=20
> > > How does this work for you?
> >=20
> > No. My sd card still don't work with this change.
> >=20
> > >=20
> > > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > > index c80287a..23603b2 100644
> > > --- a/drivers/mmc/host/sdhci.c
> > > +++ b/drivers/mmc/host/sdhci.c
> > > @@ -1528,7 +1528,10 @@ static void sdhci_do_set_ios(struct sdhci_host=
 *host, struct mmc_ios *ios)
> > >         if (host->ops->platform_send_init_74_clocks)
> > >                 host->ops->platform_send_init_74_clocks(host, ios->po=
wer_mode);
> > > =20
> > > -       host->ops->set_bus_width(host, ios->bus_width);
> > > +       if (host->ops->set_bus_width)
> > > +               host->ops->set_bus_width(host, ios->bus_width);
> > > +       else
> > > +               sdhci_set_bus_width(host, ios->bus_width);
> >=20
> > The default sdhci_set_bus_width() doesn't apply to the esdhc controller=
 on my
> > board (p2020rdb). This controller is compatible with the sd host specif=
ication
> > 2.0 and the implementation of sdhci_set_bus_width() can't set the bus w=
idth
> > correctly for it.
>=20
> But the controller is the same as for T1042 I presume?

No. As I know the controller on t1042 is compatible with sd host specificat=
ion 3.

> The bus width is in SDHCI_HOST_CONTROL
> and the 8BIT is bit 29 in the register?

Yes, that is true.

>=20
> What bus width do you use and what is the failure?

4 bit sd card. I got some error like this:
mmcblk0: error -84 transferring data, sector 3911672, nr 8, cmd response 0x=
900, card status 0xb0

Thanks,
Kevin

>=20
>nk  Jocke
> =20
>=20

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVWCFUAAoJEJNY7TDerrFxVvEH/R2Rtc0eWKaTH4LdGSM/TysW
zjsEjWqDrE8cirZblLN4yBqv2bf/2QLUJddKUaKDdB8n5D/OuNMO2YEyrljlp+kn
lYrXmGBiHvBE8TS/AyqTE5RwEvpfjIP6/KbvdP0shbgCiU+5SUn8IWeFZwI0aUjP
Z73vAylyUClX8ZaVaSnggD5KYxM1GqWlWSRG2FwPdSq6LQoUsNN2lDwR7V2ZXS1D
C1TP3E0PdCfjx8gt3zj39BvnHyr2sRTPRYwQX+U+Hqla4kkmUqzkRm/pg6hCk6jI
fg+502VVKLn7FvaYRs6mawKIf/PNUZwJiL/hqeWdU2zAiwhc9J/zuDma7Oxdo/E=
=TvMU
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
