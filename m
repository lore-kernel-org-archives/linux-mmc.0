From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 6/6] mmc: sdhci-s3c: Add device tree support
Date: Tue, 10 Apr 2012 17:37:41 -0400
Message-ID: <87wr5ntgii.fsf@laptop.org>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
	<201203271619.13320.arnd@arndb.de> <4F7553D1.4030008@st.com>
	<201203301136.05038.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51364 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755624Ab2DJViE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Apr 2012 17:38:04 -0400
In-Reply-To: <201203301136.05038.arnd@arndb.de> (Arnd Bergmann's message of
	"Fri, 30 Mar 2012 11:36:04 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Viresh Kumar <viresh.kumar@st.com>, Thomas Abraham <thomas.abraham@linaro.org>, Lee Jones <lee.jones@linaro.org>, Rajendra Nayak <rnayak@ti.com>, Stephen Warren <swarren@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "patches@linaro.org" <patches@linaro.org>

Hi Arnd,

(Diff truncated to show relevant hunks.)

On Fri, Mar 30 2012, Arnd Bergmann wrote:
> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> index dbd4368..90b86e5 100644
> --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> @@ -15,10 +15,10 @@ Optional properties:
>  ti,dual-volt: boolean, supports dual voltage cards
>  <supply-name>-supply: phandle to the regulator device tree node
>  "supply-name" examples are "vmmc", "vmmc_aux" etc
> -ti,bus-width: Number of data lines, default assumed is 1 if the property is missing.
> +bus-width: Number of data lines, default assumed is 1 if the property is missing.
>  cd-gpios: GPIOs for card detection
>  wp-gpios: GPIOs for write protection
> -ti,non-removable: non-removable slot (like eMMC)
> +non-removable: non-removable slot (like eMMC)
>  ti,needs-special-reset: Requires a special softreset sequence
>  
>  Example:
> @@ -27,7 +27,7 @@ Example:
>  		reg = <0x4809c000 0x400>;
>  		ti,hwmods = "mmc1";
>  		ti,dual-volt;
> -		ti,bus-width = <4>;
> +		bus-width = <4>;
>  		vmmc-supply = <&vmmc>; /* phandle to regulator node */
>  		ti,non-removable;
>  	};
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 47adb16..ae48fc7 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1766,7 +1766,7 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
>  		pdata->slots[0].nonremovable = true;
>  		pdata->slots[0].no_regulator_off_init = true;
>  	}
> -	of_property_read_u32(np, "ti,bus-width", &bus_width);
> +	of_property_read_u32(np, "bus-width", &bus_width);
>  	if (bus_width == 4)
>  		pdata->slots[0].caps |= MMC_CAP_4_BIT_DATA;
>  	else if (bus_width == 8)

Here you change "ti,non-removable" to "non-removable" in the properties
section of ti-omap-hsmmc.txt without changing it in the example section
of that document, or in the code or shipped .dts files.

(Presumably you decided to preserve it for backwards compatibility, so
the bindings documentation shouldn't be changed.)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
