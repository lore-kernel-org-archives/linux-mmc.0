From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [RFC PATCH 09/12] mmc: sdhci: Use software timer when timeout
 greater than hardware capablility
Date: Fri, 2 Feb 2018 18:55:34 +0530
Message-ID: <04efc506-b6dd-3950-336d-a4d92787d35d@ti.com>
References: <20171214130941.26666-1-kishon@ti.com>
 <20171214130941.26666-10-kishon@ti.com>
 <74170f0a-329a-2c66-7ad4-a1fedb9747df@intel.com>
 <2da01441-84d0-0d96-610d-2f9a3055ccc7@ti.com>
 <2a41ba31-07e5-027a-de30-495f69d71a88@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:36274 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbeBBN0P (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Feb 2018 08:26:15 -0500
In-Reply-To: <2a41ba31-07e5-027a-de30-495f69d71a88@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com

Hi Adrian,

On Thursday 11 January 2018 02:16 PM, Adrian Hunter wrote:
> On 04/01/18 14:59, Kishon Vijay Abraham I wrote:
>> Hi Adrian,
>>
>> On Wednesday 20 December 2017 07:41 PM, Adrian Hunter wrote:
>>> On 14/12/17 15:09, Kishon Vijay Abraham I wrote:
>>>> Errata i834 in AM572x Sitara Processors Silicon Revision 2.0, 1.1
>>>> (SPRZ429K July 2014–Revised March 2017 [1]) mentions
>>>> Under high speed HS200 and SDR104 modes, the functional clock for MMC
>>>> modules will reach up to 192 MHz. At this frequency, the maximum obtainable
>>>> timeout (DTO = 0xE) through MMC host controller is (1/192MHz)*2^27 = 700ms.
>>>> Commands taking longer than 700ms may be affected by this small window
>>>> frame. Workaround for this errata is use a software timer instead of
>>>> hardware timer to provide the delay requested by the upper layer.
>>>>
>>>> While this errata is specific to AM572x, it is applicable to all sdhci
>>>> based controllers when a particular request require timeout greater
>>>> than hardware capability.
>>>
>>> It doesn't work for our controllers.  Even if the data timeout interrupt is
>>> disabled, it seems like the timeout still "happens" in some fashion - after
>>> which the host controller starts misbehaving.
>>
>> even if the data timeout doesn't get disabled, count = 0xE is still present. So
>> ideally this shouldn't break any existing platforms no?
> 
> I don't want to hide this kind of variation in the hardware behaviour.
> 
>>>
>>> So you will need to add a quirk.
>>>
>>>>
>>>> Re-use the software timer already implemented in sdhci to program the
>>>> correct timeout value and also disable the hardware timeout when
>>>> the required timeout is greater than hardware capabiltiy in order to
>>>> avoid spurious timeout interrupts.
>>>>
>>>> This patch is based on the earlier patch implemented for omap_hsmmc [2]
>>>>
>>>> [1] -> http://www.ti.com/lit/er/sprz429k/sprz429k.pdf
>>>> [2] -> https://patchwork.kernel.org/patch/9791449/
>>>>
>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> ---
>>>>  drivers/mmc/host/sdhci.c | 41 +++++++++++++++++++++++++++++++++++++++--
>>>>  drivers/mmc/host/sdhci.h | 11 +++++++++++
>>>>  2 files changed, 50 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>> index e9290a3439d5..d0655e1d2cc7 100644
>>>> --- a/drivers/mmc/host/sdhci.c
>>>> +++ b/drivers/mmc/host/sdhci.c
>>>> @@ -673,6 +673,27 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
>>>>  	}
>>>>  }
>>>>  
>>>> +static void sdhci_calc_sw_timeout(struct sdhci_host *host,
>>>> +				  struct mmc_command *cmd,
>>>> +				  unsigned int target_timeout)
>>>> +{
>>>> +	struct mmc_host *mmc = host->mmc;
>>>> +	struct mmc_ios *ios = &mmc->ios;
>>>> +	struct mmc_data *data = cmd->data;
>>>> +	unsigned long long transfer_time;
>>>> +
>>>> +	if (data) {
>>>> +		transfer_time = MMC_BLOCK_TRANSFER_TIME_MS(data->blksz,
>>>> +							   ios->bus_width,
>>>> +							   ios->clock);
>>>
>>> If it has a value, actual_clock is better than ios->clock.
>>
>> okay.
>>>
>>>> +		/* calculate timeout for the entire data */
>>>> +		host->data_timeout = (data->blocks * (target_timeout +
>>>> +						      transfer_time));
>>>> +	} else if (cmd->flags & MMC_RSP_BUSY) {
>>>> +		host->data_timeout = cmd->busy_timeout * MSEC_PER_SEC;
>>>
>>> Doesn't need MSEC_PER_SEC multiplier.
>>
>> right.
>>>
>>>> +	}
>>>> +}
>>>> +
>>>>  static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>>>>  {
>>>>  	u8 count;
>>>> @@ -732,8 +753,12 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>>>>  	}
>>>>  
>>>>  	if (count >= 0xF) {
>>>> -		DBG("Too large timeout 0x%x requested for CMD%d!\n",
>>>> -		    count, cmd->opcode);
>>>> +		DBG("Too large timeout.. using SW timeout for CMD%d!\n",
>>>> +		    cmd->opcode);
>>>> +		sdhci_calc_sw_timeout(host, cmd, target_timeout);
>>>> +		host->ier &= ~SDHCI_INT_DATA_TIMEOUT;
>>>> +		sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
>>>> +		sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
>>>>  		count = 0xE;
>>>>  	}
>>>>  
>>>> @@ -1198,6 +1223,14 @@ static void sdhci_finish_command(struct sdhci_host *host)
>>>>  {
>>>>  	struct mmc_command *cmd = host->cmd;
>>>>  
>>>> +	if (host->data_timeout) {
>>>> +		unsigned long timeout;
>>>> +
>>>> +		timeout = jiffies +
>>>> +			  msecs_to_jiffies(host->data_timeout);
>>>> +		sdhci_mod_timer(host, host->cmd->mrq, timeout);
>>>
>>> cmd could be the sbc or a stop cmd or a command during transfer, so this
>>> needs more logic.
>>
>> host->data_timeout gets set only for data commands or commands with busy
>> timeout. But I guess for commands during data transfer, host->data_timeout
>> might still be set?
>>
>> Checking sdhci_data_line_cmd(mrq->cmd) in addition to host->data_timeout should
>> take care of all cases right?
> 
> I suggest you make the timeout calculation allow for the commands as well
> and then reorder sdhci_mod_timer() to be called after sdhci_prepare_data()
> and make sdhci_mod_timer() do the right thing.

Since we don't know when exactly the command will be sent, the timeout
calculation might not be very accurate. Programming the timer in command
complete will be bit more accurate IMO. What do you think?

Thanks
Kishon
