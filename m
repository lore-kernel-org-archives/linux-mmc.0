From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: add DT bindings for Milbeaut SD controller
Date: Mon, 29 Apr 2019 12:24:16 +0200
Message-ID: <CAPDyKFouv1MDJXwDryqhC=X4mLycoAigB3x6Xee09U+QNGTa-Q@mail.gmail.com>
References: <1556244392-15822-1-git-send-email-orito.takao@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556244392-15822-1-git-send-email-orito.takao@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takao Orito <orito.takao@socionext.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jaswinder Singh <jaswinder.singh@linaro.org>, sugaya.taichi@socionext.com, kasai.kazuhiro@socionext.com, kanematsu.shinji@socionext.com
List-Id: linux-mmc@vger.kernel.org

On Fri, 26 Apr 2019 at 04:04, Takao Orito <orito.takao@socionext.com> wrote:
>
> Signed-off-by: Takao Orito <orito.takao@socionext.com>
> ---
>  .../devicetree/bindings/mmc/sdhci-milbeaut.txt     | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt b/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
> new file mode 100644
> index 0000000..7008462
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
> @@ -0,0 +1,35 @@
> +* SOCIONEXT SDHCI controller
> +
> +This file documents differences between the core properties in mmc.txt
> +and the properties used by the sdhci_milbeaut driver.
> +
> +Required properties:
> +- compatible: "socionext,milbeaut-m10v-sdhci-3.0"
> +- clocks: Must contain an entry for each entry in clock-names. It is a
> +  list of phandles and clock-specifier pairs.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names: Should contain the following two entries:
> +       "iface" - clock used for sdhci interface
> +       "core"  - core clock for sdhci controller
> +
> +Optional properties:
> +- vqmmc-supply: phandle to the regulator device tree node, mentioned
> +  as the VCCQ/VDD_IO supply in the eMMC/SD specs.
> +- fujitsu,cmd-dat-delay-select: boolean property indicating that this host
> +  requires the CMD_DAT_DELAY control to be enabled.
> +- sni,mmc-power-gpio: set property indicating that power on or off needs
> +  control of gpios.

Please use a vmmc-supply instead of "power-gpio" (which means you need
to model this as a fixed GPIO regulator).

> +
> +Example:
> +       sdhci3: mmc@1b010000 {
> +               compatible = "socionext,milbeaut-m10v-sdhci-3.0";
> +               reg = <0x1b010000 0x10000>;
> +               interrupts = <0 265 0x4>;
> +               voltage-ranges = <3300 3300>;
> +               bus-width = <4>;
> +               clocks = <&clk 7>, <&ahb_clk>;
> +               clock-names = "core", "iface";
> +               cap-sdio-irq;
> +               sni,mmc-power-gpio = <&pinctrl 53 GPIO_ACTIVE_HIGH>;
> +                       fujitsu,cmd-dat-delay-select;
> +       };
> --
> 1.9.1
>
>

Kind regards
Uffe
