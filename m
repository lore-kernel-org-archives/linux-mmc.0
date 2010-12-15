From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/4] sdhci: add quirk for broken sdio irq
Date: Wed, 15 Dec 2010 04:54:43 -0600
Message-ID: <20101215105443.GA32297@lixom.net>
References: <1292388576-25600-1-git-send-email-olof@lixom.net> <1292388576-25600-3-git-send-email-olof@lixom.net> <AANLkTint+ObCy3Mak4E1Cj+2TS_4vbpZm57tXK_-CJ+K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.lixom.net ([70.86.134.90]:42139 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752944Ab0LOKyn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 15 Dec 2010 05:54:43 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTint+ObCy3Mak4E1Cj+2TS_4vbpZm57tXK_-CJ+K@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

On Wed, Dec 15, 2010 at 05:42:14AM -0500, zhangfei gao wrote:
> On Tue, Dec 14, 2010 at 11:49 PM, Olof Johansson <olof@lixom.net> wro=
te:
> > Some controllers can't handle SDIO IRQ properly. Give a way to
> > disable it.
> >
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> > ---
> > =A0drivers/mmc/host/sdhci.c =A0| =A0 =A06 +++++-
> > =A0include/linux/mmc/sdhci.h | =A0 =A02 ++
> > =A02 files changed, 7 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index c0094c1..98f3d3d 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -1871,7 +1871,10 @@ int sdhci_add_host(struct sdhci_host *host)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->f_min =3D host->max_clk / SDHCI=
_MAX_DIV_SPEC_200;
> >
> > =A0 =A0 =A0 =A0mmc->f_max =3D host->max_clk;
> > - =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_SDIO_IRQ;
> > + =A0 =A0 =A0 mmc->caps =3D 0;
> > +
> > + =A0 =A0 =A0 if (!(host->quirks & SDHCI_QUIRK_NO_SDIO_IRQ))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_SDIO_IRQ;
> >
> > =A0 =A0 =A0 =A0/*
> > =A0 =A0 =A0 =A0 * A controller may support 8-bit width, but the boa=
rd itself
> > diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> > index dfb2106..97d547e 100644
> > --- a/include/linux/mmc/sdhci.h
> > +++ b/include/linux/mmc/sdhci.h
> > @@ -85,6 +85,8 @@ struct sdhci_host {
> > =A0#define SDHCI_QUIRK_NO_HISPD_BIT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (1<<29)
> > =A0/* Controller treats ADMA descriptors with length 0000h incorrec=
tly */
> > =A0#define SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC =A0 =A0 =A0 =A0 =A0=
 (1<<30)
> > +/* Controller should not use SDIO IRQ */
> > +#define SDHCI_QUIRK_NO_SDIO_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<<31)
>=20
> Just wander can we use another way instead of using the last two
> quirk, otherwise, no quirk can be used any more.
> If this is only tegra specific issue, any possibility to modify vecto=
r
> after add_host in sdhci-tegra.c.
> for example
> sdhci_add_host(host);
> host->mmc->max_seg_size =3D 65535;
> host->mmc->caps |=3D MMC_CAP_SDIO_IRQ;

Yuck. That completely breaks any kind of abstraction and layering.

> Really appreciate if not using the valuable quirk resource, which is =
u32.

No big deal. Next person that needs a quirk bit gets to bump the data
type to u64.


-Olof

