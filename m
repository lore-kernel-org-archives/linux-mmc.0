From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 3/5] dt-bindings: sdhci-omap: Add bindings for the
 sdhci-omap controller
Date: Tue, 29 Aug 2017 12:11:21 -0500
Message-ID: <20170829171121.cxjwrzhbotdkddec@rob-hp-laptop>
References: <20170821142132.GH6008@atomide.com>
 <20170823054246.23927-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35914 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdH2RLY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Aug 2017 13:11:24 -0400
Content-Disposition: inline
In-Reply-To: <20170823054246.23927-1-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Aug 23, 2017 at 11:12:46AM +0530, Kishon Vijay Abraham I wrote:
> Add binding for the TI's sdhci-omap controller. This now includes only
> a subset of properties documented in ti-omap-hsmmc.txt but will eventually
> include all the properties.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> Changes from v2:
> *) Fixed example to use the updated compatible
> 
> Changes from v1:
> *) Create a new sdhci-omap.txt document for TI's sdhci-omap controller instead
>    of using the ti-omap-hsmmc.txt as suggested by Tony
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

Well, if you are doing a new compatible, then why aren't you using 
common properties?

> +
> +Example:
> +	mmc1: mmc@0x4809c000 {

Drop the '0x'.

> +		compatible = "ti,dra7-sdhci";
> +		reg = <0x4809c000 0x400>;
> +		ti,hwmods = "mmc1";
> +		ti,dual-volt;
> +		bus-width = <4>;
> +		vmmc-supply = <&vmmc>; /* phandle to regulator node */
> +		ti,non-removable;
> +	};
> -- 
> 2.11.0
> 
