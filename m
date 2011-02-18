From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH 01/12] mmc: sdhci: add support for auto CMD23
Date: Fri, 18 Feb 2011 05:45:27 -0500
Message-ID: <AANLkTi=Dmsud5KJqFcP-97FxgyLVKmnxPn9e3z6fqqNc@mail.gmail.com>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
	<1297762510-2696-2-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:62305 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab1BRKp3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Feb 2011 05:45:29 -0500
Received: by qyk12 with SMTP id 12so3582875qyk.19
        for <linux-mmc@vger.kernel.org>; Fri, 18 Feb 2011 02:45:29 -0800 (PST)
In-Reply-To: <1297762510-2696-2-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

On Tue, Feb 15, 2011 at 4:34 AM, Arindam Nath <arindam.nath@amd.com> wr=
ote:
> Host Controller v3.00 and later support Auto CMD23 in the Transfer
> Mode register. Since Auto CMD23 can be used with or without DMA,
> and if used with DMA, it should _only_ be ADMA, we check against
> SDHCI_USE_SDMA not being set. This flag is reset when SDHCI_USE_ADMA
> is set.
>
> A new definition for SDHCI_ARGUMENT2 register has been added
> in v3.00 spec, which is the same as SDHCI_DMA_ADDRESS. We program the
> block count for CMD23 in SDHCI_ARGUMENT2, so we don't need CMD12 to
> stop multiple block transfers. But during error recovery procedure,
> we will need to send Abort command, so we use a global variable
> abort_cmd to save the stop command to be used later.
>
> Two bits are added to SCR register as per the Physical Layer Spec v3.=
01,
> which specify whether the card supports CMD20 and/or CMD23. We use th=
is
> as one of the conditions to decide whether to enable Auto CMD23 or no=
t.
>
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> ---
> =A0drivers/mmc/core/sd.c =A0 =A0| =A0 =A06 ++++
> =A0drivers/mmc/host/sdhci.c | =A0 66 ++++++++++++++++++++++++++++++++=
+++++++++++--
> =A0drivers/mmc/host/sdhci.h | =A0 =A02 +
> =A0include/linux/mmc/card.h | =A0 =A04 +++
> =A0include/linux/mmc/sd.h =A0 | =A0 =A02 +-
> =A05 files changed, 76 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index d18c32b..b3f8a3c 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -188,6 +188,12 @@ static int mmc_decode_scr(struct mmc_card *card)
>
> =A0 =A0 =A0 =A0scr->sda_vsn =3D UNSTUFF_BITS(resp, 56, 4);
> =A0 =A0 =A0 =A0scr->bus_widths =3D UNSTUFF_BITS(resp, 48, 4);
> + =A0 =A0 =A0 if (scr->sda_vsn =3D=3D SCR_SPEC_VER_2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Check if Physical Layer Spec v3.0 is=
 supported*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 scr->sda_spec3 =3D UNSTUFF_BITS(resp, 4=
7, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (scr->sda_spec3)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scr->cmd_support =3D UN=
STUFF_BITS(resp, 32, 2);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if (UNSTUFF_BITS(resp, 55, 1))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->erased_byte =3D 0xFF;
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9e15f41..0b537cf 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -25,6 +25,7 @@
>
> =A0#include <linux/mmc/mmc.h>
> =A0#include <linux/mmc/host.h>
> +#include <linux/mmc/card.h>
>
> =A0#include "sdhci.h"
>
> @@ -46,6 +47,8 @@ static void sdhci_finish_data(struct sdhci_host *);
> =A0static void sdhci_send_command(struct sdhci_host *, struct mmc_com=
mand *);
> =A0static void sdhci_finish_command(struct sdhci_host *);
>
> +static struct mmc_command *abort_cmd;
> +
> =A0static void sdhci_dumpregs(struct sdhci_host *host)
> =A0{
> =A0 =A0 =A0 =A0printk(KERN_DEBUG DRIVER_NAME ": =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D REGISTER DUMP (%s)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
> @@ -812,6 +815,30 @@ static void sdhci_prepare_data(struct sdhci_host=
 *host, struct mmc_data *data)
> =A0 =A0 =A0 =A0sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
> =A0}
>
> +/*
> + * Does the Host Controller support Auto CMD23?
> + *
> + * There are four preconditions for Auto CMD23 to be supported:
> + * =A01. Host Controller v3.00 or later
> + * =A02. Card supports CMD23
> + * =A03. If DMA is used, it should be ADMA
> + * =A04. Only when CMD18 or CMD25 is issued
> + */
> +static int sdhci_host_auto_cmd23_supported(struct sdhci_host *host,
> + =A0 =A0 =A0 struct mmc_request *mrq)
> +{
> + =A0 =A0 =A0 struct mmc_card *card =3D host->mmc->card;
> +
> + =A0 =A0 =A0 if ((host->version >=3D SDHCI_SPEC_300) &&
> + =A0 =A0 =A0 =A0 =A0card && (card->scr.cmd_support & SD_SCR_CMD23_SU=
PPORT) &&
> + =A0 =A0 =A0 =A0 =A0!(host->flags & SDHCI_USE_SDMA) &&
> + =A0 =A0 =A0 =A0 =A0((mrq->cmd->opcode =3D=3D MMC_READ_MULTIPLE_BLOC=
K) ||
> + =A0 =A0 =A0 =A0 =A0(mrq->cmd->opcode =3D=3D MMC_WRITE_MULTIPLE_BLOC=
K)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> =A0static void sdhci_set_transfer_mode(struct sdhci_host *host,
> =A0 =A0 =A0 =A0struct mmc_data *data)
> =A0{
> @@ -824,11 +851,23 @@ static void sdhci_set_transfer_mode(struct sdhc=
i_host *host,
>
> =A0 =A0 =A0 =A0mode =3D SDHCI_TRNS_BLK_CNT_EN;
> =A0 =A0 =A0 =A0if (data->blocks > 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sdhci_host_auto_cmd23_supported(hos=
t, host->mrq)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Host Controller v3=
=2E00 can automatically send CMD23
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* before CMD18 or CM=
D25. For that, we need to enable
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Auto CMD23 in the =
Transfer Mode register and
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* program the block =
count in Argument 2 register.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D SDHCI_TRNS_AU=
TO_CMD23;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writel(host, data=
->blocks, SDHCI_ARGUMENT2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->quirks & SDHCI_QUIRK_MULTIBL=
OCK_READ_ACMD12)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mode |=3D SDHCI_TRNS_M=
ULTI | SDHCI_TRNS_ACMD12;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mode |=3D SDHCI_TRNS_M=
ULTI;
> =A0 =A0 =A0 =A0}
> +
> =A0 =A0 =A0 =A0if (data->flags & MMC_DATA_READ)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mode |=3D SDHCI_TRNS_READ;
> =A0 =A0 =A0 =A0if (host->flags & SDHCI_REQ_USE_DMA)
> @@ -1131,6 +1170,23 @@ static void sdhci_request(struct mmc_host *mmc=
, struct mmc_request *mrq)
> =A0#ifndef SDHCI_USE_LEDS_CLASS
> =A0 =A0 =A0 =A0sdhci_activate_led(host);
> =A0#endif
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Since the block count for CMD23 has already been s=
pecified in the
> + =A0 =A0 =A0 =A0* Argument 2 register, we don't need CMD12 to stop m=
ultiple block
> + =A0 =A0 =A0 =A0* transfers.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (sdhci_host_auto_cmd23_supported(host, mrq)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mrq->stop) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Save the stop comm=
and here to be used during
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* error recovery
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abort_cmd =3D mrq->data=
->stop;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mrq->data->stop =3D NUL=
L;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mrq->stop =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mrq->stop) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mrq->data->stop =3D NU=
LL;
> @@ -1396,6 +1452,7 @@ static void sdhci_timeout_timer(unsigned long d=
ata)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->data) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->data->error =3D =
-ETIMEDOUT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->data->stop =3D ab=
ort_cmd;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_finish_data(host=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->cmd)
> @@ -1534,9 +1591,10 @@ static void sdhci_data_irq(struct sdhci_host *=
host, u32 intmask)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->data->error =3D -EIO;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (host->data->error)
> + =A0 =A0 =A0 if (host->data->error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->data->stop =3D abort_cmd;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_finish_data(host);
> - =A0 =A0 =A0 else {
> + =A0 =A0 =A0 } else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (intmask & (SDHCI_INT_DATA_AVAIL | =
SDHCI_INT_SPACE_AVAIL))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_transfer_pio(hos=
t);
>
> @@ -1783,8 +1841,10 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->flags &=3D ~SDHCI_USE_SDMA;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if ((host->version >=3D SDHCI_SPEC_200) && (caps & SDHC=
I_CAN_DO_ADMA2))
> + =A0 =A0 =A0 if ((host->version >=3D SDHCI_SPEC_200) && (caps & SDHC=
I_CAN_DO_ADMA2)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->flags &=3D ~SDHCI_USE_SDMA;

Here may have issue if controller use only support SDMA with
SDHCI_QUIRK_BROKEN_ADMA.
After this, both SDHCI_USE_SDMA and SDHCI_USE_ADMA are cleared.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->flags |=3D SDHCI_USE_ADMA;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if ((host->quirks & SDHCI_QUIRK_BROKEN_ADMA) &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(host->flags & SDHCI_USE_ADMA)) {

> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 6e0969e..223762c 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -25,6 +25,7 @@
> =A0*/
>
> =A0#define SDHCI_DMA_ADDRESS =A0 =A0 =A00x00
> +#define SDHCI_ARGUMENT2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SDHCI_DMA_ADD=
RESS
>
> =A0#define SDHCI_BLOCK_SIZE =A0 =A0 =A0 0x04
> =A0#define =A0SDHCI_MAKE_BLKSZ(dma, blksz) (((dma & 0x7) << 12) | (bl=
ksz & 0xFFF))
> @@ -37,6 +38,7 @@
> =A0#define =A0SDHCI_TRNS_DMA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x01
> =A0#define =A0SDHCI_TRNS_BLK_CNT_EN 0x02
> =A0#define =A0SDHCI_TRNS_ACMD12 =A0 =A0 0x04
> +#define =A0SDHCI_TRNS_AUTO_CMD23 0x08
> =A0#define =A0SDHCI_TRNS_READ =A0 =A0 =A0 0x10
> =A0#define =A0SDHCI_TRNS_MULTI =A0 =A0 =A00x20
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 8ce0827..22b0335 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -58,9 +58,13 @@ struct mmc_ext_csd {
>
> =A0struct sd_scr {
> =A0 =A0 =A0 =A0unsigned char =A0 =A0 =A0 =A0 =A0 sda_vsn;
> + =A0 =A0 =A0 unsigned char =A0 =A0 =A0 =A0 =A0 sda_spec3;
> =A0 =A0 =A0 =A0unsigned char =A0 =A0 =A0 =A0 =A0 bus_widths;
> =A0#define SD_SCR_BUS_WIDTH_1 =A0 =A0 (1<<0)
> =A0#define SD_SCR_BUS_WIDTH_4 =A0 =A0 (1<<2)
> + =A0 =A0 =A0 unsigned char =A0 =A0 =A0 =A0 =A0 cmd_support;
> +#define SD_SCR_CMD20_SUPPORT =A0 (1<<0)
> +#define SD_SCR_CMD23_SUPPORT =A0 (1<<1)
> =A0};
>
> =A0struct sd_ssr {
> diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
> index 3fd85e0..178363b 100644
> --- a/include/linux/mmc/sd.h
> +++ b/include/linux/mmc/sd.h
> @@ -59,7 +59,7 @@
>
> =A0#define SCR_SPEC_VER_0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 /* Implements=
 system specification 1.0 - 1.01 */
> =A0#define SCR_SPEC_VER_1 =A0 =A0 =A0 =A0 1 =A0 =A0 =A0 /* Implements=
 system specification 1.10 */
> -#define SCR_SPEC_VER_2 =A0 =A0 =A0 =A0 2 =A0 =A0 =A0 /* Implements s=
ystem specification 2.00 */
> +#define SCR_SPEC_VER_2 =A0 =A0 =A0 =A0 2 =A0 =A0 =A0 /* Implements s=
ystem specification 2.00 - 3.0x */
>
> =A0/*
> =A0* SD bus widths
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
