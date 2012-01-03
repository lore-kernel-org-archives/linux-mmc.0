From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 2/2] mmc: sdhci: Deal with failure case in sdhci_suspend_host
Date: Mon, 02 Jan 2012 19:11:14 -0500
Message-ID: <m28vlpprvh.fsf@bob.laptop.org>
References: <1325127014-16337-1-git-send-email-aaron.lu@amd.com>
	<4EFD6708.6080608@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60448 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753468Ab2ACALX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 2 Jan 2012 19:11:23 -0500
In-Reply-To: <4EFD6708.6080608@intel.com> (Adrian Hunter's message of "Fri, 30
	Dec 2011 09:23:52 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Aaron Lu <aaron.lu@amd.com>, linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>

Hi Aaron,

On Fri, Dec 30 2011, Adrian Hunter wrote:
> On 29/12/2011 4:50 a.m., Aaron Lu wrote:
>> V2: Error processing code in sdhci_pci_suspend should not be deleted,
>> it is used to resume hosts which are already successfully suspended for
>> a multi slot pci device as suggested by Adrian.
>>
>> If there are errors happened in sdhci_suspend_host, handle it so that
>> when the function returns with an error, the host's behaviour is the
>> same before this function call, e.g. card detection is enabled and
>> tuning timer is active, etc.
>>
>> Signed-off-by: Philip Rakity<prakity@marvell.com>
>> Signed-off-by: Aaron Lu<aaron.lu@amd.com>
>> Cc: Adrian Hunter<adrian.hunter@intel.com>
>> ---
>>   drivers/mmc/host/sdhci.c |   27 +++++++++++++++++++++------
>>   1 files changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 2007d37..37aeb81 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2339,25 +2339,40 @@ out:
>>
>>   int sdhci_suspend_host(struct sdhci_host *host)
>>   {
>> -	int ret;
>> +	int ret, has_tuning_timer;
>>
>>   	sdhci_disable_card_detection(host);
>>
>>   	/* Disable tuning since we are suspending */
>> -	if (host->version>= SDHCI_SPEC_300&&  host->tuning_count&&
>> -	    host->tuning_mode == SDHCI_TUNING_MODE_1) {
>> +	has_tuning_timer = host->version>= SDHCI_SPEC_300&&
>> +		host->tuning_count&&  host->tuning_mode == SDHCI_TUNING_MODE_1;
>> +	if (has_tuning_timer) {
>>   		del_timer_sync(&host->tuning_timer);
>>   		host->flags&= ~SDHCI_NEEDS_RETUNING;
>>   	}
>>
>>   	ret = mmc_suspend_host(host->mmc);
>>   	if (ret)
>> -		return ret;
>> +		goto err_suspend;
>> +
>> +	if (host->vmmc) {
>> +		ret = regulator_disable(host->vmmc);
>> +		if (ret)
>> +			goto err_suspend;
>> +	}
>
> This is slightly in conflict with my patch
> "mmc: sdhci: fix vmmc handling"
>
> Maybe you guys could ack/nack that
> and adjust this accordingly.

I've pushed Adrian's vmmc patch to mmc-next now, so this can be reworked.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
