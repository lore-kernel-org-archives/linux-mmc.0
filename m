From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH Resend 1/2] mmc: sdhci-spear: add device tree bindings
Date: Fri, 28 Sep 2012 05:03:41 -0400
Message-ID: <87lifuv7rm.fsf@octavius.laptop.org>
References: <viresh.kumar@linaro.org>
	<a42729885c593f61bb62c45f229174d9f7370c40.1348809217.git.viresh.kumar2@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46462 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619Ab2I1JDu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 28 Sep 2012 05:03:50 -0400
In-Reply-To: <a42729885c593f61bb62c45f229174d9f7370c40.1348809217.git.viresh.kumar2@arm.com>
	(Viresh Kumar's message of "Fri, 28 Sep 2012 10:48:08 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: spear-devel@list.st.com, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, sr@denx.de

Hi Viresh,

On Fri, Sep 28 2012, Viresh Kumar wrote:
> This adds simple DT bindings for SDHCI SPEAr controller. It uses cd-gpios from
> common mmc bindings.
>
> This also fixes spear300-evb.dts with correct name for card detect binding.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V1->resend:
> - Use cd-gpios instead of int-gpio as binding for card detect gpio.
> - Fix spear300-evb.dts binding name for cd-gpios
>
> .../devicetree/bindings/mmc/sdhci-spear.txt        | 28 +++++++++
>  arch/arm/boot/dts/spear300-evb.dts                 |  2 +-
>  drivers/mmc/host/sdhci-spear.c                     | 71 +++++++++++++++++++++-
>  3 files changed, 98 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-spear.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-spear.txt b/Documentation/devicetree/bindings/mmc/sdhci-spear.txt
> new file mode 100644
> index 0000000..cd34a05
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-spear.txt
> @@ -0,0 +1,28 @@
> +* SPEAr SDHCI Controller
> +
> +Required properties:
> +- compatible : "st,spear300-sdhci"
> +- reg : Address range of the sdhci
> +- interrupt-parent: Should be the phandle for the interrupt controller
> +  that services interrupts for this device
> +- interrupt: Should contain the sdhci interrupt number

You don't have to mention reg/interrupts, because they're already
covered in mmc.txt.

> +Optional Properties:
> +- cd-gpios: card detect gpio, with zero flags.
> +- power-gpio: specifies the power gpio pin with flags: active low:1, active
> +  high:0
> +- power_always_enb: power should be on before inserting the card and so can't be
> +  switched off. Only valid when power gpio is supported.

power-gpio should be "power-gpios" (even though there's only one), and
power_always_enb should use hyphens instead of underscores, but I have
a more fundamental request:

You should use a fixed regulator instead of this power-gpio hack.
It's easy to hook up a fixed regulator to a gpio:

        vmmc1: fixedregulator@0 {
                compatible = "regulator-fixed";
                regulator-name = "fixed-supply";
                regulator-min-microvolt = <1800000>;
                regulator-max-microvolt = <1800000>;
                gpio = <&gpio1 16 0>;
                startup-delay-us = <70000>;
                vin-supply = <&parent_reg>;
        };

and then you can encode the regulator inside your SD host:

	sdhci@fc000000 {
		compatible = "st,spear300-sdhci";
		reg = <0xfc000000 0x1000>;
		cd-gpios = <&gpio0 6 0>;
		vmmc-supply = <&vmmc1>;
	};

and the MMC core will take care of making sure that it's powered up
only when needed.  What do you think?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
