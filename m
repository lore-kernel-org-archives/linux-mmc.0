From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 04/38] dt-bindings: mmc: Add Tegra SDHCI sampling
 trimmer values
Date: Fri, 31 Aug 2018 15:15:55 +0200
Message-ID: <CAPDyKFqrqNLH_bTsckL5WfM5G6xnhgd9BFQSjEzm2b+mRVJRsQ@mail.gmail.com>
References: <20180830150639.21048-1-avienamo@nvidia.com> <20180830150639.21048-5-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830150639.21048-5-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>, DTML <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 30 August 2018 at 17:06, Aapo Vienamo <avienamo@nvidia.com> wrote:
> Document the Tegra SDHCI inbound and outbound sampling trimmer values.
>
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>

Applied for next, thanks!

I noted that Rob added his tag for the earlier version, so I am
re-adding when applying.

Kind regards
Uffe

> ---
>  .../devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt  | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 9713e052f736..edecf97231b9 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -67,6 +67,10 @@ Optional properties for Tegra210 and Tegra186:
>  - nvidia,pad-autocal-pull-up-offset-hs400,
>    nvidia,pad-autocal-pull-down-offset-hs400 : Specify drive strength
>    calibration offsets for HS400 mode.
> +- nvidia,default-tap : Specify the default inbound sampling clock
> +  trimmer value for non-tunable modes.
> +- nvidia,default-trim : Specify the default outbound clock trimmer
> +  value.
>
>    Notes on the pad calibration pull up and pulldown offset values:
>      - The property values are drive codes which are programmed into the
> @@ -77,6 +81,13 @@ Optional properties for Tegra210 and Tegra186:
>      - The SDR104 and HS400 timing specific values are used in
>        corresponding modes if specified.
>
> +  Notes on tap and trim values:
> +    - The values are used for compensating trace length differences
> +      by adjusting the sampling point.
> +    - The values are programmed to the Vendor Clock Control Register.
> +      Please refer to the reference manual of the SoC for correct
> +      values.
> +
>  Example:
>  sdhci@700b0000 {
>         compatible = "nvidia,tegra210-sdhci", "nvidia,tegra124-sdhci";
> --
> 2.18.0
>
