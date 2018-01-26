From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH RFC 2/2] mmc: sdhci-msm: support voltage pad switching
Date: Fri, 26 Jan 2018 10:11:18 +0200
Message-ID: <496b6a31-47b1-483a-f096-32fcdee34501@intel.com>
References: <1516262742-44326-1-git-send-email-vviswana@codeaurora.org>
 <1516262742-44326-3-git-send-email-vviswana@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1516262742-44326-3-git-send-email-vviswana@codeaurora.org>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Vijay Viswanath <vviswana@codeaurora.org>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, Krishna Konda <kkonda@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

On 18/01/18 10:05, Vijay Viswanath wrote:
> From: Krishna Konda <kkonda@codeaurora.org>
> 
> The PADs for sdhc controller are dual-voltage that support 3v/1.8v.
> Those PADs have a control signal (io_pad_pwr_switch/mode18 ) that
> indicates whether the PAD works in 3v or 1.8v.
> 
> SDHC core on msm platforms should have IO_PAD_PWR_SWITCH bit set/unset
> based on actual voltage used for IO lines. So when power irq is
> triggered for io high or io low, the driver should check the voltages
> supported and set the pad accordingly.
> 
> Signed-off-by: Krishna Konda <kkonda@codeaurora.org>
> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
> ---

Not sure why this is RFC, but for sdhci:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

>  drivers/mmc/host/sdhci-msm.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 5c23e92..f5728a8 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -78,6 +78,8 @@
>  #define CORE_HC_MCLK_SEL_DFLT	(2 << 8)
>  #define CORE_HC_MCLK_SEL_HS400	(3 << 8)
>  #define CORE_HC_MCLK_SEL_MASK	(3 << 8)
> +#define CORE_IO_PAD_PWR_SWITCH_EN	(1 << 15)
> +#define CORE_IO_PAD_PWR_SWITCH  (1 << 16)
>  #define CORE_HC_SELECT_IN_EN	BIT(18)
>  #define CORE_HC_SELECT_IN_HS400	(6 << 19)
>  #define CORE_HC_SELECT_IN_MASK	(7 << 19)
> @@ -1166,6 +1168,35 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
>  	 */
>  	writel_relaxed(irq_ack, msm_host->core_mem + CORE_PWRCTL_CTL);
>  
> +	/*
> +	 * SDHC has core_mem and hc_mem device memory and these memory
> +	 * addresses do not fall within 1KB region. Hence, any update to
> +	 * core_mem address space would require an mb() to ensure this gets
> +	 * completed before its next update to registers within hc_mem.
> +	 */
> +	mb();
> +	/*
> +	 * We should unset IO PAD PWR switch only if the register write can
> +	 * set IO lines high and the regulator also switches to 3 V.
> +	 * Else, we should keep the IO PAD PWR switch set.
> +	 * This is applicable to certain targets where eMMC vccq supply is only
> +	 * 1.8V. In such targets, even during REQ_IO_HIGH, the IO PAD PWR
> +	 * switch must be kept set to reflect actual regulator voltage. This
> +	 * way, during initialization of controllers with only 1.8V, we will
> +	 * set the IO PAD bit without waiting for a REQ_IO_LOW.
> +	 */
> +	if ((io_level & REQ_IO_HIGH) && (msm_host->caps_0 & CORE_3_0V_SUPPORT))
> +		writel_relaxed((readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC) &
> +					~CORE_IO_PAD_PWR_SWITCH), host->ioaddr +
> +				CORE_VENDOR_SPEC);
> +	else if ((io_level & REQ_IO_LOW) ||
> +			(msm_host->caps_0 & CORE_1_8V_SUPPORT))
> +		writel_relaxed((readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC) |
> +					CORE_IO_PAD_PWR_SWITCH), host->ioaddr +
> +				CORE_VENDOR_SPEC);
> +	/* Ensure that the IO PAD switches are updated before proceeding */
> +	mb();
> +
>  	if (pwr_state)
>  		msm_host->curr_pwr_state = pwr_state;
>  	if (io_level)
> @@ -1518,6 +1549,13 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	}
>  
>  	/*
> +	 * Set the PAD_PWR_SWITCH_EN bit so that the PAD_PWR_SWITCH bit can
> +	 * be used as required later on.
> +	 */
> +	writel_relaxed((readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC) |
> +				CORE_IO_PAD_PWR_SWITCH_EN), host->ioaddr +
> +			CORE_VENDOR_SPEC);
> +	/*
>  	 * Power on reset state may trigger power irq if previous status of
>  	 * PWRCTL was either BUS_ON or IO_HIGH_V. So before enabling pwr irq
>  	 * interrupt in GIC, any pending power irq interrupt should be
> 
