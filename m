From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v6 07/14] dt: bindings: Add bindings for Marvell Xenon SD
 Host Controller
Date: Wed, 15 Mar 2017 13:48:29 +0100
Message-ID: <CAPDyKFrmb51cTR7B5S0JkmACH0=bw9+28RmWnjwWkuiT7N4wVw@mail.gmail.com>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
 <3a4ce2fd25ed812482b0fc96f50dd305c8f40fe9.1487091464.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <3a4ce2fd25ed812482b0fc96f50dd305c8f40fe9.1487091464.git-series.gregory.clement@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Jimmy Xu <zmxu@marvell.com>, Andrew Lunn <andrew@lunn.ch>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mike Turquette <mturquette@baylibre.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nadav Haklai <nadavh@marvell.com>, Ziji Hu <huziji@marvell.com>, Victor Gu <xigu@marvell.com>, Doug Jones <dougj@marvell.com>, linux-clk <linux-clk@vger.kernel.org>, Jisheng Zhang <jszhang@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Rob Herring <robh+dt@kernel.org>, Ryan Gao <ygao@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lis>
List-Id: linux-mmc@vger.kernel.org

[...]

> +
> +Example:
> +- For eMMC:
> +
> +       sdhci@aa0000 {
> +               compatible = "marvell,armada-ap806-sdhci";
> +               reg = <0xaa0000 0x1000>;
> +               interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>
> +               clocks = <&emmc_clk>;
> +               clock-names = "core";
> +               bus-width = <4>;
> +               marvell,xenon-phy-slow-mode;
> +               marvell,xenon-tun-count = <11>;

There's no vmmc-supply here.

How do you control power to the eMMC card?

> +
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               apm_mmccard: mmccard@0 {
> +                       compatible = "mmc-card";
> +                       reg = <0>;
> +               };
> +       };
> +
> +- For SD/SDIO:
> +
> +       sdhci@ab0000 {
> +               compatible = "marvell,armada-cp110-sdhci";
> +               reg = <0xab0000 0x1000>;
> +               interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>
> +               vqmmc-supply = <&sd_regulator>;

I guess you know vqmmc is for the I/O voltage.

Again, how do you power the SD/SDIO card? No vmmc?

> +               clocks = <&sdclk>;
> +               clock-names = "core";
> +               bus-width = <4>;
> +               marvell,xenon-tun-count = <9>;
> +       };
> +
> +- For eMMC with compatible "marvell,armada-3700-sdhci":
> +
> +       sdhci@aa0000 {
> +               compatible = "marvell,armada-3700-sdhci";
> +               reg = <0xaa0000 0x1000>,
> +                     <phy_addr 0x4>;
> +               interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>
> +               clocks = <&emmcclk>;
> +               clock-names = "core";
> +               bus-width = <8>;
> +               mmc-ddr-1_8v;
> +               mmc-hs400-1_8v;

Again, no vmmc?

> +
> +               marvell,pad-type = "fixed-1-8v";
> +
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               mmccard: mmccard@0 {
> +                       compatible = "mmc-card";
> +                       reg = <0>;
> +               };
> +       };
> +
> +- For SD/SDIO with compatible "marvell,armada-3700-sdhci":
> +
> +       sdhci@ab0000 {
> +               compatible = "marvell,armada-3700-sdhci";
> +               reg = <0xab0000 0x1000>,
> +                     <phy_addr 0x4>;
> +               interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>
> +               vqmmc-supply = <&sd_regulator>;

Again, no vmmc?

> +               clocks = <&sdclk>;
> +               clock-names = "core";
> +               bus-width = <4>;
> +
> +               marvell,pad-type = "sd";
> +       };
> --
> git-series 0.9.1


Kind regards
Uffe
