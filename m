From: Zang Roy-R61911 <r61911@freescale.com>
Subject: RE: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for eSDHC driver
Date: Tue, 10 Aug 2010 18:04:54 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A0562AF@zch01exm23.fsl.freescale.net>
References: <20100809174333.GC7665@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:42596
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754651Ab0HJKFF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Aug 2010 06:05:05 -0400
Received: from mail172-va3 (localhost.localdomain [127.0.0.1])	by
 mail172-va3-R.bigfish.com (Postfix) with ESMTP id 6F8131408211	for
 <linux-mmc@vger.kernel.org>; Tue, 10 Aug 2010 10:05:04 +0000 (UTC)
Received: from VA3EHSMHS025.bigfish.com (unknown [10.7.14.242])	by
 mail172-va3.bigfish.com (Postfix) with ESMTP id DF8DC137004F	for
 <linux-mmc@vger.kernel.org>; Tue, 10 Aug 2010 10:05:03 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id o7AA515m009770	for
 <linux-mmc@vger.kernel.org>; Tue, 10 Aug 2010 03:05:01 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
 [10.192.129.207])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
 o7AAIqxP002260	for <linux-mmc@vger.kernel.org>; Tue, 10 Aug 2010 05:18:53
 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <20100809174333.GC7665@oksana.dev.rtsoft.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, linux-mmc@vger.kernel.org

=20

> -----Original Message-----
> From: Anton Vorontsov [mailto:cbouatmailru@gmail.com]=20
> Sent: Tuesday, August 10, 2010 1:44 AM
> To: Grant Likely
> Cc: Zang Roy-R61911; linuxppc-dev@ozlabs.org;=20
> akpm@linux-foundation.org; linux-mmc@vger.kernel.org
> Subject: Re: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for=20
> eSDHC driver
>=20
> On Wed, Aug 04, 2010 at 07:02:56PM -0600, Grant Likely wrote:
> > On Mon, Aug 2, 2010 at 9:11 PM, Roy Zang=20
> <tie-fei.zang@freescale.com> wrote:
> > > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > >
> > > Add auto CMD12 command support for eSDHC driver.
> > > This is needed by P4080 and P1022 for block read/write.
> > > Manual asynchronous CMD12 abort operation causes protocol=20
> violations on
> > > these silicons.
> > >
> > > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> > > ---
> > > =A0drivers/mmc/host/sdhci-of-core.c | =A0 =A04 ++++
> > > =A0drivers/mmc/host/sdhci.c =A0 =A0 =A0 =A0 | =A0 14 ++++++++++++=
--
> > > =A0drivers/mmc/host/sdhci.h =A0 =A0 =A0 =A0 | =A0 =A02 ++
> > > =A03 files changed, 18 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > > index c6d1bd8..a92566e 100644
> > > --- a/drivers/mmc/host/sdhci.c
> > > +++ b/drivers/mmc/host/sdhci.c
> > > @@ -817,8 +817,12 @@ static void=20
> sdhci_set_transfer_mode(struct sdhci_host *host,
> > > =A0 =A0 =A0 =A0WARN_ON(!host->data);
> > >
> > > =A0 =A0 =A0 =A0mode =3D SDHCI_TRNS_BLK_CNT_EN;
> > > - =A0 =A0 =A0 if (data->blocks > 1)
> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D SDHCI_TRNS_MULTI;
> > > + =A0 =A0 =A0 if (data->blocks > 1) {
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->quirks &=20
> SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D SDHCI_TRN=
S_MULTI |=20
> SDHCI_TRNS_ACMD12;
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D SDHCI_TRN=
S_MULTI;
> >=20
> > nit:
> > +               mode |=3D SDHCI_TRNS_MULTI;
> > +               if (host->quirks &=20
> SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
> > +                       mode |=3D SDHCI_TRNS_ACMD12;
> >=20
> > Clearer, no?
>=20
> Much clearer. I would prefer the nit incorporated.
Agree.

>=20
> Another nit:
>=20
> > @@ -154,6 +154,10 @@ static int __devinit=20
> sdhci_of_probe(struct of_device *ofdev,
> >                 host->ops =3D &sdhci_of_data->ops;
> >         }
> >=20
> > +       if (of_get_property(np, "sdhci,auto-cmd12", NULL))
> > +               host->quirks |=3D SDHCI_QUIRK_MULTIBLOCK_READ_ACMD1=
2;
> > +
> > +     =20
>=20
> ^^ No need for the two empty lines.
Agree.
>=20
> >        if (of_get_property(np, "sdhci,1-bit-only", NULL))
>=20
> Though, technically the patch looks OK, feel free to add my
>=20
>   Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
I send a new patch to fix the nip. you are Cced.
Thanks.
Roy

