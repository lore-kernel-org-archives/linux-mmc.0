From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] ARM: bcm_defconfig: re-enable BCM Kona SDHCI driver
Date: Mon, 16 Jun 2014 23:22:59 +0200
Message-ID: <CAPDyKFqh1chuz_Yw74vXU+kTtCUyKT1eY9pKroMCFTaVrPX-bQ@mail.gmail.com>
References: <1402941376-29594-1-git-send-email-mporter@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:42061 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312AbaFPVXA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jun 2014 17:23:00 -0400
Received: by mail-qc0-f181.google.com with SMTP id x13so8579144qcv.26
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jun 2014 14:23:00 -0700 (PDT)
In-Reply-To: <1402941376-29594-1-git-send-email-mporter@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Porter <mporter@linaro.org>
Cc: "arm@kernel.org" <arm@kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On 16 June 2014 19:56, Matt Porter <mporter@linaro.org> wrote:
> Since 5d01b7684b7e "mmc: simplify SDHCI Kconfig dependencies",
> MMC_SDHCI_PLTFM is no longer selected by the BCM Kona SDHCI
> driver which is enabled in this defconfig. This results in the
> SDHCI driver not being built and a boot failure. Explictly
> enable MMC_SDHCI_PLTFM in bcm_defconfig so the BCM Kona SDHCI
> driver is built.
>
> Fixes: 5d01b7684b7e ("mmc: simplify SDHCI Kconfig dependencies")
> Signed-off-by: Matt Porter <mporter@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

I suppose this goes through arm-soc, but ping me if want me to send
this as a fix for 3.16.

Kind regards
Uffe

> ---
>  arch/arm/configs/bcm_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
> index 9d13dae..dcfc559 100644
> --- a/arch/arm/configs/bcm_defconfig
> +++ b/arch/arm/configs/bcm_defconfig
> @@ -98,6 +98,7 @@ CONFIG_MMC_UNSAFE_RESUME=y
>  CONFIG_MMC_BLOCK_MINORS=32
>  CONFIG_MMC_TEST=y
>  CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_PLTFM=y
>  CONFIG_MMC_SDHCI_BCM_KONA=y
>  CONFIG_NEW_LEDS=y
>  CONFIG_LEDS_CLASS=y
> --
> 1.8.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
