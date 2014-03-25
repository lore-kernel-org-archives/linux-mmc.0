From: Arend van Spriel <arend@broadcom.com>
Subject: Re: RESEND:[PATCH V3] sdhci: only reprogram retuning timer when flag
 is set
Date: Tue, 25 Mar 2014 21:49:53 +0100
Message-ID: <5331EBF1.4030600@broadcom.com>
References: <1393012782-23917-1-git-send-email-arend@broadcom.com> <532A7D87.4000009@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:37528 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755258AbaCYUt4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Mar 2014 16:49:56 -0400
In-Reply-To: <532A7D87.4000009@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Aaron Lu <aaron.lu@intel.com>, linux-mmc@vger.kernel.org, Dong Aisheng <dongas86@gmail.com>

On 03/20/14 06:32, Aaron Lu wrote:
> On 02/22/2014 03:59 AM, Arend van Spriel wrote:
>> When the host->tuning_count is zero it means that the
>> retuning is disabled. This is checked on the first
>> run of sdhci_execute_tuning() by the if statement below:
>>
>> 	if (!(host->flags&  SDHCI_NEEDS_RETUNING)&&  host->tuning_count&&
>> 	(host->tuning_mode == SDHCI_TUNING_MODE_1)) {
>>
>> So only when tuning_count is non-zero it will set the host
>> flag SDHCI_USING_RETUNING_TIMER. The else statement is only
>> for re-programming the timer, which means that flag must be
>> set. Because that is not checked the else statement is executed
>> in the first run when tuning_count is zero.
>>
>> This was seen on a host controller which indicated
>> SDHCI_TUNING_MODE_1 (0) and tuning_count being zero. Suspect
>> that (one of) these registers is not properly set.
>>
>> Cc: Dong Aisheng<dongas86@gmail.com>
>> Cc: Aaron Lu<aaron.lwe@gmail.com>
>> Signed-off-by: Arend van Spriel<arend@broadcom.com>
>
> In addition to solve your problem, this patch also makes sense in the
> common case, so:
>
> Reviewed-by: Aaron Lu<aaron.lu@intel.com>

Hi Chris,

Is this patch still in your queue?

Regards,
Arend
