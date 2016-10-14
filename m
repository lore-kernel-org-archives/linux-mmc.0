From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci: cast unsigned int to unsigned long long to
 avoid unexpeted error
Date: Fri, 14 Oct 2016 12:12:27 +0300
Message-ID: <cd546cd4-e64f-1b86-1cae-08b89dabc410@intel.com>
References: <1473750418-23111-1-git-send-email-haibo.chen@nxp.com>
 <3603c63f-f007-12cc-677b-f39924628335@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:22548 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751195AbcJNJRR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 14 Oct 2016 05:17:17 -0400
In-Reply-To: <3603c63f-f007-12cc-677b-f39924628335@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haibo Chen <haibo.chen@nxp.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org

On 13/09/16 11:36, Adrian Hunter wrote:
> On 13/09/16 10:06, Haibo Chen wrote:
>> Potentially overflowing expression 1000000 * data->timeout_clks with
>> type unsigned int is evaluated using 32-bit arithmetic, and then used
>> in a context that expects an expression of type unsigned long long.
>>
>> To avoid overflow, cast 1000000U to type unsigned long long.
>> Special thanks to coverity <http://www.coverity.com>
> 
> Let's leave out the web link - it is enough to say it was found with Coverity.
> 
>>
>> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Do you plan to re-submit this?

> 
> Needs a fixes tag and cc stable.
> 
>> ---
>>  drivers/mmc/host/sdhci.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 4805566..0e9f495 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -687,7 +687,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>>  			 * host->clock is in Hz.  target_timeout is in us.
>>  			 * Hence, us = 1000000 * cycles / Hz.  Round up.
>>  			 */
>> -			val = 1000000 * data->timeout_clks;
>> +			val = (unsigned long long)1000000 * data->timeout_clks;
> 
> Please use 1000000ULL instead of a cast.
> 
>>  			if (do_div(val, host->clock))
>>  				target_timeout++;
>>  			target_timeout += val;
>>
> 
> 

