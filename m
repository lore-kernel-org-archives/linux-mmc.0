From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 4/7] arm: set CONFIG_MMC_BCM2835=y in bcm2835_defconfig
 and multi_v7_defconfig
Date: Fri, 17 Mar 2017 08:35:12 +0100
Message-ID: <CAPDyKFo+GLXjBK+DwxTqq65OSVvrtF9eMT4pVu+xaxWsE3NdDg@mail.gmail.com>
References: <1488964751-22763-1-git-send-email-kraxel@redhat.com> <1488964751-22763-8-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:34790 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbdCQHfO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Mar 2017 03:35:14 -0400
Received: by mail-vk0-f45.google.com with SMTP id r136so36622815vke.1
        for <linux-mmc@vger.kernel.org>; Fri, 17 Mar 2017 00:35:13 -0700 (PDT)
In-Reply-To: <1488964751-22763-8-git-send-email-kraxel@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-rpi-kernel@lists.infradead.org, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

-trimmed cc list

On 8 March 2017 at 10:19, Gerd Hoffmann <kraxel@redhat.com> wrote:
> We need to enable this controller so that we can switch the SD card's
> pinmux over to it by default, which will improve storage performance.
>
> Read access (dd with 64k blocks on rpi2):
>   CONFIG_MMC_SDHCI_IPROC: 11-12 MB/s
>   CONFIG_MMC_BCM2835:     19-20 MB/s
>
> Differences on write access are pretty much in the noise.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Normally this change should go via arm soc. However as the new
CONFIG_MMC_BCM2835 is added in this series, perhaps it makes sense to
that I pick it up. In such case I need an ack from some of the arm soc
folkz, like Arnd/Olof.

Kind regards
Uffe

> ---
>  arch/arm/configs/bcm2835_defconfig  | 1 +
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
> index 4b89f4e..3767c24 100644
> --- a/arch/arm/configs/bcm2835_defconfig
> +++ b/arch/arm/configs/bcm2835_defconfig
> @@ -92,6 +92,7 @@ CONFIG_MMC=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_PLTFM=y
>  CONFIG_MMC_SDHCI_IPROC=y
> +CONFIG_MMC_BCM2835=y
>  CONFIG_NEW_LEDS=y
>  CONFIG_LEDS_CLASS=y
>  CONFIG_LEDS_GPIO=y
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index a94126f..63b94d0 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -730,6 +730,7 @@ CONFIG_MMC_DW_EXYNOS=y
>  CONFIG_MMC_DW_ROCKCHIP=y
>  CONFIG_MMC_SH_MMCIF=y
>  CONFIG_MMC_SUNXI=y
> +CONFIG_MMC_BCM2835=y
>  CONFIG_NEW_LEDS=y
>  CONFIG_LEDS_CLASS=y
>  CONFIG_LEDS_CLASS_FLASH=m
> --
> 1.8.3.1
>
