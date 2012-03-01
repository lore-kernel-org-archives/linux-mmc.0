From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 1/4] mmc: sdhci-s3c: use the sdhci-pltfm for Samsung-SoC
Date: Fri, 02 Mar 2012 08:58:53 +0900
Message-ID: <4F500D3D.2000902@samsung.com>
References: <4F4B3798.2000003@samsung.com>
 <001701ccf6ab$fd136910$f73a3b30$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:43929 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199Ab2CAX7B (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Mar 2012 18:59:01 -0500
In-reply-to: <001701ccf6ab$fd136910$f73a3b30$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'linux-mmc' <linux-mmc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'kgene kim' <kgene.kim@samsung.com>, 'Thomas Abraham' <thomas.abraham@linaro.org>

On 02/29/2012 03:33 PM, Seungwon Jeon wrote:

> Hi Jaehoon,
> 
> Thank you for the patch.
> Could you check comments below?
> 
> Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> This patch is change to use the sdhci-pltfm.c
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/mmc/host/Kconfig     |   20 ++--
>>  drivers/mmc/host/sdhci-s3c.c |  254 ++++++++++++++----------------------------
>>  2 files changed, 95 insertions(+), 179 deletions(-)
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 0c9b3b1..21ea0ba 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -169,6 +169,8 @@ config MMC_SDHCI_TEGRA
>>  config MMC_SDHCI_S3C
>>  	tristate "SDHCI support on Samsung S3C SoC"
>>  	depends on MMC_SDHCI && PLAT_SAMSUNG
>> +	depends on MMC_SDHCI_PLTFM
>> +	select MMC_SDHCI_IO_ACCESSORS
>>  	help
>>  	  This selects the Secure Digital Host Controller Interface (SDHCI)
>>  	  often referrered to as the HSMMC block in some of the Samsung S3C
>> @@ -181,6 +183,14 @@ config MMC_SDHCI_S3C
>>
>>  	  If unsure, say N.
>>
>> +config MMC_SDHCI_S3C_DMA
>> +	bool "DMA support on S3C SDHCI"
>> +	depends on MMC_SDHCI_S3C && EXPERIMENTAL
>> +	help
>> +	  Enable DMA support on the Samsung S3C SDHCI glue. The DMA
>> +	  has proved to be problematic if the controller encounters
>> +	  certain errors, and thus should be treated with care.
>> +
>>  config MMC_SDHCI_PXAV3
>>  	tristate "Marvell MMP2 SD Host Controller support (PXAV3)"
>>  	depends on CLKDEV_LOOKUP
>> @@ -219,16 +229,6 @@ config MMC_SDHCI_SPEAR
>>
>>  	  If unsure, say N.
>>
>> -config MMC_SDHCI_S3C_DMA
>> -	bool "DMA support on S3C SDHCI"
>> -	depends on MMC_SDHCI_S3C && EXPERIMENTAL
>> -	help
>> -	  Enable DMA support on the Samsung S3C SDHCI glue. The DMA
>> -	  has proved to be problematic if the controller encounters
>> -	  certain errors, and thus should be treated with care.
>> -
>> -	  YMMV.
>> -
>>  config MMC_OMAP
>>  	tristate "TI OMAP Multimedia Card Interface support"
>>  	depends on ARCH_OMAP
>> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
>> index 3bf509b..0778c38 100644
>> --- a/drivers/mmc/host/sdhci-s3c.c
>> +++ b/drivers/mmc/host/sdhci-s3c.c
>> @@ -28,6 +28,7 @@
>>  #include <plat/sdhci.h>
>>  #include <plat/regs-sdhci.h>
>>
>> +#include "sdhci-pltfm.h"
>>  #include "sdhci.h"
>>
>>  #define MAX_BUS_CLK	(4)
>> @@ -46,9 +47,7 @@
>>   * @clk_bus: The clocks that are available for the SD/MMC bus clock.
>>   */
>>  struct sdhci_s3c {
>> -	struct sdhci_host	*host;
>>  	struct platform_device	*pdev;
>> -	struct resource		*ioarea;
>>  	struct s3c_sdhci_platdata *pdata;
>>  	unsigned int		cur_clk;
>>  	int			ext_cd_irq;
>> @@ -71,11 +70,6 @@ struct sdhci_s3c_drv_data {
>>  	unsigned int	sdhci_quirks;
>>  };
>>
>> -static inline struct sdhci_s3c *to_s3c(struct sdhci_host *host)
>> -{
>> -	return sdhci_priv(host);
>> -}
>> -
>>  /**
>>   * get_curclk - convert ctrl2 register to clock source number
>>   * @ctrl2: Control2 register value.
>> @@ -90,7 +84,8 @@ static u32 get_curclk(u32 ctrl2)
>>
>>  static void sdhci_s3c_check_sclk(struct sdhci_host *host)
>>  {
>> -	struct sdhci_s3c *ourhost = to_s3c(host);
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_s3c *ourhost = pltfm_host->priv;
>>  	u32 tmp = readl(host->ioaddr + S3C_SDHCI_CONTROL2);
>>
>>  	if (get_curclk(tmp) != ourhost->cur_clk) {
>> @@ -110,7 +105,8 @@ static void sdhci_s3c_check_sclk(struct sdhci_host *host)
>>  */
>>  static unsigned int sdhci_s3c_get_max_clk(struct sdhci_host *host)
>>  {
>> -	struct sdhci_s3c *ourhost = to_s3c(host);
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_s3c *ourhost = pltfm_host->priv;
>>  	struct clk *busclk;
>>  	unsigned int rate, max;
>>  	int clk;
>> @@ -138,11 +134,13 @@ static unsigned int sdhci_s3c_get_max_clk(struct sdhci_host *host)
>>   * @src: The source clock index.
>>   * @wanted: The clock frequency wanted.
>>   */
>> -static unsigned int sdhci_s3c_consider_clock(struct sdhci_s3c *ourhost,
>> +static unsigned int sdhci_s3c_consider_clock(struct sdhci_host *host,
>>  					     unsigned int src,
>>  					     unsigned int wanted)
>>  {
>>  	unsigned long rate;
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_s3c *ourhost = pltfm_host->priv;
>>  	struct clk *clksrc = ourhost->clk_bus[src];
>>  	int div;
>>
>> @@ -153,7 +151,7 @@ static unsigned int sdhci_s3c_consider_clock(struct sdhci_s3c *ourhost,
>>  	 * If controller uses a non-standard clock division, find the best clock
>>  	 * speed possible with selected clock source and skip the division.
>>  	 */
>> -	if (ourhost->host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK) {
>> +	if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK) {
>>  		rate = clk_round_rate(clksrc, wanted);
>>  		return wanted - rate;
>>  	}
>> @@ -181,7 +179,8 @@ static unsigned int sdhci_s3c_consider_clock(struct sdhci_s3c *ourhost,
>>  */
>>  static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
>>  {
>> -	struct sdhci_s3c *ourhost = to_s3c(host);
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_s3c *ourhost = pltfm_host->priv;
>>  	unsigned int best = UINT_MAX;
>>  	unsigned int delta;
>>  	int best_src = 0;
>> @@ -193,7 +192,7 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
>>  		return;
>>
>>  	for (src = 0; src < MAX_BUS_CLK; src++) {
>> -		delta = sdhci_s3c_consider_clock(ourhost, src, clock);
>> +		delta = sdhci_s3c_consider_clock(host, src, clock);
>>  		if (delta < best) {
>>  			best = delta;
>>  			best_src = src;
>> @@ -251,12 +250,11 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
>>  */
>>  static unsigned int sdhci_s3c_get_min_clock(struct sdhci_host *host)
>>  {
>> -	struct sdhci_s3c *ourhost = to_s3c(host);
>>  	unsigned int delta, min = UINT_MAX;
>>  	int src;
>>
>>  	for (src = 0; src < MAX_BUS_CLK; src++) {
>> -		delta = sdhci_s3c_consider_clock(ourhost, src, 0);
>> +		delta = sdhci_s3c_consider_clock(host, src, 0);
>>  		if (delta == UINT_MAX)
>>  			continue;
>>  		/* delta is a negative value in this case */
>> @@ -269,27 +267,26 @@ static unsigned int sdhci_s3c_get_min_clock(struct sdhci_host *host)
>>  /* sdhci_cmu_get_max_clk - callback to get maximum clock frequency.*/
>>  static unsigned int sdhci_cmu_get_max_clock(struct sdhci_host *host)
>>  {
>> -	struct sdhci_s3c *ourhost = to_s3c(host);
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>
>> -	return clk_round_rate(ourhost->clk_bus[ourhost->cur_clk], UINT_MAX);
>> +	return clk_round_rate(pltfm_host->clk, UINT_MAX);
>>  }
>>
>>  /* sdhci_cmu_get_min_clock - callback to get minimal supported clock value. */
>>  static unsigned int sdhci_cmu_get_min_clock(struct sdhci_host *host)
>>  {
>> -	struct sdhci_s3c *ourhost = to_s3c(host);
>> -
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>  	/*
>>  	 * initial clock can be in the frequency range of
>>  	 * 100KHz-400KHz, so we set it as max value.
>>  	 */
>> -	return clk_round_rate(ourhost->clk_bus[ourhost->cur_clk], 400000);
>> +	return clk_round_rate(pltfm_host->clk, 400000);
>>  }
>>
>>  /* sdhci_cmu_set_clock - callback on clock change.*/
>>  static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
>>  {
>> -	struct sdhci_s3c *ourhost = to_s3c(host);
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>  	unsigned long timeout;
>>  	u16 clk = 0;
>>
>> @@ -299,7 +296,7 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
>>
>>  	sdhci_s3c_set_clock(host, clock);
>>
>> -	clk_set_rate(ourhost->clk_bus[ourhost->cur_clk], clock);
>> +	clk_set_rate(pltfm_host->clk, clock);
>>
>>  	host->clock = clock;
>>
>> @@ -426,7 +423,8 @@ static int __devinit sdhci_s3c_parse_dt(struct device *dev,
>>  		struct sdhci_host *host, struct s3c_sdhci_platdata *pdata)
>>  {
>>  	struct device_node *node = dev->of_node;
>> -	struct sdhci_s3c *ourhost = to_s3c(host);
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_s3c *ourhost = pltfm_host->priv;
>>  	u32 max_width;
>>  	int gpio, cnt, ret;
>>
>> @@ -484,6 +482,7 @@ static int __devinit sdhci_s3c_parse_dt(struct device *dev,
>>  			dev_err(dev, "invalid gpio[%d]\n", cnt);
>>  			goto err_free_dt_cd_gpio;
>>  		}
>> +		p
> Typo?

It's typo. i will remove it.

> 
>>  		ourhost->gpios[cnt] = gpio;
>>  	}
>>
>> @@ -529,62 +528,60 @@ static inline struct sdhci_s3c_drv_data *sdhci_s3c_get_driver_data(
>>  			platform_get_device_id(pdev)->driver_data;
>>  }
>>
>> +static struct sdhci_pltfm_data sdhci_s3c_pdata = {
>> +	.quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
>> +		SDHCI_QUIRK_NO_HISPD_BIT | SDHCI_QUIRK_NO_BUSY_IRQ |
>> +		SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 |
>> +		SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
>> +		SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
>> +		SDHCI_QUIRK_32BIT_DMA_ADDR | SDHCI_QUIRK_32BIT_DMA_SIZE,
>> +	.ops	= &sdhci_s3c_ops,
>> +};
>> +
>>  static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>  {
>> -	struct s3c_sdhci_platdata *pdata;
>>  	struct sdhci_s3c_drv_data *drv_data;
>>  	struct device *dev = &pdev->dev;
>> +	struct sdhci_pltfm_host *pltfm_host;
>> +	struct sdhci_pltfm_data *pltfm_pdata = &sdhci_s3c_pdata;
>>  	struct sdhci_host *host;
>>  	struct sdhci_s3c *sc;
>> -	struct resource *res;
>> -	int ret, irq, ptr, clks;
>> +	int ret, ptr, clks;
>>
>>  	if (!pdev->dev.platform_data && !pdev->dev.of_node) {
>>  		dev_err(dev, "no device data specified\n");
>>  		return -ENOENT;
>>  	}
>>
>> -	irq = platform_get_irq(pdev, 0);
>> -	if (irq < 0) {
>> -		dev_err(dev, "no irq specified\n");
>> -		return irq;
>> -	}
>> -
>> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -	if (!res) {
>> -		dev_err(dev, "no memory specified\n");
>> -		return -ENOENT;
>> -	}
>> -
>> -	host = sdhci_alloc_host(dev, sizeof(struct sdhci_s3c));
>> +	host = sdhci_pltfm_init(pdev, pltfm_pdata);
>>  	if (IS_ERR(host)) {
>>  		dev_err(dev, "sdhci_alloc_host() failed\n");
>>  		return PTR_ERR(host);
>>  	}
>> -	sc = sdhci_priv(host);
>>
>> -	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
>> -	if (!pdata) {
>> +	sc = devm_kzalloc(dev, sizeof(struct sdhci_s3c), GFP_KERNEL);
>> +	if (!sc) {
>>  		ret = -ENOMEM;
>> -		goto err_pdata;
>> +		goto err_alloc_host;
>>  	}
>>
>> +	pltfm_host = sdhci_priv(host);
>> +	pltfm_host->priv = sc;
>> +
>>  	if (pdev->dev.of_node) {
>> -		ret = sdhci_s3c_parse_dt(&pdev->dev, host, pdata);
>> +		ret = sdhci_s3c_parse_dt(&pdev->dev, host, sc->pdata);
>>  		if (ret)
>> -			goto err_pdata;
>> +			goto err_alloc_host;
>>  	} else {
>> -		memcpy(pdata, pdev->dev.platform_data, sizeof(*pdata));
>> +		memcpy(&sc->pdata, &pdev->dev.platform_data, sizeof(sc->pdata));
>>  		sc->ext_cd_gpio = -1; /* invalid gpio number */
>>  	}
>>
>>  	drv_data = sdhci_s3c_get_driver_data(pdev);
>> +	if (drv_data)
>> +		host->quirks |= drv_data->sdhci_quirks;
>>
>> -	sc->host = host;
>>  	sc->pdev = pdev;
>> -	sc->pdata = pdata;
>> -
>> -	platform_set_drvdata(pdev, host);
>>
>>  	sc->clk_io = clk_get(dev, "hsmmc");
>>  	if (IS_ERR(sc->clk_io)) {
>> @@ -602,9 +599,8 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>
>>  		snprintf(name, 14, "mmc_busclk.%d", ptr);
>>  		clk = clk_get(dev, name);
>> -		if (IS_ERR(clk)) {
>> +		if (IS_ERR(clk))
>>  			continue;
>> -		}
>>
>>  		clks++;
>>  		sc->clk_bus[ptr] = clk;
>> @@ -613,7 +609,10 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>  		 * save current clock index to know which clock bus
>>  		 * is used later in overriding functions.
>>  		 */
>> -		sc->cur_clk = ptr;
>> +		if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK)
>> +			pltfm_host->clk = clk;
>> +		else
> We need to keep below?
> According to two commits, this seems to be relevant to SDHCI_QUIRK_NONSTANDARD_CLOCK.
>   mmc: sdhci-s3c: Support controllers with no internal clock divider(253e0a7c3dc4b)
>   mmc: sdhci-s3c: Remove usage of clk_type member in platform data(b77d777eeb0a086)

Right, it's related with them.
I want to remove the sc->cur_clk.But in c110 case, it seems to need them.
In c110, clk_src is used the one of four.
If you want to remove the quirks, i will use only sc->cur_clk.
How about this?

And any comment?

Best Regards,
Jaehoon Chung

> 
> Thanks,
> Seungwon Jeon.
> 
>> +			sc->cur_clk = ptr;
>>
>>  		clk_enable(clk);
>>
>> @@ -627,63 +626,25 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>  		goto err_no_busclks;
>>  	}
>>
>> -	sc->ioarea = request_mem_region(res->start, resource_size(res),
>> -					mmc_hostname(host->mmc));
>> -	if (!sc->ioarea) {
>> -		dev_err(dev, "failed to reserve register area\n");
>> -		ret = -ENXIO;
>> -		goto err_req_regs;
>> -	}
>> -
>> -	host->ioaddr = ioremap_nocache(res->start, resource_size(res));
>> -	if (!host->ioaddr) {
>> -		dev_err(dev, "failed to map registers\n");
>> -		ret = -ENXIO;
>> -		goto err_req_regs;
>> -	}
>> -
>>  	/* Ensure we have minimal gpio selected CMD/CLK/Detect */
>> -	if (pdata->cfg_gpio)
>> -		pdata->cfg_gpio(pdev, pdata->max_width);
>> -
>> -	host->hw_name = "samsung-hsmmc";
>> -	host->ops = &sdhci_s3c_ops;
>> -	host->quirks = 0;
>> -	host->irq = irq;
>> -
>> -	/* Setup quirks for the controller */
>> -	host->quirks |= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
>> -	host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
>> -	if (drv_data)
>> -		host->quirks |= drv_data->sdhci_quirks;
>> +	if (sc->pdata->cfg_gpio)
>> +		sc->pdata->cfg_gpio(pdev, sc->pdata->max_width);
>>
>>  #ifndef CONFIG_MMC_SDHCI_S3C_DMA
>> -
>>  	/* we currently see overruns on errors, so disable the SDMA
>>  	 * support as well. */
>>  	host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
>>
>>  #endif /* CONFIG_MMC_SDHCI_S3C_DMA */
>>
>> -	/* It seems we do not get an DATA transfer complete on non-busy
>> -	 * transfers, not sure if this is a problem with this specific
>> -	 * SDHCI block, or a missing configuration that needs to be set. */
>> -	host->quirks |= SDHCI_QUIRK_NO_BUSY_IRQ;
>> -
>> -	/* This host supports the Auto CMD12 */
>> -	host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>> -
>> -	/* Samsung SoCs need BROKEN_ADMA_ZEROLEN_DESC */
>> -	host->quirks |= SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC;
>> -
>> -	if (pdata->cd_type == S3C_SDHCI_CD_NONE ||
>> -	    pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
>> +	if (sc->pdata->cd_type == S3C_SDHCI_CD_NONE ||
>> +	    sc->pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
>>  		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>>
>> -	if (pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
>> +	if (sc->pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
>>  		host->mmc->caps = MMC_CAP_NONREMOVABLE;
>>
>> -	switch (pdata->max_width) {
>> +	switch (sc->pdata->max_width) {
>>  	case 8:
>>  		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
>>  	case 4:
>> @@ -691,17 +652,12 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>  		break;
>>  	}
>>
>> -	if (pdata->host_caps)
>> -		host->mmc->caps |= pdata->host_caps;
>> -
>> -	if (pdata->pm_caps)
>> -		host->mmc->pm_caps |= pdata->pm_caps;
>> -
>> -	host->quirks |= (SDHCI_QUIRK_32BIT_DMA_ADDR |
>> -			 SDHCI_QUIRK_32BIT_DMA_SIZE);
>> +	/* It supports additional host capabilities if needed */
>> +	if (sc->pdata->host_caps)
>> +		host->mmc->caps |= sc->pdata->host_caps;
>>
>> -	/* HSMMC on Samsung SoCs uses SDCLK as timeout clock */
>> -	host->quirks |= SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK;
>> +	if (sc->pdata->pm_caps)
>> +		host->mmc->pm_caps |= sc->pdata->pm_caps;
>>
>>  	/*
>>  	 * If controller does not have internal clock divider,
>> @@ -713,10 +669,6 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>  		sdhci_s3c_ops.get_max_clock = sdhci_cmu_get_max_clock;
>>  	}
>>
>> -	/* It supports additional host capabilities if needed */
>> -	if (pdata->host_caps)
>> -		host->mmc->caps |= pdata->host_caps;
>> -
>>  	ret = sdhci_add_host(host);
>>  	if (ret) {
>>  		dev_err(dev, "sdhci_add_host() failed\n");
>> @@ -726,38 +678,35 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>  	/* The following two methods of card detection might call
>>  	   sdhci_s3c_notify_change() immediately, so they can be called
>>  	   only after sdhci_add_host(). Setup errors are ignored. */
>> -	if (pdata->cd_type == S3C_SDHCI_CD_EXTERNAL && pdata->ext_cd_init)
>> -		pdata->ext_cd_init(&sdhci_s3c_notify_change);
>> -	if (pdata->cd_type == S3C_SDHCI_CD_GPIO &&
>> -	    gpio_is_valid(pdata->ext_cd_gpio))
>> +	if (sc->pdata->cd_type == S3C_SDHCI_CD_EXTERNAL &&
>> +			sc->pdata->ext_cd_init)
>> +		sc->pdata->ext_cd_init(&sdhci_s3c_notify_change);
>> +	if (sc->pdata->cd_type == S3C_SDHCI_CD_GPIO &&
>> +	    gpio_is_valid(sc->pdata->ext_cd_gpio))
>>  		sdhci_s3c_setup_card_detect_gpio(sc);
>>
>>  	return 0;
>>
>> - err_add_host:
>> -	release_resource(sc->ioarea);
>> -	kfree(sc->ioarea);
>> -
>> - err_req_regs:
>> +err_add_host:
>>  	for (ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
>>  		if (sc->clk_bus[ptr]) {
>>  			clk_disable(sc->clk_bus[ptr]);
>>  			clk_put(sc->clk_bus[ptr]);
>>  		}
>>  	}
>> -
>> - err_no_busclks:
>> +err_no_busclks:
>>  	clk_disable(sc->clk_io);
>>  	clk_put(sc->clk_io);
>>
>> - err_io_clk:
>> +err_io_clk:
>>  	for (ptr = 0; ptr < NUM_GPIOS(sc->pdata->max_width); ptr++)
>>  		gpio_free(sc->gpios[ptr]);
>> -	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL)
>> +	if (sc->pdata->cd_type == S3C_SDHCI_CD_INTERNAL)
>>  		gpio_free(sc->ext_cd_gpio);
>>
>> - err_pdata:
>> -	sdhci_free_host(host);
>> +err_alloc_host:
>> +	sdhci_pltfm_free(pdev);
>> +	dev_err(&pdev->dev, "%s failed %d\n", __func__, ret);
>>
>>  	return ret;
>>  }
>> @@ -765,12 +714,13 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>  static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
>>  {
>>  	struct sdhci_host *host =  platform_get_drvdata(pdev);
>> -	struct sdhci_s3c *sc = sdhci_priv(host);
>> -	struct s3c_sdhci_platdata *pdata = sc->pdata;
>> -	int ptr;
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_s3c *sc = pltfm_host->priv;
>> +	int ptr, ret;
>>
>> -	if (pdata->cd_type == S3C_SDHCI_CD_EXTERNAL && pdata->ext_cd_cleanup)
>> -		pdata->ext_cd_cleanup(&sdhci_s3c_notify_change);
>> +	if (sc->pdata->cd_type == S3C_SDHCI_CD_EXTERNAL &&
>> +			sc->pdata->ext_cd_cleanup)
>> +		sc->pdata->ext_cd_cleanup(&sdhci_s3c_notify_change);
>>
>>  	if (sc->ext_cd_irq)
>>  		free_irq(sc->ext_cd_irq, sc);
>> @@ -778,9 +728,9 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
>>  	if (gpio_is_valid(sc->ext_cd_gpio))
>>  		gpio_free(sc->ext_cd_gpio);
>>
>> -	sdhci_remove_host(host, 1);
>> +	ret = sdhci_pltfm_unregister(pdev);
>>
>> -	for (ptr = 0; ptr < 3; ptr++) {
>> +	for (ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
>>  		if (sc->clk_bus[ptr]) {
>>  			clk_disable(sc->clk_bus[ptr]);
>>  			clk_put(sc->clk_bus[ptr]);
>> @@ -789,48 +739,14 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
>>  	clk_disable(sc->clk_io);
>>  	clk_put(sc->clk_io);
>>
>> -	iounmap(host->ioaddr);
>> -	release_resource(sc->ioarea);
>> -	kfree(sc->ioarea);
>> -
>>  	if (pdev->dev.of_node) {
>>  		for (ptr = 0; ptr < NUM_GPIOS(sc->pdata->max_width); ptr++)
>>  			gpio_free(sc->gpios[ptr]);
>>  	}
>>
>> -	sdhci_free_host(host);
>> -	platform_set_drvdata(pdev, NULL);
>> -
>> -	return 0;
>> -}
>> -
>> -#ifdef CONFIG_PM
>> -
>> -static int sdhci_s3c_suspend(struct device *dev)
>> -{
>> -	struct sdhci_host *host = dev_get_drvdata(dev);
>> -
>> -	return sdhci_suspend_host(host);
>> -}
>> -
>> -static int sdhci_s3c_resume(struct device *dev)
>> -{
>> -	struct sdhci_host *host = dev_get_drvdata(dev);
>> -
>> -	return sdhci_resume_host(host);
>> +	return ret;
>>  }
>>
>> -static const struct dev_pm_ops sdhci_s3c_pmops = {
>> -	.suspend	= sdhci_s3c_suspend,
>> -	.resume		= sdhci_s3c_resume,
>> -};
>> -
>> -#define SDHCI_S3C_PMOPS (&sdhci_s3c_pmops)
>> -
>> -#else
>> -#define SDHCI_S3C_PMOPS NULL
>> -#endif
>> -
>>  #if defined(CONFIG_CPU_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212)
>>  static struct sdhci_s3c_drv_data exynos4_sdhci_drv_data = {
>>  	.sdhci_quirks = SDHCI_QUIRK_NONSTANDARD_CLOCK,
>> @@ -870,7 +786,7 @@ static struct platform_driver sdhci_s3c_driver = {
>>  		.owner	= THIS_MODULE,
>>  		.name	= "s3c-sdhci",
>>  		.of_match_table = of_match_ptr(sdhci_s3c_dt_match),
>> -		.pm	= SDHCI_S3C_PMOPS,
>> +		.pm	= SDHCI_PLTFM_PMOPS,
>>  	},
>>  };
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


