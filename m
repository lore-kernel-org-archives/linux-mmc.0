From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: mmc: sdhci-of-arasan: Add new
 compatible for Intel LGM eMMC
Date: Tue, 27 Aug 2019 15:49:46 +0200
Message-ID: <CAPDyKFpsvZ+LEwY91LiSExgm=4g=BhWNpkkJMniBNff+qch-QA@mail.gmail.com>
References: <20190826072800.38413-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190826072800.38413-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ramuthevar,Vadivel MuruganX" <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, DTML <devicetree@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, andriy.shevchenko@intel.com, cheol.yong.kim@intel.com, qi-ming.wu@intel.com
List-Id: linux-mmc@vger.kernel.org

On Mon, 26 Aug 2019 at 09:28, Ramuthevar,Vadivel MuruganX
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>
> Add a new compatible to use the sdhc-arasan host controller driver
> with the eMMC PHY on Intel's Lightning Mountain SoC.
>
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 1edbb049cccb..7ca0aa7ccc0b 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -17,6 +17,8 @@ Required Properties:
>        For this device it is strongly suggested to include arasan,soc-ctl-syscon.
>      - "ti,am654-sdhci-5.1", "arasan,sdhci-5.1": TI AM654 MMC PHY
>         Note: This binding has been deprecated and moved to [5].
> +    - "intel,lgm-sdhci-5.1-emmc", "arasan,sdhci-5.1": Intel LGM eMMC PHY
> +      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
>
>    [5] Documentation/devicetree/bindings/mmc/sdhci-am654.txt
>
> @@ -80,3 +82,18 @@ Example:
>                 phy-names = "phy_arasan";
>                 #clock-cells = <0>;
>         };
> +
> +       emmc: sdhci@ec700000 {
> +               compatible = "intel,lgm-sdhci-5.1-emmc", "arasan,sdhci-5.1";
> +               reg = <0xec700000 0x300>;
> +               interrupt-parent = <&ioapic1>;
> +               interrupts = <44 1>;
> +               clocks = <&cgu0 LGM_CLK_EMMC5>, <&cgu0 LGM_CLK_NGI>,
> +                        <&cgu0 LGM_GCLK_EMMC>;
> +               clock-names = "clk_xin", "clk_ahb", "gate";
> +               clock-output-names = "emmc_cardclock";
> +               #clock-cells = <0>;
> +               phys = <&emmc_phy>;
> +               phy-names = "phy_arasan";
> +               arasan,soc-ctl-syscon = <&sysconf>;
> +       };
> --
> 2.11.0
>
