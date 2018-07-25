From: Mikko Perttunen <cyndis@kapsi.fi>
Subject: Re: [PATCH 6/7] arm64: dts: tegra210-p2180: Correct sdmmc4
 vqmmc-supply
Date: Wed, 25 Jul 2018 09:53:44 +0300
Message-ID: <2e6f0b68-38df-8cfd-9d6b-6de08bcaf97c@kapsi.fi>
References: <1532090746-15863-1-git-send-email-avienamo@nvidia.com>
 <1532090746-15863-7-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532090746-15863-7-git-send-email-avienamo@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Technically this shouldn't be required since VDD_1V8 is always on 
anyway, but I think it's nicer to specify regulators anyway, so +1!

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>

On 20.07.2018 15:45, Aapo Vienamo wrote:
> On p2180 sdmmc4 is powered from a fixed 1.8 V regulator.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
> index 8496101..053458a 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
> @@ -273,6 +273,7 @@
>   		status = "okay";
>   		bus-width = <8>;
>   		non-removable;
> +		vqmmc-supply = <&vdd_1v8>;
>   	};
>   
>   	clocks {
> 
