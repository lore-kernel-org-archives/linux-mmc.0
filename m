From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] dt-bindings: mmc: aspeed: Update example ranges property
Date: Tue, 27 Aug 2019 15:49:39 +0200
Message-ID: <CAPDyKFroS-Z+4QYitmYrCugPV_f4u1MDJiRkDxGWvVjsU=9RgA@mail.gmail.com>
References: <20190826021620.11915-1-andrew@aj.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190826021620.11915-1-andrew@aj.id.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Jeffery <andrew@aj.id.au>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Joel Stanley <joel@jms.id.au>, DTML <devicetree@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-aspeed <linux-aspeed@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 26 Aug 2019 at 04:15, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The example node in the binding uses the AST2500 compatible string for
> the SD controller with a 64kiB ranges property, but the SD controller is
> allocated 128kiB of MMIO space according to the AST2500 datasheet. Fix
> the example to correctly reflect the hardware in the AST2500, however it
> should be noted that the MMIO region is reduced to 64kiB in the AST2600
> where a second SD controller block has been introduced into the address
> space.
>
> Also add the IBM copyright header that I left out of the initial patch.
>
> Suggested-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Applied for next, thanks!

FYI, I took the liberty to amend all aspeed patches, by putting
"sdhci-of-aspeed" as the prefix of the commit message header.

Kind regards
Uffe


> ---
> Hi Ulf, this is the follow-up fix as discussed here:
>
> http://patchwork.ozlabs.org/patch/1143090/
>
>  Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> index 570f8c72662b..200de9396036 100644
> --- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright 2019 IBM Corp.
>  %YAML 1.2
>  ---
>  $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
> @@ -84,7 +85,7 @@ examples:
>              reg = <0x1e740000 0x100>;
>              #address-cells = <1>;
>              #size-cells = <1>;
> -            ranges = <0 0x1e740000 0x10000>;
> +            ranges = <0 0x1e740000 0x20000>;
>              clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
>
>              sdhci0: sdhci@100 {
> --
> 2.20.1
>
