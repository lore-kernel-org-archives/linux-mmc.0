From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 05/12] dt: bindings: Add bindings for Marvell Xenon SD
 Host Controller
Date: Thu, 26 Jan 2017 11:49:52 +0100
Message-ID: <CAPDyKFrCxk37uVZ4wM-=iwX3-Cn9j+uh1KneJoopVzia2nKTVA@mail.gmail.com>
References: <cover.8527229dae6c124f24c5e637430c2cdc86f80392.1484154449.git-series.gregory.clement@free-electrons.com>
 <89c95d0084da6ad7132caa54ca66eb619d8a5090.1484154449.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <89c95d0084da6ad7132caa54ca66eb619d8a5090.1484154449.git-series.gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk <linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ziji Hu <huziji@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan
List-Id: linux-mmc@vger.kernel.org

On 11 January 2017 at 18:19, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> From: Hu Ziji <huziji@marvell.com>
>
> Marvell Xenon SDHC can support eMMC/SD/SDIO.
> Add Xenon-specific properties.
> Also add properties for Xenon PHY setting.
>
> Signed-off-by: Hu Ziji <huziji@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

An overall comment. Please run a spell-checking as I noticed some
simple errors that needs to be fixed.

Optional Properties:
> +- mmccard:
> +  mmccard child node must be provided when current SDHC is for eMMC.
> +  Xenon SDHC often can support both SD and eMMC. This child node indicates that
> +  current SDHC is for eMMC card. Thus Xenon eMMC specific configuration and
> +  operations can be enabled prior to eMMC init sequence.
> +  Please refer to Documentation/devicetree/bindings/mmc/mmc-card.txt.
> +  This child node should not be set if current Xenon SDHC is for SD/SDIO.
> +
> +- bus-width:
> +  When 8-bit data bus width is in use for eMMC, this property should be
> +  explicitly provided and set as 8.
> +  It is optional when data bus width is 4-bit or 1-bit.
> +
> +- mmc-ddr-1_8v:
> +  Select this property when eMMC HS DDR is supported on SDHC side.
> +
> +- mmc-hs400-1_8v:
> +  Select this property when eMMC HS400 is supported on SDHC side.

All the above properties is already specified as common mmc bindings.
Let's not do that again, but instead just refer to mmc.txt as how
other documentations looks like.

> +
> +- no-1-8-v:
> +  Select this property when 1.8V signaling voltage supply is unavailable.
> +  When this property is enabled, both mmc-ddr-1_8v and mmc-hs400-1_8v should be
> +  cleared.

Please don't use this sdhci property, unless really needed.

Perhaps you can elaborate exactly why it makes sense for your case. Or
perhaps we already discussed this, in either case, please re-fresh my
mind.

[...]

Kind regards
Uffe
