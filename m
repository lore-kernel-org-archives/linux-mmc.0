From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for eSDHC driver
Date: Mon, 9 Aug 2010 21:43:33 +0400
Message-ID: <20100809174333.GC7665@oksana.dev.rtsoft.ru>
References: <1280805072-26112-1-git-send-email-tie-fei.zang@freescale.com>
 <AANLkTinJKO3-iXOXuL7CMWCj5qMMHyMrtnadwPpqTeBu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52525 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab0HIRnk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Aug 2010 13:43:40 -0400
Received: by bwz3 with SMTP id 3so1388735bwz.19
        for <linux-mmc@vger.kernel.org>; Mon, 09 Aug 2010 10:43:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinJKO3-iXOXuL7CMWCj5qMMHyMrtnadwPpqTeBu@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Roy Zang <tie-fei.zang@freescale.com>, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, linux-mmc@vger.kernel.org

On Wed, Aug 04, 2010 at 07:02:56PM -0600, Grant Likely wrote:
> On Mon, Aug 2, 2010 at 9:11 PM, Roy Zang <tie-fei.zang@freescale.com>=
 wrote:
> > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> >
> > Add auto CMD12 command support for eSDHC driver.
> > This is needed by P4080 and P1022 for block read/write.
> > Manual asynchronous CMD12 abort operation causes protocol violation=
s on
> > these silicons.
> >
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> > ---
> > =C2=A0drivers/mmc/host/sdhci-of-core.c | =C2=A0 =C2=A04 ++++
> > =C2=A0drivers/mmc/host/sdhci.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 14 ++++++++++++--
> > =C2=A0drivers/mmc/host/sdhci.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 =C2=A02 ++
> > =C2=A03 files changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index c6d1bd8..a92566e 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -817,8 +817,12 @@ static void sdhci_set_transfer_mode(struct sdh=
ci_host *host,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0WARN_ON(!host->data);
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0mode =3D SDHCI_TRNS_BLK_CNT_EN;
> > - =C2=A0 =C2=A0 =C2=A0 if (data->blocks > 1)
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mode |=3D SDHCI_=
TRNS_MULTI;
> > + =C2=A0 =C2=A0 =C2=A0 if (data->blocks > 1) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (host->quirks=
 & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 mode |=3D SDHCI_TRNS_MULTI | SDHCI_TRNS_ACMD12;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 mode |=3D SDHCI_TRNS_MULTI;
>=20
> nit:
> +               mode |=3D SDHCI_TRNS_MULTI;
> +               if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12=
)
> +                       mode |=3D SDHCI_TRNS_ACMD12;
>=20
> Clearer, no?

Much clearer. I would prefer the nit incorporated.

Another nit:

> @@ -154,6 +154,10 @@ static int __devinit sdhci_of_probe(struct of_de=
vice *ofdev,
>                 host->ops =3D &sdhci_of_data->ops;
>         }
>=20
> +       if (of_get_property(np, "sdhci,auto-cmd12", NULL))
> +               host->quirks |=3D SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
> +
> +     =20

^^ No need for the two empty lines.

>        if (of_get_property(np, "sdhci,1-bit-only", NULL))

Though, technically the patch looks OK, feel free to add my

  Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

on the next resend (if any).

Thanks Roy!

--=20
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
