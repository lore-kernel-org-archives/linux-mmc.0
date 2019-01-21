From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/7] dt-bindings: sdhci-omap: Add example for using
 external dma
Date: Mon, 21 Jan 2019 17:20:57 -0600
Message-ID: <20190121232057.GA30919@bogus>
References: <20190111110851.6805-1-faiz_abbas@ti.com>
 <20190111110851.6805-4-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190111110851.6805-4-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, zhang.chunyan@linaro.org, kishon@ti.com, adrian.hunter@intel.com, mark.rutland@arm.com, ulf.hansson@linaro.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 11, 2019 at 04:38:47PM +0530, Faiz Abbas wrote:
> From: Chunyan Zhang <zhang.chunyan@linaro.org>

The subject is misleading. You are adding new properties, not just 
changing an example.

> 
> sdhci-omap can support both external dma controller via dmaengine
> framework as well as ADMA which standard SD host controller
> provides.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-omap.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> index 72c4dec7e1db..f8914a2a2aec 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> @@ -14,6 +14,11 @@ Required properties:
>  		 "ddr_1_8v-rev11", "ddr_1_8v" or "ddr_3_3v", "hs200_1_8v-rev11",
>  		 "hs200_1_8v",
>  - pinctrl-<n> : Pinctrl states as described in bindings/pinctrl/pinctrl-bindings.txt
> +- dmas:		List of DMA specifiers with the controller specific format as described
> +		in the generic DMA client binding. A tx and rx specifier is required.
> +- dma-names:	List of DMA request names. These strings correspond 1:1 with the
> +		DMA specifiers listed in dmas. The string naming is to be "rx"
> +		and "tx" for RX and TX DMA requests, respectively.

The ordering of rx and tx should be defined and you have a mixture.

>  
>  Example:
>  	mmc1: mmc@4809c000 {
> @@ -22,4 +27,6 @@ Example:
>  		ti,hwmods = "mmc1";
>  		bus-width = <4>;
>  		vmmc-supply = <&vmmc>; /* phandle to regulator node */
> +		dmas = <&sdma 61 &sdma 62>;
> +		dma-names = "tx", "rx";
>  	};
> -- 
> 2.19.2
> 
