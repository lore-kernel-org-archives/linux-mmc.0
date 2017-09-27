From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC v2 0/2] Add support for Meson MX "SDIO" MMC controller
Date: Wed, 27 Sep 2017 14:36:16 -0500
Message-ID: <20170927193616.32gxszmk4cjjoqmo@rob-hp-laptop>
References: <20170924190528.21841-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170924190528.21841-1-martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Sun, Sep 24, 2017 at 09:05:26PM +0200, Martin Blumenstingl wrote:
> This is the successor to Carlo Caione's "Add support for Amlogic Meson
> MMC driver" series (v5) from [0].
> This new driver is for the "SDIO" controller found in Amlogic Meson6,
> Meson8 and Meson8b SoCs and supports an internal mux to allow connecting
> three cards to it.
> 
> 
> changes since RFC v1 at [1]:
> - added COMMON_CLK dependency as reported by the kbuild test robot
> - use of_platform_device_{create,destroy} instead of open-coding it's
>   logic
> - moved struct device (which was an array) from meson_mx_mmc_host to
>   the corresponding meson_mx_mmc_slot
> - use struct mmc_command's busy_timeout instead of hard-coding the
>   timeout values in meson_mx_mmc_start_cmd()
> - don't use arrays with only one element for the clock parents in
>   meson_mx_mmc_register_clks()
> - removed the wrapper functions meson_mx_mmc_readl() meson_mx_mmc_writel()
> - allow setting the MMC clock to 0 for UHS speed mode (the actual
>   hardware clock cannot be gated as far as I know, so instead the
>   lowest supported rate is chosen)
> - remove unused #include <linux/init.h>
> - add MMC_CAP_ERASE
> - removed multiple slot support after discussing this with Ulf
>   (this is a feature that needs to be part of the MMC core before drivers
>   can use it)
> - removed SDIO interrupt support (as I currently don't have a way to
>   test it)
> - merge meson_mx_mmc_apply_ios into meson_mx_mmc_set_ios (as that's
>   the only place where it's needed after removing multiple slot support)
> - updated the commit message of the driver patch to indicate the
>   difference between the meson-mx-sdio.c and meson-gx.c (and the "still
>   missing SDHC") driver
> - NOTE: I did not add Rob's ACK on the dt-bindings patch because I
>   introduced the "mmc-slot" compatible for the child nodes as suggested
>   by Ulf (and I want confirmation from the DT maintainers that I did this
>   correctly)

Didn't slot support get removed as no h/w really uses that feature?

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
