From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH] sdhci: expose the SDCLK frq in sys ios
Date: Thu, 20 Oct 2011 10:00:42 +0200
Message-ID: <4E9FD52A.8080806@st.com>
References: <1319031945-2630-1-git-send-email-peppe.cavallaro@st.com> <4E9FBE0C.7040002@intel.com> <4E9FC054.6060606@st.com> <4E9FD00C.4020506@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:52499 "EHLO
	eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753655Ab1JTIAs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Oct 2011 04:00:48 -0400
In-Reply-To: <4E9FD00C.4020506@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org

On 10/20/2011 9:38 AM, Adrian Hunter wrote:
> On 20/10/11 09:31, Giuseppe CAVALLARO wrote:
>> Hello Adrian
>>
>> On 10/20/2011 8:22 AM, Adrian Hunter wrote:
>>> On 19/10/11 16:45, Giuseppe CAVALLARO wrote:
>>>> This patch is to expose the SDCLK frequency in the ios /sys entry.
>>>>
>>>> For example, if the max clk for a normal speed card is 20MHz
>>>> this will be reported in /sys/kernel/debug/mmc0/ios instead of
>>>> the real SDCLK frequency (calculated as Baseclock / divisor;
>>>> divisor used for programming the Clock Control Register).
>>>>
>>>> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
>>>> ---
>>>>  drivers/mmc/host/sdhci.c |    9 ++++++++-
>>>>  1 files changed, 8 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>> index 0e02cc1..6bdf64f 100644
>>>> --- a/drivers/mmc/host/sdhci.c
>>>> +++ b/drivers/mmc/host/sdhci.c
>>>> @@ -1045,6 +1045,7 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>>>>  	int div = 0; /* Initialized for compiler warning */
>>>>  	u16 clk = 0;
>>>>  	unsigned long timeout;
>>>> +	unsigned int new_hc_clock = host->max_clk;
>>>>  
>>>>  	if (clock == host->clock)
>>>>  		return;
>>>> @@ -1134,7 +1135,10 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>>>>  	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>>>>  
>>>>  out:
>>>> -	host->clock = clock;
>>>> +	if (div)
>>>> +		new_hc_clock = host->max_clk / div;
>>>
>>> At this point div is the value written to the register not the
>>> divisor
>>
>> Hmm, you are right. I'll fix it.
>>
>>>> +
>>>> +	host->clock = new_hc_clock;
>>>>  }
>>>>  
>>>>  static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
>>>> @@ -1293,6 +1297,9 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>>  
>>>>  	sdhci_set_clock(host, ios->clock);
>>>>  
>>>> +	/* Clock provided to the HC */
>>>> +	ios->clock = host->clock;
>>>
>>> It would be nicer to keep ios->clock as the target
>>> frequency and add a new member to struct mmc_host for
>>> the actual frequency.
>>
>> Why not! I like it. I'll rework the patch and send it again.
>> Just a question: do I have to dump both in /sys/.../ios?
>> If yes, maybe it's worth using: card_clock and hc_clock as names.
>> What do you think?
> 
> For me hc_clock is confusing.  Potentially the host controller has
> lots of clocks e.g. interface clock, functional clock, debounce clock
> 
> Also, I would not rename anything.  You could add

Indeed, it 's better to not rename clock field for compatibility. ;-)

> 	/sys/kernel/debug/mmcx/actual_clock
> 
> or amend /sys/kernel/debug/mmcx/ios e.g.
> 
> clock:          26000000 Hz (actual 25000000 Hz)

ok I prefer the latter.

Thanks
Peppe

> vdd:            17 (2.9 ~ 3.0 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      2 (4 bits)
> timing spec:    0 (legacy)



> 
> 
> 
>>
>> Regards
>> Peppe
>>
>>>
>>>> +
>>>>  	if (ios->power_mode == MMC_POWER_OFF)
>>>>  		sdhci_set_power(host, -1);
>>>>  	else
>>>
>>>
>>
>>
> 
> 

