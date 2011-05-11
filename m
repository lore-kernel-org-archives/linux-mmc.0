From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v4 13/15] mmc eMMC signal voltage does not use CMD11
Date: Wed, 11 May 2011 05:19:13 -0400
Message-ID: <BANLkTikpBMhTjxkuua9LV6tFvKp-4vuyvg@mail.gmail.com>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
	<1304578151-1775-14-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:63551 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756621Ab1EKQZG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 May 2011 12:25:06 -0400
Received: by vxi39 with SMTP id 39so470994vxi.19
        for <linux-mmc@vger.kernel.org>; Wed, 11 May 2011 09:25:05 -0700 (PDT)
In-Reply-To: <1304578151-1775-14-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: cjb@laptop.org, prakity@marvell.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

On Thu, May 5, 2011 at 2:49 AM, Arindam Nath <arindam.nath@amd.com> wro=
te:
> eMMC chips do not use CMD11 when changing voltage. =A0Add extra
> argument to call to indicate if CMD11 needs to be sent.

mmc_set_signal_voltage or start_signal_voltage_switch may not support
emmc, not only cmd11, but also start_signal_voltage_switch is wrote
according to sd phys spec.
JESD84-A441 A8.1 describes how to support dual voltage of emmc,
however it only support to 1.8v.
Still not find emmc card which could support 1.2v.

>
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> Reviewed-by: Arindam Nath <arindam.nath@amd.com>
> ---
> =A0drivers/mmc/core/core.c | =A0 =A04 ++--
> =A0drivers/mmc/core/core.h | =A0 =A03 ++-
> =A0drivers/mmc/core/sd.c =A0 | =A0 =A04 ++--
> =A03 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 78a9b51..74b4409 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -942,7 +942,7 @@ u32 mmc_select_voltage(struct mmc_host *host, u32=
 ocr)
> =A0 =A0 =A0 =A0return ocr;
> =A0}
>
> -int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage=
)
> +int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage=
, int cmd11)
> =A0{
> =A0 =A0 =A0 =A0struct mmc_command cmd;
> =A0 =A0 =A0 =A0int err =3D 0;
> @@ -953,7 +953,7 @@ int mmc_set_signal_voltage(struct mmc_host *host,=
 int signal_voltage)
> =A0 =A0 =A0 =A0 * Send CMD11 only if the request is to switch the car=
d to
> =A0 =A0 =A0 =A0 * 1.8V signalling.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (signal_voltage =3D=3D MMC_SIGNAL_VOLTAGE_180) {
> + =A0 =A0 =A0 if ((signal_voltage !=3D MMC_SIGNAL_VOLTAGE_330) && cmd=
11) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memset(&cmd, 0, sizeof(struct mmc_comm=
and));
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmd.opcode =3D SD_SWITCH_VOLTAGE;
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 93f3397..3c11e17 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -41,7 +41,8 @@ void mmc_set_bus_width(struct mmc_host *host, unsig=
ned int width);
> =A0void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int wid=
th,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int ddr)=
;
> =A0u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
> -int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage=
);
> +int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int cmd11);
> =A0void mmc_set_timing(struct mmc_host *host, unsigned int timing);
> =A0void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_t=
ype);
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 851c8fc..d2a05ab 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -731,7 +731,7 @@ try_again:
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (!mmc_host_is_spi(host) && rocr &&
> =A0 =A0 =A0 =A0 =A0 ((*rocr & 0x41000000) =3D=3D 0x41000000)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_set_signal_voltage(host, MM=
C_SIGNAL_VOLTAGE_180);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_set_signal_voltage(host, MM=
C_SIGNAL_VOLTAGE_180, 1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ocr &=3D ~SD_OCR_S18R;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto try_again;
> @@ -1104,7 +1104,7 @@ int mmc_attach_sd(struct mmc_host *host)
> =A0 =A0 =A0 =A0WARN_ON(!host->claimed);
>
> =A0 =A0 =A0 =A0/* Make sure we are at 3.3V signalling voltage */
> - =A0 =A0 =A0 err =3D mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE=
_330);
> + =A0 =A0 =A0 err =3D mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE=
_330, 0);
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
>
> --
> 1.7.1
>
>
