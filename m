From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] sdhci: do not program timer when tuning_count is zero
Date: Fri, 08 Nov 2013 19:49:05 +0800
Message-ID: <527CCFB1.5020906@intel.com>
References: <1383821960-2533-1-git-send-email-arend@broadcom.com> <527C899C.3030506@intel.com> <527CAA9F.5030907@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:22215 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752830Ab3KHLsT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 8 Nov 2013 06:48:19 -0500
In-Reply-To: <527CAA9F.5030907@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arend van Spriel <arend@broadcom.com>, Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On 11/08/2013 05:10 PM, Arend van Spriel wrote:
> On 11/08/2013 07:50 AM, Aaron Lu wrote:
>> On 11/07/2013 06:59 PM, Arend van Spriel wrote:
>>> When the host->tuning_count is zero it means that the
>>
>> If the tuning_count is zero, then the retuning timer shouldn't be
>> started in the first place and not possible to run code there. Or is the
>> tuning_count dynamically changed?
> 
> Actually, the sdhci_execute_tuning() must run once to do the initial 
> tuning procedure. This is mandatory for SDR104. However, *re*tuning is 
> not and a zero tuning_count disables it.

So the host in question doesn't need do retuning while in SDR104 mode?
It seems your host's retuning mode is mode_1.

> 
> The function is executed initially. The 'if' statement above the patched 
> 'else' statement is actually responsible for programming the retuning 
> timer for the first time. However, it requires tuning_count to be 
> non-zero. The 'else' statement is actually for reloading the retuning 
> timer, which is not the case. Adding the non-zero check assures the 
> retuning timer is never started.

OK, I see.
The SDHCI_USING_RETUNING_TIMER flag is supposed to mean if the host is
currently using retuning timer to do retuning, it could also be used to
decide if retuning timer needs be re-programmed.

Anyway, a host in retuning mode 1 does not have tuning_count set seems a
little odd to me...

Thanks,
Aaron

> 
> I guess the fact that this needs explaining indicates that the commit 
> message should be updated. I will send a V2 for this.
> 
> Regards,
> Arend
> 
>> Thanks,
>> Aaron
>>
>>> retuning is disabled. Doing a mod_timer() with a zero
>>> tuning_count does something else.
>>>
>>> Signed-off-by: Arend van Spriel <arend@broadcom.com>
>>> ---
>>>   drivers/mmc/host/sdhci.c |    3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 7a7fb4f..9803e7a 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -2007,7 +2007,8 @@ out:
>>>   	} else {
>>>   		host->flags &= ~SDHCI_NEEDS_RETUNING;
>>>   		/* Reload the new initial value for timer */
>>> -		if (host->tuning_mode == SDHCI_TUNING_MODE_1)
>>> +		if (host->tuning_count &&
>>> +		    host->tuning_mode == SDHCI_TUNING_MODE_1)
>>>   			mod_timer(&host->tuning_timer, jiffies +
>>>   				host->tuning_count * HZ);
>>>   	}
>>>
>>
>>
> 
> 

