From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: Re: [PATCH RFC 2/2] mmc: sdhci-msm: support voltage pad switching
Date: Thu, 8 Feb 2018 10:49:10 +0530
Message-ID: <288d817a-0c9d-5c9f-c0bc-c5b523793670@codeaurora.org>
References: <1516262742-44326-1-git-send-email-vviswana@codeaurora.org>
 <1516262742-44326-3-git-send-email-vviswana@codeaurora.org>
 <20180202215154.GI12728@builder>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180202215154.GI12728@builder>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, Krishna Konda <kkonda@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org



On 2/3/2018 3:21 AM, Bjorn Andersson wrote:
> On Thu 18 Jan 00:05 PST 2018, Vijay Viswanath wrote:
> 
>> From: Krishna Konda <kkonda@codeaurora.org>
>>
>> The PADs for sdhc controller are dual-voltage that support 3v/1.8v.
>> Those PADs have a control signal (io_pad_pwr_switch/mode18 ) that
>> indicates whether the PAD works in 3v or 1.8v.
>>
>> SDHC core on msm platforms should have IO_PAD_PWR_SWITCH bit set/unset
>> based on actual voltage used for IO lines. So when power irq is
>> triggered for io high or io low, the driver should check the voltages
>> supported and set the pad accordingly.
>>
> 
> I'll try to find some time to check that this doesn't break 8916 and
> 8974...again...
>

Thanks! Btwn, I had tested the code in db410c.

>> Signed-off-by: Krishna Konda <kkonda@codeaurora.org>
>> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
>> ---
>>   drivers/mmc/host/sdhci-msm.c | 38 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index 5c23e92..f5728a8 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -78,6 +78,8 @@
>>   #define CORE_HC_MCLK_SEL_DFLT	(2 << 8)
>>   #define CORE_HC_MCLK_SEL_HS400	(3 << 8)
>>   #define CORE_HC_MCLK_SEL_MASK	(3 << 8)
>> +#define CORE_IO_PAD_PWR_SWITCH_EN	(1 << 15)
>> +#define CORE_IO_PAD_PWR_SWITCH  (1 << 16)
>>   #define CORE_HC_SELECT_IN_EN	BIT(18)
>>   #define CORE_HC_SELECT_IN_HS400	(6 << 19)
>>   #define CORE_HC_SELECT_IN_MASK	(7 << 19)
>> @@ -1166,6 +1168,35 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
>>   	 */
>>   	writel_relaxed(irq_ack, msm_host->core_mem + CORE_PWRCTL_CTL);
>>   
>> +	/*
>> +	 * SDHC has core_mem and hc_mem device memory and these memory
>> +	 * addresses do not fall within 1KB region. Hence, any update to
>> +	 * core_mem address space would require an mb() to ensure this gets
>> +	 * completed before its next update to registers within hc_mem.
>> +	 */
>> +	mb();
> 
> If you just use writel() instead of writel_relaxed() you don't need to
> sprinkle the driver with comments like this. And you really should be
> able to just say "Ensure ordering between core_mem and hc_mem writes" if
> you really feel like making it explicit.
> 
>> +	/*
>> +	 * We should unset IO PAD PWR switch only if the register write can
>> +	 * set IO lines high and the regulator also switches to 3 V.
>> +	 * Else, we should keep the IO PAD PWR switch set.
>> +	 * This is applicable to certain targets where eMMC vccq supply is only
>> +	 * 1.8V. In such targets, even during REQ_IO_HIGH, the IO PAD PWR
>> +	 * switch must be kept set to reflect actual regulator voltage. This
>> +	 * way, during initialization of controllers with only 1.8V, we will
>> +	 * set the IO PAD bit without waiting for a REQ_IO_LOW.
>> +	 */
>> +	if ((io_level & REQ_IO_HIGH) && (msm_host->caps_0 & CORE_3_0V_SUPPORT))
>> +		writel_relaxed((readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC) &
>> +					~CORE_IO_PAD_PWR_SWITCH), host->ioaddr +
>> +				CORE_VENDOR_SPEC);
> 
> Please split this up in read, modify and write operations.
> 

Will do

>> +	else if ((io_level & REQ_IO_LOW) ||
>> +			(msm_host->caps_0 & CORE_1_8V_SUPPORT))
>> +		writel_relaxed((readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC) |
>> +					CORE_IO_PAD_PWR_SWITCH), host->ioaddr +
>> +				CORE_VENDOR_SPEC);
>> +	/* Ensure that the IO PAD switches are updated before proceeding */
> 
> That's not what "mb()" does, it ensures that any writes that was done
> before this line will hit the hardware before any writes that is done
> after this line.
> 

Will update the comments.

> But again, using writel() would save us from doing this explicitly
> throughout the code.
> 
>> +	mb();
>> +
>>   	if (pwr_state)
>>   		msm_host->curr_pwr_state = pwr_state;
>>   	if (io_level)
>> @@ -1518,6 +1549,13 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>   	}
>>   
>>   	/*
>> +	 * Set the PAD_PWR_SWITCH_EN bit so that the PAD_PWR_SWITCH bit can
>> +	 * be used as required later on.
>> +	 */
>> +	writel_relaxed((readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC) |
>> +				CORE_IO_PAD_PWR_SWITCH_EN), host->ioaddr +
>> +			CORE_VENDOR_SPEC);
> 
> Please rewrite as 3 operations.
> 
> Do we need to set the pwr switch value as well? Or we're fine relying on
> the existing value here?

After the IO_PAD_PWR_SWTCH is enabled, we will call 
sdhci_msm_handle_pwr_irq. If there is any pending power irq interrupt, 
that will set the appropriate pwr switch value. Otherwise, an 
appropriate value will get set during REQ_BUS_ON event.

> 
> Regards,
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
