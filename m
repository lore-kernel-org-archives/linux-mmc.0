From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v3 12/14] fbdev: jz4740-fb: Let the pinctrl driver
 configure the pins
Date: Mon, 30 Jan 2017 17:10:59 +0100
Message-ID: <4646116.fubHeuC3Nm@amdc3058>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <CGME20170125185254epcas5p15b40cad57649dc77afe8d2fd316687ff@epcas5p1.samsung.com>
 <20170125185207.23902-13-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-reply-to: <20170125185207.23902-13-paul@crapouillou.net>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, james.hogan@imgtec.com
List-Id: linux-mmc@vger.kernel.org


Hi,

On Wednesday, January 25, 2017 07:52:05 PM Paul Cercueil wrote:
> Now that the JZ4740 and similar SoCs have a pinctrl driver, we rely on
> the pins being properly configured before the driver probes.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/jz4740_fb.c | 104 ++--------------------------------------
>  1 file changed, 3 insertions(+), 101 deletions(-)
> 
> v2: No changes
> v3: No changes
> 
> diff --git a/drivers/video/fbdev/jz4740_fb.c b/drivers/video/fbdev/jz4740_fb.c
> index 87790e9644d0..b57df83fdbd3 100644
> --- a/drivers/video/fbdev/jz4740_fb.c
> +++ b/drivers/video/fbdev/jz4740_fb.c
> @@ -17,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_device.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> @@ -27,7 +28,6 @@
>  #include <linux/dma-mapping.h>
>  
>  #include <asm/mach-jz4740/jz4740_fb.h>
> -#include <asm/mach-jz4740/gpio.h>
>  
>  #define JZ_REG_LCD_CFG		0x00
>  #define JZ_REG_LCD_VSYNC	0x04
> @@ -146,93 +146,6 @@ static const struct fb_fix_screeninfo jzfb_fix = {
>  	.accel		= FB_ACCEL_NONE,
>  };
>  
> -static const struct jz_gpio_bulk_request jz_lcd_ctrl_pins[] = {
> -	JZ_GPIO_BULK_PIN(LCD_PCLK),
> -	JZ_GPIO_BULK_PIN(LCD_HSYNC),
> -	JZ_GPIO_BULK_PIN(LCD_VSYNC),
> -	JZ_GPIO_BULK_PIN(LCD_DE),
> -	JZ_GPIO_BULK_PIN(LCD_PS),
> -	JZ_GPIO_BULK_PIN(LCD_REV),
> -	JZ_GPIO_BULK_PIN(LCD_CLS),
> -	JZ_GPIO_BULK_PIN(LCD_SPL),
> -};
> -
> -static const struct jz_gpio_bulk_request jz_lcd_data_pins[] = {
> -	JZ_GPIO_BULK_PIN(LCD_DATA0),
> -	JZ_GPIO_BULK_PIN(LCD_DATA1),
> -	JZ_GPIO_BULK_PIN(LCD_DATA2),
> -	JZ_GPIO_BULK_PIN(LCD_DATA3),
> -	JZ_GPIO_BULK_PIN(LCD_DATA4),
> -	JZ_GPIO_BULK_PIN(LCD_DATA5),
> -	JZ_GPIO_BULK_PIN(LCD_DATA6),
> -	JZ_GPIO_BULK_PIN(LCD_DATA7),
> -	JZ_GPIO_BULK_PIN(LCD_DATA8),
> -	JZ_GPIO_BULK_PIN(LCD_DATA9),
> -	JZ_GPIO_BULK_PIN(LCD_DATA10),
> -	JZ_GPIO_BULK_PIN(LCD_DATA11),
> -	JZ_GPIO_BULK_PIN(LCD_DATA12),
> -	JZ_GPIO_BULK_PIN(LCD_DATA13),
> -	JZ_GPIO_BULK_PIN(LCD_DATA14),
> -	JZ_GPIO_BULK_PIN(LCD_DATA15),
> -	JZ_GPIO_BULK_PIN(LCD_DATA16),
> -	JZ_GPIO_BULK_PIN(LCD_DATA17),
> -};
> -
> -static unsigned int jzfb_num_ctrl_pins(struct jzfb *jzfb)
> -{
> -	unsigned int num;
> -
> -	switch (jzfb->pdata->lcd_type) {
> -	case JZ_LCD_TYPE_GENERIC_16_BIT:
> -		num = 4;
> -		break;
> -	case JZ_LCD_TYPE_GENERIC_18_BIT:
> -		num = 4;
> -		break;
> -	case JZ_LCD_TYPE_8BIT_SERIAL:
> -		num = 3;
> -		break;
> -	case JZ_LCD_TYPE_SPECIAL_TFT_1:
> -	case JZ_LCD_TYPE_SPECIAL_TFT_2:
> -	case JZ_LCD_TYPE_SPECIAL_TFT_3:
> -		num = 8;
> -		break;
> -	default:
> -		num = 0;
> -		break;
> -	}
> -	return num;
> -}
> -
> -static unsigned int jzfb_num_data_pins(struct jzfb *jzfb)
> -{
> -	unsigned int num;
> -
> -	switch (jzfb->pdata->lcd_type) {
> -	case JZ_LCD_TYPE_GENERIC_16_BIT:
> -		num = 16;
> -		break;
> -	case JZ_LCD_TYPE_GENERIC_18_BIT:
> -		num = 18;
> -		break;
> -	case JZ_LCD_TYPE_8BIT_SERIAL:
> -		num = 8;
> -		break;
> -	case JZ_LCD_TYPE_SPECIAL_TFT_1:
> -	case JZ_LCD_TYPE_SPECIAL_TFT_2:
> -	case JZ_LCD_TYPE_SPECIAL_TFT_3:
> -		if (jzfb->pdata->bpp == 18)
> -			num = 18;
> -		else
> -			num = 16;
> -		break;
> -	default:
> -		num = 0;
> -		break;
> -	}
> -	return num;
> -}
> -
>  /* Based on CNVT_TOHW macro from skeletonfb.c */
>  static inline uint32_t jzfb_convert_color_to_hw(unsigned val,
>  	struct fb_bitfield *bf)
> @@ -487,8 +400,7 @@ static void jzfb_enable(struct jzfb *jzfb)
>  
>  	clk_prepare_enable(jzfb->ldclk);
>  
> -	jz_gpio_bulk_resume(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
> -	jz_gpio_bulk_resume(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
> +	pinctrl_pm_select_default_state(&jzfb->pdev->dev);
>  
>  	writel(0, jzfb->base + JZ_REG_LCD_STATE);
>  
> @@ -511,8 +423,7 @@ static void jzfb_disable(struct jzfb *jzfb)
>  		ctrl = readl(jzfb->base + JZ_REG_LCD_STATE);
>  	} while (!(ctrl & JZ_LCD_STATE_DISABLED));
>  
> -	jz_gpio_bulk_suspend(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
> -	jz_gpio_bulk_suspend(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
> +	pinctrl_pm_select_sleep_state(&jzfb->pdev->dev);
>  
>  	clk_disable_unprepare(jzfb->ldclk);
>  }
> @@ -701,9 +612,6 @@ static int jzfb_probe(struct platform_device *pdev)
>  	fb->mode = NULL;
>  	jzfb_set_par(fb);
>  
> -	jz_gpio_bulk_request(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
> -	jz_gpio_bulk_request(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
> -
>  	ret = register_framebuffer(fb);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to register framebuffer: %d\n", ret);
> @@ -715,9 +623,6 @@ static int jzfb_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_free_devmem:
> -	jz_gpio_bulk_free(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
> -	jz_gpio_bulk_free(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
> -
>  	fb_dealloc_cmap(&fb->cmap);
>  	jzfb_free_devmem(jzfb);
>  err_framebuffer_release:
> @@ -731,9 +636,6 @@ static int jzfb_remove(struct platform_device *pdev)
>  
>  	jzfb_blank(FB_BLANK_POWERDOWN, jzfb->fb);
>  
> -	jz_gpio_bulk_free(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
> -	jz_gpio_bulk_free(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
> -
>  	fb_dealloc_cmap(&jzfb->fb->cmap);
>  	jzfb_free_devmem(jzfb);
