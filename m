From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v2 02/12] mmc: sd: add support for signal voltage switch procedure
Date: Wed, 9 Mar 2011 07:45:15 -0500
Message-ID: <AANLkTimZ1carhEsaBVFW5862R9GsztYfp2xJi_3n+av=@mail.gmail.com>
References: <1299238369-1768-1-git-send-email-arindam.nath@amd.com>
	<1299238369-1768-3-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36997 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932179Ab1CIMpQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Mar 2011 07:45:16 -0500
Received: by vws12 with SMTP id 12so399379vws.19
        for <linux-mmc@vger.kernel.org>; Wed, 09 Mar 2011 04:45:15 -0800 (PST)
In-Reply-To: <1299238369-1768-3-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: cjb@laptop.org, prakity@marvell.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

On Fri, Mar 4, 2011 at 6:32 AM, Arindam Nath <arindam.nath@amd.com> wro=
te:
> Host Controller v3.00 adds another Capabilities register. Apart
> from other things, this new register indicates whether the Host
> Controller supports SDR50, SDR104, and DDR50 UHS-I modes. The spec
> doesn't mention about explicit support for SDR12 and SDR25 UHS-I
> modes, so the Host Controller v3.00 should support them by default.
> Also if the controller support SDR104 mode, it will also support
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
> initialization sequence.
>
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>

The patch can not work with generic card  :(

> ---
> =A0drivers/mmc/core/sd.c =A0 =A0 | =A0 37 ++++++++++-
> =A0drivers/mmc/core/sd_ops.c | =A0 32 ++++++++++
> =A0drivers/mmc/core/sd_ops.h | =A0 =A01 +
> =A0drivers/mmc/host/sdhci.c =A0| =A0148 +++++++++++++++++++++++++++++=
++++++++++++----
> =A0drivers/mmc/host/sdhci.h =A0| =A0 18 +++++-
> =A0include/linux/mmc/host.h =A0| =A0 10 +++
> =A0include/linux/mmc/sd.h =A0 =A0| =A0 =A01 +
> =A07 files changed, 229 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index b3f8a3c..3e82599 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -408,6 +408,7 @@ struct device_type sd_type =3D {
> =A0int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid)
> =A0{
> =A0 =A0 =A0 =A0int err;
> + =A0 =A0 =A0 u32 rocr;
rocr not initialized here, or move to mmc_sd_init_card in following
patch, it may be risky, since dependency.

>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Since we're changing the OCR value, we seem to
> @@ -427,10 +428,25 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 o=
cr, u32 *cid)
> =A0 =A0 =A0 =A0if (!err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ocr |=3D 1 << 30;
>
> - =A0 =A0 =A0 err =3D mmc_send_app_op_cond(host, ocr, NULL);
> + =A0 =A0 =A0 /* If the host can supply more than 150mA, XPC should b=
e set to 1. */
> + =A0 =A0 =A0 if (host->caps & (MMC_CAP_SET_XPC_330 | MMC_CAP_SET_XPC=
_300 |
> + =A0 =A0 =A0 =A0 =A0 MMC_CAP_SET_XPC_180))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ocr |=3D 1 << 28;
> +
> + =A0 =A0 =A0 err =3D mmc_send_app_op_cond(host, ocr, &rocr);
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* In case CCS and S18A in the response is set, start=
 Signal Voltage
> + =A0 =A0 =A0 =A0* Switch procedure. SPI mode doesn't support CMD11.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (!mmc_host_is_spi(host) && (rocr & 0x41000000)) {

 if (!mmc_host_is_spi(host) && (rocr & 0x41000000 =3D=3D 0x41000000))
Currently your patch can not work with general card, for example
rocr=3D0xc0ff8000 & 0x41000000 =3D 0x40000000, while what you want is b=
oth
two bit are set.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_start_voltage_switch(host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (mmc_host_is_spi(host))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_send_cid(host, cid);
> =A0 =A0 =A0 =A0else
> @@ -827,11 +843,26 @@ int mmc_attach_sd(struct mmc_host *host)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/*
> + =A0 =A0 =A0 =A0* If the host supports one of UHS-I modes, request t=
he card
> + =A0 =A0 =A0 =A0* to switch to 1.8V signaling level.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (host->caps & (MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25=
 |
> + =A0 =A0 =A0 =A0 =A0 MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 | MMC_CA=
P_UHS_DDR50))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ocr |=3D (1 << 24);
> +
> + =A0 =A0 =A0 /*
> =A0 =A0 =A0 =A0 * Detect and init the card.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0err =3D mmc_sd_init_card(host, host->ocr, NULL);
> - =A0 =A0 =A0 if (err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 if (err =3D=3D -EAGAIN) {
If other error happen, for example -ETIMEDOUT in current patch for
general card, the following card can not be executed.
kernel panic will happen in mmc_add_card for null pinter, since card
is not allocated.
how about if (err) for safety?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Retry initialization with S18R set=
 to 0.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ocr &=3D ~(1 << 24);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_sd_init_card(host, host->oc=
r, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0mmc_release_host(host);
> =A0 =A0 =A0 =A0err =3D mmc_add_card(host->card);
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index 797cdb5..8a23e2e 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -146,6 +146,38 @@ int mmc_app_set_bus_width(struct mmc_card *card,=
 int width)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +int mmc_start_voltage_switch(struct mmc_host *host)
> +{
> + =A0 =A0 =A0 struct mmc_command cmd;
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 BUG_ON(!host);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If the host does not provide signal voltage switch=
 procedure, we
> + =A0 =A0 =A0 =A0* set S18R to 0, and then retry initialization seque=
nce.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (!host->ops->start_signal_voltage_switch)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EAGAIN;
> +
> + =A0 =A0 =A0 memset(&cmd, 0, sizeof(struct mmc_command));
> +
> + =A0 =A0 =A0 cmd.opcode =3D SD_SWITCH_VOLTAGE;
> + =A0 =A0 =A0 cmd.arg =3D 0;
> + =A0 =A0 =A0 cmd.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
> +
> + =A0 =A0 =A0 err =3D mmc_wait_for_cmd(host, &cmd, 0);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> +
> + =A0 =A0 =A0 if (!mmc_host_is_spi(host) && (cmd.resp[0] & R1_ERROR))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> +
> + =A0 =A0 =A0 err =3D host->ops->start_signal_voltage_switch(host);
> +
> + =A0 =A0 =A0 return err;
> +}
> +
> =A0int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr=
)
> =A0{
> =A0 =A0 =A0 =A0struct mmc_command cmd;
> diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
> index ffc2305..3cfba59 100644
> --- a/drivers/mmc/core/sd_ops.h
> +++ b/drivers/mmc/core/sd_ops.h
> @@ -20,6 +20,7 @@ int mmc_app_send_scr(struct mmc_card *card, u32 *sc=
r);
> =A0int mmc_sd_switch(struct mmc_card *card, int mode, int group,
> =A0 =A0 =A0 =A0u8 value, u8 *resp);
> =A0int mmc_app_sd_status(struct mmc_card *card, void *ssr);
> +int mmc_start_voltage_switch(struct mmc_host *host);
>
> =A0#endif
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 8914a25..5487a0b 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -85,6 +85,8 @@ static void sdhci_dumpregs(struct sdhci_host *host)
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
> @@ -1337,11 +1339,70 @@ out:
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&host->lock, flags);
> =A0}
>
> +static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc)
> +{
> + =A0 =A0 =A0 struct sdhci_host *host;
> + =A0 =A0 =A0 u8 pwr;
> + =A0 =A0 =A0 u16 clk, ctrl;
> + =A0 =A0 =A0 u32 present_state;
> +
> + =A0 =A0 =A0 host =3D mmc_priv(mmc);
> +
> + =A0 =A0 =A0 /* Stop SDCLK */
> + =A0 =A0 =A0 host =3D mmc_priv(mmc);
> + =A0 =A0 =A0 clk =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> + =A0 =A0 =A0 clk &=3D ~SDHCI_CLOCK_CARD_EN;
> + =A0 =A0 =A0 sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> + =A0 =A0 =A0 /* Check whether DAT[3:0] is 0000 */
> + =A0 =A0 =A0 present_state =3D sdhci_readl(host, SDHCI_PRESENT_STATE=
);
> + =A0 =A0 =A0 if (!((present_state & SDHCI_DATA_LVL_MASK) >> SDHCI_DA=
TA_LVL_SHIFT)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Enable 1.8V Signal Enable in the Hos=
t Control2 register */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =3D sdhci_readw(host, SDHCI_HOST_C=
ONTROL2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_VDD_180;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, ctrl, SDHCI_HOST_CON=
TROL2);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Wait for 5ms */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usleep_range(5000, 5500);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =3D sdhci_readw(host, SDHCI_HOST_C=
ONTROL2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ctrl & SDHCI_CTRL_VDD_180) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Provide SDCLK again =
and wait for 1ms*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk =3D sdhci_readw(hos=
t, SDHCI_CLOCK_CONTROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk |=3D SDHCI_CLOCK_CA=
RD_EN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, clk,=
 SDHCI_CLOCK_CONTROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usleep_range(1000, 1500=
);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If DAT[3:0] level =
is 1111b, then the card was
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* successfully switc=
hed to 1.8V signaling.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 present_state =3D sdhci=
_readl(host, SDHCI_PRESENT_STATE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((present_state & SD=
HCI_DATA_LVL_MASK) =3D=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SDHCI_DATA_L=
VL_MASK) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If we are here, that means the switch to 1.8V sign=
aling failed. Stop
> + =A0 =A0 =A0 =A0* power to the card, and retry initialization sequen=
ce by setting S18R
> + =A0 =A0 =A0 =A0* to 0.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 pwr =3D sdhci_readb(host, SDHCI_POWER_CONTROL);
> + =A0 =A0 =A0 pwr &=3D ~SDHCI_POWER_ON;
> + =A0 =A0 =A0 sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> +
> + =A0 =A0 =A0 return -EAGAIN;
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
> @@ -1799,7 +1860,9 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
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
> @@ -1822,12 +1885,15 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->version);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 caps =3D (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? ho=
st->caps :
> + =A0 =A0 =A0 caps[0] =3D (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ?=
 host->caps :
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_readl(host, SDHCI_CAPABILITIES);
>
> + =A0 =A0 =A0 if (host->version >=3D SDHCI_SPEC_300)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 caps[1] =3D sdhci_readl(host, SDHCI_CAP=
ABILITIES_1);
> +
> =A0 =A0 =A0 =A0if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->flags |=3D SDHCI_USE_SDMA;
> - =A0 =A0 =A0 else if (!(caps & SDHCI_CAN_DO_SDMA))
> + =A0 =A0 =A0 else if (!(caps[0] & SDHCI_CAN_DO_SDMA))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DBG("Controller doesn't have SDMA capa=
bility\n");
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->flags |=3D SDHCI_USE_SDMA;
> @@ -1838,7 +1904,8 @@ int sdhci_add_host(struct sdhci_host *host)
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
> @@ -1892,10 +1959,10 @@ int sdhci_add_host(struct sdhci_host *host)
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
> @@ -1911,7 +1978,7 @@ int sdhci_add_host(struct sdhci_host *host)
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
> @@ -1923,7 +1990,7 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 if (caps & SDHCI_TIMEOUT_CLK_UNIT)
> + =A0 =A0 =A0 if (caps[0] & SDHCI_TIMEOUT_CLK_UNIT)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->timeout_clk *=3D 1000;
>
> =A0 =A0 =A0 =A0/*
> @@ -1950,21 +2017,76 @@ int sdhci_add_host(struct sdhci_host *host)
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
> @@ -2024,7 +2146,7 @@ int sdhci_add_host(struct sdhci_host *host)
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
> index 223762c..95d70e6 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -69,6 +69,8 @@
> =A0#define =A0SDHCI_DATA_AVAILABLE =A00x00000800
> =A0#define =A0SDHCI_CARD_PRESENT =A0 =A00x00010000
> =A0#define =A0SDHCI_WRITE_PROTECT =A0 0x00080000
> +#define =A0SDHCI_DATA_LVL_MASK =A0 0x00F00000
> +#define =A0 SDHCI_DATA_LVL_SHIFT 20
>
> =A0#define SDHCI_HOST_CONTROL =A0 =A0 0x28
> =A0#define =A0SDHCI_CTRL_LED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x01
> @@ -147,7 +149,8 @@
>
> =A0#define SDHCI_ACMD12_ERR =A0 =A0 =A0 0x3C
>
> -/* 3E-3F reserved */
> +#define SDHCI_HOST_CONTROL2 =A0 =A0 =A0 =A0 =A0 =A00x3E
> +#define =A0SDHCI_CTRL_VDD_180 =A0 =A0 =A0 =A0 =A0 =A00x0008
>
> =A0#define SDHCI_CAPABILITIES =A0 =A0 0x40
> =A0#define =A0SDHCI_TIMEOUT_CLK_MASK =A0 =A0 =A0 =A00x0000003F
> @@ -168,9 +171,20 @@
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
> index bcb793e..ad7daa3 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -117,6 +117,8 @@ struct mmc_host_ops {
>
> =A0 =A0 =A0 =A0/* optional callback for HC quirks */
> =A0 =A0 =A0 =A0void =A0 =A0(*init_card)(struct mmc_host *host, struct=
 mmc_card *card);
> +
> + =A0 =A0 =A0 int =A0 =A0 (*start_signal_voltage_switch)(struct mmc_h=
ost *host);
> =A0};
>
> =A0struct mmc_card;
> @@ -173,6 +175,14 @@ struct mmc_host {
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
> index 178363b..3ba5aa6 100644
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
> --
> 1.7.1
>
>
