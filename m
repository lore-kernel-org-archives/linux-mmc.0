From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 1/4] mmc: sdhci-msm: fix issue with power irq
Date: Tue, 3 Oct 2017 14:44:23 +0300
Message-ID: <3ebe9c45-f338-87ef-1513-7255124902b1@intel.com>
References: <1506490483-46871-1-git-send-email-vviswana@codeaurora.org>
 <1506490483-46871-2-git-send-email-vviswana@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1506490483-46871-2-git-send-email-vviswana@codeaurora.org>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Vijay Viswanath <vviswana@codeaurora.org>, ulf.hansson@linaro.org, will.deacon@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, riteshh@codeaurora.org, subhashj@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On 27/09/17 08:34, Vijay Viswanath wrote:
> From: Subhash Jadavani <subhashj@codeaurora.org>
> 
> SDCC controller reset (SW_RST) during probe may trigger power irq if
> previous status of PWRCTL was either BUS_ON or IO_HIGH_V. So before we
> enable the power irq interrupt in GIC (by registering the interrupt
> handler), we need to ensure that any pending power irq interrupt status
> is acknowledged otherwise power irq interrupt handler would be fired
> prematurely.
> 
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>

I already acked v1, nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-msm.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 9d601dc..d636251 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1250,6 +1250,21 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  			       CORE_VENDOR_SPEC_CAPABILITIES0);
>  	}
>  
> +	/*
> +	 * Power on reset state may trigger power irq if previous status of
> +	 * PWRCTL was either BUS_ON or IO_HIGH_V. So before enabling pwr irq
> +	 * interrupt in GIC, any pending power irq interrupt should be
> +	 * acknowledged. Otherwise power irq interrupt handler would be
> +	 * fired prematurely.
> +	 */
> +	sdhci_msm_voltage_switch(host);
> +
> +	/*
> +	 * Ensure that above writes are propogated before interrupt enablement
> +	 * in GIC.
> +	 */
> +	mb();
> +
>  	/* Setup IRQ for handling power/voltage tasks with PMIC */
>  	msm_host->pwr_irq = platform_get_irq_byname(pdev, "pwr_irq");
>  	if (msm_host->pwr_irq < 0) {
> @@ -1259,6 +1274,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  		goto clk_disable;
>  	}
>  
> +	/* Enable pwr irq interrupts */
> +	writel_relaxed(INT_MASK, msm_host->core_mem + CORE_PWRCTL_MASK);
> +
>  	ret = devm_request_threaded_irq(&pdev->dev, msm_host->pwr_irq, NULL,
>  					sdhci_msm_pwr_irq, IRQF_ONESHOT,
>  					dev_name(&pdev->dev), host);
> 
