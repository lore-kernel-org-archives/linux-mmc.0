From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH 1/1]mmc: set timeout for SDHCI host before sending busy
 cmd
Date: Thu, 24 Feb 2011 22:54:56 +0800
Message-ID: <5D8008F58939784290FAB48F5497519835CE59FE81@shsmsx502.ccr.corp.intel.com>
References: <20110224111935.GB7169@intel.com>
 <AANLkTinJEXc_x36Rht=XfYEtjShAYKWRDcsjGFtd=5Tj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:13169 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751835Ab1BXO5C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Feb 2011 09:57:02 -0500
In-Reply-To: <AANLkTinJEXc_x36Rht=XfYEtjShAYKWRDcsjGFtd=5Tj@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jae hoon Chung <jh80.chung@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, Kyungmin Park <kyungmin.park@samsung.com>

Great. Maybe we wouldn't need to add this quirk since give a maximum ti=
meout value is safe for all host controller I think. We would better sa=
ve the quirk for other really critical silicon bugs.

> -----Original Message-----
> From: Jae hoon Chung [mailto:jh80.chung@gmail.com]
> Sent: Thursday, February 24, 2011 10:18 PM
> To: Dong, Chuanxiao
> Cc: linux-mmc@vger.kernel.org; cjb@laptop.org; linux-kernel@vger.kern=
el.org;
> arnd@arndb.de; Kyungmin Park
> Subject: Re: [PATCH 1/1]mmc: set timeout for SDHCI host before sendin=
g busy cmd
>=20
> Hi
>=20
> This patch looks like this. I sent to the RFC patch..
>=20
> http://marc.info/?l=3Dlinux-mmc&m=3D129109794815028&w=3D3
>=20
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>  Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>=20
> ---
>  drivers/mmc/host/sdhci.c  |    6 +++++-
>  include/linux/mmc/sdhci.h |    3 ++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 782c0ee..3b93d97 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -655,8 +655,12 @@ static void sdhci_prepare_data(struct sdhci_host
> *host, struct mmc_data *data)
>=20
>        WARN_ON(host->data);
>=20
> -       if (data =3D=3D NULL)
> +       if (data =3D=3D NULL) {
> +               if ((host->quirks & SDHCI_QUIRK_SET_DATA_TIMEOUT_VAL)
> &&
> +                               (host->cmd->flags & MMC_RSP_BUSY))
> +                       sdhci_writel(host, 0xE, SDHCI_TIMEOUT_CONTROL=
);
>                return;
> +       }
>=20
>        /* Sanity checks */
>        BUG_ON(data->blksz * data->blocks > 524288);
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index 1fdc673..315ff49 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -83,7 +83,8 @@ struct sdhci_host {
>  #define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12             (1<<28)
>  /* Controller doesn't have HISPD bit field in HI-SPEED SD card */
>  #define SDHCI_QUIRK_NO_HISPD_BIT                       (1<<29)
> -
> +/* Controller need set data timeout value when card is busy */
> +#define SDHCI_QUIRK_SET_DATA_TIMEOUT_VAL               (1<<30)
>        int irq;                /* Device IRQ */
>        void __iomem *ioaddr;   /* Mapped address */
>=20
> --
> 1.6.0.4
>=20
> 2011/2/24 Chuanxiao Dong <chuanxiao.dong@intel.com>:
> > Set the timeout control register for SDHCI host when it needs to se=
nd some
> > commands which need busy signal. Use the maximum timeout value will=
 be safe.
> >
> > Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> > ---
> > =A0drivers/mmc/host/sdhci.c | =A0 14 ++++++++++----
> > =A01 files changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 9e15f41..32b7475 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -40,7 +40,6 @@
> >
> > =A0static unsigned int debug_quirks =3D 0;
> >
> > -static void sdhci_prepare_data(struct sdhci_host *, struct mmc_dat=
a *);
> > =A0static void sdhci_finish_data(struct sdhci_host *);
> >
> > =A0static void sdhci_send_command(struct sdhci_host *, struct mmc_c=
ommand
> *);
> > @@ -651,16 +650,23 @@ static void sdhci_set_transfer_irqs(struct sd=
hci_host
> *host)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_clear_set_irqs(host, dma_irqs,=
 pio_irqs);
> > =A0}
> >
> > -static void sdhci_prepare_data(struct sdhci_host *host, struct mmc=
_data *data)
> > +static void sdhci_prepare_data(struct sdhci_host *host, struct mmc=
_command
> *cmd)
> > =A0{
> > =A0 =A0 =A0 =A0u8 count;
> > =A0 =A0 =A0 =A0u8 ctrl;
> > + =A0 =A0 =A0 struct mmc_data *data =3D cmd->data;
> > =A0 =A0 =A0 =A0int ret;
> >
> > =A0 =A0 =A0 =A0WARN_ON(host->data);
> >
> > - =A0 =A0 =A0 if (data =3D=3D NULL)
> > + =A0 =A0 =A0 if (data =3D=3D NULL) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* set timeout to be maximum value =
for command with busy
> signal.
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cmd->flags & MMC_RSP_BUSY)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writeb(host, 0x=
E,
> SDHCI_TIMEOUT_CONTROL);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> > + =A0 =A0 =A0 }
> >
> > =A0 =A0 =A0 =A0/* Sanity checks */
> > =A0 =A0 =A0 =A0BUG_ON(data->blksz * data->blocks > 524288);
> > @@ -920,7 +926,7 @@ static void sdhci_send_command(struct sdhci_hos=
t *host,
> struct mmc_command *cmd)
> >
> > =A0 =A0 =A0 =A0host->cmd =3D cmd;
> >
> > - =A0 =A0 =A0 sdhci_prepare_data(host, cmd->data);
> > + =A0 =A0 =A0 sdhci_prepare_data(host, cmd);
> >
> > =A0 =A0 =A0 =A0sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
> >
> > --
> > 1.6.6.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >
