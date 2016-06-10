From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 08/12] dt-bindings: mmc: Add Xenon description
Date: Fri, 10 Jun 2016 09:16:03 -0500
Message-ID: <20160610141603.GA7827@rob-hp-laptop>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
 <1465456218-28354-9-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36279 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbcFJOQG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jun 2016 10:16:06 -0400
Content-Disposition: inline
In-Reply-To: <1465456218-28354-9-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Romain Perier <romain.perier@free-electrons.com>, Omri Itach <omrii@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, Shadi Ammouri <shadi@marvell.com>

On Thu, Jun 09, 2016 at 09:10:14AM +0200, Gregory CLEMENT wrote:
> This patch documents the Xenon SDHCI controller that we can find in the
> Armada 37xx and the Armada 7K and 8K SoCs.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  .../devicetree/bindings/mmc/sdhci-xenon.txt        | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-xenon.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-xenon.txt b/Documentation/devicetree/bindings/mmc/sdhci-xenon.txt
> new file mode 100644
> index 000000000000..e8d49fda5f12
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-xenon.txt
> @@ -0,0 +1,27 @@
> +* Marvell sdhci-xenon controller
> +
> +This file documents differences between the core properties in mmc.txt
> +and the properties used by the sdhci-xenon drivers.

Bindings don't document drivers...

> +
> +Required properties:
> +- compatible: Should be "marvell,xenon-sdhci".

SoC specific compatible strings please. This one can be fallback.

> +- reg:
> +  one register area for the SDHCI registers.
> +- interrupts-extended: interrupt number and attributes

Just use interrupts unless you really have a need for 
interrupts-extended. Really, either is valid for any binding, but I 
prefer to just have bindings documented one way.

> +- clocks: array of clocks required for SDHCI.

Missing from the exmaple, and how many clocks and in what order?

> +- bus-width: max bus width in unit of bit, normally should be 1 bit, 4 bits or 8 bits

Isn't this one standard? Just refer back to the common binding.

> +
> +Optional properties:
> +- non-removable: whether card is non-removable.
> +- auto-cmd12: whether cmd12 is sent automatically.

Seems strange this would be optional for a specific controller. I'd 
expect either the xenon controller needs this or not.

> +Example:
> +
> +sdhci0: sdhci@D8000 {
> +	compatible = "marvell,xenon-sdhci";
> +	reg = <0xD8000 0x300>;
> +	interrupts-extended = <&gic GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +	non-removable;
> +	bus-width = <8>;
> +	auto-cmd12;
> +	status = "disabled";
> +};
> -- 
> 2.5.0
> 
