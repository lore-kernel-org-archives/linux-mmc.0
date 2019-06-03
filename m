From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: mmc: sun4i: Add YAML schemas
Date: Mon, 3 Jun 2019 15:48:23 +0200
Message-ID: <CAPDyKFrjXAdiuYZRT9+BQ9omPT0g+SaAO3NbEHBkF03S3mzDJA@mail.gmail.com>
References: <fab0ec653b4e059cdb1206f65bfca051c8b0a7de.1559114458.git-series.maxime.ripard@bootlin.com>
 <18bb36183d93fd6bc03a401c2b6b498c0171d375.1559114458.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <18bb36183d93fd6bc03a401c2b6b498c0171d375.1559114458.git-series.maxime.ripard@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 29 May 2019 at 09:23, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Switch the DT binding to a YAML schema to enable the DT validation.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
>
> Changes from v2
>   - Add Rob's Reviewed-by
> ---
>  Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  Documentation/devicetree/bindings/mmc/sunxi-mmc.txt                | 52 +--------------------------------------
>  2 files changed, 98 insertions(+), 52 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> new file mode 100644
> index 000000000000..df0280edef97
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/allwinner,sun4i-a10-mmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner A10 MMC Controller Device Tree Bindings
> +
> +allOf:
> +  - $ref: "mmc-controller.yaml"
> +
> +maintainers:
> +  - Chen-Yu Tsai <wens@csie.org>
> +  - Maxime Ripard <maxime.ripard@bootlin.com>
> +
> +properties:
> +  "#address-cells": true
> +  "#size-cells": true
> +
> +  compatible:
> +    oneOf:
> +      - const: allwinner,sun4i-a10-mmc
> +      - const: allwinner,sun5i-a13-mmc
> +      - const: allwinner,sun7i-a20-mmc
> +      - const: allwinner,sun8i-a83t-emmc
> +      - const: allwinner,sun9i-a80-mmc
> +      - const: allwinner,sun50i-a64-emmc
> +      - const: allwinner,sun50i-a64-mmc
> +      - items:
> +          - const: allwinner,sun8i-a83t-mmc
> +          - const: allwinner,sun7i-a20-mmc
> +      - items:
> +          - const: allwinner,sun50i-h6-emmc
> +          - const: allwinner,sun50i-a64-emmc
> +      - items:
> +          - const: allwinner,sun50i-h6-mmc
> +          - const: allwinner,sun50i-a64-mmc
> +      - items:
> +          - const: allwinner,sun8i-r40-emmc
> +          - const: allwinner,sun50i-a64-emmc
> +      - items:
> +          - const: allwinner,sun8i-r40-mmc
> +          - const: allwinner,sun50i-a64-mmc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 4
> +    items:
> +      - description: Bus Clock
> +      - description: Module Clock
> +      - description: Output Clock
> +      - description: Sample Clock
> +
> +  clock-names:
> +    minItems: 2
> +    maxItems: 4
> +    items:
> +      - const: ahb
> +      - const: mmc
> +      - const: output
> +      - const: sample
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: ahb
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    mmc0: mmc@1c0f000 {
> +        compatible = "allwinner,sun5i-a13-mmc";
> +        reg = <0x01c0f000 0x1000>;
> +        clocks = <&ahb_gates 8>, <&mmc0_clk>;
> +        clock-names = "ahb", "mmc";
> +        interrupts = <32>;
> +        bus-width = <4>;
> +        cd-gpios = <&pio 7 1 0>;
> +    };
> +
> +# FIXME: We should set it, but it would report all the generic
> +# properties as additional properties.
> +# additionalProperties: false
> +
> +...
> diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> deleted file mode 100644
> index e9cb3ec5e502..000000000000
> --- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> +++ /dev/null
> @@ -1,52 +0,0 @@
> -* Allwinner sunxi MMC controller
> -
> -The highspeed MMC host controller on Allwinner SoCs provides an interface
> -for MMC, SD and SDIO types of memory cards.
> -
> -Supported maximum speeds are the ones of the eMMC standard 4.5 as well
> -as the speed of SD standard 3.0.
> -Absolute maximum transfer rate is 200MB/s
> -
> -Required properties:
> - - compatible : should be one of:
> -   * "allwinner,sun4i-a10-mmc"
> -   * "allwinner,sun5i-a13-mmc"
> -   * "allwinner,sun7i-a20-mmc"
> -   * "allwinner,sun8i-a83t-emmc"
> -   * "allwinner,sun9i-a80-mmc"
> -   * "allwinner,sun50i-a64-emmc"
> -   * "allwinner,sun50i-a64-mmc"
> -   * "allwinner,sun50i-h6-emmc", "allwinner.sun50i-a64-emmc"
> -   * "allwinner,sun50i-h6-mmc", "allwinner.sun50i-a64-mmc"
> - - reg : mmc controller base registers
> - - clocks : a list with 4 phandle + clock specifier pairs
> - - clock-names : must contain "ahb", "mmc", "output" and "sample"
> - - interrupts : mmc controller interrupt
> -
> -Optional properties:
> - - resets : phandle + reset specifier pair
> - - reset-names : must contain "ahb"
> - - for cd, bus-width and additional generic mmc parameters
> -   please refer to mmc.txt within this directory
> -
> -Examples:
> -       - Within .dtsi:
> -       mmc0: mmc@1c0f000 {
> -               compatible = "allwinner,sun5i-a13-mmc";
> -               reg = <0x01c0f000 0x1000>;
> -               clocks = <&ahb_gates 8>, <&mmc0_clk>, <&mmc0_output_clk>, <&mmc0_sample_clk>;
> -               clock-names = "ahb", "mod", "output", "sample";
> -               interrupts = <0 32 4>;
> -               status = "disabled";
> -       };
> -
> -       - Within dts:
> -       mmc0: mmc@1c0f000 {
> -               pinctrl-names = "default", "default";
> -               pinctrl-0 = <&mmc0_pins_a>;
> -               pinctrl-1 = <&mmc0_cd_pin_reference_design>;
> -               bus-width = <4>;
> -               cd-gpios = <&pio 7 1 0>; /* PH1 */
> -               cd-inverted;
> -               status = "okay";
> -       };
> --
> git-series 0.9.1
