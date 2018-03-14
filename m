From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 09/16] mmc: sdhci: Add quirk to disable HW timeout
Date: Wed, 14 Mar 2018 18:55:06 +0530
Message-ID: <ccca4747-198d-b43f-57d3-b9dcebeaf460@ti.com>
References: <20180205125029.21570-1-kishon@ti.com>
 <20180205125029.21570-10-kishon@ti.com>
 <cda22332-ed17-9309-4989-19765744879b@intel.com>
 <a7ba98cd-7a3c-00f9-bfaa-a982126c9185@ti.com>
 <18a7cff5-5cc5-4eb1-17c8-033bd5ddf6c1@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <18a7cff5-5cc5-4eb1-17c8-033bd5ddf6c1@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org



On Monday 05 March 2018 03:08 PM, Adrian Hunter wrote:
> On 05/03/18 11:30, Kishon Vijay Abraham I wrote:
>> Hi Adrian,
>>
>> On Monday 19 February 2018 02:21 PM, Adrian Hunter wrote:
>>> On 05/02/18 14:50, Kishon Vijay Abraham I wrote:
>>>> Add quirk to disable HW timeout if the requested timeout is more than
>>>> the maximum obtainable timeout.
>>>>
>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> ---
>>>>  drivers/mmc/host/sdhci.c | 12 ++++++++++++
>>>>  drivers/mmc/host/sdhci.h |  7 +++++++
>>>>  2 files changed, 19 insertions(+)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>> index 070aff9c108f..1aa74b4682f3 100644
>>>> --- a/drivers/mmc/host/sdhci.c
>>>> +++ b/drivers/mmc/host/sdhci.c
>>>> @@ -735,6 +735,12 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>>>>  		DBG("Too large timeout 0x%x requested for CMD%d!\n",
>>>>  		    count, cmd->opcode);
>>>>  		count = 0xE;
>>>> +		if (host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT) {
>>>> +			host->ier &= ~SDHCI_INT_DATA_TIMEOUT;
>>>> +			sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
>>>> +			sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
>>>> +			host->hw_timeout_disabled = true;
>>>> +		}
>>>
>>> sdhci_calc_timeout() is really for calculations so please do this in
>>> sdhci_set_timeout() instead (i.e. change sdhci_calc_timeout() to return
>>> whether the timeout is too big).  Note that you need to cater for the "/*
>>> Unspecified timeout, assume max */" case and the
>>> SDHCI_QUIRK_BROKEN_TIMEOUT_VAL case.
>>>
>>> Also if SDHCI_INT_DATA_TIMEOUT is not being disabled, check here to
>>> re-enable it and leave sdhci_request_done() alone. i.e.
>>>
>>> 	else if (!(host->ier & SDHCI_INT_DATA_TIMEOUT)) {
>>> 		host->ier |= SDHCI_INT_DATA_TIMEOUT;
>>> 		sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
>>> 		sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
>>> 	}
>>>
>>> Maybe make a separate subroutine for the update:
>>>
>>> void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable)
>>> {
>>> 	if (enable)
>>> 		host->ier |= SDHCI_INT_DATA_TIMEOUT;
>>> 	else
>>> 		host->ier &= ~SDHCI_INT_DATA_TIMEOUT;
>>> 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
>>> 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
>>> }
>>>
>>>
>>>>  	}
>>>>  
>>>>  	return count;
>>>> @@ -2349,6 +2355,12 @@ static bool sdhci_request_done(struct sdhci_host *host)
>>>>  	}
>>>>  
>>>>  	sdhci_del_timer(host, mrq);
>>>> +	if (sdhci_data_line_cmd(mrq->cmd) && host->hw_timeout_disabled) {
>>>> +		host->ier |= SDHCI_INT_DATA_TIMEOUT;
>>>> +		sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
>>>> +		sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
>>>> +		host->hw_timeout_disabled = false;
>>>> +	}
>>>>  
>>>>  	/*
>>>>  	 * Always unmap the data buffers if they were mapped by
>>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>>> index afab26fd70e6..3a967a56fcc3 100644
>>>> --- a/drivers/mmc/host/sdhci.h
>>>> +++ b/drivers/mmc/host/sdhci.h
>>>> @@ -437,6 +437,11 @@ struct sdhci_host {
>>>>  #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
>>>>  /* Controller has CRC in 136 bit Command Response */
>>>>  #define SDHCI_QUIRK2_RSP_136_HAS_CRC			(1<<16)
>>>> +/*
>>>> + * Disable HW timeout if the requested timeout is more than the maximum
>>>> + * obtainable timeout
>>>> + */
>>>> +#define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			(1<<17)
>>
>> Are you okay with the definition of this quirk? i.e this quirk is applied only
>> when the requested timeout is "more" than the maximum obtainable timeout.
>>
>> By this way platforms can continue to use hardware timeout for smaller timeout
>> value.
> 
> It is fine to me.
> 
Okay thanks. I've posted v3 sometime last week. I'm trying to get this in for
4.17? Can you review the new revision please?

Thanks
Kishon
