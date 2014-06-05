From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 09/10] ARM: update multi_v7_defconfig for STI
Date: Thu, 5 Jun 2014 14:08:09 +0100
Message-ID: <20140605130809.GB24240@lee--X1>
References: <1401899424-1365-1-git-send-email-peter.griffin@linaro.org>
 <1401899424-1365-10-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1401899424-1365-10-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, kernel@stlinux.com
List-Id: linux-mmc@vger.kernel.org

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
