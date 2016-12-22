From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v10 8/8] dt-bindings: mmc: Add Cavium SOCs MMC bindings
Date: Thu, 22 Dec 2016 14:32:42 -0600
Message-ID: <20161222203242.nxnmqyldtvdxkqhc@rob-hp-laptop>
References: <20161219121552.18316-1-jglauber@cavium.com>
 <20161219121552.18316-9-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161219121552.18316-9-jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "Steven J . Hill" <Steven.Hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Dec 19, 2016 at 01:15:52PM +0100, Jan Glauber wrote:
> Add description of Cavium Octeon and ThunderX SOC device tree bindings.
> 
> CC: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> CC: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> CC: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> CC: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> 
> Signed-off-by: Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> ---
>  .../devicetree/bindings/mmc/octeon-mmc.txt         | 59 ++++++++++++++++++++++

Perhaps cavium-mmc.txt would be more appropriate now.

>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/octeon-mmc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/octeon-mmc.txt b/Documentation/devicetree/bindings/mmc/octeon-mmc.txt
> new file mode 100644
> index 0000000..aad02eb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/octeon-mmc.txt
> @@ -0,0 +1,59 @@
> +* Cavium Octeon & ThunderX MMC controller
> +
> +The highspeed MMC host controller on Caviums SoCs provides an interface
> +for MMC and SD types of memory cards.
> +
> +Supported maximum speeds are the ones of the eMMC standard 4.41 as well
> +as the speed of SD standard 4.0. Only 3.3 Volt is supported.
> +
> +Required properties:
> + - compatible : should be one of:
> +   * "cavium,octeon-6130-mmc"
> +   * "cavium,octeon-6130-mmc-slot"
> +   * "cavium,octeon-7890-mmc"
> +   * "cavium,octeon-7890-mmc-slot"
> +   * "cavium,thunder-8190-mmc"
> +   * "cavium,thunder-8190-mmc-slot"
> +   * "cavium,thunder-8390-mmc"
> +   * "cavium,thunder-8390-mmc-slot"
> + - reg : mmc controller base registers

Following PCI addressing?

> + - clocks : phandle
> +
> +Optional properties:
> + - for cd, bus-width and additional generic mmc parameters
> +   please refer to mmc.txt within this directory
> + - "cavium,cmd-clk-skew" : number of coprocessor clocks before sampling command
> + - "cavium,dat-clk-skew" : number of coprocessor clocks before sampling data
> +
> +Deprecated properties:
> +- spi-max-frequency : use max-frequency instead
> +- "cavium,bus-max-width" : use bus-width instead

Drop the quotes.

> +
> +Examples:
> +	- Within .dtsi:

Don't show the division between files in the example.

> +	mmc_1_4: mmc@1,4 {
> +		compatible = "cavium,thunder-8390-mmc";
> +		reg = <0x0c00 0 0 0 0>;	/* DEVFN = 0x0c (1:4) */
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clocks = <&sclk>;
> +	};
> +
> +	- Within dts:
> +	mmc-slot@0 {

Need to show this is a child node.

> +		compatible = "cavium,thunder-8390-mmc-slot";
> +		reg = <0>;
> +		voltage-ranges = <3300 3300>;
> +		max-frequency = <42000000>;
> +		bus-width = <4>;
> +		cap-sd-highspeed;
> +	};
> +	mmc-slot@1 {
> +		compatible = "cavium,thunder-8390-mmc-slot";
> +		reg = <1>;
> +		voltage-ranges = <3300 3300>;
> +		max-frequency = <42000000>;
> +		bus-width = <8>;
> +		cap-mmc-highspeed;
> +		non-removable;
> +	};
> -- 
> 2.9.0.rc0.21.g7777322
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
