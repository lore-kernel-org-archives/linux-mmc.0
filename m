From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 8/8] ARM: update multi_v7_defconfig for STI
Date: Thu, 22 May 2014 16:36:50 +0100
Message-ID: <20140522153650.GC19747@lee--X1>
References: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
 <1400771902-26553-9-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:53071 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbaEVPg5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 May 2014 11:36:57 -0400
Received: by mail-ig0-f182.google.com with SMTP id uy17so3686617igb.9
        for <linux-mmc@vger.kernel.org>; Thu, 22 May 2014 08:36:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400771902-26553-9-git-send-email-peter.griffin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, chris@printf.net, ulf.hansson@linaro.org, kernel@stlinux.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org

> This patch enables SDHCI STI platform driver.
>=20
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/m=
ulti_v7_defconfig
> index d4e8a47..48951fc 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -277,6 +277,7 @@ CONFIG_MMC_SDHCI_TEGRA=3Dy
>  CONFIG_MMC_SDHCI_DOVE=3Dy
>  CONFIG_MMC_SDHCI_SPEAR=3Dy
>  CONFIG_MMC_SDHCI_BCM_KONA=3Dy
> +CONFIG_MMC_SDHCI_ST=3Dy
>  CONFIG_MMC_OMAP=3Dy
>  CONFIG_MMC_OMAP_HS=3Dy
>  CONFIG_MMC_MVSDIO=3Dy

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
