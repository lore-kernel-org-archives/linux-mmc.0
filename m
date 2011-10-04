From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-pci: add runtime pm support
Date: Tue, 04 Oct 2011 13:44:02 +0900
Message-ID: <4E8A8F12.9000609@samsung.com>
References: <1317645214-12316-1-git-send-email-adrian.hunter@intel.com>
 <1317645214-12316-3-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:20719 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080Ab1JDEoP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Oct 2011 00:44:15 -0400
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LSI008Q1YHOSNA0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 04 Oct 2011 13:44:13 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LSI009XHYHOFN50@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 04 Oct 2011 13:44:12 +0900 (KST)
In-reply-to: <1317645214-12316-3-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>

Hi Adrian...

> +#ifdef CONFIG_PM_RUNTIME
> +
> +static int sdhci_pci_runtime_suspend(struct device *dev)
> +{
> +	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
> +	struct sdhci_pci_chip *chip;
> +	struct sdhci_pci_slot *slot;
> +	pm_message_t state = { .event = PM_EVENT_SUSPEND };
> +	int i, ret;
> +
> +	chip = pci_get_drvdata(pdev);
> +	if (!chip)
> +		return 0;
> +
> +	for (i = 0; i < chip->num_slots; i++) {
> +		slot = chip->slots[i];
> +		if (!slot)
> +			continue;
> +
> +		ret = sdhci_runtime_suspend_host(slot->host);
> +
> +		if (ret) {
> +			for (i--; i >= 0; i--)
> +				sdhci_runtime_resume_host(chip->slots[i]->host);
> +			return ret;
> +		}
> +	}
> +
> +	if (chip->fixes && chip->fixes->suspend) {
> +		ret = chip->fixes->suspend(chip, state);
> +		if (ret) {
> +			for (i = chip->num_slots - 1; i >= 0; i--)
> +				sdhci_runtime_resume_host(chip->slots[i]->host);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}


sdhci_runtime_resume_host() is missed return-value.
And i looked into sdhci_runtime_resume/suspend_host()...but
always return 0...why did you check return-value..?

> +
> +static int sdhci_pci_runtime_resume(struct device *dev)
> +{
> +	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
> +	struct sdhci_pci_chip *chip;
> +	struct sdhci_pci_slot *slot;
> +	int i, ret;
> +
> +	chip = pci_get_drvdata(pdev);
> +	if (!chip)
> +		return 0;
> +
> +	if (chip->fixes && chip->fixes->resume) {
> +		ret = chip->fixes->resume(chip);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i = 0; i < chip->num_slots; i++) {
> +		slot = chip->slots[i];
> +		if (!slot)
> +			continue;
> +
> +		ret = sdhci_runtime_resume_host(slot->host);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sdhci_pci_runtime_idle(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +#else
> +
> +#define sdhci_pci_runtime_suspend	NULL
> +#define sdhci_pci_runtime_resume	NULL
> +#define sdhci_pci_runtime_idle		NULL
> +
> +#endif
> +
> +static const struct dev_pm_ops sdhci_pci_pm_ops = {
> +	.runtime_suspend = sdhci_pci_runtime_suspend,
> +	.runtime_resume = sdhci_pci_runtime_resume,
> +	.runtime_idle = sdhci_pci_runtime_idle,
> +};
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Device probing/removal                                                    *
> @@ -1132,6 +1290,21 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
>  	sdhci_free_host(slot->host);
>  }
>  
> +static void __devinit sdhci_pci_runtime_pm_allow(struct device *dev)
> +{
> +	pm_runtime_put_noidle(dev);
> +	pm_runtime_allow(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 50);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_suspend_ignore_children(dev, 1);
> +}
> +
> +static void __devexit sdhci_pci_runtime_pm_forbid(struct device *dev)
> +{
> +	pm_runtime_forbid(dev);
> +	pm_runtime_get_noresume(dev);
> +}
> +
>  static int __devinit sdhci_pci_probe(struct pci_dev *pdev,
>  				     const struct pci_device_id *ent)
>  {
> @@ -1207,6 +1380,8 @@ static int __devinit sdhci_pci_probe(struct pci_dev *pdev,
>  		chip->slots[i] = slot;
>  	}
>  
> +	sdhci_pci_runtime_pm_allow(&pdev->dev);
> +
>  	return 0;
>  
>  free:
> @@ -1223,6 +1398,8 @@ static void __devexit sdhci_pci_remove(struct pci_dev *pdev)
>  	int i;
>  	struct sdhci_pci_chip *chip;
>  
> +	sdhci_pci_runtime_pm_forbid(&pdev->dev);
> +
>  	chip = pci_get_drvdata(pdev);
>  
>  	if (chip) {
> @@ -1243,6 +1420,9 @@ static struct pci_driver sdhci_driver = {
>  	.remove =	__devexit_p(sdhci_pci_remove),
>  	.suspend =	sdhci_pci_suspend,
>  	.resume	=	sdhci_pci_resume,
> +	.driver =	{
> +		.pm =   &sdhci_pci_pm_ops
> +	},
>  };
>  
>  /*****************************************************************************\
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index d66a7a1..787b877 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -20,6 +20,7 @@
>  #include <linux/slab.h>
>  #include <linux/scatterlist.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/pm_runtime.h>
>  
>  #include <linux/leds.h>
>  
> @@ -41,6 +42,7 @@
>  #define MAX_TUNING_LOOP 40
>  
>  static unsigned int debug_quirks = 0;
> +static unsigned int debug_quirks2;
>  
>  static void sdhci_finish_data(struct sdhci_host *);
>  
> @@ -49,6 +51,20 @@ static void sdhci_finish_command(struct sdhci_host *);
>  static int sdhci_execute_tuning(struct mmc_host *mmc);
>  static void sdhci_tuning_timer(unsigned long data);
>  
> +#ifdef CONFIG_PM_RUNTIME
> +static int sdhci_runtime_pm_get(struct sdhci_host *host);
> +static int sdhci_runtime_pm_put(struct sdhci_host *host);
> +#else
> +static inline int sdhci_runtime_pm_get(struct sdhci_host *host)
> +{
> +	return 0;
> +}
> +static inline int sdhci_runtime_pm_put(struct sdhci_host *host)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static void sdhci_dumpregs(struct sdhci_host *host)
>  {
>  	printk(KERN_DEBUG DRIVER_NAME ": =========== REGISTER DUMP (%s)===========\n",
> @@ -132,6 +148,9 @@ static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
>  	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
>  		return;
>  
> +	if (host->quirks2 & SDHCI_QUIRK2_OWN_CARD_DETECTION)
> +		return;
> +
>  	present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
>  			      SDHCI_CARD_PRESENT;
>  	irqs = present ? SDHCI_INT_CARD_REMOVE : SDHCI_INT_CARD_INSERT;
> @@ -251,11 +270,14 @@ static void sdhci_led_control(struct led_classdev *led,
>  
>  	spin_lock_irqsave(&host->lock, flags);
>  
> +	if (host->runtime_suspended)
> +		goto out;
> +
>  	if (brightness == LED_OFF)
>  		sdhci_deactivate_led(host);
>  	else
>  		sdhci_activate_led(host);
> -
> +out:
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
>  #endif
> @@ -1209,6 +1231,8 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  
>  	host = mmc_priv(mmc);
>  
> +	sdhci_runtime_pm_get(host);
> +
>  	spin_lock_irqsave(&host->lock, flags);
>  
>  	WARN_ON(host->mrq != NULL);
> @@ -1269,14 +1293,11 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
>  
> -static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>  {
> -	struct sdhci_host *host;
>  	unsigned long flags;
>  	u8 ctrl;
>  
> -	host = mmc_priv(mmc);
> -
>  	spin_lock_irqsave(&host->lock, flags);
>  
>  	if (host->flags & SDHCI_DEVICE_DEAD)
> @@ -1426,7 +1447,16 @@ out:
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
>  
> -static int check_ro(struct sdhci_host *host)
> +static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	sdhci_runtime_pm_get(host);
> +	sdhci_do_set_ios(host, ios);
> +	sdhci_runtime_pm_put(host);
> +}
> +
> +static int sdhci_check_ro(struct sdhci_host *host)
>  {
>  	unsigned long flags;
>  	int is_readonly;
> @@ -1450,19 +1480,16 @@ static int check_ro(struct sdhci_host *host)
>  
>  #define SAMPLE_COUNT	5
>  
> -static int sdhci_get_ro(struct mmc_host *mmc)
> +static int sdhci_do_get_ro(struct sdhci_host *host)
>  {
> -	struct sdhci_host *host;
>  	int i, ro_count;
>  
> -	host = mmc_priv(mmc);
> -
>  	if (!(host->quirks & SDHCI_QUIRK_UNSTABLE_RO_DETECT))
> -		return check_ro(host);
> +		return sdhci_check_ro(host);
>  
>  	ro_count = 0;
>  	for (i = 0; i < SAMPLE_COUNT; i++) {
> -		if (check_ro(host)) {
> +		if (sdhci_check_ro(host)) {
>  			if (++ro_count > SAMPLE_COUNT / 2)
>  				return 1;
>  		}
> @@ -1479,38 +1506,56 @@ static void sdhci_hw_reset(struct mmc_host *mmc)
>  		host->ops->hw_reset(host);
>  }
>  
> -static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
> +static int sdhci_get_ro(struct mmc_host *mmc)
>  {
> -	struct sdhci_host *host;
> -	unsigned long flags;
> -
> -	host = mmc_priv(mmc);
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	int ret;
>  
> -	spin_lock_irqsave(&host->lock, flags);
> +	sdhci_runtime_pm_get(host);
> +	ret = sdhci_do_get_ro(host);
> +	sdhci_runtime_pm_put(host);
> +	return ret;
> +}
>  
> +static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int enable)
> +{
>  	if (host->flags & SDHCI_DEVICE_DEAD)
>  		goto out;
>  
>  	if (enable)
> +		host->flags |= SDHCI_SDIO_IRQ_ENABLED;
> +	else
> +		host->flags &= ~SDHCI_SDIO_IRQ_ENABLED;
> +
> +	/* SDIO IRQ will be enabled as appropriate in runtime resume */
> +	if (host->runtime_suspended)
> +		goto out;
> +
> +	if (enable)
>  		sdhci_unmask_irqs(host, SDHCI_INT_CARD_INT);
>  	else
>  		sdhci_mask_irqs(host, SDHCI_INT_CARD_INT);
>  out:
>  	mmiowb();
> +}
> +
> +static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	unsigned long flags;
>  
> +	spin_lock_irqsave(&host->lock, flags);
> +	sdhci_enable_sdio_irq_nolock(host, enable);
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
>  
> -static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> -	struct mmc_ios *ios)
> +static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
> +						struct mmc_ios *ios)
>  {
> -	struct sdhci_host *host;
>  	u8 pwr;
>  	u16 clk, ctrl;
>  	u32 present_state;
>  
> -	host = mmc_priv(mmc);
> -
>  	/*
>  	 * Signal Voltage Switching is only applicable for Host Controllers
>  	 * v3.00 and above.
> @@ -1603,6 +1648,20 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  		return 0;
>  }
>  
> +static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> +	struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	int err;
> +
> +	if (host->version < SDHCI_SPEC_300)
> +		return 0;
> +	sdhci_runtime_pm_get(host);
> +	err = sdhci_do_start_signal_voltage_switch(host, ios);
> +	sdhci_runtime_pm_put(host);
> +	return err;
> +}
> +
>  static int sdhci_execute_tuning(struct mmc_host *mmc)
>  {
>  	struct sdhci_host *host;
> @@ -1614,6 +1673,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc)
>  
>  	host = mmc_priv(mmc);
>  
> +	sdhci_runtime_pm_get(host);
>  	disable_irq(host->irq);
>  	spin_lock(&host->lock);
>  
> @@ -1631,6 +1691,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc)
>  	else {
>  		spin_unlock(&host->lock);
>  		enable_irq(host->irq);
> +		sdhci_runtime_pm_put(host);
>  		return 0;
>  	}
>  
> @@ -1656,7 +1717,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc)
>  	timeout = 150;
>  	do {
>  		struct mmc_command cmd = {0};
> -		struct mmc_request mrq = {0};
> +		struct mmc_request mrq = {NULL};
>  
>  		if (!tuning_loop_counter && !timeout)
>  			break;
> @@ -1774,18 +1835,16 @@ out:
>  	sdhci_clear_set_irqs(host, SDHCI_INT_DATA_AVAIL, ier);
>  	spin_unlock(&host->lock);
>  	enable_irq(host->irq);
> +	sdhci_runtime_pm_put(host);
>  
>  	return err;
>  }
>  
> -static void sdhci_enable_preset_value(struct mmc_host *mmc, bool enable)
> +static void sdhci_do_enable_preset_value(struct sdhci_host *host, bool enable)
>  {
> -	struct sdhci_host *host;
>  	u16 ctrl;
>  	unsigned long flags;
>  
> -	host = mmc_priv(mmc);
> -
>  	/* Host Controller v3.00 defines preset value registers */
>  	if (host->version < SDHCI_SPEC_300)
>  		return;
> @@ -1801,14 +1860,25 @@ static void sdhci_enable_preset_value(struct mmc_host *mmc, bool enable)
>  	if (enable && !(ctrl & SDHCI_CTRL_PRESET_VAL_ENABLE)) {
>  		ctrl |= SDHCI_CTRL_PRESET_VAL_ENABLE;
>  		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> +		host->flags |= SDHCI_PV_ENABLED;
>  	} else if (!enable && (ctrl & SDHCI_CTRL_PRESET_VAL_ENABLE)) {
>  		ctrl &= ~SDHCI_CTRL_PRESET_VAL_ENABLE;
>  		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> +		host->flags &= ~SDHCI_PV_ENABLED;
>  	}
>  
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
>  
> +static void sdhci_enable_preset_value(struct mmc_host *mmc, bool enable)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	sdhci_runtime_pm_get(host);
> +	sdhci_do_enable_preset_value(host, enable);
> +	sdhci_runtime_pm_put(host);
> +}
> +
>  static const struct mmc_host_ops sdhci_ops = {
>  	.request	= sdhci_request,
>  	.set_ios	= sdhci_set_ios,
> @@ -1835,19 +1905,19 @@ static void sdhci_tasklet_card(unsigned long param)
>  
>  	spin_lock_irqsave(&host->lock, flags);
>  
> -	if (!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT)) {
> -		if (host->mrq) {
> -			printk(KERN_ERR "%s: Card removed during transfer!\n",
> -				mmc_hostname(host->mmc));
> -			printk(KERN_ERR "%s: Resetting controller.\n",
> -				mmc_hostname(host->mmc));
> +	/* Check host->mrq first in case we are runtime suspended */
> +	if (host->mrq &&
> +	    !(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT)) {
> +		printk(KERN_ERR "%s: Card removed during transfer!\n",
> +			mmc_hostname(host->mmc));
> +		printk(KERN_ERR "%s: Resetting controller.\n",
> +			mmc_hostname(host->mmc));
>  
> -			sdhci_reset(host, SDHCI_RESET_CMD);
> -			sdhci_reset(host, SDHCI_RESET_DATA);
> +		sdhci_reset(host, SDHCI_RESET_CMD);
> +		sdhci_reset(host, SDHCI_RESET_DATA);
>  
> -			host->mrq->cmd->error = -ENOMEDIUM;
> -			tasklet_schedule(&host->finish_tasklet);
> -		}
> +		host->mrq->cmd->error = -ENOMEDIUM;
> +		tasklet_schedule(&host->finish_tasklet);
>  	}
>  
>  	spin_unlock_irqrestore(&host->lock, flags);
> @@ -1863,14 +1933,16 @@ static void sdhci_tasklet_finish(unsigned long param)
>  
>  	host = (struct sdhci_host*)param;
>  
> +	spin_lock_irqsave(&host->lock, flags);
> +
>          /*
>           * If this tasklet gets rescheduled while running, it will
>           * be run again afterwards but without any active request.
>           */
> -	if (!host->mrq)
> +	if (!host->mrq) {
> +		spin_unlock_irqrestore(&host->lock, flags);
>  		return;
> -
> -	spin_lock_irqsave(&host->lock, flags);
> +	}
>  
>  	del_timer(&host->timer);
>  
> @@ -1914,6 +1986,7 @@ static void sdhci_tasklet_finish(unsigned long param)
>  	spin_unlock_irqrestore(&host->lock, flags);
>  
>  	mmc_request_done(host->mmc, mrq);
> +	sdhci_runtime_pm_put(host);
>  }
>  
>  static void sdhci_timeout_timer(unsigned long data)
> @@ -2145,12 +2218,19 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  static irqreturn_t sdhci_irq(int irq, void *dev_id)
>  {
>  	irqreturn_t result;
> -	struct sdhci_host* host = dev_id;
> +	struct sdhci_host *host = dev_id;
>  	u32 intmask;
>  	int cardint = 0;
>  
>  	spin_lock(&host->lock);
>  
> +	if (host->runtime_suspended) {
> +		spin_unlock(&host->lock);
> +		printk(KERN_WARNING "%s: got irq while runtime suspended\n",
> +		       mmc_hostname(host->mmc));
> +		return IRQ_HANDLED;
> +	}
> +
>  	intmask = sdhci_readl(host, SDHCI_INT_STATUS);
>  
>  	if (!intmask || intmask == 0xffffffff) {
> @@ -2284,7 +2364,6 @@ int sdhci_resume_host(struct sdhci_host *host)
>  			return ret;
>  	}
>  
> -
>  	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
>  		if (host->ops->enable_dma)
>  			host->ops->enable_dma(host);
> @@ -2323,6 +2402,90 @@ EXPORT_SYMBOL_GPL(sdhci_enable_irq_wakeups);
>  
>  #endif /* CONFIG_PM */
>  
> +#ifdef CONFIG_PM_RUNTIME
> +
> +static int sdhci_runtime_pm_get(struct sdhci_host *host)
> +{
> +	return pm_runtime_get_sync(host->mmc->parent);
> +}
> +
> +static int sdhci_runtime_pm_put(struct sdhci_host *host)
> +{
> +	pm_runtime_mark_last_busy(host->mmc->parent);
> +	return pm_runtime_put_autosuspend(host->mmc->parent);
> +}
> +
> +int sdhci_runtime_suspend_host(struct sdhci_host *host)
> +{
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	/* Disable tuning since we are suspending */
> +	if (host->version >= SDHCI_SPEC_300 &&
> +	    host->tuning_mode == SDHCI_TUNING_MODE_1) {
> +		del_timer_sync(&host->tuning_timer);
> +		host->flags &= ~SDHCI_NEEDS_RETUNING;
> +	}
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +	sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	synchronize_irq(host->irq);
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +	host->runtime_suspended = true;
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(sdhci_runtime_suspend_host);
> +
> +int sdhci_runtime_resume_host(struct sdhci_host *host)
> +{
> +	unsigned long flags;
> +	int ret = 0, host_flags = host->flags;
> +
> +	if (host_flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
> +		if (host->ops->enable_dma)
> +			host->ops->enable_dma(host);
> +	}
> +
> +	sdhci_init(host, 0);
> +
> +	/* Force clock and power re-program */
> +	host->pwr = 0;
> +	host->clock = 0;
> +	sdhci_do_set_ios(host, &host->mmc->ios);
> +
> +	sdhci_do_start_signal_voltage_switch(host, &host->mmc->ios);
> +	if (host_flags & SDHCI_PV_ENABLED)
> +		sdhci_do_enable_preset_value(host, true);
> +
> +	/* Set the re-tuning expiration flag */
> +	if ((host->version >= SDHCI_SPEC_300) && host->tuning_count &&
> +	    (host->tuning_mode == SDHCI_TUNING_MODE_1))
> +		host->flags |= SDHCI_NEEDS_RETUNING;
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	host->runtime_suspended = false;
> +
> +	/* Enable SDIO IRQ */
> +	if ((host->flags & SDHCI_SDIO_IRQ_ENABLED))
> +		sdhci_enable_sdio_irq_nolock(host, true);
> +
> +	/* Enable Card Detection */
> +	sdhci_enable_card_detection(host);
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(sdhci_runtime_resume_host);
> +
> +#endif
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Device allocation/registration                                            *
> @@ -2365,6 +2528,8 @@ int sdhci_add_host(struct sdhci_host *host)
>  
>  	if (debug_quirks)
>  		host->quirks = debug_quirks;
> +	if (debug_quirks2)
> +		host->quirks2 = debug_quirks2;
>  
>  	sdhci_reset(host, SDHCI_RESET_ALL);
>  
> @@ -2887,9 +3052,11 @@ module_init(sdhci_drv_init);
>  module_exit(sdhci_drv_exit);
>  
>  module_param(debug_quirks, uint, 0444);
> +module_param(debug_quirks2, uint, 0444);
>  
>  MODULE_AUTHOR("Pierre Ossman <pierre@ossman.eu>");
>  MODULE_DESCRIPTION("Secure Digital Host Controller Interface core driver");
>  MODULE_LICENSE("GPL");
>  
>  MODULE_PARM_DESC(debug_quirks, "Force certain quirks.");
> +MODULE_PARM_DESC(debug_quirks, "Force certain other quirks.");
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 7bd919c..0a5b654 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -379,4 +379,9 @@ extern int sdhci_resume_host(struct sdhci_host *host);
>  extern void sdhci_enable_irq_wakeups(struct sdhci_host *host);
>  #endif
>  
> +#ifdef CONFIG_PM_RUNTIME
> +extern int sdhci_runtime_suspend_host(struct sdhci_host *host);
> +extern int sdhci_runtime_resume_host(struct sdhci_host *host);
> +#endif
> +
>  #endif /* __SDHCI_HW_H */
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index 5666f3a..e4b6935 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -88,6 +88,10 @@ struct sdhci_host {
>  /* The read-only detection via SDHCI_PRESENT_STATE register is unstable */
>  #define SDHCI_QUIRK_UNSTABLE_RO_DETECT			(1<<31)
>  
> +	unsigned int quirks2;	/* More deviations from spec. */
> +
> +#define SDHCI_QUIRK2_OWN_CARD_DETECTION			(1<<0)
> +
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
>  
> @@ -115,6 +119,8 @@ struct sdhci_host {
>  #define SDHCI_NEEDS_RETUNING	(1<<5)	/* Host needs retuning */
>  #define SDHCI_AUTO_CMD12	(1<<6)	/* Auto CMD12 support */
>  #define SDHCI_AUTO_CMD23	(1<<7)	/* Auto CMD23 support */
> +#define SDHCI_PV_ENABLED	(1<<8)	/* Preset value enabled */
> +#define SDHCI_SDIO_IRQ_ENABLED	(1<<9)	/* SDIO irq enabled */
>  
>  	unsigned int version;	/* SDHCI spec. version */
>  
> @@ -125,6 +131,8 @@ struct sdhci_host {
>  	unsigned int clock;	/* Current clock (MHz) */
>  	u8 pwr;			/* Current voltage */
>  
> +	bool runtime_suspended;	/* Host is runtime suspended */
> +
>  	struct mmc_request *mrq;	/* Current request */
>  	struct mmc_command *cmd;	/* Current command */
>  	struct mmc_data *data;	/* Current data request */


