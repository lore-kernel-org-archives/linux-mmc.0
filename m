From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] sdhci: fix the fake timeout bug
Date: Fri, 30 Nov 2018 16:40:04 +0200
Message-ID: <c580be57-8a49-59f3-791e-c605d892266b@intel.com>
References: <20181130150028.732896d8@xdu1-mobl>
 <81ba3745-8277-d16e-3aad-48324f51dc8a@intel.com>
 <20181130221300.4ef2956c@xdu1-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130221300.4ef2956c@xdu1-mobl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Du, Alek" <alek.du@intel.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 30/11/18 4:13 PM, Du, Alek wrote:
> On Fri, 30 Nov 2018 11:19:03 +0200
> Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
>> Commands and resets are under spin lock, so no possibility for
>> preemption, and certainly a few microseconds isn't going to make any
>> difference to these timeouts, so I don't see how this patch could
>> help.
> 
> Thanks for your review.
> 
> I believe my case the scheduling out delay sometime can reach 10~20
> milliseconds... This may be due to the hypervisor...

So you are saying this only happens under virtualization?

> 
> Please look at the sdhci_enable_clk() below, there is a window in clock
> stabilization check. The first check is to check status register, the
> second check is to check if time passed. That's why I can capture a
> case that after time passed, the actually clock control register
> indicated that clock is stable. So the error handling is wrong...

Sure, but "Internal clock never stabilised." is not one of the  errors you
listed.

> 
> Also the sdhci_send_command commands is not in spin lock There is a
> windows between mod_timer and real command send...

What code path does not have a spin lock?

> 
> Thanks,
> Alek
> 
>>
>> I recently sent a patch for GLK laptops that had BIOS issues:
>>
>> 	https://marc.info/?l=linux-mmc&m=154270005901609
>>
>> And also some improvements to error handling:
>>
>> 	https://marc.info/?l=linux-mmc&m=154229013900437
>>
>> If those don't help, please share more details of the actual problem.
> 
> Sorry, I can't see how this patches could fix my problem.
> 
> 
> 
>>
>>>
>>> Signed-off-by: Alek Du <alek.du@intel.com>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 19 ++++++++++++++++---
>>>  1 file changed, 16 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 99bdae53fa2e..f88c49fc574e 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -218,12 +218,17 @@ void sdhci_reset(struct sdhci_host *host, u8
>>> mask) /* hw clears the bit when it's done */
>>>  	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
>>>  		if (ktime_after(ktime_get(), timeout)) {
>>> +			/* check it again, since there is a window
>>> between
>>> +			   bit check and time check */
>>> +			if (!(sdhci_readb(host,
>>> SDHCI_SOFTWARE_RESET) & mask))
>>> +				break;
>>>  			pr_err("%s: Reset 0x%x never completed.\n",
>>>  				mmc_hostname(host->mmc),
>>> (int)mask); sdhci_dumpregs(host);
>>>  			return;
>>> +		} else {
>>> +			udelay(10);
>>>  		}
>>> -		udelay(10);
>>>  	}
>>>  }
>>>  EXPORT_SYMBOL_GPL(sdhci_reset);
>>> @@ -1395,9 +1400,10 @@ void sdhci_send_command(struct sdhci_host
>>> *host, struct mmc_command *cmd) timeout +=
>>> DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ; else
>>>  		timeout += 10 * HZ;
>>> -	sdhci_mod_timer(host, cmd->mrq, timeout);
>>>  
>>>  	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags),
>>> SDHCI_COMMAND);
>>> +	/* setup timer after command to avoid fake timeout */
>>> +	sdhci_mod_timer(host, cmd->mrq, timeout);
>>>  }
>>>  EXPORT_SYMBOL_GPL(sdhci_send_command);
>>>  
>>> @@ -1611,12 +1617,19 @@ void sdhci_enable_clk(struct sdhci_host
>>> *host, u16 clk) while (!((clk = sdhci_readw(host,
>>> SDHCI_CLOCK_CONTROL)) & SDHCI_CLOCK_INT_STABLE)) {
>>>  		if (ktime_after(ktime_get(), timeout)) {
>>> +			/* check it again since there is a window
>>> between
>>> +			   status check and time check */
>>> +			if ((clk = sdhci_readw(host,
>>> SDHCI_CLOCK_CONTROL))
>>> +					& SDHCI_CLOCK_INT_STABLE)
>>> +				break;
>>>  			pr_err("%s: Internal clock never
>>> stabilised.\n", mmc_hostname(host->mmc));
>>>  			sdhci_dumpregs(host);
>>>  			return;
>>>  		}
>>> -		udelay(10);
>>> +		else {
>>> +			udelay(10);
>>> +		}
>>>  	}
>>>  
>>>  	clk |= SDHCI_CLOCK_CARD_EN;
>>>   
>>
> 
> 
