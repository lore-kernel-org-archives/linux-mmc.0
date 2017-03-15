From: Rob Herring <robh@kernel.org>
Subject: Re: [v2 PATCH 2/3] Documentation: bindings: add description of PHY
 delays for sdhci-cadence
Date: Wed, 15 Mar 2017 11:55:13 -0500
Message-ID: <20170315165513.aojq7b2yb3etutxb@rob-hp-laptop>
References: <1488807576-4571-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1488807576-4571-1-git-send-email-piotrs@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Mar 06, 2017 at 01:39:36PM +0000, Piotr Sroka wrote:
> Add description of new DLL PHY delays.

For the subject: "dt-bindings: mmc: ..."

> 
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> ---
> Changes for v2:
> - file was created in v2. It was a part of driver source file patch.
> - most delays were moved from dts file 
>   to data associated with an SoC specific compatible
> - description of delays was updated to be more clearly
> ---
>  .../devicetree/bindings/mmc/sdhci-cadence.txt          | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt b/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
> index c0f37cb..77c4b99 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
> @@ -19,6 +19,23 @@ if supported.  See mmc.txt for details.
>  - mmc-hs400-1_8v
>  - mmc-hs400-1_2v
>  
> +Some PHY delays can be configured by following properties.
> +Each delay property represents the fraction of the clock period.
> +The approximate delay value will be
> +(<delay property value>/128)*sdmclk_clock_period.
> +- phy-dll-delay-sdclk:
> +  Value of the delay introduced on the sdclk output
> +  for all modes except HS200, HS400 and HS400_ES.
> +  Valid range = [0:0x7F].
> +- phy-dll-delay-sdclk-hsmmc:
> +  Value of the delay introduced on the sdclk output
> +  for HS200, HS400 and HS400_ES speed modes.
> +  Valid range = [0:0x7F].
> +- phy-dll-delay-strobe:
> +  Value of the delay introduced on the dat_strobe input
> +  used in HS400 / HS400_ES speed modes.
> +  Valid range = [0:0x7F].

These all vendor prefixes.

> +
>  Example:
>  	emmc: sdhci@5a000000 {
>  		compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
> @@ -29,4 +46,5 @@ Example:
>  		mmc-ddr-1_8v;
>  		mmc-hs200-1_8v;
>  		mmc-hs400-1_8v;
> +		phy-dll-delay-sdclk = <0>;
>  	};
> -- 
> 2.2.2
> 
