From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 3/4] mmc: omap_hsmmc: Use GPIO offset for external GPIO
 chips
Date: Fri, 02 Mar 2012 11:32:52 +0530
Message-ID: <4F50628C.9080706@ti.com>
References: <20120301185044.29210.44521.stgit@kaulin.local> <20120301185532.29210.32421.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120301185532.29210.32421.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linuxkernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Friday 02 March 2012 12:25 AM, Tony Lindgren wrote:
> We can now remove the setting of GPIO pins with callbacks
> as the drivers can access a GPIO offset on a named gpio_chip
> directly with gpio_find_by_chip_name().
>
> Cc: Rajendra Nayak<rnayak@ti.com>
> Signed-off-by: Tony Lindgren<tony@atomide.com>
> ---
>   arch/arm/mach-omap2/board-3430sdp.c          |   13 ++++---------
>   arch/arm/mach-omap2/board-cm-t35.c           |    8 ++------
>   arch/arm/mach-omap2/board-devkit8000.c       |    7 ++-----
>   arch/arm/mach-omap2/board-igep0020.c         |    8 ++------
>   arch/arm/mach-omap2/board-omap3beagle.c      |    9 +++------
>   arch/arm/mach-omap2/board-omap3evm.c         |    8 ++------
>   arch/arm/mach-omap2/board-omap3pandora.c     |   13 ++++---------
>   arch/arm/mach-omap2/board-omap3stalker.c     |    8 ++------
>   arch/arm/mach-omap2/board-omap3touchbook.c   |    7 ++-----
>   arch/arm/mach-omap2/board-zoom-peripherals.c |    7 ++-----
>   10 files changed, 25 insertions(+), 63 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
> index da75f23..238b95a 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -231,14 +231,16 @@ static struct omap2_hsmmc_info mmc[] = {
>   		 * so the SIM card isn't used; else 4 bits.
>   		 */
>   		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
> +		.gpiochip_cd	= "twl4030_gpio",
> +		.gpio_cd	= 0,	/* mmc0_cd offset in twl4030 */
>   		.gpio_wp	= 4,
> -		.deferred	= true,

Shouldn't this patch completely get rid of all the 'deferred'
infrastructure that was put in place, including the 
omap_hsmmc_late_init() function, since there is no need for it
anymore?

>   	},
[..]

>   	/*
>   	 * Most GPIOs are for USB OTG.  Some are mostly sent to
>   	 * the P2 connector; notably LEDA for the LCD backlight.
> diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
> index ace466b..b387264 100644
> --- a/arch/arm/mach-omap2/board-omap3pandora.c
> +++ b/arch/arm/mach-omap2/board-omap3pandora.c
> @@ -270,19 +270,19 @@ static struct omap2_hsmmc_info omap3pandora_mmc[] = {
>   	{
>   		.mmc		= 1,
>   		.caps		= MMC_CAP_4_BIT_DATA,
> -		.gpio_cd	= -EINVAL,
> +		.gpiochip_cd	= "twl4030_gpio",
> +		.gpio_cd	= 0,	/* mmc0_cd offset in twl4030 */
>   		.gpio_wp	= 126,
>   		.ext_clock	= 0,
> -		.deferred	= true,
>   	},
>   	{
>   		.mmc		= 2,
>   		.caps		= MMC_CAP_4_BIT_DATA,
> -		.gpio_cd	= -EINVAL,
> +		.gpiochip_cd	= "twl4030_gpio",
> +		.gpio_cd	= 0,	/* mmc0_cd offset in twl4030 */

This one should be gpio_cd = 1,

regards,
Rajendra

>   		.gpio_wp	= 127,
>   		.ext_clock	= 1,
>   		.transceiver	= true,
> -		.deferred	= true,
>   	},
>   	{
>   		.mmc		= 3,
> @@ -299,11 +299,6 @@ static int omap3pandora_twl_gpio_setup(struct device *dev,
>   {
>   	int ret, gpio_32khz;
>
> -	/* gpio + {0,1} is "mmc{0,1}_cd" (input/IRQ) */
> -	omap3pandora_mmc[0].gpio_cd = gpio + 0;
> -	omap3pandora_mmc[1].gpio_cd = gpio + 1;
> -	omap_hsmmc_late_init(omap3pandora_mmc);
> -
>   	/* gpio + 13 drives 32kHz buffer for wifi module */
>   	gpio_32khz = gpio + 13;
>   	ret = gpio_request_one(gpio_32khz, GPIOF_OUT_INIT_HIGH, "wifi 32kHz");
> diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
> index 6410043..6d0deb9 100644
> --- a/arch/arm/mach-omap2/board-omap3stalker.c
> +++ b/arch/arm/mach-omap2/board-omap3stalker.c
> @@ -211,9 +211,9 @@ static struct omap2_hsmmc_info mmc[] = {
>   	{
>   		.mmc		= 1,
>   		.caps		= MMC_CAP_4_BIT_DATA,
> -		.gpio_cd	= -EINVAL,
> +		.gpiochip_cd	= "twl4030_gpio",
> +		.gpio_cd	= 0,	/* mmc0_cd offset in twl4030 */
>   		.gpio_wp	= 23,
> -		.deferred	= true,
>   	 },
>   	{}			/* Terminator */
>   };
> @@ -282,10 +282,6 @@ static int
>   omap3stalker_twl_gpio_setup(struct device *dev,
>   			    unsigned gpio, unsigned ngpio)
>   {
> -	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
> -	mmc[0].gpio_cd = gpio + 0;
> -	omap_hsmmc_late_init(mmc);
> -
>   	/*
>   	 * Most GPIOs are for USB OTG.  Some are mostly sent to
>   	 * the P2 connector; notably LEDA for the LCD backlight.
> diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
> index 8842e04..cf270b8 100644
> --- a/arch/arm/mach-omap2/board-omap3touchbook.c
> +++ b/arch/arm/mach-omap2/board-omap3touchbook.c
> @@ -99,8 +99,9 @@ static struct omap2_hsmmc_info mmc[] = {
>   	{
>   		.mmc		= 1,
>   		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
> +		.gpiochip_cd	= "twl4030_gpio",
> +		.gpio_cd	= 0,	/* mmc0_cd offset in twl4030 */
>   		.gpio_wp	= 29,
> -		.deferred	= true,
>   	},
>   	{}	/* Terminator */
>   };
> @@ -118,10 +119,6 @@ static struct gpio_led gpio_leds[];
>   static int touchbook_twl_gpio_setup(struct device *dev,
>   		unsigned gpio, unsigned ngpio)
>   {
> -	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
> -	mmc[0].gpio_cd = gpio + 0;
> -	omap_hsmmc_late_init(mmc);
> -
>   	/* REVISIT: need ehci-omap hooks for external VBUS
>   	 * power switch and overcurrent detect
>   	 */
> diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
> index 3d39cdb..604df86 100644
> --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> @@ -203,9 +203,10 @@ static struct omap2_hsmmc_info mmc[] = {
>   		.name		= "external",
>   		.mmc		= 1,
>   		.caps		= MMC_CAP_4_BIT_DATA,
> +		.gpiochip_cd	= "twl4030_gpio",
> +		.gpio_cd	= 0,	/* mmc0_cd offset in twl4030 */
>   		.gpio_wp	= -EINVAL,
>   		.power_saving	= true,
> -		.deferred	= true,
>   	},
>   	{
>   		.name		= "internal",
> @@ -232,10 +233,6 @@ static int zoom_twl_gpio_setup(struct device *dev,
>   {
>   	int ret;
>
> -	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
> -	mmc[0].gpio_cd = gpio + 0;
> -	omap_hsmmc_late_init(mmc);
> -
>   	ret = gpio_request_one(LCD_PANEL_ENABLE_GPIO, GPIOF_OUT_INIT_LOW,
>   			       "lcd enable");
>   	if (ret)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

