From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v11 1/9] dt-bindings: mmc: Add Cavium SOCs MMC bindings
Date: Fri, 3 Mar 2017 12:47:06 +0100
Message-ID: <CAPDyKFrE546UMc3QBHw_C1a6Dz5mOQfURroiCBTOV3SbreR-EQ@mail.gmail.com>
References: <20170206133953.8390-1-jglauber@cavium.com> <20170206133953.8390-2-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170206133953.8390-2-jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Cc: "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "Steven J . Hill" <Steven.Hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 6 February 2017 at 14:39, Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org> wrote:
> Add description of Cavium Octeon and ThunderX SOC device tree bindings.
>
> CC: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> CC: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> CC: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> CC: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>
> Signed-off-by: Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> Signed-off-by: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Steven J. Hill <steven.hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> ---
>  .../devicetree/bindings/mmc/cavium-mmc.txt         | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/cavium-mmc.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/cavium-mmc.txt b/Documentation/devicetree/bindings/mmc/cavium-mmc.txt
> new file mode 100644
> index 0000000..b79e356
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/cavium-mmc.txt
> @@ -0,0 +1,60 @@
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
> +   cavium,octeon-6130-mmc
> +   cavium,octeon-6130-mmc-slot
> +   cavium,octeon-7890-mmc
> +   cavium,octeon-7890-mmc-slot
> +   cavium,thunder-8190-mmc
> +   cavium,thunder-8190-mmc-slot
> +   cavium,thunder-8390-mmc
> +   cavium,thunder-8390-mmc-slot
> + - reg : mmc controller base registers
> + - clocks : phandle
> +
> +Optional properties:
> + - for cd, bus-width and additional generic mmc parameters
> +   please refer to mmc.txt within this directory
> + - cavium,cmd-clk-skew : number of coprocessor clocks before sampling command
> + - cavium,dat-clk-skew : number of coprocessor clocks before sampling data
> +
> +Deprecated properties:
> +- spi-max-frequency : use max-frequency instead
> +- cavium,bus-max-width : use bus-width instead
> +
> +Examples:
> +       mmc_1_4: mmc@1,4 {
> +               compatible = "cavium,thunder-8390-mmc";
> +               reg = <0x0c00 0 0 0 0>; /* DEVFN = 0x0c (1:4) */
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               clocks = <&sclk>;
> +
> +               mmc-slot@0 {
> +                       compatible = "cavium,thunder-8390-mmc-slot";
> +                       reg = <0>;
> +                       voltage-ranges = <3300 3300>;
> +                       vmmc-supply = <&mmc_supply_3v3>;

The vmmc supply as a regulator provides you with the voltage range,
thus you don't need the "voltage-ranges" here. Please remove this.

> +                       max-frequency = <42000000>;
> +                       bus-width = <4>;
> +                       cap-sd-highspeed;
> +               };
> +
> +               mmc-slot@1 {
> +                       compatible = "cavium,thunder-8390-mmc-slot";
> +                       reg = <1>;
> +                       voltage-ranges = <3300 3300>;
> +                       vmmc-supply = <&mmc_supply_3v3>;

Ditto.

> +                       max-frequency = <42000000>;
> +                       bus-width = <8>;
> +                       cap-mmc-highspeed;
> +                       non-removable;
> +               };
> +       };
> --
> 2.9.0.rc0.21.g7777322
>

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
