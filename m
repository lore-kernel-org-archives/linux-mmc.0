From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH V5 2/2] mmc: sdhci-msm: support voltage pad switching
Date: Sun, 22 Apr 2018 10:26:23 -0700
Message-ID: <20180422172623.GB2052@tuxbook-pro>
References: <1524226529-30100-1-git-send-email-vviswana@codeaurora.org>
 <1524226529-30100-3-git-send-email-vviswana@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1524226529-30100-3-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Viswanath <vviswana@codeaurora.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, riteshh@codeaurora.org, vbadigan@codeaurora.org, Krishna Konda <kkonda@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

On Fri 20 Apr 05:15 PDT 2018, Vijay Viswanath wrote:

> The PADs for SD card are dual-voltage that support 3v/1.8v. Those PADs
> have a control signal  (io_pad_pwr_switch/mode18 ) that indicates
> whether the PAD works in 3v or 1.8v.
> 
> SDHC core on msm platforms should have IO_PAD_PWR_SWITCH bit set/unset
> based on actual voltage used for IO lines. So when power irq is
> triggered for io high or io low, the driver should check the voltages
> supported and set the pad accordingly.
> 
> Signed-off-by: Krishna Konda <kkonda@codeaurora.org>
> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/mmc/host/sdhci-msm.c | 57 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index edd30a2..bb11916 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -78,12 +78,15 @@
>  #define CORE_HC_MCLK_SEL_DFLT	(2 << 8)
>  #define CORE_HC_MCLK_SEL_HS400	(3 << 8)
>  #define CORE_HC_MCLK_SEL_MASK	(3 << 8)
> +#define CORE_IO_PAD_PWR_SWITCH_EN	(1 << 15)
> +#define CORE_IO_PAD_PWR_SWITCH  (1 << 16)
>  #define CORE_HC_SELECT_IN_EN	BIT(18)
>  #define CORE_HC_SELECT_IN_HS400	(6 << 19)
>  #define CORE_HC_SELECT_IN_MASK	(7 << 19)
>  
>  #define CORE_3_0V_SUPPORT	(1 << 25)
>  #define CORE_1_8V_SUPPORT	(1 << 26)
> +#define CORE_VOLT_SUPPORT	(CORE_3_0V_SUPPORT | CORE_1_8V_SUPPORT)
>  
>  #define CORE_CSR_CDC_CTLR_CFG0		0x130
>  #define CORE_SW_TRIG_FULL_CALIB		BIT(16)
> @@ -1109,7 +1112,7 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
>  	u32 irq_status, irq_ack = 0;
>  	int retry = 10;
>  	u32 pwr_state = 0, io_level = 0;
> -
> +	u32 config;
>  
>  	irq_status = readl_relaxed(msm_host->core_mem + CORE_PWRCTL_STATUS);
>  	irq_status &= INT_MASK;
> @@ -1166,6 +1169,38 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
>  	 */
>  	writel_relaxed(irq_ack, msm_host->core_mem + CORE_PWRCTL_CTL);
>  
> +	/*
> +	 * If we don't have info regarding the voltage levels supported by
> +	 * regulators, don't change the IO PAD PWR SWITCH.
> +	 */
> +	if (msm_host->caps_0 & CORE_VOLT_SUPPORT) {
> +		u32 new_config;
> +		/*
> +		 * We should unset IO PAD PWR switch only if the register write
> +		 * can set IO lines high and the regulator also switches to 3 V.
> +		 * Else, we should keep the IO PAD PWR switch set.
> +		 * This is applicable to certain targets where eMMC vccq supply
> +		 * is only 1.8V. In such targets, even during REQ_IO_HIGH, the
> +		 * IO PAD PWR switch must be kept set to reflect actual
> +		 * regulator voltage. This way, during initialization of
> +		 * controllers with only 1.8V, we will set the IO PAD bit
> +		 * without waiting for a REQ_IO_LOW.
> +		 */
> +		config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
> +		new_config = config;
> +
> +		if ((io_level & REQ_IO_HIGH) &&
> +				(msm_host->caps_0 & CORE_3_0V_SUPPORT))
> +			new_config &= ~CORE_IO_PAD_PWR_SWITCH;
> +		else if ((io_level & REQ_IO_LOW) ||
> +				(msm_host->caps_0 & CORE_1_8V_SUPPORT))
> +			new_config |= CORE_IO_PAD_PWR_SWITCH;
> +
> +		if (config ^ new_config)
> +			writel_relaxed(new_config,
> +					host->ioaddr + CORE_VENDOR_SPEC);
> +	}
> +
>  	if (pwr_state)
>  		msm_host->curr_pwr_state = pwr_state;
>  	if (io_level)
> @@ -1322,7 +1357,8 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
>  {
>  	struct mmc_host *mmc = msm_host->mmc;
>  	struct regulator *supply = mmc->supply.vqmmc;
> -	u32 caps = 0;
> +	u32 caps = 0, config;
> +	struct sdhci_host *host = mmc_priv(mmc);
>  
>  	if (!IS_ERR(mmc->supply.vqmmc)) {
>  		if (regulator_is_supported_voltage(supply, 1700000, 1950000))
> @@ -1335,6 +1371,23 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
>  					mmc_hostname(mmc));
>  	}
>  
> +	if (caps) {
> +		/*
> +		 * Set the PAD_PWR_SWITCH_EN bit so that the PAD_PWR_SWITCH
> +		 * bit can be used as required later on.
> +		 */
> +		u32 io_level = msm_host->curr_io_level;
> +
> +		config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
> +		config |= CORE_IO_PAD_PWR_SWITCH_EN;
> +
> +		if ((io_level & REQ_IO_HIGH) && (caps &	CORE_3_0V_SUPPORT))
> +			config &= ~CORE_IO_PAD_PWR_SWITCH;
> +		else if ((io_level & REQ_IO_LOW) || (caps & CORE_1_8V_SUPPORT))
> +			config |= CORE_IO_PAD_PWR_SWITCH;
> +
> +		writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
> +	}
>  	msm_host->caps_0 |= caps;
>  	pr_debug("%s: supported caps: 0x%08x\n", mmc_hostname(mmc), caps);
>  }
> -- 
>  Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
