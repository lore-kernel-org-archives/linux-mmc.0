From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 2/4] mmc: sdhci-msm: Fix HW issue with power IRQ
 handling during reset
Date: Tue, 3 Oct 2017 14:44:28 +0300
Message-ID: <12eeb19a-e9eb-731c-4918-64a0bfb7ceb5@intel.com>
References: <1506490483-46871-1-git-send-email-vviswana@codeaurora.org>
 <1506490483-46871-3-git-send-email-vviswana@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1506490483-46871-3-git-send-email-vviswana@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Viswanath <vviswana@codeaurora.org>, ulf.hansson@linaro.org, will.deacon@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, riteshh@codeaurora.org, subhashj@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On 27/09/17 08:34, Vijay Viswanath wrote:
> From: Sahitya Tummala <stummala@codeaurora.org>
> 
> There is a rare scenario in HW, where the first clear pulse could
> be lost when the actual reset and clear/read of status register
> are happening at the same time. Fix this by retrying upto 10 times
> to ensure the status register gets cleared. Otherwise, this will
> lead to a spurious power IRQ which results in system instability.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>

I already acked v1, nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-msm.c | 46 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index d636251..42a65ab 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -995,17 +995,52 @@ static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
>  		sdhci_msm_hs400(host, &mmc->ios);
>  }
>  
> -static void sdhci_msm_voltage_switch(struct sdhci_host *host)
> +static void sdhci_msm_dump_pwr_ctrl_regs(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +
> +	pr_err("%s: PWRCTL_STATUS: 0x%08x | PWRCTL_MASK: 0x%08x | PWRCTL_CTL: 0x%08x\n",
> +			mmc_hostname(host->mmc),
> +			readl_relaxed(msm_host->core_mem + CORE_PWRCTL_STATUS),
> +			readl_relaxed(msm_host->core_mem + CORE_PWRCTL_MASK),
> +			readl_relaxed(msm_host->core_mem + CORE_PWRCTL_CTL));
> +}
> +
> +static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>  	u32 irq_status, irq_ack = 0;
> +	int retry = 10;
>  
>  	irq_status = readl_relaxed(msm_host->core_mem + CORE_PWRCTL_STATUS);
>  	irq_status &= INT_MASK;
>  
>  	writel_relaxed(irq_status, msm_host->core_mem + CORE_PWRCTL_CLEAR);
>  
> +	/*
> +	 * There is a rare HW scenario where the first clear pulse could be
> +	 * lost when actual reset and clear/read of status register is
> +	 * happening at a time. Hence, retry for at least 10 times to make
> +	 * sure status register is cleared. Otherwise, this will result in
> +	 * a spurious power IRQ resulting in system instability.
> +	 */
> +	while (irq_status & readl_relaxed(msm_host->core_mem +
> +				CORE_PWRCTL_STATUS)) {
> +		if (retry == 0) {
> +			pr_err("%s: Timedout clearing (0x%x) pwrctl status register\n",
> +					mmc_hostname(host->mmc), irq_status);
> +			sdhci_msm_dump_pwr_ctrl_regs(host);
> +			WARN_ON(1);
> +			break;
> +		}
> +		writel_relaxed(irq_status,
> +				msm_host->core_mem + CORE_PWRCTL_CLEAR);
> +		retry--;
> +		udelay(10);
> +	}
> +
>  	if (irq_status & (CORE_PWRCTL_BUS_ON | CORE_PWRCTL_BUS_OFF))
>  		irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
>  	if (irq_status & (CORE_PWRCTL_IO_LOW | CORE_PWRCTL_IO_HIGH))
> @@ -1017,13 +1052,17 @@ static void sdhci_msm_voltage_switch(struct sdhci_host *host)
>  	 * switches are handled by the sdhci core, so just report success.
>  	 */
>  	writel_relaxed(irq_ack, msm_host->core_mem + CORE_PWRCTL_CTL);
> +
> +	pr_debug("%s: %s: Handled IRQ(%d), irq_status=0x%x, ack=0x%x\n",
> +		mmc_hostname(msm_host->mmc), __func__, irq, irq_status,
> +		irq_ack);
>  }
>  
>  static irqreturn_t sdhci_msm_pwr_irq(int irq, void *data)
>  {
>  	struct sdhci_host *host = (struct sdhci_host *)data;
>  
> -	sdhci_msm_voltage_switch(host);
> +	sdhci_msm_handle_pwr_irq(host, irq);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -1106,7 +1145,6 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>  	.get_max_clock = sdhci_msm_get_max_clock,
>  	.set_bus_width = sdhci_set_bus_width,
>  	.set_uhs_signaling = sdhci_msm_set_uhs_signaling,
> -	.voltage_switch = sdhci_msm_voltage_switch,
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_msm_pdata = {
> @@ -1257,7 +1295,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	 * acknowledged. Otherwise power irq interrupt handler would be
>  	 * fired prematurely.
>  	 */
> -	sdhci_msm_voltage_switch(host);
> +	sdhci_msm_handle_pwr_irq(host, 0);
>  
>  	/*
>  	 * Ensure that above writes are propogated before interrupt enablement
> 
