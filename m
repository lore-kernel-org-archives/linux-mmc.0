From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v4 12/15] sdhci pxa add platform specific code for UHS signaling
Date: Wed, 11 May 2011 04:48:23 -0400
Message-ID: <BANLkTikdwJ3KOhxtJu9Msq6G-SmutGaSHg@mail.gmail.com>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
	<1304578151-1775-13-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61778 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab1EKSLL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 May 2011 14:11:11 -0400
Received: by vxi39 with SMTP id 39so553869vxi.19
        for <linux-mmc@vger.kernel.org>; Wed, 11 May 2011 11:11:10 -0700 (PDT)
In-Reply-To: <1304578151-1775-13-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: cjb@laptop.org, prakity@marvell.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

On Thu, May 5, 2011 at 2:49 AM, Arindam Nath <arindam.nath@amd.com> wro=
te:
> Marvell controller requires 1.8V bit in UHS control register 2
> be set when doing UHS. =A0eMMC does not require 1.8V for DDR.
> add platform code to handle this.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> Reviewed-by: Arindam Nath <arindam.nath@amd.com>
> ---
> =A0drivers/mmc/host/sdhci-pxa.c | =A0 36 ++++++++++++++++++++++++++++=
++++++++
> =A01 files changed, 36 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-px=
a.c
> index 5a61208..b52c3e6 100644
> --- a/drivers/mmc/host/sdhci-pxa.c
> +++ b/drivers/mmc/host/sdhci-pxa.c
> @@ -69,7 +69,40 @@ static void set_clock(struct sdhci_host *host, uns=
igned int clock)
> =A0 =A0 =A0 =A0}
> =A0}
>
> +static int set_uhs_signaling(struct sdhci_host *host, unsigned int u=
hs)
> +{
> + =A0 =A0 =A0 u16 ctrl_2;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Set V18_EN -- UHS modes do not work without this.
> + =A0 =A0 =A0 =A0* does not change signaling voltage
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 ctrl_2 =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Select Bus Speed Mode for host */
> + =A0 =A0 =A0 ctrl_2 &=3D ~SDHCI_CTRL_UHS_MASK;
> + =A0 =A0 =A0 if (uhs =3D=3D MMC_TIMING_UHS_SDR12)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_UHS_SDR12;
> + =A0 =A0 =A0 else if (uhs =3D=3D MMC_TIMING_UHS_SDR25)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_UHS_SDR25;
> + =A0 =A0 =A0 else if (uhs =3D=3D MMC_TIMING_UHS_SDR50) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_UHS_SDR50;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_VDD_180;
> + =A0 =A0 =A0 } else if (uhs =3D=3D MMC_TIMING_UHS_SDR104) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_UHS_SDR104;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_VDD_180;
> + =A0 =A0 =A0 } else if (uhs =3D=3D MMC_TIMING_UHS_DDR50) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_UHS_DDR50;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_VDD_180;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> + =A0 =A0 =A0 pr_debug("%s:%s uhs =3D %d, ctrl_2 =3D %04X\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, mmc_hostname(host->mmc), uhs,=
 ctrl_2);
> + =A0 =A0 =A0 return 0;
> +}

Why move common register accessing from sdhci.c to specific driver?

> +
> =A0static struct sdhci_ops sdhci_pxa_ops =3D {
> + =A0 =A0 =A0 .set_uhs_signaling =3D set_uhs_signaling,
> =A0 =A0 =A0 =A0.set_clock =3D set_clock,
> =A0};
>
> @@ -141,6 +174,9 @@ static int __devinit sdhci_pxa_probe(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0if (pdata->quirks)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->quirks |=3D pdata->quirks;
>
> + =A0 =A0 =A0 /* enable 1/8V DDR capable */
> + =A0 =A0 =A0 host->mmc->caps |=3D MMC_CAP_1_8V_DDR;
> +
> =A0 =A0 =A0 =A0/* If slot design supports 8 bit data, indicate this t=
o MMC. */
> =A0 =A0 =A0 =A0if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->mmc->caps |=3D MMC_CAP_8_BIT_DAT=
A;
> --
> 1.7.1
>
>
