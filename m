From: Ben Dooks <ben@simtec.co.uk>
Subject: Re: [PATCHv5 3/4] sdhci-s3c: add support for new card detection methods
 (driver part)
Date: Wed, 28 Jul 2010 18:03:10 +0100
Message-ID: <4C5062CE.2000105@simtec.co.uk>
References: <1280326797-15792-1-git-send-email-m.szyprowski@samsung.com> <1280326797-15792-4-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1280326797-15792-4-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, broonie@opensource.wolfsonmicro.com, kyungmin.park@samsung.com, ben-linux@fluff.org, akpm@linux-foundation.org
List-Id: linux-mmc@vger.kernel.org

On 28/07/10 15:19, Marek Szyprowski wrote:
> On some Samsung SoCs not all SDHCI controllers have card detect (CD)
> line. For some embedded designs it is not even needed, because ususally
> the device (like SDIO flash memory or wifi controller) is permanently
> wired to the controller. There are also systems which have a card detect
> line connected to some of the external interrupt lines or the presence
> of the card depends on some other actions (like enabling a power
> regulator).
> 
> This patch adds support for all these cases. The following card
> detection methods are possible:
> 
> 1. internal sdhci host card detect line
> 2. external event
> 3. external gpio interrupt
> 4. no card detect line, controller will poll for the card
> 5. no card detect line, card is permanently wired to the controller
> (once detected host won't poll it any more)
> 
> By default, all existing code would use method #1, what is compatible
> with the previous version of the driver.
> 
> In case of external event, two callbacks must be provided in platdata:
> ext_cd_init and ext_cd_cleanup. Both of them get a callback to a
> function that notifies the s3c-sdhci host contoller as their argument.
> That callback function should be called from the even dispatcher to let
> host notice the card insertion/removal.
> 
> In case of external gpio interrupt, a gpio pin number must be provided
> in platdata (ext_cd_gpio parameter), as well as the information about
> the polarity of that gpio pin (ext_cd_gpio_invert). By default
> (ext_cd_gpio_invert == 0) gpio value 0 means 'card has been removed',
> but this can be changed to 'card has been removed' when
> ext_cd_gpio_invert == 1.
> 
> This patch adds all required changes to sdhci-s3c driver.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> 
> Changes since V4:
> - adapted to threaded irq approach in sdhci driver
> - rebased onto latest -mm kernel tree
> - fixed problem when gpio-base card detection was not called on driver
> init
> 
> Changes since V3:
> - renamed patch to avoid confusion with the patch for the s3c-sdhci
> platform changes - added "(driver part)" in subject
> 
> Changes since V2:
> According to Andrew Morton's suggestion local_irq_save() call in the
> sdhci_s3c_notify_change function has been replaced by spin_lock_irqsave
> (host driver already has a spinlock that is used for protecting internal
> state of the driver).
> 
> Changes since V1:
> - added support for gpio external interrupt card based detect method
>   directly to sdhci-s3c driver
> 
> ---
>  drivers/mmc/host/sdhci-s3c.c |   78 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c     |   47 ++++++++++++++-----------
>  drivers/mmc/host/sdhci.h     |    1 +
>  3 files changed, 106 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 9938ded..606e695 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -18,6 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> +#include <linux/gpio.h>
>  
>  #include <linux/mmc/host.h>
>  
> @@ -44,6 +45,8 @@ struct sdhci_s3c {
>  	struct resource		*ioarea;
>  	struct s3c_sdhci_platdata *pdata;
>  	unsigned int		cur_clk;
> +	int			ext_cd_irq;
> +	int			ext_cd_gpio;
>  
>  	struct clk		*clk_io;
>  	struct clk		*clk_bus[MAX_BUS_CLK];
> @@ -235,6 +238,36 @@ static struct sdhci_ops sdhci_s3c_ops = {
>  	.get_min_clock		= sdhci_s3c_get_min_clock,
>  };
>  
> +static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
> +{
> +	struct sdhci_host *host = platform_get_drvdata(dev);
> +	if (host) {
> +		mutex_lock(&host->lock);
> +		if (state) {
> +			dev_dbg(&dev->dev, "card inserted.\n");
> +			host->flags &= ~SDHCI_DEVICE_DEAD;
> +			host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> +			sdhci_card_detect(host);
> +		} else {
> +			dev_dbg(&dev->dev, "card removed.\n");
> +			host->flags |= SDHCI_DEVICE_DEAD;
> +			host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> +			sdhci_card_detect(host);
> +		}
> +		mutex_unlock(&host->lock);
> +	}
> +}
> +
> +static irqreturn_t sdhci_s3c_gpio_card_detect_thread(int irq, void *dev_id)
> +{
> +	struct sdhci_s3c *sc = dev_id;
> +	int status = gpio_get_value(sc->ext_cd_gpio);
> +	if (sc->pdata->ext_cd_gpio_invert)
> +		status = !status;

maybe move the invert into sdhci_s3c_notify_change()

> +	sdhci_s3c_notify_change(sc->pdev, status);
> +	return IRQ_HANDLED;
> +}
> +
>  static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  {
>  	struct s3c_sdhci_platdata *pdata = pdev->dev.platform_data;
> @@ -272,6 +305,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  	sc->host = host;
>  	sc->pdev = pdev;
>  	sc->pdata = pdata;
> +	sc->ext_cd_gpio = -1;
>  
>  	platform_set_drvdata(pdev, host);
>  
> @@ -355,6 +389,13 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  	 * SDHCI block, or a missing configuration that needs to be set. */
>  	host->quirks |= SDHCI_QUIRK_NO_BUSY_IRQ;
>  
> +	if (pdata->cd_type == S3C_SDHCI_CD_NONE ||
> +	    pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
> +		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> +
> +	if (pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
> +		host->mmc->caps = MMC_CAP_NONREMOVABLE;
> +
>  	host->quirks |= (SDHCI_QUIRK_32BIT_DMA_ADDR |
>  			 SDHCI_QUIRK_32BIT_DMA_SIZE);
>  
> @@ -367,6 +408,33 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  		goto err_add_host;
>  	}
>  
> +	/* pdata->ext_cd_init might call sdhci_s3c_notify_change immediately,
> +	   so it can be called only after sdhci_add_host() */
> +	if (pdata->cd_type == S3C_SDHCI_CD_EXTERNAL && pdata->ext_cd_init)
> +		pdata->ext_cd_init(&sdhci_s3c_notify_change);

do we really need a callback for this?

> +
> +	if (pdata->cd_type == S3C_SDHCI_CD_GPIO &&
> +	    gpio_is_valid(pdata->ext_cd_gpio)) {
> +		int status;
> +
> +		gpio_request(pdata->ext_cd_gpio, "SDHCI EXT CD");
> +		sc->ext_cd_gpio = pdata->ext_cd_gpio;
> +
> +		sc->ext_cd_irq = gpio_to_irq(pdata->ext_cd_gpio);
> +		if (sc->ext_cd_irq &&
> +		    request_threaded_irq(sc->ext_cd_irq, NULL, sdhci_s3c_gpio_card_detect_thread,
> +				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +				dev_name(&pdev->dev), sc)) {
> +			dev_err(&pdev->dev, "cannot request irq for card detect\n");
> +			sc->ext_cd_irq = 0;
> +		}
> +
> +		status = gpio_get_value(sc->ext_cd_gpio);
> +		if (sc->pdata->ext_cd_gpio_invert)
> +			status = !status;
> +		sdhci_s3c_notify_change(sc->pdev, status);
> +	}
> +
>  	return 0;
>  
>   err_add_host:
> @@ -391,10 +459,20 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  
>  static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
>  {
> +	struct s3c_sdhci_platdata *pdata = pdev->dev.platform_data;
>  	struct sdhci_host *host =  platform_get_drvdata(pdev);
>  	struct sdhci_s3c *sc = sdhci_priv(host);
>  	int ptr;
>  
> +	if (pdata->cd_type == S3C_SDHCI_CD_EXTERNAL && pdata->ext_cd_cleanup)
> +		pdata->ext_cd_cleanup(&sdhci_s3c_notify_change);
> +
> +	if (sc->ext_cd_irq)
> +		free_irq(sc->ext_cd_irq, sc);
> +
> +	if (sc->ext_cd_gpio != -1)
> +		gpio_free(sc->ext_cd_gpio);
> +
>  	sdhci_remove_host(host, 1);
>  
>  	for (ptr = 0; ptr < 3; ptr++) {
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 682b285..aa82344 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1244,26 +1244,6 @@ static const struct mmc_host_ops sdhci_ops = {
>   *                                                                           *
>  \*****************************************************************************/
>  
> -static void sdhci_card_detect(struct sdhci_host *host)
> -{
> -	if (!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT)) {
> -		if (host->mrq) {
> -			printk(KERN_ERR "%s: Card removed during transfer!\n",
> -				mmc_hostname(host->mmc));
> -			printk(KERN_ERR "%s: Resetting controller.\n",
> -				mmc_hostname(host->mmc));
> -
> -			sdhci_reset(host, SDHCI_RESET_CMD);
> -			sdhci_reset(host, SDHCI_RESET_DATA);
> -
> -			host->mrq->cmd->error = -ENOMEDIUM;
> -			schedule_work(&host->finish_work);
> -		}
> -	}
> -
> -	mmc_detect_change(host->mmc, msecs_to_jiffies(200));
> -}
> -
>  static void sdhci_finish_work(struct work_struct *wk)
>  {
>  	struct sdhci_host *host;
> @@ -1627,6 +1607,33 @@ EXPORT_SYMBOL_GPL(sdhci_resume_host);
>  
>  /*****************************************************************************\
>   *                                                                           *
> + * Implementation dependent callbacks                                        *
> + *                                                                           *
> +\*****************************************************************************/
> +
> +void sdhci_card_detect(struct sdhci_host *host)
> +{
> +	if (!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT)) {
> +		if (host->mrq) {
> +			printk(KERN_ERR "%s: Card removed during transfer!\n",
> +				mmc_hostname(host->mmc));
> +			printk(KERN_ERR "%s: Resetting controller.\n",
> +				mmc_hostname(host->mmc));
> +
> +			sdhci_reset(host, SDHCI_RESET_CMD);
> +			sdhci_reset(host, SDHCI_RESET_DATA);
> +
> +			host->mrq->cmd->error = -ENOMEDIUM;
> +			schedule_work(&host->finish_work);
> +		}
> +	}
> +
> +	mmc_detect_change(host->mmc, msecs_to_jiffies(200));
> +}
> +EXPORT_SYMBOL_GPL(sdhci_card_detect);

somehow this function seems to have been changed without a lot of
obvious changes?
