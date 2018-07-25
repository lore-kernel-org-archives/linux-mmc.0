From: Mikko Perttunen <cyndis@kapsi.fi>
Subject: Re: [PATCH 3/7] arm64: dts: Add Tegra210 sdmmc pinctrl voltage states
Date: Wed, 25 Jul 2018 09:49:27 +0300
Message-ID: <e33f9c5b-1277-c05a-1b4b-babecfefbba3@kapsi.fi>
References: <1532090746-15863-1-git-send-email-avienamo@nvidia.com>
 <1532090746-15863-4-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532090746-15863-4-git-send-email-avienamo@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>

On 20.07.2018 15:45, Aapo Vienamo wrote:
> Add pad voltage configuration nodes for sdmmc pads with configurable
> voltages on Tegra210.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra210.dtsi | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> index 3be920e..bc1918e 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> @@ -3,6 +3,7 @@
>   #include <dt-bindings/gpio/tegra-gpio.h>
>   #include <dt-bindings/memory/tegra210-mc.h>
>   #include <dt-bindings/pinctrl/pinctrl-tegra.h>
> +#include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/thermal/tegra124-soctherm.h>
>   
> @@ -776,6 +777,26 @@
>   				#power-domain-cells = <0>;
>   			};
>   		};
> +
> +		sdmmc1_3v3: sdmmc1-3v3 {
> +			pins = "sdmmc1";
> +			power-source = <TEGRA_IO_PAD_VOLTAGE_3V3>;
> +		};
> +
> +		sdmmc1_1v8: sdmmc1-1v8 {
> +			pins = "sdmmc1";
> +			power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
> +		};
> +
> +		sdmmc3_3v3: sdmmc3-3v3 {
> +			pins = "sdmmc3";
> +			power-source = <TEGRA_IO_PAD_VOLTAGE_3V3>;
> +		};
> +
> +		sdmmc3_1v8: sdmmc3-1v8 {
> +			pins = "sdmmc3";
> +			power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
> +		};
>   	};
>   
>   	fuse@7000f800 {
> @@ -1027,6 +1048,9 @@
>   		clock-names = "sdhci";
>   		resets = <&tegra_car 14>;
>   		reset-names = "sdhci";
> +		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
> +		pinctrl-0 = <&sdmmc1_3v3>;
> +		pinctrl-1 = <&sdmmc1_1v8>;
>   		status = "disabled";
>   	};
>   
> @@ -1049,6 +1073,9 @@
>   		clock-names = "sdhci";
>   		resets = <&tegra_car 69>;
>   		reset-names = "sdhci";
> +		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
> +		pinctrl-0 = <&sdmmc3_3v3>;
> +		pinctrl-1 = <&sdmmc3_1v8>;
>   		status = "disabled";
>   	};
>   
> 
