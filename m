From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v1 1/5] ARM: imx28: add basic dt support
Date: Wed, 14 Mar 2012 20:41:23 +0100
Message-ID: <20120314194123.GR26642@pengutronix.de>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
 <1331628428-24017-2-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1331628428-24017-2-git-send-email-b29396@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@freescale.com, kernel@pengutronix.de, grant.likely@secretlab.ca, rob.herring@calxeda.com, cjb@laptop.org, rdunlap@xenotime.net, vinod.koul@linux.intel.com
List-Id: linux-mmc@vger.kernel.org

On Tue, Mar 13, 2012 at 04:47:04PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> This patch includes basic dt support which can boot via nfs rootfs.
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt |    4 +
>  arch/arm/boot/dts/imx28-evk.dts               |   31 +++++++++
>  arch/arm/boot/dts/imx28.dtsi                  |   88 +++++++++++++++++++++++++
>  arch/arm/mach-mxs/Kconfig                     |    9 +++
>  arch/arm/mach-mxs/Makefile                    |    1 +
>  arch/arm/mach-mxs/imx28-dt.c                  |   67 +++++++++++++++++++
>  6 files changed, 200 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
> index 54bddda..9f21faf 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.txt
> +++ b/Documentation/devicetree/bindings/arm/fsl.txt
> @@ -1,6 +1,10 @@

> +
> +static const char *imx28_dt_compat[] __initdata = {
> +	"fsl,imx28-evk",
> +	NULL,
> +};
> +

I suggest to add a generic "fsl,imx28" entry here. It helps people to
start an unpatched kernel on their boards.

Sascha

> +DT_MACHINE_START(IMX28, "Freescale i.MX28 (Device Tree)")
> +	.map_io		= mx28_map_io,
> +	.init_irq	= imx28_dt_init_irq,
> +	.timer		= &imx28_timer,
> +	.init_machine	= imx28_init,
> +	.dt_compat	= imx28_dt_compat,
> +	.restart	= mxs_restart,
> +MACHINE_END
> -- 
> 1.7.0.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
