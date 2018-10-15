From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RFT PATCH] mmc: pwrseq_simple: Fix incorrect handling of GPIO
 bitmap
Date: Mon, 15 Oct 2018 10:32:08 +0200
Message-ID: <20181015083209eucas1p2fb3d1961745fdb3007dec317c6441142~duxEkRvmp2005320053eucas1p2D@eucas1p2.samsung.com>
References: <20180925192433.1377-1-jmkrzyszt@gmail.com>
        <CGME20181012190748epcas5p3dc41f6d0f9c69f22351209b2e7ea66f3@epcas5p3.samsung.com>
        <20181012190901.1243-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012190901.1243-1-jmkrzyszt@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org, Kukjin Kim <kgene@kernel.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, linux-omap@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Janusz,

On 2018-10-12 21:09, Janusz Krzysztofik wrote:
> Commit b9762bebc633 ("gpiolib: Pass bitmaps, not integer arrays, to
> get/set array") changed the way GPIO values are passed to
> gpiod_get/set_array_value() and friends.  The new code introduced into
> mmc_pwrseq_simple_set_gpios_value() incorrectly interpretes the 'value'
> argument as a bitmap of GPIO values and assigns it directly to the
> 'values' bitmap variable passed to gpiod_set_array_value_cansleep()
> instead of filling that bitmap with bits equal to the 'value' argument.
> As a result, only member 0 of the array is handled correctly.
>
> Moreover, wrong assumption is taken about the 'values' bitmap size not
> exceding the number of bits of the 'value' argument type.
>
> Fix it.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
> Hi,
>
> I think that patch has been missed while we were resolving issues 
> related to GPIO fast bitmap processing.  Since all issues other than the 
> one addreessed by this patch have been been hopefully identified and 
> fixed, GPIO tree seems now to be in good shape in regard to that. 
> However, I believe pwrseq_simple is still broken.  Hence, I'm 
> resubmitting this patch to Ulf for inclusion in MMC tree, Cc: many other 
> people who are kindly requested to test it if possible.
>
> I've identified the following DT files representing devices which may be 
> affected (have more than one GPIO assigned to pwrseq_simple):
> - arch/arm/boot/dts/imx6qdl-sr-som-brcm.dtsi
> - arch/arm/boot/dts/exynos5250-snow-common.dtsi

On Samsung Snow Chromebook it doesn't change anything. Board boots and
detects WiFi SDIO card before and after applying it on top on Linux
next-20181012.

Tested-by: Marek Szyprowski <m.szyprowski

> - arch/arm/boot/dts/imx6sl-warp.dts
> - arch/arm/boot/dts/omap3-igep0030.dts
> - arch/arm/boot/dts/omap3-igep0020.dts
> - arch/arm/boot/dts/rk3036-kylin.dts
> - arch/arm64/boot/dts/rockchip/rk3368-r88.dts
> - arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
>
> Please start with checking if pwrseq_simple from linux-next works for 
> you and if not, please test if this patch fixes the issue.
>
> Thanks,
> Janusz
>
>
>  drivers/mmc/core/pwrseq_simple.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index 7f882a2bb872..ece34c734693 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -40,13 +40,22 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
>  	struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
>  
>  	if (!IS_ERR(reset_gpios)) {
> -		DECLARE_BITMAP(values, BITS_PER_TYPE(value));
> +		unsigned long *values;
>  		int nvalues = reset_gpios->ndescs;
>  
> -		values[0] = value;
> +		values = bitmap_alloc(nvalues, GFP_KERNEL);
> +		if (!values)
> +			return;
> +
> +		if (value)
> +			bitmap_fill(values, nvalues);
> +		else
> +			bitmap_zero(values, nvalues);
>  
>  		gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc,
>  					       reset_gpios->info, values);
> +
> +		kfree(values);
>  	}
>  }
>  

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
