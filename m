From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v4 01/15] mmc: sd: add support for signal voltage switch procedure
Date: Fri, 6 May 2011 06:36:05 -0400
Message-ID: <BANLkTik8yWFUPsOV=oJYh23Bo44FhS_1sg@mail.gmail.com>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
	<1304578151-1775-2-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:38389 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab1EFKgH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 May 2011 06:36:07 -0400
Received: by vxi39 with SMTP id 39so3289229vxi.19
        for <linux-mmc@vger.kernel.org>; Fri, 06 May 2011 03:36:05 -0700 (PDT)
In-Reply-To: <1304578151-1775-2-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: cjb@laptop.org, prakity@marvell.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

On Thu, May 5, 2011 at 2:48 AM, Arindam Nath <arindam.nath@amd.com> wro=
te:
> Host Controller v3.00 adds another Capabilities register. Apart
> from other things, this new register indicates whether the Host
> Controller supports SDR50, SDR104, and DDR50 UHS-I modes. The spec
> doesn't mention about explicit support for SDR12 and SDR25 UHS-I
> modes, so the Host Controller v3.00 should support them by default.
> Also if the controller supports SDR104 mode, it will also support
> SDR50 mode as well. So depending on the host support, we set the
> corresponding MMC_CAP_* flags. One more new register. Host Control2
> is added in v3.00, which is used during Signal Voltage Switch
> procedure described below.
>
> Since as per v3.00 spec, UHS-I supported hosts should set S18R
> to 1, we set S18R (bit 24) of OCR before sending ACMD41. We also
> need to set XPC (bit 28) of OCR in case the host can supply >150mA.
> This support is indicated by the Maximum Current Capabilities
> register of the Host Controller.
>
> If the response of ACMD41 has both CCS and S18A set, we start the
> signal voltage switch procedure, which if successfull, will switch
> the card from 3.3V signalling to 1.8V signalling. Signal voltage
> switch procedure adds support for a new command CMD11 in the
> Physical Layer Spec v3.01. As part of this procedure, we need to
> set 1.8V Signalling Enable (bit 3) of Host Control2 register, which
> if remains set after 5ms, means the switch to 1.8V signalling is
> successfull. Otherwise, we clear bit 24 of OCR and retry the
> initialization sequence. When we remove the card, and insert the
> same or another card, we need to make sure that we start with 3.3V
> signalling voltage. So we call mmc_set_signal_voltage() with
> MMC_SIGNAL_VOLTAGE_330 set so that we are back to 3.3V signalling
> voltage before we actually start initializing the card.
>
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> Reviewed-by: Philip Rakity <prakity@marvell.com>
> Tested-by: Philip Rakity <prakity@marvell.com>

Acked-by: Zhangfei Gao<zhangfei.gao@marvell.com>
Verified with Toshiba uhs card and general hs card,   on mmp2 in SDMA m=
ode.

> ---
> =A0drivers/mmc/core/core.c =A0| =A0 34 ++++++++
> =A0drivers/mmc/core/core.h =A0| =A0 =A01 +
> =A0drivers/mmc/core/sd.c =A0 =A0| =A0 36 ++++++++-
> =A0drivers/mmc/host/sdhci.c | =A0193 ++++++++++++++++++++++++++++++++=
++++++++++---
> =A0drivers/mmc/host/sdhci.h | =A0 18 ++++-
> =A0include/linux/mmc/host.h | =A0 15 ++++
> =A0include/linux/mmc/sd.h =A0 | =A0 =A07 ++
> =A07 files changed, 287 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 1dbc185..ea5c28d 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -942,6 +942,40 @@ u32 mmc_select_voltage(struct mmc_host *host, u3=
2 ocr)
> =A0 =A0 =A0 =A0return ocr;
> =A0}
>
> +int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage=
)
> +{
> + =A0 =A0 =A0 struct mmc_command cmd;
> + =A0 =A0 =A0 int err =3D 0;
> +
> + =A0 =A0 =A0 BUG_ON(!host);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Send CMD11 only if the request is to switch the ca=
rd to
> + =A0 =A0 =A0 =A0* 1.8V signalling.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (signal_voltage =3D=3D MMC_SIGNAL_VOLTAGE_180) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memset(&cmd, 0, sizeof(struct mmc_comma=
nd));
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.opcode =3D SD_SWITCH_VOLTAGE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.arg =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_wait_for_cmd(host, &cmd, 0)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!mmc_host_is_spi(host) && (cmd.resp=
[0] & R1_ERROR))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 host->ios.signal_voltage =3D signal_voltage;
> +
> + =A0 =A0 =A0 if (host->ops->start_signal_voltage_switch)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D host->ops->start_signal_voltage=
_switch(host, &host->ios);
> +
> + =A0 =A0 =A0 return err;
> +}
> +
> =A0/*
> =A0* Select timing parameters for host.
> =A0*/
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index ca1fdde..7745dea 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -41,6 +41,7 @@ void mmc_set_bus_width(struct mmc_host *host, unsig=
ned int width);
> =A0void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int wid=
th,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int ddr)=
;
> =A0u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
> +int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage=
);
> =A0void mmc_set_timing(struct mmc_host *host, unsigned int timing);
>
> =A0static inline void mmc_delay(unsigned int ms)
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 6dac89f..b0cd285 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -403,6 +403,7 @@ struct device_type sd_type =3D {
> =A0int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid)
> =A0{
> =A0 =A0 =A0 =A0int err;
> + =A0 =A0 =A0 u32 rocr;
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Since we're changing the OCR value, we seem to
> @@ -420,12 +421,38 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 o=
cr, u32 *cid)
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0err =3D mmc_send_if_cond(host, ocr);
> =A0 =A0 =A0 =A0if (!err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ocr |=3D 1 << 30;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ocr |=3D SD_OCR_CCS;
>
> - =A0 =A0 =A0 err =3D mmc_send_app_op_cond(host, ocr, NULL);
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If the host supports one of UHS-I modes, request t=
he card
> + =A0 =A0 =A0 =A0* to switch to 1.8V signaling level.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (host->caps & (MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25=
 |
> + =A0 =A0 =A0 =A0 =A0 MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 | MMC_CA=
P_UHS_DDR50))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ocr |=3D SD_OCR_S18R;
> +
> + =A0 =A0 =A0 /* If the host can supply more than 150mA, XPC should b=
e set to 1. */
> + =A0 =A0 =A0 if (host->caps & (MMC_CAP_SET_XPC_330 | MMC_CAP_SET_XPC=
_300 |
> + =A0 =A0 =A0 =A0 =A0 MMC_CAP_SET_XPC_180))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ocr |=3D SD_OCR_XPC;
> +
> +try_again:
> + =A0 =A0 =A0 err =3D mmc_send_app_op_cond(host, ocr, &rocr);
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* In case CCS and S18A in the response is set, start=
 Signal Voltage
> + =A0 =A0 =A0 =A0* Switch procedure. SPI mode doesn't support CMD11.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (!mmc_host_is_spi(host) && ((rocr & 0x41000000) =3D=3D=
 0x41000000)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_set_signal_voltage(host, MM=
C_SIGNAL_VOLTAGE_180);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ocr &=3D ~SD_OCR_S18R;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto try_again;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (mmc_host_is_spi(host))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_send_cid(host, cid);
> =A0 =A0 =A0 =A0else
> @@ -773,6 +800,11 @@ int mmc_attach_sd(struct mmc_host *host)
> =A0 =A0 =A0 =A0BUG_ON(!host);
> =A0 =A0 =A0 =A0WARN_ON(!host->claimed);
>
> + =A0 =A0 =A0 /* Make sure we are at 3.3V signalling voltage */
> + =A0 =A0 =A0 err =3D mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE=
_330);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> +
> =A0 =A0 =A0 =A0err =3D mmc_send_app_op_cond(host, 0, &ocr);
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index e5cfe70..52faa50 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -83,6 +83,8 @@ static void sdhci_dumpregs(struct sdhci_host *host)
> =A0 =A0 =A0 =A0printk(KERN_DEBUG DRIVER_NAME ": Cmd: =A0 =A0 =A00x%08=
x | Max curr: 0x%08x\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_readw(host, SDHCI_COMMAND),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_readl(host, SDHCI_MAX_CURRENT));
> + =A0 =A0 =A0 printk(KERN_DEBUG DRIVER_NAME ": Host ctl2: 0x%08x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_readw(host, SDHCI_HOST_CONTROL2))=
;
>
> =A0 =A0 =A0 =A0if (host->flags & SDHCI_USE_ADMA)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_DEBUG DRIVER_NAME ": ADMA =
Err: 0x%08x | ADMA Ptr: 0x%08x\n",
> @@ -1323,11 +1325,115 @@ out:
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&host->lock, flags);
> =A0}
>
> +static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> + =A0 =A0 =A0 struct mmc_ios *ios)
> +{
> + =A0 =A0 =A0 struct sdhci_host *host;
> + =A0 =A0 =A0 u8 pwr;
> + =A0 =A0 =A0 u16 clk, ctrl;
> + =A0 =A0 =A0 u32 present_state;
> +
> + =A0 =A0 =A0 host =3D mmc_priv(mmc);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Signal Voltage Switching is only applicable for Ho=
st Controllers
> + =A0 =A0 =A0 =A0* v3.00 and above.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (host->version < SDHCI_SPEC_300)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* We first check whether the request is to set signa=
lling voltage
> + =A0 =A0 =A0 =A0* to 3.3V. If so, we change the voltage to 3.3V and =
return quickly.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 ctrl =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
> + =A0 =A0 =A0 if (ios->signal_voltage =3D=3D MMC_SIGNAL_VOLTAGE_330) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set 1.8V Signal Enable in the Host C=
ontrol2 register to 0 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~SDHCI_CTRL_VDD_180;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, ctrl, SDHCI_HOST_CON=
TROL2);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Wait for 5ms */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usleep_range(5000, 5500);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* 3.3V regulator output should be stab=
le within 5 ms */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =3D sdhci_readw(host, SDHCI_HOST_C=
ONTROL2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(ctrl & SDHCI_CTRL_VDD_180))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO DRIVER=
_NAME ": Switching to 3.3V "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "signal=
ling voltage failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 } else if (!(ctrl & SDHCI_CTRL_VDD_180) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ios->signal_voltage =3D=3D MMC_SIG=
NAL_VOLTAGE_180)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Stop SDCLK */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk =3D sdhci_readw(host, SDHCI_CLOCK_C=
ONTROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk &=3D ~SDHCI_CLOCK_CARD_EN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, clk, SDHCI_CLOCK_CON=
TROL);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Check whether DAT[3:0] is 0000 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 present_state =3D sdhci_readl(host, SDH=
CI_PRESENT_STATE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!((present_state & SDHCI_DATA_LVL_M=
ASK) >>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SDHCI_DATA_LVL_SHIFT)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Enable 1.8V Signal=
 Enable in the Host Control2
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* register
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_VD=
D_180;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, ctrl=
, SDHCI_HOST_CONTROL2);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Wait for 5ms */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usleep_range(5000, 5500=
);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =3D sdhci_readw(ho=
st, SDHCI_HOST_CONTROL2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ctrl & SDHCI_CTRL_V=
DD_180) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Prov=
ide SDCLK again and wait for 1ms*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk =3D=
 sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk |=3D=
 SDHCI_CLOCK_CARD_EN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_w=
ritew(host, clk, SDHCI_CLOCK_CONTROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usleep_=
range(1000, 1500);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If=
 DAT[3:0] level is 1111b, then the card
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* wa=
s successfully switched to 1.8V signaling.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 present=
_state =3D sdhci_readl(host,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_PRESENT_STATE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((pr=
esent_state & SDHCI_DATA_LVL_MASK) =3D=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0SDHCI_DATA_LVL_MASK) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If we are here, that means the swi=
tch to 1.8V signaling
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* failed. We power cycle the card, a=
nd retry initialization
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* sequence by setting S18R to 0.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwr =3D sdhci_readb(host, SDHCI_POWER_C=
ONTROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwr &=3D ~SDHCI_POWER_ON;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writeb(host, pwr, SDHCI_POWER_CON=
TROL);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Wait for 1ms as per the spec */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usleep_range(1000, 1500);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwr |=3D SDHCI_POWER_ON;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writeb(host, pwr, SDHCI_POWER_CON=
TROL);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO DRIVER_NAME ": Switchi=
ng to 1.8V signalling "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "voltage failed, retryi=
ng with S18R set to 0\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EAGAIN;
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* No signal voltage switch required */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +}
> +
> =A0static const struct mmc_host_ops sdhci_ops =3D {
> =A0 =A0 =A0 =A0.request =A0 =A0 =A0 =A0=3D sdhci_request,
> =A0 =A0 =A0 =A0.set_ios =A0 =A0 =A0 =A0=3D sdhci_set_ios,
> =A0 =A0 =A0 =A0.get_ro =A0 =A0 =A0 =A0 =3D sdhci_get_ro,
> =A0 =A0 =A0 =A0.enable_sdio_irq =3D sdhci_enable_sdio_irq,
> + =A0 =A0 =A0 .start_signal_voltage_switch =A0 =A0=3D sdhci_start_sig=
nal_voltage_switch,
> =A0};
>
> =A0/*****************************************************************=
************\
> @@ -1808,7 +1914,9 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
> =A0int sdhci_add_host(struct sdhci_host *host)
> =A0{
> =A0 =A0 =A0 =A0struct mmc_host *mmc;
> - =A0 =A0 =A0 unsigned int caps, ocr_avail;
> + =A0 =A0 =A0 u32 caps[2];
> + =A0 =A0 =A0 u32 max_current_caps;
> + =A0 =A0 =A0 unsigned int ocr_avail;
> =A0 =A0 =A0 =A0int ret;
>
> =A0 =A0 =A0 =A0WARN_ON(host =3D=3D NULL);
> @@ -1831,12 +1939,15 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->version);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 caps =3D (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? ho=
st->caps :
> + =A0 =A0 =A0 caps[0] =3D (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ?=
 host->caps :
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_readl(host, SDHCI_CAPABILITIES);
>
> + =A0 =A0 =A0 caps[1] =3D (host->version >=3D SDHCI_SPEC_300) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_readl(host, SDHCI_CAPABILITIES_1)=
 : 0;
> +
> =A0 =A0 =A0 =A0if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->flags |=3D SDHCI_USE_SDMA;
> - =A0 =A0 =A0 else if (!(caps & SDHCI_CAN_DO_SDMA))
> + =A0 =A0 =A0 else if (!(caps[0] & SDHCI_CAN_DO_SDMA))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DBG("Controller doesn't have SDMA capa=
bility\n");
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->flags |=3D SDHCI_USE_SDMA;
> @@ -1847,7 +1958,8 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->flags &=3D ~SDHCI_USE_SDMA;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if ((host->version >=3D SDHCI_SPEC_200) && (caps & SDHC=
I_CAN_DO_ADMA2))
> + =A0 =A0 =A0 if ((host->version >=3D SDHCI_SPEC_200) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (caps[0] & SDHCI_CAN_DO_ADMA2))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->flags |=3D SDHCI_USE_ADMA;
>
> =A0 =A0 =A0 =A0if ((host->quirks & SDHCI_QUIRK_BROKEN_ADMA) &&
> @@ -1897,10 +2009,10 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (host->version >=3D SDHCI_SPEC_300)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->max_clk =3D (caps & SDHCI_CLOCK_V=
3_BASE_MASK)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->max_clk =3D (caps[0] & SDHCI_CLOC=
K_V3_BASE_MASK)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0>> SDHCI_CLOCK_BASE_SH=
IFT;
> =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->max_clk =3D (caps & SDHCI_CLOCK_B=
ASE_MASK)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->max_clk =3D (caps[0] & SDHCI_CLOC=
K_BASE_MASK)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0>> SDHCI_CLOCK_BASE_SH=
IFT;
>
> =A0 =A0 =A0 =A0host->max_clk *=3D 1000000;
> @@ -1916,7 +2028,7 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0host->timeout_clk =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (caps & SDHCI_TIMEOUT_CLK_MASK) >> SDHC=
I_TIMEOUT_CLK_SHIFT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (caps[0] & SDHCI_TIMEOUT_CLK_MASK) >> S=
DHCI_TIMEOUT_CLK_SHIFT;
> =A0 =A0 =A0 =A0if (host->timeout_clk =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->ops->get_timeout_clock) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->timeout_clk =3D =
host->ops->get_timeout_clock(host);
> @@ -1928,7 +2040,7 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 if (caps & SDHCI_TIMEOUT_CLK_UNIT)
> + =A0 =A0 =A0 if (caps[0] & SDHCI_TIMEOUT_CLK_UNIT)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->timeout_clk *=3D 1000;
>
> =A0 =A0 =A0 =A0/*
> @@ -1955,21 +2067,76 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_4_BIT_DATA;
>
> - =A0 =A0 =A0 if (caps & SDHCI_CAN_DO_HISPD)
> + =A0 =A0 =A0 if (caps[0] & SDHCI_CAN_DO_HISPD)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_SD_HIGHSPEED | =
MMC_CAP_MMC_HIGHSPEED;
>
> =A0 =A0 =A0 =A0if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)=
 &&
> =A0 =A0 =A0 =A0 =A0 =A0mmc_card_is_removable(mmc))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_NEEDS_POLL;
>
> + =A0 =A0 =A0 /* UHS-I mode(s) supported by the host controller. */
> + =A0 =A0 =A0 if (host->version >=3D SDHCI_SPEC_300)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_UHS_SDR12 | MMC_=
CAP_UHS_SDR25;
> +
> + =A0 =A0 =A0 /* SDR104 supports also implies SDR50 support */
> + =A0 =A0 =A0 if (caps[1] & SDHCI_SUPPORT_SDR104)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_UHS_SDR104 | MMC=
_CAP_UHS_SDR50;
> + =A0 =A0 =A0 else if (caps[1] & SDHCI_SUPPORT_SDR50)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_UHS_SDR50;
> +
> + =A0 =A0 =A0 if (caps[1] & SDHCI_SUPPORT_DDR50)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_UHS_DDR50;
> +
> =A0 =A0 =A0 =A0ocr_avail =3D 0;
> - =A0 =A0 =A0 if (caps & SDHCI_CAN_VDD_330)
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* According to SD Host Controller spec v3.00, if the=
 Host System
> + =A0 =A0 =A0 =A0* can afford more than 150mA, Host Driver should set=
 XPC to 1. Also
> + =A0 =A0 =A0 =A0* the value is meaningful only if Voltage Support in=
 the Capabilities
> + =A0 =A0 =A0 =A0* register is set. The actual current value is 4 tim=
es the register
> + =A0 =A0 =A0 =A0* value.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 max_current_caps =3D sdhci_readl(host, SDHCI_MAX_CURREN=
T);
> +
> + =A0 =A0 =A0 if (caps[0] & SDHCI_CAN_VDD_330) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int max_current_330;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ocr_avail |=3D MMC_VDD_32_33 | MMC_VDD=
_33_34;
> - =A0 =A0 =A0 if (caps & SDHCI_CAN_VDD_300)
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_current_330 =3D ((max_current_caps =
&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
SDHCI_MAX_CURRENT_330_MASK) >>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
SDHCI_MAX_CURRENT_330_SHIFT) *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
SDHCI_MAX_CURRENT_MULTIPLIER;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (max_current_330 > 150)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_=
SET_XPC_330;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (caps[0] & SDHCI_CAN_VDD_300) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int max_current_300;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ocr_avail |=3D MMC_VDD_29_30 | MMC_VDD=
_30_31;
> - =A0 =A0 =A0 if (caps & SDHCI_CAN_VDD_180)
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_current_300 =3D ((max_current_caps =
&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
SDHCI_MAX_CURRENT_300_MASK) >>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
SDHCI_MAX_CURRENT_300_SHIFT) *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
SDHCI_MAX_CURRENT_MULTIPLIER;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (max_current_300 > 150)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_=
SET_XPC_300;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (caps[0] & SDHCI_CAN_VDD_180) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int max_current_180;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ocr_avail |=3D MMC_VDD_165_195;
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_current_180 =3D ((max_current_caps =
&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
SDHCI_MAX_CURRENT_180_MASK) >>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
SDHCI_MAX_CURRENT_180_SHIFT) *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
SDHCI_MAX_CURRENT_MULTIPLIER;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (max_current_180 > 150)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_=
SET_XPC_180;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0mmc->ocr_avail =3D ocr_avail;
> =A0 =A0 =A0 =A0mmc->ocr_avail_sdio =3D ocr_avail;
> =A0 =A0 =A0 =A0if (host->ocr_avail_sdio)
> @@ -2029,7 +2196,7 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0if (host->quirks & SDHCI_QUIRK_FORCE_BLK_SZ_2048) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->max_blk_size =3D 2;
> =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_blk_size =3D (caps & SDHCI_MAX=
_BLOCK_MASK) >>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_blk_size =3D (caps[0] & SDHCI_=
MAX_BLOCK_MASK) >>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SDHCI_=
MAX_BLOCK_SHIFT;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mmc->max_blk_size >=3D 3) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_WARNING "%=
s: Invalid maximum block size, "
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index c6e25a7..5cba2fe 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -68,6 +68,8 @@
> =A0#define =A0SDHCI_DATA_AVAILABLE =A00x00000800
> =A0#define =A0SDHCI_CARD_PRESENT =A0 =A00x00010000
> =A0#define =A0SDHCI_WRITE_PROTECT =A0 0x00080000
> +#define =A0SDHCI_DATA_LVL_MASK =A0 0x00F00000
> +#define =A0 SDHCI_DATA_LVL_SHIFT 20
>
> =A0#define SDHCI_HOST_CONTROL =A0 =A0 0x28
> =A0#define =A0SDHCI_CTRL_LED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x01
> @@ -146,7 +148,8 @@
>
> =A0#define SDHCI_ACMD12_ERR =A0 =A0 =A0 0x3C
>
> -/* 3E-3F reserved */
> +#define SDHCI_HOST_CONTROL2 =A0 =A0 =A0 =A0 =A0 =A00x3E
> +#define =A0SDHCI_CTRL_VDD_180 =A0 =A0 =A0 =A0 =A0 =A00x0008
>
> =A0#define SDHCI_CAPABILITIES =A0 =A0 0x40
> =A0#define =A0SDHCI_TIMEOUT_CLK_MASK =A0 =A0 =A0 =A00x0000003F
> @@ -167,9 +170,20 @@
> =A0#define =A0SDHCI_CAN_VDD_180 =A0 =A0 0x04000000
> =A0#define =A0SDHCI_CAN_64BIT =A0 =A0 =A0 0x10000000
>
> +#define =A0SDHCI_SUPPORT_SDR50 =A0 0x00000001
> +#define =A0SDHCI_SUPPORT_SDR104 =A00x00000002
> +#define =A0SDHCI_SUPPORT_DDR50 =A0 0x00000004
> +
> =A0#define SDHCI_CAPABILITIES_1 =A0 0x44
>
> -#define SDHCI_MAX_CURRENT =A0 =A0 =A00x48
> +#define SDHCI_MAX_CURRENT =A0 =A0 =A0 =A0 =A0 =A0 =A00x48
> +#define =A0SDHCI_MAX_CURRENT_330_MASK =A0 =A00x0000FF
> +#define =A0SDHCI_MAX_CURRENT_330_SHIFT =A0 0
> +#define =A0SDHCI_MAX_CURRENT_300_MASK =A0 =A00x00FF00
> +#define =A0SDHCI_MAX_CURRENT_300_SHIFT =A0 8
> +#define =A0SDHCI_MAX_CURRENT_180_MASK =A0 =A00xFF0000
> +#define =A0SDHCI_MAX_CURRENT_180_SHIFT =A0 16
> +#define =A0 SDHCI_MAX_CURRENT_MULTIPLIER 4
>
> =A0/* 4C-4F reserved for more max current */
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 0fffa5c..bde5a0b 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -56,6 +56,11 @@ struct mmc_ios {
> =A0#define MMC_SDR_MODE =A0 =A0 =A0 =A0 =A0 0
> =A0#define MMC_1_2V_DDR_MODE =A0 =A0 =A01
> =A0#define MMC_1_8V_DDR_MODE =A0 =A0 =A02
> +
> + =A0 =A0 =A0 unsigned char =A0 signal_voltage; =A0 =A0 =A0 =A0 /* si=
gnalling voltage (1.8V or 3.3V) */
> +
> +#define MMC_SIGNAL_VOLTAGE_330 0
> +#define MMC_SIGNAL_VOLTAGE_180 1
> =A0};
>
> =A0struct mmc_host_ops {
> @@ -117,6 +122,8 @@ struct mmc_host_ops {
>
> =A0 =A0 =A0 =A0/* optional callback for HC quirks */
> =A0 =A0 =A0 =A0void =A0 =A0(*init_card)(struct mmc_host *host, struct=
 mmc_card *card);
> +
> + =A0 =A0 =A0 int =A0 =A0 (*start_signal_voltage_switch)(struct mmc_h=
ost *host, struct mmc_ios *ios);
> =A0};
>
> =A0struct mmc_card;
> @@ -173,6 +180,14 @@ struct mmc_host {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0/* DDR mode at 1.2V */
> =A0#define MMC_CAP_POWER_OFF_CARD (1 << 13) =A0 =A0 =A0 /* Can power =
off after boot */
> =A0#define MMC_CAP_BUS_WIDTH_TEST (1 << 14) =A0 =A0 =A0 /* CMD14/CMD1=
9 bus width ok */
> +#define MMC_CAP_UHS_SDR12 =A0 =A0 =A0(1 << 15) =A0 =A0 =A0 /* Host s=
upports UHS SDR12 mode */
> +#define MMC_CAP_UHS_SDR25 =A0 =A0 =A0(1 << 16) =A0 =A0 =A0 /* Host s=
upports UHS SDR25 mode */
> +#define MMC_CAP_UHS_SDR50 =A0 =A0 =A0(1 << 17) =A0 =A0 =A0 /* Host s=
upports UHS SDR50 mode */
> +#define MMC_CAP_UHS_SDR104 =A0 =A0 (1 << 18) =A0 =A0 =A0 /* Host sup=
ports UHS SDR104 mode */
> +#define MMC_CAP_UHS_DDR50 =A0 =A0 =A0(1 << 19) =A0 =A0 =A0 /* Host s=
upports UHS DDR50 mode */
> +#define MMC_CAP_SET_XPC_330 =A0 =A0(1 << 20) =A0 =A0 =A0 /* Host sup=
ports >150mA current at 3.3V */
> +#define MMC_CAP_SET_XPC_300 =A0 =A0(1 << 21) =A0 =A0 =A0 /* Host sup=
ports >150mA current at 3.0V */
> +#define MMC_CAP_SET_XPC_180 =A0 =A0(1 << 22) =A0 =A0 =A0 /* Host sup=
ports >150mA current at 1.8V */
>
> =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0=
 =A0/* supported pm features */
>
> diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
> index 3fd85e0..c648878 100644
> --- a/include/linux/mmc/sd.h
> +++ b/include/linux/mmc/sd.h
> @@ -17,6 +17,7 @@
> =A0/* This is basically the same command as for MMC with some quirks.=
 */
> =A0#define SD_SEND_RELATIVE_ADDR =A0 =A0 3 =A0 /* bcr =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 R6 =A0*/
> =A0#define SD_SEND_IF_COND =A0 =A0 =A0 =A0 =A0 8 =A0 /* bcr =A0[11:0]=
 See below =A0 R7 =A0*/
> +#define SD_SWITCH_VOLTAGE =A0 =A0 =A0 =A0 11 =A0/* ac =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0R1 =A0*/
>
> =A0 /* class 10 */
> =A0#define SD_SWITCH =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 6 =A0 /* adtc [3=
1:0] See below =A0 R1 =A0*/
> @@ -32,6 +33,12 @@
> =A0#define SD_APP_OP_COND =A0 =A0 =A0 =A0 =A0 41 =A0 /* bcr =A0[31:0]=
 OCR =A0 =A0 =A0 =A0 R3 =A0*/
> =A0#define SD_APP_SEND_SCR =A0 =A0 =A0 =A0 =A051 =A0 /* adtc =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0R1 =A0*/
>
> +/* OCR bit definitions */
> +#define SD_OCR_S18R =A0 =A0 =A0 =A0 =A0 =A0(1 << 24) =A0 =A0/* 1.8V =
switching request */
> +#define SD_ROCR_S18A =A0 =A0 =A0 =A0 =A0 SD_OCR_S18R =A0/* 1.8V swit=
ching accepted by card */
> +#define SD_OCR_XPC =A0 =A0 =A0 =A0 =A0 =A0 (1 << 28) =A0 =A0/* SDXC =
power control */
> +#define SD_OCR_CCS =A0 =A0 =A0 =A0 =A0 =A0 (1 << 30) =A0 =A0/* Card =
Capacity Status */
> +
> =A0/*
> =A0* SD_SWITCH argument format:
> =A0*
> --
> 1.7.1
>
>
