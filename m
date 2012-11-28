From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v2 1/2] mmc: dw_mmc: exynos: Stop claiming wp-gpio
Date: Wed, 28 Nov 2012 18:29:04 +0900
Message-ID: <001a01cdcd4a$cf01ad40$6d0507c0$%jun@samsung.com>
References: <1353535387-32106-1-git-send-email-dianders@chromium.org>
 <1353624835-19137-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1353624835-19137-1-git-send-email-dianders@chromium.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Doug Anderson' <dianders@chromium.org>, linux-samsung-soc@vger.kernel.org, 'Thomas Abraham' <thomas.abraham@linaro.org>, 'Kukjin Kim' <kgene.kim@samsung.com>
Cc: 'Olof Johansson' <olof@lixom.net>, 'Arnd Bergmann' <arnd@arndb.de>, 'Will Newton' <will.newton@imgtec.com>, 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Yes. pin of write protection is common property.
This change is good. I have some suggestion below.
Could you check it?

On Friday, November 23, 2012, Doug Anderson wrote:
> The exynos code claimed wp-gpio with devm_gpio_request() but never did
> anything with it.  That meant that anyone using a write protect GPIO
> would effectively be write protected all the time.
> 
> A future change will move the wp-gpio support to the core dw_mmc.c
> file.  Now the exynos-specific code won't claim the GPIO but will
> just set the DW_MCI_QUIRK_NO_WRITE_PROTECT quirk if write protect
> won't be used.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> 
> ---
> Changes in v2:
> - Nothing new in this patch
> 
>  drivers/mmc/host/dw_mmc-exynos.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 4d50da6..58cc03e 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -175,12 +175,12 @@ static int dw_mci_exynos_setup_bus(struct dw_mci *host,
>  		}
>  	}
> 
> -	gpio = of_get_named_gpio(slot_np, "wp-gpios", 0);
> -	if (gpio_is_valid(gpio)) {
> -		if (devm_gpio_request(host->dev, gpio, "dw-mci-wp"))
> -			dev_info(host->dev, "gpio [%d] request failed\n",
> -						gpio);
> -	} else {
> +	/*
> +	 * If there are no write-protect GPIOs present then we assume no write
> +	 * protect.  The mci_readl() in dw_mmc.c won't work since it's not
> +	 * hooked up on exynos.
> +	 */
> +	if (!of_find_property(slot_np, "wp-gpios", NULL)) {
>  		dev_info(host->dev, "wp gpio not available");
>  		host->pdata->quirks |= DW_MCI_QUIRK_NO_WRITE_PROTECT;
>  	}
All card types need this quirk in case wp-gpio property is empty?
I think wp-pin is valid for SD card, not eMMC/SDIO.
Of course, I know origin code did it.
How about removing whole checking routine?
Instead, new definition for this quirk can be added into 'dw_mci_of_quirks'(dw_mmc.c) and dts file.

Thanks,
Seungwon Jeon
> --
> 1.7.7.3
