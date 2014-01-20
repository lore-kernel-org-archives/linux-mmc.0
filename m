From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci: Allow for long command timeouts
Date: Mon, 20 Jan 2014 08:17:01 +0200
Message-ID: <52DCBF5D.8000500@intel.com>
References: <1384416980-15850-1-git-send-email-adrian.hunter@intel.com> <52AAE541.6090606@intel.com> <52D39059.5080504@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:2064 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710AbaATGPf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Jan 2014 01:15:35 -0500
In-Reply-To: <52D39059.5080504@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc@vger.kernel.org

Ping?

On 13/01/14 09:06, Adrian Hunter wrote:
> Ping?
> 
> 
> On 13/12/13 12:45, Adrian Hunter wrote:
>> Hi Chris
>>
>> What about this one?
>>
>> Regards
>> Adrian
>>
>> On 14/11/13 10:16, Adrian Hunter wrote:
>>> The driver has a timer with a 10 second
>>> timeout to catch devices that stop responding.
>>> However it is possible for commands to take
>>> even longer than that.  Change the timer
>>> timeout to reflect the command timeout.
>>>
>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index bd8a098..614a34d 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -1013,7 +1013,12 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>>>  		mdelay(1);
>>>  	}
>>>  
>>> -	mod_timer(&host->timer, jiffies + 10 * HZ);
>>> +	timeout = jiffies;
>>> +	if (!cmd->data && cmd->cmd_timeout_ms > 9000)
>>> +		timeout += DIV_ROUND_UP(cmd->cmd_timeout_ms, 1000) * HZ + HZ;
>>> +	else
>>> +		timeout += 10 * HZ;
>>> +	mod_timer(&host->timer, timeout);
>>>  
>>>  	host->cmd = cmd;
>>>  
>>>
>>
>>
>>
> 
> 
> 

