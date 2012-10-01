From: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: sdhci-tegra and power-gpios
Date: Mon, 01 Oct 2012 11:15:29 -0400
Message-ID: <87vceunrzi.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Stephen, tegra folks,

sdhci-tegra uses a power-gpios property in the DT:

        sdhci@c8000400 {
                status = "okay";
                cd-gpios = <&gpio 69 0>; /* gpio PI5 */
                wp-gpios = <&gpio 57 0>; /* gpio PH1 */
                power-gpios = <&gpio 70 0>; /* gpio PI6 */
                bus-width = <4>;
        };

which it turns on at probe-time in the driver:

        plat->power_gpio = of_get_named_gpio(np, "power-gpios", 0);
        ...
	if (gpio_is_valid(plat->power_gpio)) {
		rc = gpio_request(plat->power_gpio, "sdhci_power");
		if (rc) {
			dev_err(mmc_dev(host->mmc),
				"failed to allocate power gpio\n");
			goto err_power_req;
		}
		gpio_direction_output(plat->power_gpio, 1);
	}

and then leaves on forever.  Seems like this should instead be a fixed
regulator (vmmc-supply) -- the MMC core would handle powering it up and
down as needed, and it's cleaner to let the regulator subsystem handle
power changes like this.  It might save you some power, too.

It's quite easy to set up a regulator and attach it to an MMC node:

        vmmc1: fixedregulator@0 {
                compatible = "regulator-fixed";
                regulator-name = "fixed-supply";
                regulator-min-microvolt = <2200000>;
                regulator-max-microvolt = <2200000>;
                gpio = <&gpio 70 0>; /* gpio PI6 */
                startup-delay-us = <70000>;
                vin-supply = <&parent_reg>;
        };
..
        sdhci@c8000400 {
                status = "okay";
                cd-gpios = <&gpio 69 0>; /* gpio PI5 */
                wp-gpios = <&gpio 57 0>; /* gpio PH1 */
		vmmc-supply = <&vmmc1>;
                bus-width = <4>;
        };

Any interest in making this change?  I've asked other drivers
(sdhci-pxav3 and sdhci-spear) to do the same thing (although
they hadn't merged their use of power-gpios yet and tegra has).

Thanks,

- Chris.
-- 
Chris Ball   <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>   <http://printf.net/>
One Laptop Per Child
