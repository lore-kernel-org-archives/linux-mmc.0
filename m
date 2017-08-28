From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: Re: [PATCH 1/5] mmc: sdhci-msm: fix issue with power irq
Date: Mon, 28 Aug 2017 18:03:38 +0530
Message-ID: <b106efb4-0143-e76a-f442-e4aa5426f476@codeaurora.org>
References: <1503033582-48703-1-git-send-email-vviswana@codeaurora.org>
 <1503033582-48703-2-git-send-email-vviswana@codeaurora.org>
 <7b85cd75-4f39-df08-eaa1-cd7f9499c29b@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <7b85cd75-4f39-df08-eaa1-cd7f9499c29b@intel.com>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org, will.deacon@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, riteshh@codeaurora.org, subhashj@codeaurora.org
List-Id: linux-mmc@vger.kernel.org



On 8/24/2017 1:10 PM, Adrian Hunter wrote:
> On 18/08/17 08:19, Vijay Viswanath wrote:
>> From: Subhash Jadavani <subhashj@codeaurora.org>
>>
>> SDCC controller reset (SW_RST) during probe may trigger power irq if
>> previous status of PWRCTL was either BUS_ON or IO_HIGH_V. So before we
>> enable the power irq interrupt in GIC (by registering the interrupt
>> handler), we need to ensure that any pending power irq interrupt status
>> is acknowledged otherwise power irq interrupt handler would be fired
>> prematurely.
>>
>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
>> ---
>>   drivers/mmc/host/sdhci-msm.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index 9d601dc..0957199 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -1128,6 +1128,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>   	u16 host_version, core_minor;
>>   	u32 core_version, config;
>>   	u8 core_major;
>> +	u32 irq_status, irq_ctl;
>>   
>>   	host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata, sizeof(*msm_host));
>>   	if (IS_ERR(host))
>> @@ -1250,6 +1251,28 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>   			       CORE_VENDOR_SPEC_CAPABILITIES0);
>>   	}
>>   
>> +	/*
>> +	 * Power on reset state may trigger power irq if previous status of
>> +	 * PWRCTL was either BUS_ON or IO_HIGH_V. So before enabling pwr irq
>> +	 * interrupt in GIC, any pending power irq interrupt should be
>> +	 * acknowledged. Otherwise power irq interrupt handler would be
>> +	 * fired prematurely.
>> +	 */
>> +
>> +	irq_status = readl_relaxed(msm_host->core_mem + CORE_PWRCTL_STATUS);
>> +	writel_relaxed(irq_status, msm_host->core_mem + CORE_PWRCTL_CLEAR);
>> +	irq_ctl = readl_relaxed(msm_host->core_mem + CORE_PWRCTL_CTL);
>> +	if (irq_status & (CORE_PWRCTL_BUS_ON | CORE_PWRCTL_BUS_OFF))
>> +		irq_ctl |= CORE_PWRCTL_BUS_SUCCESS;
>> +	if (irq_status & (CORE_PWRCTL_IO_HIGH | CORE_PWRCTL_IO_LOW))
>> +		irq_ctl |= CORE_PWRCTL_IO_SUCCESS;
>> +	writel_relaxed(irq_ctl,	msm_host->core_mem + CORE_PWRCTL_CTL);
> 
> This looks a lot like sdhci_msm_voltage_switch().  Can clearing the
> interrupt be a common function?
> 
This is better. Will change the patches to do it this way.
>> +	/*
>> +	 * Ensure that above writes are propogated before interrupt enablement
>> +	 * in GIC.
>> +	 */
>> +	mb();
>> +
>>   	/* Setup IRQ for handling power/voltage tasks with PMIC */
>>   	msm_host->pwr_irq = platform_get_irq_byname(pdev, "pwr_irq");
>>   	if (msm_host->pwr_irq < 0) {
>> @@ -1259,6 +1282,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>   		goto clk_disable;
>>   	}
>>   
>> +	/* Enable pwr irq interrupts */
>> +	writel_relaxed(INT_MASK, msm_host->core_mem + CORE_PWRCTL_MASK);
>> +
>>   	ret = devm_request_threaded_irq(&pdev->dev, msm_host->pwr_irq, NULL,
>>   					sdhci_msm_pwr_irq, IRQF_ONESHOT,
>>   					dev_name(&pdev->dev), host);
>>
> 
