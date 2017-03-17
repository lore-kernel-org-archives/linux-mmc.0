From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v12 1/9] dt-bindings: mmc: Add Cavium SOCs MMC bindings
Date: Fri, 17 Mar 2017 09:31:23 +0100
Message-ID: <CAPDyKFqVHN--=AWttMz_uDEkGTO+aX8APM34enDuVxqM6XKYJg@mail.gmail.com>
References: <20170310132507.32025-1-jglauber@cavium.com> <20170310132507.32025-2-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:35070 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbdCQIbZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Mar 2017 04:31:25 -0400
Received: by mail-ua0-f181.google.com with SMTP id q7so40108266uaf.2
        for <linux-mmc@vger.kernel.org>; Fri, 17 Mar 2017 01:31:24 -0700 (PDT)
In-Reply-To: <20170310132507.32025-2-jglauber@cavium.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, David Daney <david.daney@cavium.com>

On 10 March 2017 at 14:24, Jan Glauber <jglauber@cavium.com> wrote:
> Add description of Cavium Octeon and ThunderX SOC device tree bindings.
>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: devicetree@vger.kernel.org
>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> Acked-by: Rob Herring <robh+dt@kernel.org>
> ---
>  .../devicetree/bindings/mmc/cavium-mmc.txt         | 58 ++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/cavium-mmc.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/cavium-mmc.txt b/Documentation/devicetree/bindings/mmc/cavium-mmc.txt
> new file mode 100644
> index 0000000..225c2be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/cavium-mmc.txt
> @@ -0,0 +1,58 @@
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

Just realized that I forgotten to follow up about the details for I
think we should generally describe slots nodes in DT.

Currently we treat a child node of a host device node, with reg=0 as
being an embedded mmc card [1] (in case it has the "mmc-card"
compatible set).
When reg is 1->7, those are reserved for SDIO function nodes [2] (as
those can be exactly 7, according to the SDIO spec).

Let's take the above into account and consider that a slot node may
also require a its own child node as to describe an embedded mmc card
or SDIO funcs. In this context I don't think it makes sense to use SoC
specific compatibles for slot nodes, instead I suggest we use only
"mmc-slot".

Does that makes sense?

> +                       vmmc-supply = <&mmc_supply_3v3>;
> +                       max-frequency = <42000000>;
> +                       bus-width = <4>;
> +                       cap-sd-highspeed;
> +               };
> +
> +               mmc-slot@1 {
> +                       compatible = "cavium,thunder-8390-mmc-slot";
> +                       reg = <1>;
> +                       vmmc-supply = <&mmc_supply_3v3>;
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
