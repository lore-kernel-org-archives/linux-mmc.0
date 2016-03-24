From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] ARM: dts: exynos: Fix invalid maximum voltage for buck9
 supplying SD card
Date: Thu, 24 Mar 2016 18:33:20 +0900
Message-ID: <56F3B460.9040306@samsung.com>
References: <1458807125-13580-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1458807125-13580-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 03/24/2016 05:12 PM, Krzysztof Kozlowski wrote:
> The buck9 regulator of S2MPS11 PMIC had incorrect maximum voltage -
> lower by 5 mV than specified by datasheet. This buck9 provides power to
> other regulators, including LDO13 and LDO19 which supply the MMC2 (SD
> card).
> 
> When constraints were applied, the depending regulators were not
> providing enough power, leading to SD card detection errors:
> 	mmc1: card never left busy state
> 	mmc1: error -110 whilst initialising SD card
> 
> Fixes: 86a2d2ac5e5d ("ARM: dts: Add dts file for Odroid XU3 board")
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Tested-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> 
> ---
> 
> The issue can be reproduced on next-20160324 with
> bae4fdc88d7f7dda1 (regulator: core: Ensure we are at least in bounds for our constraints).
> ---
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> index 1bd507bfa750..82b2ba632cf6 100644
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> @@ -299,7 +299,7 @@
>  			buck9_reg: BUCK9 {
>  				regulator-name = "vdd_2.8v_ldo";
>  				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3750000>;
> +				regulator-max-microvolt = <3755000>;
>  				regulator-always-on;
>  				regulator-boot-on;
>  			};
> 
