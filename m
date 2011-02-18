From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH 01/12] mmc: sdhci: add support for auto CMD23
Date: Fri, 18 Feb 2011 05:53:50 -0600
Message-ID: <6C03668EAF45B747AF947A1603D1B300DCED190B@SAUSEXMBP01.amd.com>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
	<1297762510-2696-2-git-send-email-arindam.nath@amd.com>
 <AANLkTi=Dmsud5KJqFcP-97FxgyLVKmnxPn9e3z6fqqNc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:23103
	"EHLO VA3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754029Ab1BRLyD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 18 Feb 2011 06:54:03 -0500
In-Reply-To: <AANLkTi=Dmsud5KJqFcP-97FxgyLVKmnxPn9e3z6fqqNc@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>

Hi Zhangfei,

> -----Original Message-----
> From: zhangfei gao [mailto:zhangfei.gao@gmail.com]
> Sent: Friday, February 18, 2011 4:15 PM
> To: Nath, Arindam
> Cc: cjb@laptop.org; linux-mmc@vger.kernel.org; Su, Henry; Lu, Aaron;
> anath.amd@gmail.com
> Subject: Re: [PATCH 01/12] mmc: sdhci: add support for auto CMD23
>=20
> On Tue, Feb 15, 2011 at 4:34 AM, Arindam Nath <arindam.nath@amd.com>
> wrote:
> > Host Controller v3.00 and later support Auto CMD23 in the Transfer
> > Mode register. Since Auto CMD23 can be used with or without DMA,
> > and if used with DMA, it should _only_ be ADMA, we check against
> > SDHCI_USE_SDMA not being set. This flag is reset when SDHCI_USE_ADM=
A
> > is set.
> >
> > A new definition for SDHCI_ARGUMENT2 register has been added
> > in v3.00 spec, which is the same as SDHCI_DMA_ADDRESS. We program t=
he
> > block count for CMD23 in SDHCI_ARGUMENT2, so we don't need CMD12 to
> > stop multiple block transfers. But during error recovery procedure,
> > we will need to send Abort command, so we use a global variable
> > abort_cmd to save the stop command to be used later.
> >
> > Two bits are added to SCR register as per the Physical Layer Spec
> v3.01,
> > which specify whether the card supports CMD20 and/or CMD23. We use
> this
> > as one of the conditions to decide whether to enable Auto CMD23 or
> not.
> >
> > Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> > ---
> > =A0drivers/mmc/core/sd.c =A0 =A0| =A0 =A06 ++++
> > =A0drivers/mmc/host/sdhci.c | =A0 66
> +++++++++++++++++++++++++++++++++++++++++++--
> > =A0drivers/mmc/host/sdhci.h | =A0 =A02 +
> > =A0include/linux/mmc/card.h | =A0 =A04 +++
> > =A0include/linux/mmc/sd.h =A0 | =A0 =A02 +-
> > =A05 files changed, 76 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > index d18c32b..b3f8a3c 100644
> > --- a/drivers/mmc/core/sd.c
> > +++ b/drivers/mmc/core/sd.c
> > @@ -188,6 +188,12 @@ static int mmc_decode_scr(struct mmc_card *car=
d)
> >
> > =A0 =A0 =A0 =A0scr->sda_vsn =3D UNSTUFF_BITS(resp, 56, 4);
> > =A0 =A0 =A0 =A0scr->bus_widths =3D UNSTUFF_BITS(resp, 48, 4);
> > + =A0 =A0 =A0 if (scr->sda_vsn =3D=3D SCR_SPEC_VER_2) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Check if Physical Layer Spec v3.0 =
is supported*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 scr->sda_spec3 =3D UNSTUFF_BITS(resp,=
 47, 1);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (scr->sda_spec3)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scr->cmd_support =3D =
UNSTUFF_BITS(resp, 32, 2);
> > + =A0 =A0 =A0 }
> >
> > =A0 =A0 =A0 =A0if (UNSTUFF_BITS(resp, 55, 1))
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->erased_byte =3D 0xFF;
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 9e15f41..0b537cf 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -25,6 +25,7 @@
> >
> > =A0#include <linux/mmc/mmc.h>
> > =A0#include <linux/mmc/host.h>
> > +#include <linux/mmc/card.h>
> >
> > =A0#include "sdhci.h"
> >
> > @@ -46,6 +47,8 @@ static void sdhci_finish_data(struct sdhci_host *=
);
> > =A0static void sdhci_send_command(struct sdhci_host *, struct
> mmc_command *);
> > =A0static void sdhci_finish_command(struct sdhci_host *);
> >
> > +static struct mmc_command *abort_cmd;
> > +
> > =A0static void sdhci_dumpregs(struct sdhci_host *host)
> > =A0{
> > =A0 =A0 =A0 =A0printk(KERN_DEBUG DRIVER_NAME ": =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D REGISTER DUMP
> (%s)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
> > @@ -812,6 +815,30 @@ static void sdhci_prepare_data(struct sdhci_ho=
st
> *host, struct mmc_data *data)
> > =A0 =A0 =A0 =A0sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
> > =A0}
> >
> > +/*
> > + * Does the Host Controller support Auto CMD23?
> > + *
> > + * There are four preconditions for Auto CMD23 to be supported:
> > + * =A01. Host Controller v3.00 or later
> > + * =A02. Card supports CMD23
> > + * =A03. If DMA is used, it should be ADMA
> > + * =A04. Only when CMD18 or CMD25 is issued
> > + */
> > +static int sdhci_host_auto_cmd23_supported(struct sdhci_host *host=
,
> > + =A0 =A0 =A0 struct mmc_request *mrq)
> > +{
> > + =A0 =A0 =A0 struct mmc_card *card =3D host->mmc->card;
> > +
> > + =A0 =A0 =A0 if ((host->version >=3D SDHCI_SPEC_300) &&
> > + =A0 =A0 =A0 =A0 =A0card && (card->scr.cmd_support & SD_SCR_CMD23_=
SUPPORT) &&
> > + =A0 =A0 =A0 =A0 =A0!(host->flags & SDHCI_USE_SDMA) &&
> > + =A0 =A0 =A0 =A0 =A0((mrq->cmd->opcode =3D=3D MMC_READ_MULTIPLE_BL=
OCK) ||
> > + =A0 =A0 =A0 =A0 =A0(mrq->cmd->opcode =3D=3D MMC_WRITE_MULTIPLE_BL=
OCK)))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> > +
> > + =A0 =A0 =A0 return 0;
> > +}
> > +
> > =A0static void sdhci_set_transfer_mode(struct sdhci_host *host,
> > =A0 =A0 =A0 =A0struct mmc_data *data)
> > =A0{
> > @@ -824,11 +851,23 @@ static void sdhci_set_transfer_mode(struct
> sdhci_host *host,
> >
> > =A0 =A0 =A0 =A0mode =3D SDHCI_TRNS_BLK_CNT_EN;
> > =A0 =A0 =A0 =A0if (data->blocks > 1) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sdhci_host_auto_cmd23_supported(h=
ost, host->mrq))
> {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Host Controller =
v3.00 can automatically
> send CMD23
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* before CMD18 or =
CMD25. For that, we need
> to enable
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Auto CMD23 in th=
e Transfer Mode register
> and
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* program the bloc=
k count in Argument 2
> register.
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D SDHCI_TRNS_=
AUTO_CMD23;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writel(host, da=
ta->blocks,
> SDHCI_ARGUMENT2);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > +
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->quirks & SDHCI_QUIRK_MULTI=
BLOCK_READ_ACMD12)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mode |=3D SDHCI_TRNS=
_MULTI | SDHCI_TRNS_ACMD12;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mode |=3D SDHCI_TRNS=
_MULTI;
> > =A0 =A0 =A0 =A0}
> > +
> > =A0 =A0 =A0 =A0if (data->flags & MMC_DATA_READ)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mode |=3D SDHCI_TRNS_READ;
> > =A0 =A0 =A0 =A0if (host->flags & SDHCI_REQ_USE_DMA)
> > @@ -1131,6 +1170,23 @@ static void sdhci_request(struct mmc_host
> *mmc, struct mmc_request *mrq)
> > =A0#ifndef SDHCI_USE_LEDS_CLASS
> > =A0 =A0 =A0 =A0sdhci_activate_led(host);
> > =A0#endif
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Since the block count for CMD23 has already been=
 specified
> in the
> > + =A0 =A0 =A0 =A0* Argument 2 register, we don't need CMD12 to stop=
 multiple
> block
> > + =A0 =A0 =A0 =A0* transfers.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 if (sdhci_host_auto_cmd23_supported(host, mrq)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mrq->stop) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Save the stop co=
mmand here to be used
> during
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* error recovery
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abort_cmd =3D mrq->da=
ta->stop;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mrq->data->stop =3D N=
ULL;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mrq->stop =3D NULL;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 }
> > +
> > =A0 =A0 =A0 =A0if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD1=
2) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mrq->stop) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mrq->data->stop =3D =
NULL;
> > @@ -1396,6 +1452,7 @@ static void sdhci_timeout_timer(unsigned long
> data)
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->data) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->data->error =3D=
 -ETIMEDOUT;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->data->stop =3D =
abort_cmd;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_finish_data(ho=
st);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->cmd)
> > @@ -1534,9 +1591,10 @@ static void sdhci_data_irq(struct sdhci_host
> *host, u32 intmask)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->data->error =3D -EIO;
> > =A0 =A0 =A0 =A0}
> >
> > - =A0 =A0 =A0 if (host->data->error)
> > + =A0 =A0 =A0 if (host->data->error) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->data->stop =3D abort_cmd;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_finish_data(host);
> > - =A0 =A0 =A0 else {
> > + =A0 =A0 =A0 } else {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (intmask & (SDHCI_INT_DATA_AVAIL =
|
> SDHCI_INT_SPACE_AVAIL))
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_transfer_pio(h=
ost);
> >
> > @@ -1783,8 +1841,10 @@ int sdhci_add_host(struct sdhci_host *host)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->flags &=3D ~SDHCI_USE_SDMA;
> > =A0 =A0 =A0 =A0}
> >
> > - =A0 =A0 =A0 if ((host->version >=3D SDHCI_SPEC_200) && (caps &
> SDHCI_CAN_DO_ADMA2))
> > + =A0 =A0 =A0 if ((host->version >=3D SDHCI_SPEC_200) && (caps &
> SDHCI_CAN_DO_ADMA2)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->flags &=3D ~SDHCI_USE_SDMA;
>=20
> Here may have issue if controller use only support SDMA with
> SDHCI_QUIRK_BROKEN_ADMA.
> After this, both SDHCI_USE_SDMA and SDHCI_USE_ADMA are cleared.

Thanks for the careful review. I will fix it in V2 of the patchset.

Regards,
Arindam

