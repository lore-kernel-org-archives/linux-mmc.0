From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 02/38] dt-bindings: mmc: tegra: Add pad voltage control properties
Date: Fri, 31 Aug 2018 15:15:35 +0200
Message-ID: <CAPDyKFouUgYrx_oEJF8WHrtDbtEifSJnk-a0LeJEKw9eQFXX3A@mail.gmail.com>
References: <20180830150639.21048-1-avienamo@nvidia.com> <20180830150639.21048-3-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830150639.21048-3-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>, DTML <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 30 August 2018 at 17:06, Aapo Vienamo <avienamo@nvidia.com> wrote:
> Document the pinctrl bindings used by the SDHCI driver to reconfigure
> pad voltages on controllers supporting multiple voltage levels.
>
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Thierry Reding <treding@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  .../bindings/mmc/nvidia,tegra20-sdhci.txt     | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 9bce57862ed6..90c214dbfb16 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -38,3 +38,25 @@ sdhci@c8000200 {
>         power-gpios = <&gpio 155 0>; /* gpio PT3 */
>         bus-width = <8>;
>  };
> +
> +Optional properties for Tegra210 and Tegra186:
> +- pinctrl-names, pinctrl-0, pinctrl-1 : Specify pad voltage
> +  configurations. Valid pinctrl-names are "sdmmc-3v3" and "sdmmc-1v8"
> +  for controllers supporting multiple voltage levels. The order of names
> +  should correspond to the pin configuration states in pinctrl-0 and
> +  pinctrl-1.
> +
> +Example:
> +sdhci@700b0000 {
> +       compatible = "nvidia,tegra210-sdhci", "nvidia,tegra124-sdhci";
> +       reg = <0x0 0x700b0000 0x0 0x200>;
> +       interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +       clocks = <&tegra_car TEGRA210_CLK_SDMMC1>;
> +       clock-names = "sdhci";
> +       resets = <&tegra_car 14>;
> +       reset-names = "sdhci";
> +       pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
> +       pinctrl-0 = <&sdmmc1_3v3>;
> +       pinctrl-1 = <&sdmmc1_1v8>;
> +       status = "disabled";
> +};
> --
> 2.18.0
>
