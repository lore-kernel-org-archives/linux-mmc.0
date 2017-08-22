From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/5] dt-bindings: sdhci-omap: Add bindings for the
 sdhci-omap controller
Date: Tue, 22 Aug 2017 10:39:30 -0700
Message-ID: <20170822173929.GL6008@atomide.com>
References: <20170821142132.GH6008@atomide.com>
 <20170822133907.21549-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:37518 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751496AbdHVRjl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 22 Aug 2017 13:39:41 -0400
Content-Disposition: inline
In-Reply-To: <20170822133907.21549-1-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [170822 06:39]:
> Add binding for the TI's sdhci-omap controller. This now includes only
> a subset of properties documented in ti-omap-hsmmc.txt but will eventually
> include all the properties.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> Changes from v1:
> *) Create a new sdhci-omap.txt document for TI's sdhci-omap controller instead
>    of using the ti-omap-hsmmc.txt as suggested by Tony

Works for me thanks, just one typo below..

>  .../devicetree/bindings/mmc/sdhci-omap.txt         | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> new file mode 100644
> index 000000000000..139695ad2d58
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> @@ -0,0 +1,22 @@
> +* TI OMAP SDHCI Controller
> +
> +Refer to mmc.txt for standard MMC bindings.
> +
> +Required properties:
> +- compatible: Should be "ti,dra7-sdhci" for DRA7 and DRA72 controllers
> +- ti,hwmods: Must be "mmc<n>", <n> is controller instance starting 1
> +
> +Optional properties:
> +- ti,dual-volt: boolean, supports dual voltage cards
> +- ti,non-removable: non-removable slot (like eMMC)
> +
> +Example:
> +	mmc1: mmc@0x4809c000 {
> +		compatible = "ti,omap4-hsmmc";

The compatible in the example here is still using hsmmc :)

Tony
