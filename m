From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 02/12] ARM: ep93xx: vision_ep9307: Use MMC CD and RO GPIO
Date: Fri, 26 Jul 2013 11:54:37 +0200
Message-ID: <1818634.2aPQusYJQq@avalon>
References: <1374794808-21890-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1374794808-21890-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <ADE657CA350FB648AAC2C43247A983F0021DAC5C20AC@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F0021DAC5C20AC@AUSP01VMBX24.collaborationhost.net>
Sender: linux-sh-owner@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, Ryan Mallon <rmallon@gmail.com>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

Hi Hartley,

On Thursday 25 July 2013 19:19:52 H Hartley Sweeten wrote:
> On Thursday, July 25, 2013 4:27 PM, Laurent Pinchart wrote:
> > Pass the CD and RO GPIO numbers to the MMC SPI driver and remove the
> > custom .get_cd() and .get_ro() callback functions.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  arch/arm/mach-ep93xx/vision_ep9307.c | 56  +++---------------------------
> >  1 file changed, 4 insertions(+), 52 deletions(-)
> > 
> > diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c
> > b/arch/arm/mach-ep93xx/vision_ep9307.c index 605956f..ab94dc5 100644
> > --- a/arch/arm/mach-ep93xx/vision_ep9307.c
> > +++ b/arch/arm/mach-ep93xx/vision_ep9307.c
> > @@ -224,62 +224,14 @@ static struct ep93xx_spi_chip_ops
> > vision_spi_flash_hw = {> 
> >  #define VISION_SPI_MMC_WP	EP93XX_GPIO_LINE_F(0)
> >  #define VISION_SPI_MMC_CD	EP93XX_GPIO_LINE_EGPIO15
> > 
> > -static struct gpio vision_spi_mmc_gpios[] = {
> > -	{ VISION_SPI_MMC_WP, GPIOF_DIR_IN, "mmc_spi:wp" },
> > -	{ VISION_SPI_MMC_CD, GPIOF_DIR_IN, "mmc_spi:cd" },
> > -};
> > -
> > -static int vision_spi_mmc_init(struct device *pdev,
> > -			irqreturn_t (*func)(int, void *), void *pdata)
> > -{
> > -	int err;
> > -
> > -	err = gpio_request_array(vision_spi_mmc_gpios,
> > -				 ARRAY_SIZE(vision_spi_mmc_gpios));
> > -	if (err)
> > -		return err;
> > -
> > -	err = gpio_set_debounce(VISION_SPI_MMC_CD, 1);
> > -	if (err)
> > -		goto exit_err;
> 
> I tested this and it _kind_ of works.
> 
> The card detect is a bit flaky due to the gpio interrupt debounce not being
> enabled.
> 
> The only way I can see to fix this is add the following to this patch:
> 
> @@ -233,8 +233,31 @@ static struct mmc_spi_platform_data vision_spi_mmc_data
> = { .caps2          = MMC_CAP2_RO_ACTIVE_HIGH,
>  };
> 
> +static int vision_spi_mmc_enable_cd_debounce(struct spi_device *spi)
> +{
> +       int ret;
> +
> +       ret = gpio_request_one(VISION_SPI_MMC_CD, GPIOF_DIR_IN,
> spi->modalias);
> +       if (ret)
> +               return ret;
> +
> +       ret = gpio_set_debounce(VISION_SPI_MMC_CD, 1);
> +       if (ret)
> +               return ret;
> +
> +       gpio_free(VISION_SPI_MMC_CD);
> +
> +       return 0;
> +}
> +
>  static int vision_spi_mmc_hw_setup(struct spi_device *spi)
>  {
> +       int ret;
> +
> +       ret = vision_spi_mmc_enable_cd_debounce(spi);
> +       if (ret)
> +               return ret;
> +
>         return gpio_request_one(VISION_SPI_MMC_CS, GPIOF_INIT_HIGH,
>                                 spi->modalias);
>  }

What about extending the mmc_spi and MMC core with GPIO debounce support ? The 
mmc_spi driver would get a new cd_gpio_debounce field, which would be passed 
to mmc_gpio_request_cd(). I can cook up a patch.

-- 
Regards,

Laurent Pinchart

