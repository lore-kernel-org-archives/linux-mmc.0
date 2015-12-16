From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: It is not an error for the card to be removed while
 suspended
Date: Wed, 16 Dec 2015 10:18:39 +0200
Message-ID: <56711E5F.7010603@intel.com>
References: <1450101087-24391-1-git-send-email-adrian.hunter@intel.com>
 <566F9080.6030903@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:37314 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932447AbbLPIVz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Dec 2015 03:21:55 -0500
In-Reply-To: <566F9080.6030903@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 15/12/15 06:01, Jaehoon Chung wrote:
> On 12/14/2015 10:51 PM, Adrian Hunter wrote:
>> A card can be removed while it is runtime suspended.
>> Do not print an error message.
> 
> Well, if card is non-removable (in case of eMMC, card can be non-removable),
>  it needs to print the error message?
> I'm not sure what's correct..but just my opinion.

I guess this patch should have been a "V2" but the original was so long ago.
Ulf's comment about your concern is here:

	http://marc.info/?l=linux-mmc&m=141163363902017&w=2


>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  drivers/mmc/core/mmc.c | 2 +-
>>  drivers/mmc/core/sd.c  | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 549c56e8cf6b..bf49e44571f2 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1935,7 +1935,7 @@ static int mmc_runtime_resume(struct mmc_host *host)
>>  	int err;
>>  
>>  	err = _mmc_resume(host);
>> -	if (err)
>> +	if (err && err != -ENOMEDIUM)
>>  		pr_err("%s: error %d doing runtime resume\n",
>>  			mmc_hostname(host), err);
>>  
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>> index 8f3b46a56b3d..f2b164b214ae 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -1158,7 +1158,7 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
>>  	int err;
>>  
>>  	err = _mmc_sd_resume(host);
>> -	if (err)
>> +	if (err && err != -ENOMEDIUM)
>>  		pr_err("%s: error %d doing runtime resume\n",
>>  			mmc_hostname(host), err);
>>  
>>
> 
> 

