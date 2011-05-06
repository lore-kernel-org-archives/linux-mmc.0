From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v4 03/15] mmc: sd: add support for driver type selection
Date: Fri, 6 May 2011 06:37:42 -0400
Message-ID: <BANLkTik-WnPx-ssEE+aFdBYj86YbBD3Wtw@mail.gmail.com>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
	<1304578151-1775-4-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:58831 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab1EFKhm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 May 2011 06:37:42 -0400
Received: by mail-vx0-f174.google.com with SMTP id 39so3290086vxi.19
        for <linux-mmc@vger.kernel.org>; Fri, 06 May 2011 03:37:42 -0700 (PDT)
In-Reply-To: <1304578151-1775-4-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: cjb@laptop.org, prakity@marvell.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

On Thu, May 5, 2011 at 2:48 AM, Arindam Nath <arindam.nath@amd.com> wro=
te:
> This patch adds support for setting driver strength during UHS-I
> initialization prcedure. Since UHS-I cards set S18A (bit 24) in
> response to ACMD41, we use this as a base for UHS-I initialization.
> We modify the parameter list of mmc_sd_get_cid() so that we can
> save the ROCR from ACMD41 to check whether bit 24 is set.
>
> We decide whether the Host Controller supports A, C, or D driver
> type depending on the Capabilities register. Driver type B is
> suported by default. We then set the appropriate driver type for
> the card using CMD6 mode 1. As per Host Controller spec v3.00, we
> set driver type for the host only if Preset Value Enable in the
> Host Control2 register is not set. SDHCI_HOST_CONTROL has been
> renamed to SDHCI_HOST_CONTROL1 to conform to the spec.
>
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> Reviewed-by: Philip Rakity <prakity@marvell.com>
> Tested-by: Philip Rakity <prakity@marvell.com>

Acked-by: Zhangfei Gao<zhangfei.gao@marvell.com>
Verified with Toshiba uhs card and general hs card,   on mmp2 in SDMA m=
ode.
> ---
> =A0drivers/mmc/core/core.c =A0| =A0 =A09 +++
> =A0drivers/mmc/core/core.h =A0| =A0 =A01 +
> =A0drivers/mmc/core/sd.c =A0 =A0| =A0153 ++++++++++++++++++++++++++++=
++++++++++--------
> =A0drivers/mmc/core/sd.h =A0 =A0| =A0 =A03 +-
> =A0drivers/mmc/core/sdio.c =A0| =A0 =A03 +-
> =A0drivers/mmc/host/sdhci.c | =A0 49 +++++++++++---
> =A0drivers/mmc/host/sdhci.h | =A0 11 +++-
> =A0include/linux/mmc/card.h | =A0 =A04 +
> =A0include/linux/mmc/host.h | =A0 10 +++
> =A09 files changed, 203 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index ea5c28d..78a9b51 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -986,6 +986,15 @@ void mmc_set_timing(struct mmc_host *host, unsig=
ned int timing)
> =A0}
>
> =A0/*
> + * Select appropriate driver type for host.
> + */
> +void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_typ=
e)
> +{
> + =A0 =A0 =A0 host->ios.drv_type =3D drv_type;
> + =A0 =A0 =A0 mmc_set_ios(host);
> +}
> +
> +/*
> =A0* Apply power to the MMC stack. =A0This is a two-stage process.
> =A0* First, we enable power to the card without the clock running.
> =A0* We then wait a bit for the power to stabilise. =A0Finally,
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 7745dea..93f3397 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -43,6 +43,7 @@ void mmc_set_bus_width_ddr(struct mmc_host *host, u=
nsigned int width,
> =A0u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
> =A0int mmc_set_signal_voltage(struct mmc_host *host, int signal_volta=
ge);
> =A0void mmc_set_timing(struct mmc_host *host, unsigned int timing);
> +void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_typ=
e);
>
> =A0static inline void mmc_delay(unsigned int ms)
> =A0{
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index d4410c9..a6fa52f 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -405,6 +405,98 @@ out:
> =A0 =A0 =A0 =A0return err;
> =A0}
>
> +static int sd_select_driver_type(struct mmc_card *card, u8 *status)
> +{
> + =A0 =A0 =A0 int host_drv_type =3D 0, card_drv_type =3D 0;
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If the host doesn't support any of the Driver Type=
s A,C or D,
> + =A0 =A0 =A0 =A0* default Driver Type B is used.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (!(card->host->caps & (MMC_CAP_DRIVER_TYPE_A | MMC_C=
AP_DRIVER_TYPE_C
> + =A0 =A0 =A0 =A0 =A0 | MMC_CAP_DRIVER_TYPE_D)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (card->host->caps & MMC_CAP_DRIVER_TYPE_A) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host_drv_type =3D MMC_SET_DRIVER_TYPE_A=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->sw_caps.sd3_drv_type & SD_DRI=
VER_TYPE_A)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card_drv_type =3D MMC_S=
ET_DRIVER_TYPE_A;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (card->sw_caps.sd3_drv_type & S=
D_DRIVER_TYPE_B)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card_drv_type =3D MMC_S=
ET_DRIVER_TYPE_B;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (card->sw_caps.sd3_drv_type & S=
D_DRIVER_TYPE_C)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card_drv_type =3D MMC_S=
ET_DRIVER_TYPE_C;
> + =A0 =A0 =A0 } else if (card->host->caps & MMC_CAP_DRIVER_TYPE_C) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host_drv_type =3D MMC_SET_DRIVER_TYPE_C=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->sw_caps.sd3_drv_type & SD_DRI=
VER_TYPE_C)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card_drv_type =3D MMC_S=
ET_DRIVER_TYPE_C;
> + =A0 =A0 =A0 } else if (!(card->host->caps & MMC_CAP_DRIVER_TYPE_D))=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If we are here, that means only th=
e default driver type
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* B is supported by the host.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host_drv_type =3D MMC_SET_DRIVER_TYPE_B=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->sw_caps.sd3_drv_type & SD_DRI=
VER_TYPE_B)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card_drv_type =3D MMC_S=
ET_DRIVER_TYPE_B;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (card->sw_caps.sd3_drv_type & S=
D_DRIVER_TYPE_C)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card_drv_type =3D MMC_S=
ET_DRIVER_TYPE_C;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 err =3D mmc_sd_switch(card, 1, 2, card_drv_type, status=
);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> +
> + =A0 =A0 =A0 if ((status[15] & 0xF) !=3D card_drv_type) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s: Problem settin=
g driver strength!\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host=
));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mmc_set_driver_type(card->host, host_drv_type);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/*
> + * UHS-I specific initialization procedure
> + */
> +static int mmc_sd_init_uhs_card(struct mmc_card *card)
> +{
> + =A0 =A0 =A0 int err;
> + =A0 =A0 =A0 u8 *status;
> +
> + =A0 =A0 =A0 if (!card->scr.sda_spec3)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (!(card->csd.cmdclass & CCC_SWITCH))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 status =3D kmalloc(64, GFP_KERNEL);
> + =A0 =A0 =A0 if (!status) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: could not allocate=
 a buffer for "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "switch capabilities.\n=
", mmc_hostname(card->host));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Set 4-bit bus width */
> + =A0 =A0 =A0 if ((card->host->caps & MMC_CAP_4_BIT_DATA) &&
> + =A0 =A0 =A0 =A0 =A0 (card->scr.bus_widths & SD_SCR_BUS_WIDTH_4)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_app_set_bus_width(card, MMC=
_BUS_WIDTH_4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_bus_width(card->host, MMC_BUS_W=
IDTH_4);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Set the driver strength for the card */
> + =A0 =A0 =A0 err =3D sd_select_driver_type(card, status);
> +
> +out:
> + =A0 =A0 =A0 kfree(status);
> +
> + =A0 =A0 =A0 return err;
> +}
> +
> =A0MMC_DEV_ATTR(cid, "%08x%08x%08x%08x\n", card->raw_cid[0], card->ra=
w_cid[1],
> =A0 =A0 =A0 =A0card->raw_cid[2], card->raw_cid[3]);
> =A0MMC_DEV_ATTR(csd, "%08x%08x%08x%08x\n", card->raw_csd[0], card->ra=
w_csd[1],
> @@ -453,10 +545,10 @@ struct device_type sd_type =3D {
> =A0/*
> =A0* Fetch CID from card.
> =A0*/
> -int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid)
> +int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid,
> + =A0 =A0 =A0 u32 *rocr)
> =A0{
> =A0 =A0 =A0 =A0int err;
> - =A0 =A0 =A0 u32 rocr;
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Since we're changing the OCR value, we seem to
> @@ -490,7 +582,7 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr=
, u32 *cid)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ocr |=3D SD_OCR_XPC;
>
> =A0try_again:
> - =A0 =A0 =A0 err =3D mmc_send_app_op_cond(host, ocr, &rocr);
> + =A0 =A0 =A0 err =3D mmc_send_app_op_cond(host, ocr, rocr);
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
>
> @@ -498,7 +590,8 @@ try_again:
> =A0 =A0 =A0 =A0 * In case CCS and S18A in the response is set, start =
Signal Voltage
> =A0 =A0 =A0 =A0 * Switch procedure. SPI mode doesn't support CMD11.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (!mmc_host_is_spi(host) && ((rocr & 0x41000000) =3D=3D=
 0x41000000)) {
> + =A0 =A0 =A0 if (!mmc_host_is_spi(host) && rocr &&
> + =A0 =A0 =A0 =A0 =A0((*rocr & 0x41000000) =3D=3D 0x41000000)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_set_signal_voltage(host, M=
MC_SIGNAL_VOLTAGE_180);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ocr &=3D ~SD_OCR_S18R;
> @@ -633,11 +726,12 @@ static int mmc_sd_init_card(struct mmc_host *ho=
st, u32 ocr,
> =A0 =A0 =A0 =A0struct mmc_card *card;
> =A0 =A0 =A0 =A0int err;
> =A0 =A0 =A0 =A0u32 cid[4];
> + =A0 =A0 =A0 u32 rocr =3D 0;
>
> =A0 =A0 =A0 =A0BUG_ON(!host);
> =A0 =A0 =A0 =A0WARN_ON(!host->claimed);
>
> - =A0 =A0 =A0 err =3D mmc_sd_get_cid(host, ocr, cid);
> + =A0 =A0 =A0 err =3D mmc_sd_get_cid(host, ocr, cid, &rocr);
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
>
> @@ -690,30 +784,37 @@ static int mmc_sd_init_card(struct mmc_host *ho=
st, u32 ocr,
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free_card;
>
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Attempt to change to high-speed (if supported)
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 err =3D mmc_sd_switch_hs(card);
> - =A0 =A0 =A0 if (err > 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_sd_go_highspeed(card);
> - =A0 =A0 =A0 else if (err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_card;
> -
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Set bus speed.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 mmc_set_clock(host, mmc_sd_get_max_clock(card));
> -
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Switch to wider bus (if supported).
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if ((host->caps & MMC_CAP_4_BIT_DATA) &&
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (card->scr.bus_widths & SD_SCR_BUS_WIDT=
H_4)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_app_set_bus_width(card, MMC=
_BUS_WIDTH_4);
> + =A0 =A0 =A0 /* Initialization sequence for UHS-I cards */
> + =A0 =A0 =A0 if (rocr & SD_ROCR_S18A) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_sd_init_uhs_card(card);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free_card;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Attempt to change to high-speed (i=
f supported)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_sd_switch_hs(card);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err > 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_sd_go_highspeed(car=
d);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_card;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Set bus speed.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_clock(host, mmc_sd_get_max_cloc=
k(card));
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_bus_width(host, MMC_BUS_WIDTH_4=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Switch to wider bus (if supported)=
=2E
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((host->caps & MMC_CAP_4_BIT_DATA) &=
&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (card->scr.bus_widths &=
 SD_SCR_BUS_WIDTH_4)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_app_set_bus=
_width(card, MMC_BUS_WIDTH_4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fr=
ee_card;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_bus_width(host,=
 MMC_BUS_WIDTH_4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0host->card =3D card;
> diff --git a/drivers/mmc/core/sd.h b/drivers/mmc/core/sd.h
> index 3d8800f..5106b44 100644
> --- a/drivers/mmc/core/sd.h
> +++ b/drivers/mmc/core/sd.h
> @@ -5,7 +5,8 @@
>
> =A0extern struct device_type sd_type;
>
> -int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid);
> +int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid,
> + =A0 =A0 =A0 u32 *rocr);
> =A0int mmc_sd_get_csd(struct mmc_host *host, struct mmc_card *card);
> =A0void mmc_decode_cid(struct mmc_card *card);
> =A0int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card=
,
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 1e60959..c4a6614 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -370,7 +370,8 @@ static int mmc_sdio_init_card(struct mmc_host *ho=
st, u32 ocr,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (ocr & R4_MEMORY_PRESENT
> - =A0 =A0 =A0 =A0 =A0 && mmc_sd_get_cid(host, host->ocr & ocr, card->=
raw_cid) =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 && mmc_sd_get_cid(host, host->ocr & ocr, card->=
raw_cid,
> + =A0 =A0 =A0 =A0 =A0 NULL) =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->type =3D MMC_TYPE_SD_COMBO;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (oldcard && (oldcard->type !=3D MMC=
_TYPE_SD_COMBO ||
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 52faa50..9f38317 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -61,7 +61,7 @@ static void sdhci_dumpregs(struct sdhci_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_readw(host, SDHCI_TRANSFER_MODE)=
);
> =A0 =A0 =A0 =A0printk(KERN_DEBUG DRIVER_NAME ": Present: =A00x%08x | =
Host ctl: 0x%08x\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_readl(host, SDHCI_PRESENT_STATE)=
,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_readb(host, SDHCI_HOST_CONTROL));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_readb(host, SDHCI_HOST_CONTROL1))=
;
> =A0 =A0 =A0 =A0printk(KERN_DEBUG DRIVER_NAME ": Power: =A0 =A00x%08x =
| Blk gap: =A00x%08x\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_readb(host, SDHCI_POWER_CONTROL)=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_readb(host, SDHCI_BLOCK_GAP_CONT=
ROL));
> @@ -220,18 +220,18 @@ static void sdhci_activate_led(struct sdhci_hos=
t *host)
> =A0{
> =A0 =A0 =A0 =A0u8 ctrl;
>
> - =A0 =A0 =A0 ctrl =3D sdhci_readb(host, SDHCI_HOST_CONTROL);
> + =A0 =A0 =A0 ctrl =3D sdhci_readb(host, SDHCI_HOST_CONTROL1);
> =A0 =A0 =A0 =A0ctrl |=3D SDHCI_CTRL_LED;
> - =A0 =A0 =A0 sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> + =A0 =A0 =A0 sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
> =A0}
>
> =A0static void sdhci_deactivate_led(struct sdhci_host *host)
> =A0{
> =A0 =A0 =A0 =A0u8 ctrl;
>
> - =A0 =A0 =A0 ctrl =3D sdhci_readb(host, SDHCI_HOST_CONTROL);
> + =A0 =A0 =A0 ctrl =3D sdhci_readb(host, SDHCI_HOST_CONTROL1);
> =A0 =A0 =A0 =A0ctrl &=3D ~SDHCI_CTRL_LED;
> - =A0 =A0 =A0 sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> + =A0 =A0 =A0 sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
> =A0}
>
> =A0#ifdef SDHCI_USE_LEDS_CLASS
> @@ -803,14 +803,14 @@ static void sdhci_prepare_data(struct sdhci_hos=
t *host, struct mmc_command *cmd)
> =A0 =A0 =A0 =A0 * is ADMA.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (host->version >=3D SDHCI_SPEC_200) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =3D sdhci_readb(host, SDHCI_HOST_C=
ONTROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =3D sdhci_readb(host, SDHCI_HOST_C=
ONTROL1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl &=3D ~SDHCI_CTRL_DMA_MASK;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((host->flags & SDHCI_REQ_USE_DMA) =
&&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(host->flags & SDHCI_U=
SE_ADMA))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl |=3D SDHCI_CTRL_A=
DMA32;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl |=3D SDHCI_CTRL_S=
DMA;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writeb(host, ctrl, SDHCI_HOST_CON=
TROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writeb(host, ctrl, SDHCI_HOST_CON=
TROL1);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (!(host->flags & SDHCI_REQ_USE_DMA)) {
> @@ -1218,7 +1218,7 @@ static void sdhci_set_ios(struct mmc_host *mmc,=
 struct mmc_ios *ios)
> =A0 =A0 =A0 =A0if (host->ops->platform_8bit_width)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->ops->platform_8bit_width(host, i=
os->bus_width);
> =A0 =A0 =A0 =A0else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =3D sdhci_readb(host, SDHCI_HOST_C=
ONTROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =3D sdhci_readb(host, SDHCI_HOST_C=
ONTROL1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ios->bus_width =3D=3D MMC_BUS_WIDT=
H_8) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl &=3D ~SDHCI_CTRL_=
4BITBUS;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->version >=3D=
 SDHCI_SPEC_300)
> @@ -1231,10 +1231,10 @@ static void sdhci_set_ios(struct mmc_host *mm=
c, struct mmc_ios *ios)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl &=
=3D ~SDHCI_CTRL_4BITBUS;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writeb(host, ctrl, SDHCI_HOST_CON=
TROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writeb(host, ctrl, SDHCI_HOST_CON=
TROL1);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 ctrl =3D sdhci_readb(host, SDHCI_HOST_CONTROL);
> + =A0 =A0 =A0 ctrl =3D sdhci_readb(host, SDHCI_HOST_CONTROL1);
>
> =A0 =A0 =A0 =A0if ((ios->timing =3D=3D MMC_TIMING_SD_HS ||
> =A0 =A0 =A0 =A0 =A0 =A0 ios->timing =3D=3D MMC_TIMING_MMC_HS)
> @@ -1243,7 +1243,26 @@ static void sdhci_set_ios(struct mmc_host *mmc=
, struct mmc_ios *ios)
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl &=3D ~SDHCI_CTRL_HISPD;
>
> - =A0 =A0 =A0 sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> + =A0 =A0 =A0 sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
> +
> + =A0 =A0 =A0 if (host->version >=3D SDHCI_SPEC_300) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 ctrl_2;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 =3D sdhci_readw(host, SDHCI_HOST=
_CONTROL2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(ctrl_2 & SDHCI_CTRL_PRESET_VAL_EN=
ABLE)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We only need to se=
t Driver Strength if the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* preset value enabl=
e is not set.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 &=3D ~SDHCI_CTRL=
_DRV_TYPE_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ios->drv_type =3D=3D=
 MMC_SET_DRIVER_TYPE_A)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 =
|=3D SDHCI_CTRL_DRV_TYPE_A;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (ios->drv_type =
=3D=3D MMC_SET_DRIVER_TYPE_C)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 =
|=3D SDHCI_CTRL_DRV_TYPE_C;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, ctrl=
_2, SDHCI_HOST_CONTROL2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Some (ENE) controllers go apeshit on some ios opera=
tion,
> @@ -2087,6 +2106,14 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0if (caps[1] & SDHCI_SUPPORT_DDR50)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_UHS_DDR50;
>
> + =A0 =A0 =A0 /* Driver Type(s) (A, C, D) supported by the host */
> + =A0 =A0 =A0 if (caps[1] & SDHCI_DRIVER_TYPE_A)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_DRIVER_TYPE_A;
> + =A0 =A0 =A0 if (caps[1] & SDHCI_DRIVER_TYPE_C)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_DRIVER_TYPE_C;
> + =A0 =A0 =A0 if (caps[1] & SDHCI_DRIVER_TYPE_D)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_DRIVER_TYPE_D;
> +
> =A0 =A0 =A0 =A0ocr_avail =3D 0;
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * According to SD Host Controller spec v3.00, if the =
Host System
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 5cba2fe..04c41a4 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -71,7 +71,7 @@
> =A0#define =A0SDHCI_DATA_LVL_MASK =A0 0x00F00000
> =A0#define =A0 SDHCI_DATA_LVL_SHIFT 20
>
> -#define SDHCI_HOST_CONTROL =A0 =A0 0x28
> +#define SDHCI_HOST_CONTROL1 =A0 =A00x28
> =A0#define =A0SDHCI_CTRL_LED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x01
> =A0#define =A0SDHCI_CTRL_4BITBUS =A0 =A00x02
> =A0#define =A0SDHCI_CTRL_HISPD =A0 =A0 =A00x04
> @@ -150,6 +150,12 @@
>
> =A0#define SDHCI_HOST_CONTROL2 =A0 =A0 =A0 =A0 =A0 =A00x3E
> =A0#define =A0SDHCI_CTRL_VDD_180 =A0 =A0 =A0 =A0 =A0 =A00x0008
> +#define =A0SDHCI_CTRL_DRV_TYPE_MASK =A0 =A0 =A00x0030
> +#define =A0 SDHCI_CTRL_DRV_TYPE_B =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0=
000
> +#define =A0 SDHCI_CTRL_DRV_TYPE_A =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0=
010
> +#define =A0 SDHCI_CTRL_DRV_TYPE_C =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0=
020
> +#define =A0 SDHCI_CTRL_DRV_TYPE_D =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0=
030
> +#define =A0SDHCI_CTRL_PRESET_VAL_ENABLE =A00x8000
>
> =A0#define SDHCI_CAPABILITIES =A0 =A0 0x40
> =A0#define =A0SDHCI_TIMEOUT_CLK_MASK =A0 =A0 =A0 =A00x0000003F
> @@ -173,6 +179,9 @@
> =A0#define =A0SDHCI_SUPPORT_SDR50 =A0 0x00000001
> =A0#define =A0SDHCI_SUPPORT_SDR104 =A00x00000002
> =A0#define =A0SDHCI_SUPPORT_DDR50 =A0 0x00000004
> +#define =A0SDHCI_DRIVER_TYPE_A =A0 0x00000010
> +#define =A0SDHCI_DRIVER_TYPE_C =A0 0x00000020
> +#define =A0SDHCI_DRIVER_TYPE_D =A0 0x00000040
>
> =A0#define SDHCI_CAPABILITIES_1 =A0 0x44
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 56f4d92..5393272 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -83,6 +83,10 @@ struct sd_switch_caps {
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0hs_max_dtr;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0sd3_bus_mode;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0sd3_drv_type;
> +#define SD_DRIVER_TYPE_B =A0 =A0 =A0 0x01
> +#define SD_DRIVER_TYPE_A =A0 =A0 =A0 0x02
> +#define SD_DRIVER_TYPE_C =A0 =A0 =A0 0x04
> +#define SD_DRIVER_TYPE_D =A0 =A0 =A0 0x08
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0sd3_curr_limit;
> =A0};
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index bde5a0b..949e4d5 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -61,6 +61,13 @@ struct mmc_ios {
>
> =A0#define MMC_SIGNAL_VOLTAGE_330 0
> =A0#define MMC_SIGNAL_VOLTAGE_180 1
> +
> + =A0 =A0 =A0 unsigned char =A0 drv_type; =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 /* driver type (A, B, C, D) */
> +
> +#define MMC_SET_DRIVER_TYPE_B =A00
> +#define MMC_SET_DRIVER_TYPE_A =A01
> +#define MMC_SET_DRIVER_TYPE_C =A02
> +#define MMC_SET_DRIVER_TYPE_D =A03
> =A0};
>
> =A0struct mmc_host_ops {
> @@ -188,6 +195,9 @@ struct mmc_host {
> =A0#define MMC_CAP_SET_XPC_330 =A0 =A0(1 << 20) =A0 =A0 =A0 /* Host s=
upports >150mA current at 3.3V */
> =A0#define MMC_CAP_SET_XPC_300 =A0 =A0(1 << 21) =A0 =A0 =A0 /* Host s=
upports >150mA current at 3.0V */
> =A0#define MMC_CAP_SET_XPC_180 =A0 =A0(1 << 22) =A0 =A0 =A0 /* Host s=
upports >150mA current at 1.8V */
> +#define MMC_CAP_DRIVER_TYPE_A =A0(1 << 23) =A0 =A0 =A0 /* Host suppo=
rts Driver Type A */
> +#define MMC_CAP_DRIVER_TYPE_C =A0(1 << 24) =A0 =A0 =A0 /* Host suppo=
rts Driver Type C */
> +#define MMC_CAP_DRIVER_TYPE_D =A0(1 << 25) =A0 =A0 =A0 /* Host suppo=
rts Driver Type D */
>
> =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0=
 =A0/* supported pm features */
>
> --
> 1.7.1
>
>
