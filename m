From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/6] dt-bindings: phy: am654-mmc-phy: Document new phy bindings
Date: Mon, 8 Oct 2018 13:29:55 +0200
Message-ID: <CAPDyKFpHJBebps9Z36MMykfXFWnn3bPZOf2=K8aA2OTXa8W7nQ@mail.gmail.com>
References: <20181004111451.9539-1-faiz_abbas@ti.com> <20181004111451.9539-2-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004111451.9539-2-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kishon <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

[...]

> +Host controller node:
> +
> +                       sdhci1: sdhci@0 {
> +                               compatible = "ti,am654-sdhci-5.1";
> +                               reg = <0x0 0x1000>;
> +                               power-domains = <&k3_pds 48>;
> +                               clocks = <&k3_clks 48 0>, <&k3_clks 48 1>;
> +                               clock-names = "clk_ahb", "clk_xin";
> +                               interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
> +                               clock-output-names = "mmc_cardclck";

mmc_cardclk

> +                               #clock-cells = <0>;
> +                               phys=<&mmc_phy1>;
> +                               phy-names = "phy_arasan";
> +                               status = "disabled";
> +                       };
> --
> 2.18.0
>

Besides the nitpick and the comments from Andrew, this looks good to me.

Kind regards
Uffe
