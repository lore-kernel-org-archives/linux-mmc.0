From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 1/3] dt-bindings: mmc: tegra: Add pinctrl for pad
 drive strength config
Date: Thu, 27 Dec 2018 15:33:53 -0600
Message-ID: <20181227213353.GA8110@bogus>
References: <1545260153-11338-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1545260153-11338-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: mark.rutland@arm.com, mperttunen@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com, adrian.hunter@intel.com, ulf.hansson@linaro.org, pchandru@nvidia.com, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Dec 19, 2018 at 02:55:51PM -0800, Sowjanya Komatineni wrote:
> Add pinctrl for 3V3 and 1V8 pad drive strength configuration for
> Tegra210 sdmmc which has pad configuration registers in the pinmux
> reigster domain.

typo

> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 32b4b4e41923..2cecdc71d94c 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -39,12 +39,16 @@ sdhci@c8000200 {
>  	bus-width = <8>;
>  };
>  
> -Optional properties for Tegra210 and Tegra186:
> +Optional properties for Tegra210, Tegra186 and Tegra194:

Adding Tegra194, but this patch concerns Tegra210...

>  - pinctrl-names, pinctrl-0, pinctrl-1 : Specify pad voltage
>    configurations. Valid pinctrl-names are "sdmmc-3v3" and "sdmmc-1v8"
>    for controllers supporting multiple voltage levels. The order of names
>    should correspond to the pin configuration states in pinctrl-0 and
>    pinctrl-1.
> +- pinctrl-names : "sdmmc-3v3-drv" and "sdmmc-1v8-drv" are applicable for

These are in addition to the previous values?

> +  Tegra210 where pad config registers are in the pinmux register domain
> +  for pull-up-strength and pull-down-strength values configuration when
> +  using pads at 3V3 and 1V8 levels.
>  - nvidia,only-1-8-v : The presence of this property indicates that the
>    controller operates at a 1.8 V fixed I/O voltage.
>  - nvidia,pad-autocal-pull-up-offset-3v3,
> -- 
> 2.7.4
> 
