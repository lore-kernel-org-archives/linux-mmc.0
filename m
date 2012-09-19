From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v6 8/9] mmc: dw_mmc: add support for implementation
 specific callbacks
Date: Wed, 19 Sep 2012 22:40:47 +0900
Message-ID: <001401cd966c$5fe94590$1fbbd0b0$%jun@samsung.com>
References: <1347905803-22742-1-git-send-email-thomas.abraham@linaro.org>
 <1347905803-22742-9-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1347905803-22742-9-git-send-email-thomas.abraham@linaro.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Thomas Abraham' <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: will.newton@imgtec.com, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

On Tuesday, September 18, 2012, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> -int dw_mci_pltfm_register(struct platform_device *pdev)
> +int dw_mci_pltfm_register(struct platform_device *pdev,
> +				struct dw_mci_drv_data *drv_data)
>  {
>  	struct dw_mci *host;
>  	struct resource	*regs;
> @@ -41,6 +42,7 @@ int dw_mci_pltfm_register(struct platform_device *pdev)
>  	if (host->irq < 0)
>  		return host->irq;
> 
> +	host->drv_data = drv_data;
>  	host->dev = &pdev->dev;
>  	host->irq_flags = 0;
>  	host->pdata = pdev->dev.platform_data;
> @@ -48,6 +50,12 @@ int dw_mci_pltfm_register(struct platform_device *pdev)
>  	if (!host->regs)
>  		return -ENOMEM;
> 
> +	if (host->drv_data->init) {
In non-Exynos platform, host->drv_data has NULL.

Thanks,
Seungwon Jeon

> +		ret = host->drv_data->init(host);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	platform_set_drvdata(pdev, host);
>  	ret = dw_mci_probe(host);
>  	return ret;
> @@ -56,7 +64,7 @@ EXPORT_SYMBOL_GPL(dw_mci_pltfm_register);
> 
>  static int __devinit dw_mci_pltfm_probe(struct platform_device *pdev)
>  {
> -	return dw_mci_pltfm_register(pdev);
> +	return dw_mci_pltfm_register(pdev, NULL);
>  }
> 
>  static int __devexit dw_mci_pltfm_remove(struct platform_device *pdev)
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.h b/drivers/mmc/host/dw_mmc-pltfm.h
> index 6c065d9..301f245 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.h
> +++ b/drivers/mmc/host/dw_mmc-pltfm.h
> @@ -12,7 +12,8 @@
>  #ifndef _DW_MMC_PLTFM_H_
>  #define _DW_MMC_PLTFM_H_
> 
> -extern int dw_mci_pltfm_register(struct platform_device *pdev);
> +extern int dw_mci_pltfm_register(struct platform_device *pdev,
> +				struct dw_mci_drv_data *drv_data);
>  extern int __devexit dw_mci_pltfm_remove(struct platform_device *pdev);
>  extern const struct dev_pm_ops dw_mci_pltfm_pmops;
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index c792466..9f8e487 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -231,6 +231,7 @@ static void dw_mci_set_timeout(struct dw_mci *host)
>  static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
>  {
>  	struct mmc_data	*data;
> +	struct dw_mci_slot *slot = mmc_priv(mmc);
>  	u32 cmdr;
>  	cmd->error = -EINPROGRESS;
> 
> @@ -260,6 +261,9 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
>  			cmdr |= SDMMC_CMD_DAT_WR;
>  	}
> 
> +	if (slot->host->drv_data->prepare_command)
> +		slot->host->drv_data->prepare_command(slot->host, &cmdr);
> +
>  	return cmdr;
>  }
> 
> @@ -815,6 +819,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		slot->clock = ios->clock;
>  	}
> 
> +	if (slot->host->drv_data->set_ios)
> +		slot->host->drv_data->set_ios(slot->host, ios);
> +
>  	switch (ios->power_mode) {
>  	case MMC_POWER_UP:
>  		set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
> @@ -1820,6 +1827,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  {
>  	struct mmc_host *mmc;
>  	struct dw_mci_slot *slot;
> +	int ctrl_id, ret;
>  	u8 bus_width;
> 
>  	mmc = mmc_alloc_host(sizeof(struct dw_mci_slot), host->dev);
> @@ -1851,6 +1859,16 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  	if (host->pdata->caps)
>  		mmc->caps = host->pdata->caps;
> 
> +	if (host->dev->of_node) {
> +		ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
> +		if (ctrl_id < 0)
> +			ctrl_id = 0;
> +	} else {
> +		ctrl_id = to_platform_device(host->dev)->id;
> +	}
> +	if (host->drv_data && host->drv_data->caps)
> +		mmc->caps |= host->drv_data->caps[ctrl_id];
> +
>  	if (host->pdata->caps2)
>  		mmc->caps2 = host->pdata->caps2;
> 
> @@ -1861,6 +1879,14 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  	else
>  		bus_width = 1;
> 
> +	if (host->drv_data->setup_bus) {
> +		struct device_node *slot_np;
> +		slot_np = dw_mci_of_find_slot_node(host->dev, slot->id);
> +		ret = host->drv_data->setup_bus(host, slot_np, bus_width);
> +		if (ret)
> +			goto err_setup_bus;
> +	}
> +
>  	switch (bus_width) {
>  	case 8:
>  		mmc->caps |= MMC_CAP_8_BIT_DATA;
> @@ -1927,6 +1953,10 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  	queue_work(host->card_workqueue, &host->card_work);
> 
>  	return 0;
> +
> +err_setup_bus:
> +	mmc_free_host(mmc);
> +	return -EINVAL;
>  }
> 
>  static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
> @@ -2021,7 +2051,7 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>  	struct dw_mci_board *pdata;
>  	struct device *dev = host->dev;
>  	struct device_node *np = dev->of_node;
> -	int idx;
> +	int idx, ret;
> 
>  	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>  	if (!pdata) {
> @@ -2048,6 +2078,12 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
> 
>  	of_property_read_u32(np, "card-detect-delay", &pdata->detect_delay_ms);
> 
> +	if (host->drv_data->parse_dt) {
> +		ret = host->drv_data->parse_dt(host);
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}
> +
>  	return pdata;
>  }
> 
> @@ -2107,6 +2143,15 @@ int dw_mci_probe(struct dw_mci *host)
>  	else
>  		host->bus_hz = clk_get_rate(host->ciu_clk);
> 
> +	if (host->drv_data->setup_clock) {
> +		ret = host->drv_data->setup_clock(host);
> +		if (ret) {
> +			dev_err(host->dev,
> +				"implementation specific clock setup failed\n");
> +			goto err_clk_ciu;
> +		}
> +	}
> +
>  	if (!host->bus_hz) {
>  		dev_err(host->dev,
>  			"Platform data must supply bus speed\n");
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 15c27e1..53b8fd9 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -182,4 +182,28 @@ extern int dw_mci_suspend(struct dw_mci *host);
>  extern int dw_mci_resume(struct dw_mci *host);
>  #endif
> 
> +/**
> + * dw_mci driver data - dw-mshc implementation specific driver data.
> + * @caps: mmc subsystem specified capabilities of the controller(s).
> + * @init: early implementation specific initialization.
> + * @setup_clock: implementation specific clock configuration.
> + * @prepare_command: handle CMD register extensions.
> + * @set_ios: handle bus specific extensions.
> + * @parse_dt: parse implementation specific device tree properties.
> + * @setup_bus: initialize io-interface
> + *
> + * Provide controller implementation specific extensions. The usage of this
> + * data structure is fully optional and usage of each member in this structure
> + * is optional as well.
> + */
> +struct dw_mci_drv_data {
> +	unsigned long	*caps;
> +	int		(*init)(struct dw_mci *host);
> +	int		(*setup_clock)(struct dw_mci *host);
> +	void		(*prepare_command)(struct dw_mci *host, u32 *cmdr);
> +	void		(*set_ios)(struct dw_mci *host, struct mmc_ios *ios);
> +	int		(*parse_dt)(struct dw_mci *host);
> +	int		(*setup_bus)(struct dw_mci *host,
> +				struct device_node *slot_np, u8 bus_width);
> +};
>  #endif /* _DW_MMC_H_ */
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index b72e4aa..6cb043e 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -78,6 +78,8 @@ struct mmc_data;
>   * @data_offset: Set the offset of DATA register according to VERID.
>   * @dev: Device associated with the MMC controller.
>   * @pdata: Platform data associated with the MMC controller.
> + * @drv_data: Driver specific data for identified variant of the controller
> + * @priv: Implementation defined private data.
>   * @biu_clk: Pointer to bus interface unit clock instance.
>   * @ciu_clk: Pointer to card interface unit clock instance.
>   * @slot: Slots sharing this MMC controller.
> @@ -160,6 +162,8 @@ struct dw_mci {
>  	u16			data_offset;
>  	struct device		*dev;
>  	struct dw_mci_board	*pdata;
> +	struct dw_mci_drv_data	*drv_data;
> +	void			*priv;
>  	struct clk		*biu_clk;
>  	struct clk		*ciu_clk;
>  	struct dw_mci_slot	*slot[MAX_MCI_SLOTS];
> --
> 1.6.6.rc2
