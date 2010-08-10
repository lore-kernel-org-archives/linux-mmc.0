From: Zang Roy-R61911 <r61911@freescale.com>
Subject: RE: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for eSDHC driver
Date: Tue, 10 Aug 2010 17:47:30 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A0562AA@zch01exm23.fsl.freescale.net>
References: <AANLkTinJKO3-iXOXuL7CMWCj5qMMHyMrtnadwPpqTeBu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:5248 "EHLO
	VA3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753788Ab0HJJr5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Aug 2010 05:47:57 -0400
Received: from mail147-va3 (localhost.localdomain [127.0.0.1])	by
 mail147-va3-R.bigfish.com (Postfix) with ESMTP id D80491AB013A	for
 <linux-mmc@vger.kernel.org>; Tue, 10 Aug 2010 09:47:56 +0000 (UTC)
Received: from VA3EHSMHS031.bigfish.com (unknown [10.7.14.239])	by
 mail147-va3.bigfish.com (Postfix) with ESMTP id 8983310E804F	for
 <linux-mmc@vger.kernel.org>; Tue, 10 Aug 2010 09:47:56 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id o7A9lZjI008011	for
 <linux-mmc@vger.kernel.org>; Tue, 10 Aug 2010 02:47:46 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
 [10.192.129.207])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 o7AA0X5e000572	for <linux-mmc@vger.kernel.org>; Tue, 10 Aug 2010 05:00:34
 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <AANLkTinJKO3-iXOXuL7CMWCj5qMMHyMrtnadwPpqTeBu@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org

=20

> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On=20
> Behalf Of Grant Likely
> Sent: Thursday, August 05, 2010 9:03 AM
> To: Zang Roy-R61911
> Cc: linux-mmc@vger.kernel.org; linuxppc-dev@ozlabs.org;=20
> akpm@linux-foundation.org
> Subject: Re: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for=20
> eSDHC driver
>=20
> On Mon, Aug 2, 2010 at 9:11 PM, Roy Zang=20
> <tie-fei.zang@freescale.com> wrote:
> > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> >
> > Add auto CMD12 command support for eSDHC driver.
> > This is needed by P4080 and P1022 for block read/write.
> > Manual asynchronous CMD12 abort operation causes protocol=20
> violations on
> > these silicons.
> >
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> > ---
> > =A0drivers/mmc/host/sdhci-of-core.c | =A0 =A04 ++++
> > =A0drivers/mmc/host/sdhci.c =A0 =A0 =A0 =A0 | =A0 14 ++++++++++++--
> > =A0drivers/mmc/host/sdhci.h =A0 =A0 =A0 =A0 | =A0 =A02 ++
> > =A03 files changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index c6d1bd8..a92566e 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -817,8 +817,12 @@ static void=20
> sdhci_set_transfer_mode(struct sdhci_host *host,
> > =A0 =A0 =A0 =A0WARN_ON(!host->data);
> >
> > =A0 =A0 =A0 =A0mode =3D SDHCI_TRNS_BLK_CNT_EN;
> > - =A0 =A0 =A0 if (data->blocks > 1)
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D SDHCI_TRNS_MULTI;
> > + =A0 =A0 =A0 if (data->blocks > 1) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->quirks &=20
> SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D SDHCI_TRNS_=
MULTI |=20
> SDHCI_TRNS_ACMD12;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D SDHCI_TRNS_=
MULTI;
>=20
> nit:
> +               mode |=3D SDHCI_TRNS_MULTI;
> +               if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12=
)
> +                       mode |=3D SDHCI_TRNS_ACMD12;
>=20
> Clearer, no?
It is clear.
Thanks.
Roy

