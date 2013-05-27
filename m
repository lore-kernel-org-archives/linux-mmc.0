From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2] mmc: dwmmc: let device core setup the default pin
 configuration
Date: Mon, 27 May 2013 12:49:24 +0900
Message-ID: <51A2D7C4.2060100@samsung.com>
References: <1364882999-31670-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1364882999-31670-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, heiko@sntech.de, patches@linaro.org, tgih.jun@samsung.com, t.figa@samsung.com, dianders@chromium.org, jh80.chung@samsung.com, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, cjb@laptop.org, linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Minor comment,
Maybe Seungwon mentioned the prefix use as "dw_mmc".

Best Regards,
Jaehoon Chung

On 04/02/2013 03:09 PM, Thomas Abraham wrote:
> With device core now able to setup the default pin configuration,
> the pin configuration code based on the deprecated Samsung specific
> gpio bindings is removed.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Doug Anderson <dianders@chromium.org>
> ---
> 
> Hi Doug, Seungwon,
> 
> I apologize for the delaying in following up on the review comment.
> The setup_bus callback support has been removed in this patch. I did
> intend to retain the support for setup_bus callback in the previous
> version of this patch since any new platform that might use this
> driver and need such a callback would have this callback ready for
> use. But it seems removing the setup_bus callback is preferred, so
> I am fine with it.
> 
> Thomas.
> 
>  drivers/mmc/host/dw_mmc-exynos.c |   38 --------------------------------------
>  drivers/mmc/host/dw_mmc.c        |   14 +-------------
>  drivers/mmc/host/dw_mmc.h        |    3 ---
>  3 files changed, 1 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 72fd0f2..467d043 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -152,43 +152,6 @@ static int dw_mci_exynos_parse_dt(struct dw_mci *host)
>  	return 0;
>  }
>  
> -static int dw_mci_exynos_setup_bus(struct dw_mci *host,
> -				struct device_node *slot_np, u8 bus_width)
> -{
> -	int idx, gpio, ret;
> -
> -	if (!slot_np)
> -		return -EINVAL;
> -
> -	/* cmd + clock + bus-width pins */
> -	for (idx = 0; idx < NUM_PINS(bus_width); idx++) {
> -		gpio = of_get_gpio(slot_np, idx);
> -		if (!gpio_is_valid(gpio)) {
> -			dev_err(host->dev, "invalid gpio: %d\n", gpio);
> -			return -EINVAL;
> -		}
> -
> -		ret = devm_gpio_request(host->dev, gpio, "dw-mci-bus");
> -		if (ret) {
> -			dev_err(host->dev, "gpio [%d] request failed\n", gpio);
> -			return -EBUSY;
> -		}
> -	}
> -
> -	if (host->pdata->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
> -		return 0;
> -
> -	gpio = of_get_named_gpio(slot_np, "samsung,cd-pinmux-gpio", 0);
> -	if (gpio_is_valid(gpio)) {
> -		if (devm_gpio_request(host->dev, gpio, "dw-mci-cd"))
> -			dev_err(host->dev, "gpio [%d] request failed\n", gpio);
> -	} else {
> -		dev_info(host->dev, "cd gpio not available");
> -	}
> -
> -	return 0;
> -}
> -
>  /* Exynos5250 controller specific capabilities */
>  static unsigned long exynos5250_dwmmc_caps[4] = {
>  	MMC_CAP_UHS_DDR50 | MMC_CAP_1_8V_DDR |
> @@ -205,7 +168,6 @@ static const struct dw_mci_drv_data exynos5250_drv_data = {
>  	.prepare_command	= dw_mci_exynos_prepare_command,
>  	.set_ios		= dw_mci_exynos_set_ios,
>  	.parse_dt		= dw_mci_exynos_parse_dt,
> -	.setup_bus		= dw_mci_exynos_setup_bus,
>  };
>  
>  static const struct of_device_id dw_mci_exynos_match[] = {
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 9834221..adb1b7d 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1878,7 +1878,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  	struct mmc_host *mmc;
>  	struct dw_mci_slot *slot;
>  	const struct dw_mci_drv_data *drv_data = host->drv_data;
> -	int ctrl_id, ret;
> +	int ctrl_id;
>  	u8 bus_width;
>  
>  	mmc = mmc_alloc_host(sizeof(struct dw_mci_slot), host->dev);
> @@ -1935,14 +1935,6 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  	else
>  		bus_width = 1;
>  
> -	if (drv_data && drv_data->setup_bus) {
> -		struct device_node *slot_np;
> -		slot_np = dw_mci_of_find_slot_node(host->dev, slot->id);
> -		ret = drv_data->setup_bus(host, slot_np, bus_width);
> -		if (ret)
> -			goto err_setup_bus;
> -	}
> -
>  	switch (bus_width) {
>  	case 8:
>  		mmc->caps |= MMC_CAP_8_BIT_DATA;
> @@ -2006,10 +1998,6 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  	queue_work(host->card_workqueue, &host->card_work);
>  
>  	return 0;
> -
> -err_setup_bus:
> -	mmc_free_host(mmc);
> -	return -EINVAL;
>  }
>  
>  static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 53b8fd9..0b74189 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -190,7 +190,6 @@ extern int dw_mci_resume(struct dw_mci *host);
>   * @prepare_command: handle CMD register extensions.
>   * @set_ios: handle bus specific extensions.
>   * @parse_dt: parse implementation specific device tree properties.
> - * @setup_bus: initialize io-interface
>   *
>   * Provide controller implementation specific extensions. The usage of this
>   * data structure is fully optional and usage of each member in this structure
> @@ -203,7 +202,5 @@ struct dw_mci_drv_data {
>  	void		(*prepare_command)(struct dw_mci *host, u32 *cmdr);
>  	void		(*set_ios)(struct dw_mci *host, struct mmc_ios *ios);
>  	int		(*parse_dt)(struct dw_mci *host);
> -	int		(*setup_bus)(struct dw_mci *host,
> -				struct device_node *slot_np, u8 bus_width);
>  };
>  #endif /* _DW_MMC_H_ */
> 
