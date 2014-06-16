From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: re-enable SDHCI drivers
Date: Mon, 16 Jun 2014 23:16:01 +0200
Message-ID: <CAPDyKFr98GfBZuUbod+JnvbEEyDC+Unninetw=-=6o8muQw_NQ@mail.gmail.com>
References: <1402937442-7623-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:47551 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932514AbaFPVQD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jun 2014 17:16:03 -0400
Received: by mail-qa0-f41.google.com with SMTP id cm18so8237665qab.28
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jun 2014 14:16:02 -0700 (PDT)
In-Reply-To: <1402937442-7623-1-git-send-email-swarren@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "arm@kernel.org" <arm@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>

On 16 June 2014 18:50, Stephen Warren <swarren@wwwdotorg.org> wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> Following 5d01b7684b7e "mmc: simplify SDHCI Kconfig dependencies",
> SDHCI drivers that use MMC_SDHCI_PLTFM no longer select it, but
> instead depend on it. This means that multi_v7_defconfig no longer
> selects it, and hence many SDHCI drivers are no longer enabled.
> Explicitly enable MMC_SDHCI_PLTFM to solve this.
>
> Fixes: 5d01b7684b7e ("mmc: simplify SDHCI Kconfig dependencies")
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

I suppose this goes through arm-soc, otherwise ping me if you want me
to handle it as a fix for 3.16.

Kind regards
Uffe

> ---
> This is a fix for 3.16, and based directly on v3.16-rc1.
>
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index e2d62048e198..17d9462b9fb9 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -300,6 +300,7 @@ CONFIG_MMC=y
>  CONFIG_MMC_BLOCK_MINORS=16
>  CONFIG_MMC_ARMMMCI=y
>  CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_PLTFM=y
>  CONFIG_MMC_SDHCI_OF_ARASAN=y
>  CONFIG_MMC_SDHCI_ESDHC_IMX=y
>  CONFIG_MMC_SDHCI_DOVE=y
> --
> 1.8.1.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
