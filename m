From: Chris Ball <chris@printf.net>
Subject: Re: RESEND:[PATCH V3] sdhci: only reprogram retuning timer when flag is set
Date: Tue, 25 Mar 2014 20:56:19 +0000
Message-ID: <86lhvyvvyk.fsf@void.printf.net>
References: <1393012782-23917-1-git-send-email-arend@broadcom.com>
	<532A7D87.4000009@intel.com> <5331EBF1.4030600@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47385 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754122AbaCYU41 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 25 Mar 2014 16:56:27 -0400
In-Reply-To: <5331EBF1.4030600@broadcom.com> (Arend van Spriel's message of
	"Tue, 25 Mar 2014 21:49:53 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arend van Spriel <arend@broadcom.com>
Cc: Aaron Lu <aaron.lu@intel.com>, linux-mmc@vger.kernel.org, Dong Aisheng <dongas86@gmail.com>

Hi Arend,

On Tue, Mar 25 2014, Arend van Spriel wrote:
> On 03/20/14 06:32, Aaron Lu wrote:
>> On 02/22/2014 03:59 AM, Arend van Spriel wrote:
>>> When the host->tuning_count is zero it means that the
>>> retuning is disabled. This is checked on the first
>>> run of sdhci_execute_tuning() by the if statement below:
>>>
>>> 	if (!(host->flags&  SDHCI_NEEDS_RETUNING)&&  host->tuning_count&&
>>> 	(host->tuning_mode == SDHCI_TUNING_MODE_1)) {
>>>
>>> So only when tuning_count is non-zero it will set the host
>>> flag SDHCI_USING_RETUNING_TIMER. The else statement is only
>>> for re-programming the timer, which means that flag must be
>>> set. Because that is not checked the else statement is executed
>>> in the first run when tuning_count is zero.
>>>
>>> This was seen on a host controller which indicated
>>> SDHCI_TUNING_MODE_1 (0) and tuning_count being zero. Suspect
>>> that (one of) these registers is not properly set.
>>>
>>> Cc: Dong Aisheng<dongas86@gmail.com>
>>> Cc: Aaron Lu<aaron.lwe@gmail.com>
>>> Signed-off-by: Arend van Spriel<arend@broadcom.com>
>>
>> In addition to solve your problem, this patch also makes sense in the
>> common case, so:
>>
>> Reviewed-by: Aaron Lu<aaron.lu@intel.com>
>
> Hi Chris,
>
> Is this patch still in your queue?

Thanks!  I've pushed this to mmc-next for 3.15 with Aaron/Ulf's ACKs now.

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
