From: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: Re: [PATCH V4 1/2] dt-bindings: mmc: sdhci-msm: Add SoC-specific
 compatible strings
Date: Mon, 12 Nov 2018 12:28:44 +0530
Message-ID: <e03554eb-ff64-82f8-6cf8-a2a04f2c3d49@codeaurora.org>
References: <1542002209-1510-1-git-send-email-vbadigan@codeaurora.org>
 <1542002209-1510-2-git-send-email-vbadigan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542002209-1510-2-git-send-email-vbadigan@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, evgreen@chromium.org, dianders@google.com
Cc: asutoshd@codeaurora.org, riteshh@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, Mark Rutland <mark.rutland@arm.com>, "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


Please ignore this patch set. Right patch-set is V5. 
https://patchwork.kernel.org/project/linux-mmc/list/?series=41661

Sorry for the inconvenience.


Thanks

Veera


On 11/12/2018 11:26 AM, Veerabhadrarao Badiganti wrote:
> Add SoC-specific compatible strings for qcom-sdhci controller.
>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
>   Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 502b3b8..b72871a 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -4,12 +4,25 @@ This file documents differences between the core properties in mmc.txt
>   and the properties used by the sdhci-msm driver.
>   
>   Required properties:
> -- compatible: Should contain:
> +- compatible: Should contain a SoC-specific string and a IP version string:
> +	version strings:
>   		"qcom,sdhci-msm-v4" for sdcc versions less than 5.0
> -		"qcom,sdhci-msm-v5" for sdcc versions >= 5.0
> +		"qcom,sdhci-msm-v5" for sdcc version 5.0
>   		For SDCC version 5.0.0, MCI registers are removed from SDCC
>   		interface and some registers are moved to HC. New compatible
>   		string is added to support this change - "qcom,sdhci-msm-v5".
> +	full compatible strings with SoC and version:
> +		"qcom,apq8084-sdhci", "qcom,sdhci-msm-v4"
> +		"qcom,msm8974-sdhci", "qcom,sdhci-msm-v4"
> +		"qcom,msm8916-sdhci", "qcom,sdhci-msm-v4"
> +		"qcom,msm8992-sdhci", "qcom,sdhci-msm-v4"
> +		"qcom,msm8996-sdhci", "qcom,sdhci-msm-v4"
> +		"qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"
> +		"qcom,qcs404-sdhci", "qcom,sdhci-msm-v5"
> +	NOTE that some old device tree files may be floating around that only
> +	have the string "qcom,sdhci-msm-v4" without the SoC compatible string
> +	but doing that should be considered a deprecated practice.
> +
>   - reg: Base address and length of the register in the following order:
>   	- Host controller register map (required)
>   	- SD Core register map (required)
> @@ -29,7 +42,7 @@ Required properties:
>   Example:
>   
>   	sdhc_1: sdhci@f9824900 {
> -		compatible = "qcom,sdhci-msm-v4";
> +		compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
>   		reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
>   		interrupts = <0 123 0>;
>   		bus-width = <8>;
> @@ -46,7 +59,7 @@ Example:
>   	};
>   
>   	sdhc_2: sdhci@f98a4900 {
> -		compatible = "qcom,sdhci-msm-v4";
> +		compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
>   		reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
>   		interrupts = <0 125 0>;
>   		bus-width = <4>;
