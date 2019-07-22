From: Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH 08/18] clk: bcm2835: Add BCM2711_CLOCK_EMMC2 support
Date: Mon, 22 Jul 2019 10:30:43 +0000
Message-ID: <d18150b3-3c0e-04d3-c40e-c418dcdbcafd@suse.com>
References: <1563774880-8061-1-git-send-email-wahrenst@gmx.net>
 <1563774880-8061-9-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1563774880-8061-9-git-send-email-wahrenst@gmx.net>
Content-Language: en-US
Content-ID: <11962E45BAF04149AAFFB38C069C7677@namprd18.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <wahrenst@gmx.net>, Eric Anholt <eric@anholt.net>, Mark
 Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, "linux-rpi-kernel@lists.infradead.org" <linux-rpi-kernel@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org



On 22/07/2019 07:54, Stefan Wahren wrote:
> The new BCM2711 supports an additional clock for the emmc2 block.
> So add a new compatible and register this clock only for BCM2711.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>  drivers/clk/bcm/clk-bcm2835.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index 3231b76..fbdc4e1 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -114,6 +114,8 @@
>  #define CM_AVEODIV		0x1bc
>  #define CM_EMMCCTL		0x1c0
>  #define CM_EMMCDIV		0x1c4
> +#define CM_EMMC2CTL		0x1d0
> +#define CM_EMMC2DIV		0x1d4
> 
>  /* General bits for the CM_*CTL regs */
>  # define CM_ENABLE			BIT(4)
> @@ -290,7 +292,8 @@
>  #define BCM2835_MAX_FB_RATE	1750000000u
> 
>  #define SOC_BCM2835		BIT(0)
> -#define SOC_ALL			(SOC_BCM2835)
> +#define SOC_BCM2711		BIT(1)
> +#define SOC_ALL			(SOC_BCM2835 | SOC_BCM2711)
> 
>  /*
>   * Names of clocks used within the driver that need to be replaced
> @@ -1999,6 +2002,16 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
>  		.frac_bits = 8,
>  		.tcnt_mux = 39),
> 
> +	/* EMMC2 clock (only available for BCM2711) */
> +	[BCM2711_CLOCK_EMMC2]	= REGISTER_PER_CLK(
> +		SOC_BCM2711,
> +		.name = "emmc2",
> +		.ctl_reg = CM_EMMC2CTL,
> +		.div_reg = CM_EMMC2DIV,
> +		.int_bits = 4,
> +		.frac_bits = 8,
> +		.tcnt_mux = 42),
> +
>  	/* General purpose (GPIO) clocks */
>  	[BCM2835_CLOCK_GP0]	= REGISTER_PER_CLK(
>  		SOC_ALL,
> @@ -2230,6 +2243,7 @@ static int bcm2835_clk_probe(struct platform_device *pdev)
> 
>  static const struct of_device_id bcm2835_clk_of_match[] = {
>  	{ .compatible = "brcm,bcm2835-cprman", .data = (void *)SOC_BCM2835 },
> +	{ .compatible = "brcm,bcm2711-cprman", .data = (void *)SOC_BCM2711 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, bcm2835_clk_of_match);
> --
> 2.7.4
> 
> 
