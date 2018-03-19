From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v3 07/11] mmc: sdhci: Program a relatively accurate SW
 timeout value
Date: Mon, 19 Mar 2018 15:49:08 +0530
Message-ID: <dacb62d3-086d-27a7-85cf-94916ce464b5@ti.com>
References: <20180307132020.30951-1-kishon@ti.com>
 <20180307132020.30951-8-kishon@ti.com>
 <1e87e5f9-13e1-765b-f077-26a55359b2c3@intel.com>
 <47752066-aeda-87bc-6928-1a9b80f1c45c@ti.com>
 <49210daa-b593-4b34-abf5-be81580723bc@intel.com>
 <29f640ac-b155-41c6-cf3f-8c66e1b300f1@ti.com>
 <1905d25f-d16d-50b1-54b0-35807d801a12@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1905d25f-d16d-50b1-54b0-35807d801a12@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,

On Monday 19 March 2018 03:30 PM, Adrian Hunter wrote:
> On 19/03/18 11:20, Kishon Vijay Abraham I wrote:
>> Hi Adrian,
>>
>> On Friday 16 March 2018 07:51 PM, Adrian Hunter wrote:
>>> On 16/03/18 08:29, Kishon Vijay Abraham I wrote:
>>>> Hi,
>>>>
>>>> On Thursday 15 March 2018 06:43 PM, Adrian Hunter wrote:
>>>>> On 07/03/18 15:20, Kishon Vijay Abraham I wrote:
>>>>>> sdhci has a 10 second timeout to catch devices that stop responding.
>>>>>> Instead of programming 10 second arbitrary value, calculate the total time
>>>>>> it would take for the entire transfer to happen and program the timeout
>>>>>> value accordingly.
>>>>>>
>>>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>>>> ---
>>>>>>  drivers/mmc/host/sdhci.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
>>>>>>  drivers/mmc/host/sdhci.h | 10 ++++++++++
>>>>>>  2 files changed, 50 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>>>> index 1dd117cbeb6e..baab67bfa39b 100644
>>>>>> --- a/drivers/mmc/host/sdhci.c
>>>>>> +++ b/drivers/mmc/host/sdhci.c
>>>>>> @@ -709,6 +709,36 @@ static u32 sdhci_sdma_address(struct sdhci_host *host)
>>>>>>  		return sg_dma_address(host->data->sg);
>>>>>>  }
>>>>>>  
>>>>>> +static void sdhci_calc_sw_timeout(struct sdhci_host *host,
>>>>>> +				  struct mmc_command *cmd,
>>>>>> +				  unsigned int target_timeout)
>>>>>> +{
>>>>>> +	struct mmc_data *data = cmd->data;
>>>>>> +	struct mmc_host *mmc = host->mmc;
>>>>>> +	u64 transfer_time;
>>>>>> +	struct mmc_ios *ios = &mmc->ios;
>>>>>> +	unsigned char bus_width = 1 << ios->bus_width;
>>>>>> +	unsigned int blksz;
>>>>>> +	unsigned int freq;
>>>>>> +
>>>>>> +	if (data) {
>>>>>> +		blksz = data->blksz;
>>>>>> +		freq = host->mmc->actual_clock ? : host->clock;
>>>>>> +		transfer_time = (u64)blksz * NSEC_PER_SEC * (8 / bus_width);
>>>>>> +		do_div(transfer_time, freq);
>>>>>> +		/* multiply by '2' to account for any unknowns */
>>>>>> +		transfer_time = transfer_time * 2;
>>>>>> +		/* calculate timeout for the entire data */
>>>>>> +		host->data_timeout = (data->blocks * ((target_timeout *
>>>>>> +						       NSEC_PER_USEC) +
>>>>>> +						       transfer_time));
>>>>>
>>>>> (target_timeout * NSEC_PER_USEC) might be 32-bit and therefore overflow
>>>>> for timeouts greater than about 4 seconds.
>>>>>
>>>>>> +	} else {
>>>>>> +		host->data_timeout = (u64)target_timeout * NSEC_PER_USEC;
>>>>>> +	}
>>>>>> +
>>>>>> +	host->data_timeout += MMC_CMD_TRANSFER_TIME;
>>>>>
>>>>> Need to allow for target_timeout == 0 so:
>>>>>
>>>>> 	if (host->data_timeout)
>>>>> 		host->data_timeout += MMC_CMD_TRANSFER_TIME;
>>>>>
>>>>>> +}
>>>>>> +
>>>>>>  static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>>>>>>  {
>>>>>>  	u8 count;
>>>>>> @@ -766,6 +796,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>>>>>>  		if (count >= 0xF)
>>>>>>  			break;
>>>>>>  	}
>>>>>> +	sdhci_calc_sw_timeout(host, cmd, target_timeout);
>>>>>
>>>>> If you make the changes I suggest for patch 6, then this would
>>>>> move sdhci_calc_sw_timeout() into sdhci_set_timeout().
>>>>>
>>>>> I suggest you factor out the target_timeout calculation e.g.
>>>>>
>>>>> static unsigned int sdhci_target_timeout(struct sdhci_host *host,
>>>>> 					 struct mmc_command *cmd,
>>>>> 					 struct mmc_data *data)
>>>>> {
>>>>> 	unsigned int target_timeout;
>>>>>
>>>>> 	/* timeout in us */
>>>>> 	if (!data)
>>>>> 		target_timeout = cmd->busy_timeout * 1000;
>>>>> 	else {
>>>>> 		target_timeout = DIV_ROUND_UP(data->timeout_ns, 1000);
>>>>> 		if (host->clock && data->timeout_clks) {
>>>>> 			unsigned long long val;
>>>>>
>>>>> 			/*
>>>>> 			 * data->timeout_clks is in units of clock cycles.
>>>>> 			 * host->clock is in Hz.  target_timeout is in us.
>>>>> 			 * Hence, us = 1000000 * cycles / Hz.  Round up.
>>>>> 			 */
>>>>> 			val = 1000000ULL * data->timeout_clks;
>>>>> 			if (do_div(val, host->clock))
>>>>> 				target_timeout++;
>>>>> 			target_timeout += val;
>>>>> 		}
>>>>> 	}
>>>>>
>>>>> 	return target_timeout;
>>>>> }
>>>>>
>>>>> And call it from sdhci_calc_sw_timeout()
>>>>>
>>>>>>  
>>>>>>  	return count;
>>>>>>  }
>>>>>> @@ -1175,13 +1206,6 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>>>>>>  		mdelay(1);
>>>>>>  	}
>>>>>>  
>>>>>> -	timeout = jiffies;
>>>>>> -	if (!cmd->data && cmd->busy_timeout > 9000)
>>>>>> -		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
>>>>>> -	else
>>>>>> -		timeout += 10 * HZ;
>>>>>> -	sdhci_mod_timer(host, cmd->mrq, timeout);
>>>>>> -
>>>>>>  	host->cmd = cmd;
>>>>>>  	if (sdhci_data_line_cmd(cmd)) {
>>>>>>  		WARN_ON(host->data_cmd);
>>>>>> @@ -1221,6 +1245,15 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>>>>>>  	    cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)
>>>>>>  		flags |= SDHCI_CMD_DATA;
>>>>>>  
>>>>>> +	timeout = jiffies;
>>>>>> +	if (host->data_timeout > 0) {
>>>>>
>>>>> This can be just:
>>>>>
>>>>> 	if (host->data_timeout) {
>>>>>
>>>>>> +		timeout += nsecs_to_jiffies(host->data_timeout);
>>>>>> +		host->data_timeout = 0;
>>>>>
>>>>> It would be better to initialize host->data_timeout = 0 at the top of
>>>>> sdhci_prepare_data().
>>>>>
>>>>> Also still need:
>>>>>
>>>>> 	else if (!cmd->data && cmd->busy_timeout > 9000) {
>>>>> 		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
>>>>
>>>> sdhci_calc_sw_timeout should have calculated the timeout for this case too no?
>>>
>>> Yes, but I was thinking you would only calculate when it was needed.
>>
>> I feel since we would have anyways calculated data_timeout, we should use that
>> instead unless you see a problem with that.
> 
> I would prefer not to calculate data_timeout when a hardware timeout is
> being used.
> 

That differs from what I had thought. This patch tries to program a relatively
accurate SW timeout value (for data_timer) irrespective of whether hardware
timeout is used or not. This only tries to change the 10 Sec SW timeout value
programmed for all data transfer commands.

Thanks
Kishon
