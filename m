From: Philip Rakity <prakity@nvidia.com>
Subject: Re: [PATCH v2 3/3] mmc: sdhci: update signal voltage switch code
Date: Mon, 17 Dec 2012 11:38:34 +0100
Message-ID: <139D9B7F-BBE0-4621-99B4-B09ADD34C5CE@nvidia.com>
References: <1355730627-8751-1-git-send-email-kliu5@marvell.com>
 <1355730627-8751-4-git-send-email-kliu5@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:19166 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab2LQKil convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Dec 2012 05:38:41 -0500
In-Reply-To: <1355730627-8751-4-git-send-email-kliu5@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <kliu5@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "johan.rudholm@stericsson.com" <johan.rudholm@stericsson.com>, "per.forlin@stericsson.com" <per.forlin@stericsson.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "fredrik.soderstedt@stericsson.com" <fredrik.soderstedt@stericsson.com>, "dsd@laptop.org" <dsd@laptop.org>, "leafy.myeh@allwinnertech.com" <leafy.myeh@allwinnertech.com>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>, "haojian.zhuang@gmail.com" <haojian.zhuang@gmail.com>, "cxie4@marvell.com" <cxie4@marvell.com>, "keyuan.liu@gmail.com" <keyuan.liu@gmail.com>


On Dec 17, 2012, at 8:50 AM, Kevin Liu <kliu5@marvell.com> wrote:

> The protocal related code is moved to core stack. So update the host
> driver accordingly.
> 
> Signed-off-by: Kevin Liu <kliu5@marvell.com>
> Tested-by: Tim Wang <wangtt@marvell.com>
> ---
> drivers/mmc/host/sdhci.c |  194 +++++++++++++++++++---------------------------
> 1 files changed, 81 insertions(+), 113 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 6f0bfc0..beaa233 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1608,145 +1608,99 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
> 	spin_unlock_irqrestore(&host->lock, flags);
> }
> 
> -static int sdhci_do_3_3v_signal_voltage_switch(struct sdhci_host *host,
> -						u16 ctrl)
> +static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
> +						int signal_voltage)
> {
> +	u16 ctrl;
> 	int ret;
> 
> -	/* Set 1.8V Signal Enable in the Host Control2 register to 0 */
> -	ctrl &= ~SDHCI_CTRL_VDD_180;
> -	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> -
> -	if (host->vqmmc) {
> -		ret = regulator_set_voltage(host->vqmmc, 2700000, 3600000);
> -		if (ret) {
> -			pr_warning("%s: Switching to 3.3V signalling voltage "
> -				   " failed\n", mmc_hostname(host->mmc));
> -			return -EIO;
> -		}
> -	}
> -	/* Wait for 5ms */
> -	usleep_range(5000, 5500);
> -
> -	/* 3.3V regulator output should be stable within 5 ms */
> -	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> -	if (!(ctrl & SDHCI_CTRL_VDD_180))
> +	/*
> +	 * Signal Voltage Switching is only applicable for Host Controllers
> +	 * v3.00 and above.
> +	 */
> +	if (host->version < SDHCI_SPEC_300)
> 		return 0;
> 
> -	pr_warning("%s: 3.3V regulator output did not became stable\n",
> -		   mmc_hostname(host->mmc));
> -
> -	return -EIO;
> -}
> +	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> 
> -static int sdhci_do_1_8v_signal_voltage_switch(struct sdhci_host *host,
> -						u16 ctrl)
> -{
> -	u8 pwr;
> -	u16 clk;
> -	u32 present_state;
> -	int ret;
> +	switch (signal_voltage) {
> 
> -	/* Stop SDCLK */
> -	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> -	clk &= ~SDHCI_CLOCK_CARD_EN;
> -	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +	case MMC_SIGNAL_VOLTAGE_330:
> +		/* Set 1.8V Signal Enable in the Host Control2 register to 0 */
> +		ctrl &= ~SDHCI_CTRL_VDD_180;
> +		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> 
> -	/* Check whether DAT[3:0] is 0000 */
> -	present_state = sdhci_readl(host, SDHCI_PRESENT_STATE);
> -	if (!((present_state & SDHCI_DATA_LVL_MASK) >>
> -	       SDHCI_DATA_LVL_SHIFT)) {
> -		/*
> -		 * Enable 1.8V Signal Enable in the Host Control2
> -		 * register
> -		 */
> -		if (host->vqmmc)
> -			ret = regulator_set_voltage(host->vqmmc,
> -				1700000, 1950000);
> -		else
> -			ret = 0;
> +		if (host->vqmmc) {
> +			ret = regulator_set_voltage(host->vqmmc, 2700000, 3600000);
> +			if (ret) {
> +				pr_warning("%s: Switching to 3.3V signalling voltage "
> +						" failed\n", mmc_hostname(host->mmc));
> +				return -EIO;
> +			}
> +		}
> +		/* Wait for 5ms */
> +		usleep_range(5000, 5500);
> 
> -		if (!ret) {
> -			ctrl |= SDHCI_CTRL_VDD_180;
> -			sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> +		/* 3.3V regulator output should be stable within 5 ms */
> +		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +		if (!(ctrl & SDHCI_CTRL_VDD_180))
> +			return 0;
> 
> -			/* Wait for 5ms */
> -			usleep_range(5000, 5500);
> +		pr_warning("%s: 3.3V regulator output did not became stable\n",
> +				mmc_hostname(host->mmc));
> 
> -			ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> -			if (ctrl & SDHCI_CTRL_VDD_180) {
> -				/* Provide SDCLK again and wait for 1ms */
> -				clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> -				clk |= SDHCI_CLOCK_CARD_EN;
> -				sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> -				usleep_range(1000, 1500);
> +		return -EAGAIN;
> 
> -				/*
> -				 * If DAT[3:0] level is 1111b, then the card
> -				 * was successfully switched to 1.8V signaling.
> -				 */
> -				present_state = sdhci_readl(host,
> -							SDHCI_PRESENT_STATE);
> -				if ((present_state & SDHCI_DATA_LVL_MASK) ==
> -				     SDHCI_DATA_LVL_MASK)
> -					return 0;
> +	case MMC_SIGNAL_VOLTAGE_180:
> +		if (host->vqmmc) {
> +			ret = regulator_set_voltage(host->vqmmc,
> +					1700000, 1950000);
> +			if (ret) {
> +				pr_warning("%s: Switching to 1.8V signalling voltage "
> +						" failed\n", mmc_hostname(host->mmc));
> +				return -EIO;
> 			}
> 		}
> -	}
> 
> -	/*
> -	 * If we are here, that means the switch to 1.8V signaling
> -	 * failed. We power cycle the card, and retry initialization
> -	 * sequence by setting S18R to 0.
> -	 */
> -	pwr = sdhci_readb(host, SDHCI_POWER_CONTROL);
> -	pwr &= ~SDHCI_POWER_ON;
> -	sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> -	if (host->vmmc)
> -		regulator_disable(host->vmmc);
> +		/*
> +		 * Enable 1.8V Signal Enable in the Host Control2
> +		 * register
> +		 */
> +		ctrl |= SDHCI_CTRL_VDD_180;
> +		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> 
> -	/* Wait for 1ms as per the spec */
> -	usleep_range(1000, 1500);
> -	pwr |= SDHCI_POWER_ON;
> -	sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> -	if (host->vmmc)
> -		regulator_enable(host->vmmc);
> +		/* Wait for 5ms */
> +		usleep_range(5000, 5500);
> 
> -	pr_warning("%s: Switching to 1.8V signalling voltage failed, "
> -		   "retrying with S18R set to 0\n", mmc_hostname(host->mmc));
> +		/* 1.8V regulator output should be stable within 5 ms */
> +		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +		if (ctrl & SDHCI_CTRL_VDD_180)
> +			return 0;
> 
> -	return -EAGAIN;
> -}
> +		pr_warning("%s: 1.8V regulator output did not became stable\n",
> +				mmc_hostname(host->mmc));
> 
> -static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
> -						struct mmc_ios *ios)
> -{
> -	u16 ctrl;
> +		return -EAGAIN;
> 
> -	/*
> -	 * Signal Voltage Switching is only applicable for Host Controllers
> -	 * v3.00 and above.
> -	 */
> -	if (host->version < SDHCI_SPEC_300)
> +	case MMC_SIGNAL_VOLTAGE_120:
> +		if (host->vqmmc) {
> +			ret = regulator_set_voltage(host->vqmmc, 2700000, 3600000);

?? 

> +			if (ret) {
> +				pr_warning("%s: Switching to 1.2V signalling voltage "
> +						" failed\n", mmc_hostname(host->mmc));
> +				return -EIO;
> +			}
> +		}

> +			ret = regulator_set_voltage(host->vqmmc, 2700000, 3600000);

Is this right for 1.2v vmmcq.  
> 		return 0;
> 
> -	/*
> -	 * We first check whether the request is to set signalling voltage
> -	 * to 3.3V. If so, we change the voltage to 3.3V and return quickly.
> -	 */
> -	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> -	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)
> -		return sdhci_do_3_3v_signal_voltage_switch(host, ctrl);
> -	else if (!(ctrl & SDHCI_CTRL_VDD_180) &&
> -			(ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180))
> -		return sdhci_do_1_8v_signal_voltage_switch(host, ctrl);
> -	else
> +	default:
> 		/* No signal voltage switch required */
> 		return 0;
> +	}
> }
> 
> static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> -	struct mmc_ios *ios)
> +	int signal_voltage)
> {
> 	struct sdhci_host *host = mmc_priv(mmc);
> 	int err;
> @@ -1754,11 +1708,24 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> 	if (host->version < SDHCI_SPEC_300)
> 		return 0;
> 	sdhci_runtime_pm_get(host);
> -	err = sdhci_do_start_signal_voltage_switch(host, ios);
> +	err = sdhci_do_start_signal_voltage_switch(host, signal_voltage);
> 	sdhci_runtime_pm_put(host);
> 	return err;
> }
> 
> +static int sdhci_card_busy(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	u32 present_state;
> +
> +	sdhci_runtime_pm_get(host);
> +	/* Check whether DAT[3:0] is 0000 */
> +	present_state = sdhci_readl(host, SDHCI_PRESENT_STATE);
> +	sdhci_runtime_pm_put(host);
> +
> +	return !(present_state & SDHCI_DATA_LVL_MASK);
> +}
> +
> static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
> {
> 	struct sdhci_host *host;
> @@ -2029,6 +1996,7 @@ static const struct mmc_host_ops sdhci_ops = {
> 	.execute_tuning			= sdhci_execute_tuning,
> 	.enable_preset_value		= sdhci_enable_preset_value,
> 	.card_event			= sdhci_card_event,
> +	.card_busy	= sdhci_card_busy,
> };
> 
> /*****************************************************************************\
> -- 
> 1.7.0.4
> 

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
