From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH RFC 6/8] mmc: sdhci-msm: Add pwr_irq support to sdhci-msm
Date: Thu, 30 Jun 2016 22:57:55 -0500
Message-ID: <20160701035755.GA2926@hector.attlocal.net>
References: <1467199233-20506-1-git-send-email-riteshh@codeaurora.org>
 <1467199233-20506-7-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1467199233-20506-7-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, adrian.hunter@intel.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Jun 29, 2016 at 04:50:31PM +0530, Ritesh Harjani wrote:
> From: Asutosh Das <asutoshd@codeaurora.org>

<snip>

> +static irqreturn_t sdhci_msm_pwr_irq(int irq, void *data)
> +{
> +	struct sdhci_host *host = (struct sdhci_host *)data;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +	u8 irq_status = 0;
> +	u8 irq_ack = 0;
> +	int ret = 0;
> +	int pwr_state = 0, io_level = 0;
> +	unsigned long flags;
> +
> +	irq_status = readb_relaxed(msm_host->core_mem + CORE_PWRCTL_STATUS);
> +	pr_debug("%s: Received IRQ(%d), status=0x%x\n",
> +		mmc_hostname(msm_host->mmc), irq, irq_status);
> +
> +	/* Clear the interrupt */
> +	writeb_relaxed(irq_status, (msm_host->core_mem + CORE_PWRCTL_CLEAR));
> +	/*
> +	 * SDHC has core_mem and hc_mem device memory and these memory
> +	 * addresses do not fall within 1KB region. Hence, any update to
> +	 * core_mem address space would require an mb() to ensure this gets
> +	 * completed before its next update to registers within hc_mem.
> +	 */
> +	mb();

mb is a little heavy handed.  In general, these days we don't want to introduce
_relaxed usage anyway.  I know internally you guys force the use of _relaxed,
but in mainline we generally don't.  Wouldn't a wmb() suffice?

Also this isn't about completing before anything else, this is about enforcing
order and making sure this writeb doesn't get put behind the following writel.

Lastly, writeb?  Isn't this a 32 bit wide register?

> +
> +	/* Handle BUS ON/OFF*/
> +	if (irq_status & CORE_PWRCTL_BUS_ON) {
> +		ret = sdhci_msm_setup_vreg(msm_host->pdata, true, false);
> +		if (!ret) {
> +			ret = sdhci_msm_set_vdd_io_vol(msm_host->pdata,
> +					VDD_IO_HIGH, 0);
> +		}
> +		if (ret)
> +			irq_ack |= CORE_PWRCTL_BUS_FAIL;
> +		else
> +			irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
> +
> +		pwr_state = REQ_BUS_ON;
> +		io_level = REQ_IO_HIGH;
> +	}
> +	if (irq_status & CORE_PWRCTL_BUS_OFF) {
> +		ret = sdhci_msm_setup_vreg(msm_host->pdata, false, false);
> +		if (!ret) {
> +			ret = sdhci_msm_set_vdd_io_vol(msm_host->pdata,
> +					VDD_IO_LOW, 0);
> +		}
> +		if (ret)
> +			irq_ack |= CORE_PWRCTL_BUS_FAIL;
> +		else
> +			irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
> +
> +		pwr_state = REQ_BUS_OFF;
> +		io_level = REQ_IO_LOW;
> +	}
> +	/* Handle IO LOW/HIGH */
> +	if (irq_status & CORE_PWRCTL_IO_LOW) {
> +		/* Switch voltage Low */
> +		ret = sdhci_msm_set_vdd_io_vol(msm_host->pdata, VDD_IO_LOW, 0);
> +		if (ret)
> +			irq_ack |= CORE_PWRCTL_IO_FAIL;
> +		else
> +			irq_ack |= CORE_PWRCTL_IO_SUCCESS;
> +
> +		io_level = REQ_IO_LOW;
> +	}
> +	if (irq_status & CORE_PWRCTL_IO_HIGH) {
> +		/* Switch voltage High */
> +		ret = sdhci_msm_set_vdd_io_vol(msm_host->pdata, VDD_IO_HIGH, 0);
> +		if (ret)
> +			irq_ack |= CORE_PWRCTL_IO_FAIL;
> +		else
> +			irq_ack |= CORE_PWRCTL_IO_SUCCESS;
> +
> +		io_level = REQ_IO_HIGH;
> +	}
> +
> +	/* ACK status to the core */
> +	writeb_relaxed(irq_ack, (msm_host->core_mem + CORE_PWRCTL_CTL));
> +	/*
> +	 * SDHC has core_mem and hc_mem device memory and these memory
> +	 * addresses do not fall within 1KB region. Hence, any update to
> +	 * core_mem address space would require an mb() to ensure this gets
> +	 * completed before its next update to registers within hc_mem.
> +	 */
> +	mb();

ditto from above

> +
> +	if (io_level & REQ_IO_HIGH)
> +		writel_relaxed((readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC) &
> +				~CORE_IO_PAD_PWR_SWITCH),
> +				host->ioaddr + CORE_VENDOR_SPEC);
> +	else if (io_level & REQ_IO_LOW)
> +		writel_relaxed((readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC) |
> +				CORE_IO_PAD_PWR_SWITCH),
> +				host->ioaddr + CORE_VENDOR_SPEC);
> +
> +	/* Ensure before completion that above writes are propagated */
> +	mb();

ditto.  And to make matters worse, this is a double mb() possibly without
anything else going on.

> +
> +	pr_debug("%s: Handled IRQ(%d), ret=%d, ack=0x%x\n",
> +		mmc_hostname(msm_host->mmc), irq, ret, irq_ack);
> +	if (pwr_state)
> +		msm_host->curr_pwr_state = pwr_state;
> +	if (io_level)
> +		msm_host->curr_io_level = io_level;
> +
> +	return IRQ_HANDLED;
> +}
> +
>  /* Platform specific tuning */
>  static inline int msm_dll_poll_ck_out_en(struct sdhci_host *host, u8 poll)
>  {
> @@ -801,6 +978,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_msm_host *msm_host;
>  	struct resource *core_memres;
> +	u32 irq_status, irq_ctl;
>  	int ret;
>  	u16 host_version, core_minor;
>  	u32 core_version, caps;
> @@ -917,6 +1095,45 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  			       CORE_VENDOR_SPEC_CAPABILITIES0);
>  	}
>  
> +	/*
> +	 * POR reset of VENDOR_SPEC/CORE_SW_RST above may trigger power irq
> +	 * if previous status of PWRCTL was either BUS_ON or IO_HIGH_V.
> +	 * So before we enable the power irq interrupt in GIC
> +	 * (by registering the interrupt handler), we need to
> +	 * ensure that any pending power irq interrupt status is acknowledged
> +	 * otherwise power irq interrupt handler would be fired prematurely.
> +	 */
> +	irq_status = readl_relaxed(msm_host->core_mem + CORE_PWRCTL_STATUS);
> +	writel_relaxed(irq_status, (msm_host->core_mem + CORE_PWRCTL_CLEAR));
> +	irq_ctl = readl_relaxed(msm_host->core_mem + CORE_PWRCTL_CTL);
> +	if (irq_status & (CORE_PWRCTL_BUS_ON | CORE_PWRCTL_BUS_OFF))
> +		irq_ctl |= CORE_PWRCTL_BUS_SUCCESS;
> +	if (irq_status & (CORE_PWRCTL_IO_HIGH | CORE_PWRCTL_IO_LOW))
> +		irq_ctl |= CORE_PWRCTL_IO_SUCCESS;
> +	writel_relaxed(irq_ctl, (msm_host->core_mem + CORE_PWRCTL_CTL));
> +
> +	/*
> +	 * Ensure that above writes are propogated before interrupt enablement
> +	 * in GIC.
> +	 */
> +	mb();

this comment is better.  but again, wmb?

> +	/* Setup PWRCTL irq */
> +	msm_host->pwr_irq = platform_get_irq_byname(pdev, "pwr_irq");
> +	if (msm_host->pwr_irq < 0) {
> +		dev_err(&pdev->dev, "Failed to get pwr_irq by name (%d)\n",
> +				msm_host->pwr_irq);
> +		goto vreg_deinit;
> +	}
> +	ret = devm_request_threaded_irq(&pdev->dev, msm_host->pwr_irq, NULL,
> +					sdhci_msm_pwr_irq, IRQF_ONESHOT,
> +					dev_name(&pdev->dev), host);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Request threaded irq(%d) failed (%d)\n",
> +				msm_host->pwr_irq, ret);
> +		goto vreg_deinit;
> +	}
> +
>  	ret = sdhci_add_host(host);
>  	if (ret)
>  		goto vreg_deinit;

Regards,

Andy
