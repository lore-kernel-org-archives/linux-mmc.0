From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH v2] mmc: sdhci-msm: Add sdhci_reset() implementation
Date: Tue, 29 Nov 2016 09:10:07 +0530
Message-ID: <27e95224-ff32-954d-443a-2310c1225ca0@codeaurora.org>
References: <20161128173920.25334-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20161128173920.25334-1-georgi.djakov@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Georgi,

On 11/28/2016 11:09 PM, Georgi Djakov wrote:
> On apq8016, apq8084 and apq8074 platforms, writing to the software
> reset register triggers the "power irq". We need to ack and handle
> the irq, otherwise the following message appears:
>
> mmc0: Reset 0x1 never completed.
> sdhci: =========== REGISTER DUMP (mmc0)===========
> sdhci: Sys addr: 0x00000000 | Version:  0x00002e02
> sdhci: Blk size: 0x00004000 | Blk cnt:  0x00000000
> sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
> sdhci: Present:  0x01f80000 | Host ctl: 0x00000000
> sdhci: Power:    0x00000000 | Blk gap:  0x00000000
> sdhci: Wake-up:  0x00000000 | Clock:    0x00000003
> sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
> sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
> sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
> sdhci: Caps:     0x322dc8b2 | Caps_1:   0x00008007
> sdhci: Cmd:      0x00000000 | Max curr: 0x00000000
> sdhci: Host ctl2: 0x00000000
> sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x0000000000000000
> sdhci: ===========================================
>
> Fix it by implementing the custom sdhci_reset() function,
> which performs the software reset and then handles the irq.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>
> Changes since v1: (https://lkml.org/lkml/2016/11/22/411)
>  * Perform the software reset by just writing to the SDHCI_SOFTWARE_RESET
>    register and then check for the irq.
I am still not sure about this change. Below change will trigger the 
IRQ, once this call is completed (say on a single core system) -since 
this is called while holding spin_lock_irqsave.

But you will be end up calling sdhci_msm_voltage_switch twice,
which to me does not seems correct.
1. 1st time you are directly calling it in sdhci_msm_reset.
2. 2nd time will be called from within pwr_irq to handle the same case.

Please let me know your thoughts on this ?

Regards
Ritesh

>
>  drivers/mmc/host/sdhci-msm.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 32879b845b75..157ae07f9309 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1019,6 +1019,33 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>  	__sdhci_msm_set_clock(host, clock);
>  }
>
> +void sdhci_msm_reset(struct sdhci_host *host, u8 mask)
> +{
> +	unsigned long timeout = 100;
> +
> +	sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
> +
> +	if (mask & SDHCI_RESET_ALL) {
> +		host->clock = 0;
> +
> +		/*
> +		 * SDHCI_RESET_ALL triggers the PWR IRQ and we need
> +		 * to handle it here.
> +		 */
> +		sdhci_msm_voltage_switch(host);
> +	}
> +
> +	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
> +		if (timeout == 0) {
> +			pr_err("%s: Reset 0x%x never completed.\n",
> +			       mmc_hostname(host->mmc), (int)mask);
> +			return;
> +		}
> +		timeout--;
> +		mdelay(1);
> +	}
> +}
> +
>  static const struct of_device_id sdhci_msm_dt_match[] = {
>  	{ .compatible = "qcom,sdhci-msm-v4" },
>  	{},
> @@ -1028,7 +1055,7 @@ MODULE_DEVICE_TABLE(of, sdhci_msm_dt_match);
>
>  static const struct sdhci_ops sdhci_msm_ops = {
>  	.platform_execute_tuning = sdhci_msm_execute_tuning,
> -	.reset = sdhci_reset,
> +	.reset = sdhci_msm_reset,
>  	.set_clock = sdhci_msm_set_clock,
>  	.get_min_clock = sdhci_msm_get_min_clock,
>  	.get_max_clock = sdhci_msm_get_max_clock,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
