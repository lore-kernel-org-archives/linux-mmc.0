From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH v5] mmc: add a function to get regulators, supplying card's
 power
Date: Wed, 13 Jun 2012 15:35:57 +0200
Message-ID: <4FD8973D.2010409@stericsson.com>
References: <Pine.LNX.4.64.1206131454260.17854@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1206131454260.17854@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Hi Guennadi,

On 06/13/2012 02:57 PM, Guennadi Liakhovetski wrote:
> Add a function to get regulators, supplying card's Vdd and Vccq on a
> specific host. If a Vdd supplying regulator is found, the function checks,
> whether a valid OCR mask can be obtained from it. The Vccq regulator is
> optional. A failure to get it is not fatal.
>
> Signed-off-by: Guennadi Liakhovetski<g.liakhovetski@gmx.de>
> ---
>
> v5: put struct mmc_supply inside struct mmc_host, thanks for all comments
>
>   drivers/mmc/core/core.c  |   24 ++++++++++++++++++++++++
>   include/linux/mmc/host.h |   16 ++++++++++++++--
>   2 files changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 0b6141d..4aa8658 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1013,6 +1013,30 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
>   }
>   EXPORT_SYMBOL(mmc_regulator_set_ocr);
>
> +int mmc_regulator_get_supply(struct mmc_host *mmc)
> +{
> +	struct device *dev = mmc_dev(mmc);
> +	struct regulator *supply;
> +	int ret;
> +
> +	supply = devm_regulator_get(dev, "vmmc");
> +
> +	if (IS_ERR(supply))
> +		return PTR_ERR(supply);
> +
> +	mmc->supply.vmmc = supply;
> +	mmc->supply.vqmmc = devm_regulator_get(dev, "vqmmc");
> +
> +	ret = mmc_regulator_get_ocrmask(supply);
> +	if (ret>  0)
> +		mmc->ocr_avail = ret;
> +	else
> +		dev_warn(mmc_dev(mmc), "Failed getting OCR mask: %d\n", ret);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mmc_regulator_get_supply);
> +
>   #endif /* CONFIG_REGULATOR */
>
>   /*
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 0707d22..9deb725 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -155,6 +155,13 @@ struct mmc_hotplug {
>   	void *handler_priv;
>   };
>
> +struct regulator;

Sorry for not spotting this before. Can we not remove this and instead 
do an include in the top of this file like:
#include <linux/regulator/consumer.h>

> +
> +struct mmc_supply {
> +	struct regulator *vmmc;		/* Card power supply */
> +	struct regulator *vqmmc;	/* Optional Vccq supply */
> +};

Do we really need a new separate struct for this? I am in favor of 
having the regulators directly in the mmc_host, just for simplicity.

> +
>   struct mmc_host {
>   	struct device		*parent;
>   	struct device		class_dev;
> @@ -309,6 +316,7 @@ struct mmc_host {
>   #ifdef CONFIG_REGULATOR
>   	bool			regulator_enabled; /* regulator state */
>   #endif
> +	struct mmc_supply	supply;
>
>   	struct dentry		*debugfs_root;
>
> @@ -357,13 +365,12 @@ static inline void mmc_signal_sdio_irq(struct mmc_host *host)
>   	wake_up_process(host->sdio_irq_thread);
>   }
>
> -struct regulator;
> -
>   #ifdef CONFIG_REGULATOR
>   int mmc_regulator_get_ocrmask(struct regulator *supply);
>   int mmc_regulator_set_ocr(struct mmc_host *mmc,
>   			struct regulator *supply,
>   			unsigned short vdd_bit);
> +int mmc_regulator_get_supply(struct mmc_host *mmc);
>   #else
>   static inline int mmc_regulator_get_ocrmask(struct regulator *supply)
>   {
> @@ -376,6 +383,11 @@ static inline int mmc_regulator_set_ocr(struct mmc_host *mmc,
>   {
>   	return 0;
>   }
> +
> +static inline int mmc_regulator_get_supply(struct mmc_host *mmc)
> +{
> +	return 0;
> +}
>   #endif
>
>   int mmc_card_awake(struct mmc_host *host);

Sorry being a bit picky, I am that mode today :-)

Kind regards
Ulf Hansson
