From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] ARM: bcm_defconfig: re-enable BCM Kona SDHCI driver
Date: Mon, 16 Jun 2014 14:12:36 -0500
Message-ID: <539F41A4.1090606@ieee.org>
References: <1402941376-29594-1-git-send-email-mporter@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35568 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755804AbaFPTMQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jun 2014 15:12:16 -0400
Received: by mail-ig0-f178.google.com with SMTP id hn18so3336592igb.17
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jun 2014 12:12:15 -0700 (PDT)
In-Reply-To: <1402941376-29594-1-git-send-email-mporter@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Porter <mporter@linaro.org>, arm@kernel.org
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On 06/16/2014 12:56 PM, Matt Porter wrote:
> Since 5d01b7684b7e "mmc: simplify SDHCI Kconfig dependencies",
> MMC_SDHCI_PLTFM is no longer selected by the BCM Kona SDHCI
> driver which is enabled in this defconfig. This results in the
> SDHCI driver not being built and a boot failure. Explictly
> enable MMC_SDHCI_PLTFM in bcm_defconfig so the BCM Kona SDHCI
> driver is built.
> 
> Fixes: 5d01b7684b7e ("mmc: simplify SDHCI Kconfig dependencies")
> Signed-off-by: Matt Porter <mporter@linaro.org>

Works for me.

Tested-by: Alex Elder <elder@linaro.org>

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
> 

