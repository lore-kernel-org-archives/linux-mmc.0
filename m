From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 1/3] dt-bindings: mmc: tegra: Add pinctrl for SDMMC
 drive strengths
Date: Tue, 22 Jan 2019 08:47:37 +0100
Message-ID: <CAPDyKFqHtg2TuUKNrg8Xue9jrni+8iw_KxDx5W0+4+FHsqsNZg@mail.gmail.com>
References: <1547160363-25323-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547160363-25323-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mikko Perttunen <mperttunen@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, anrao@nvidia.com, DTML <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 10 Jan 2019 at 23:46, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> Add pinctrls for 3V3 and 1V8 pad drive strength configuration for
> Tegra210 sdmmc.
>
> Tegra210 sdmmc has pad configuration registers in pinmux register
> domain and handled thru pinctrl to pinmux device node.
>
> Tegra186 and Tegra194 has pad configuration register with in the
> SDMMC register domain itself and are handles thru drive strength
> properties in sdmmc device node.
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 32b4b4e41923..2cecdc71d94c 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -39,12 +39,16 @@ sdhci@c8000200 {
>         bus-width = <8>;
>  };
>
> -Optional properties for Tegra210 and Tegra186:
> +Optional properties for Tegra210, Tegra186 and Tegra194:
>  - pinctrl-names, pinctrl-0, pinctrl-1 : Specify pad voltage
>    configurations. Valid pinctrl-names are "sdmmc-3v3" and "sdmmc-1v8"
>    for controllers supporting multiple voltage levels. The order of names
>    should correspond to the pin configuration states in pinctrl-0 and
>    pinctrl-1.
> +- pinctrl-names : "sdmmc-3v3-drv" and "sdmmc-1v8-drv" are applicable for
> +  Tegra210 where pad config registers are in the pinmux register domain
> +  for pull-up-strength and pull-down-strength values configuration when
> +  using pads at 3V3 and 1V8 levels.
>  - nvidia,only-1-8-v : The presence of this property indicates that the
>    controller operates at a 1.8 V fixed I/O voltage.
>  - nvidia,pad-autocal-pull-up-offset-3v3,
> --
> 2.7.4
>
