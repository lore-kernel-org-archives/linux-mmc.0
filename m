Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D3F18C348;
	Wed, 21 Aug 2024 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724249680; cv=none; b=Lwokt5nO5dCGkFzt3W3+q/r88Ze4YnDKR9ih5bvjladSZaM9HDFmLrhJODpD1wkrTQqx8SVYSLtEJsV+bQOc4+DtZg0J/RbOWfEdHEIu/XH6BN2xjqCHUEp8Y1dSURziF08oNhylQZmgHXDJaTdFDdOaTvwROw8QE37g5hosbv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724249680; c=relaxed/simple;
	bh=CRhd0mZzqY7HKRLH5Jk+ftSAjgB0NenBAW5LauDTmm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kZEWcg0LsINoL6wrhfFRTtMo8MS+cfsnzawRZX/m3Bu7AYoZAhl0vnMWcT1P1mzpM0BgTxNcMn84gXp4NEwrvfTXjn5LVh3ZxflQAuh7quvRBQWtZjWNqHfbqV0ex8Ein1axT4nx1cFUSkfEBtlz9UrTDQGNg1ZrRD4yxO+1cSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DiQGDurf; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DiQGDurf"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47LEEZ9W020865;
	Wed, 21 Aug 2024 09:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724249675;
	bh=B82OHOANyKNc/1if4fUQEqjOHPPZcLk9ZrOvgcGUHMQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=DiQGDurfQrurxhAuSd2LeoakN16FBh9IUXcWb5u3+wDIhQu5T03BHn3PnhsyJWI2n
	 yEC8U65fFmyOBv5dLYg1HzcnnhNVJrh4WNu2OHW1X+a+8Ud/L9wSqkpZIr4V5E9irC
	 ssskRiqcuXZZuMuanULllF2U+uOxxy/PJ9NFBCL4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47LEEZpC029849
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Aug 2024 09:14:35 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Aug 2024 09:14:35 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Aug 2024 09:14:34 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47LEEYGs071283;
	Wed, 21 Aug 2024 09:14:34 -0500
Message-ID: <f27dba79-02cf-4549-87b0-464126abbe1d@ti.com>
Date: Wed, 21 Aug 2024 09:14:34 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mmc: sdhci_am654: Add retry tuning
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240815201542.421653-1-jm@ti.com>
 <20240815201542.421653-2-jm@ti.com>
 <4a563aad-e9b3-43af-8ce5-5d30dace2dd8@intel.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <4a563aad-e9b3-43af-8ce5-5d30dace2dd8@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Adrian,

On 8/21/24 12:37 AM, Adrian Hunter wrote:
> On 15/08/24 23:15, Judith Mendez wrote:
>> Add retry tuning up to 10 times if we fail to find
>> a failing region or no passing itapdly. This is
>> necessary since some eMMC's have been observed to never
>> find a failing itapdly on the first couple of tuning
>> iterations, but eventually do. It been observed that the
>> tuning algorithm does not need to loop more than 10 times
>> before finding a failing itapdly.
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   drivers/mmc/host/sdhci_am654.c | 30 +++++++++++++++++++++++-------
>>   1 file changed, 23 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>> index 64e10f7c9faa3..c3d485bd4d553 100644
>> --- a/drivers/mmc/host/sdhci_am654.c
>> +++ b/drivers/mmc/host/sdhci_am654.c
>> @@ -86,6 +86,7 @@
>>   
>>   #define CLOCK_TOO_SLOW_HZ	50000000
>>   #define SDHCI_AM654_AUTOSUSPEND_DELAY	-1
>> +#define RETRY_TUNING_MAX	10
>>   
>>   /* Command Queue Host Controller Interface Base address */
>>   #define SDHCI_AM654_CQE_BASE_ADDR 0x200
>> @@ -151,6 +152,7 @@ struct sdhci_am654_data {
>>   	u32 flags;
>>   	u32 quirks;
>>   	bool dll_enable;
>> +	u32 tuning_loop;
>>   
>>   #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
>>   };
>> @@ -453,12 +455,14 @@ static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
>>   	int prev_fail_end = -1;
>>   	u8 i;
>>   
>> -	if (!num_fails)
>> -		return ITAPDLY_LAST_INDEX >> 1;
>> +	if (!num_fails) {
>> +		/* Retry tuning */
>> +		return -1;
>> +	}
>>   
>>   	if (fail_window->length == ITAPDLY_LENGTH) {
>> -		dev_err(dev, "No passing ITAPDLY, return 0\n");
>> -		return 0;
>> +		/* Retry tuning */
>> +		return -1;
>>   	}
>>   
>>   	first_fail_start = fail_window->start;
>> @@ -504,6 +508,7 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>>   	u8 curr_pass, itap;
>>   	u8 fail_index = 0;
>>   	u8 prev_pass = 1;
>> +	int ret;
>>   
>>   	memset(fail_window, 0, sizeof(fail_window));
>>   
>> @@ -532,10 +537,20 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>>   	if (fail_window[fail_index].length != 0)
>>   		fail_index++;
>>   
>> -	itap = sdhci_am654_calculate_itap(host, fail_window, fail_index,
>> -					  sdhci_am654->dll_enable);
>> +	ret = sdhci_am654_calculate_itap(host, fail_window, fail_index,
>> +					 sdhci_am654->dll_enable);
>>   
>> -	sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
>> +	if (ret >= 0) {
>> +		itap = ret;
>> +		sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
>> +	} else {
>> +		if (sdhci_am654->tuning_loop < RETRY_TUNING_MAX) {
>> +			sdhci_am654->tuning_loop++;
>> +			sdhci_am654_platform_execute_tuning(host, opcode);
> 
> The kernel uses very small stack size, so recursive function calls
> should not be used.  It would be better to put the loop in a separate
> function, or add a retry: label and goto retry.

Ok, can change to this method, I was not sure of recursive function
call but had opted for that since the code was to be simpler.

> 
>> +		} else {
>> +			return -1;
>> +		}
>> +	}
>>   
>>   	/* Save ITAPDLY */
>>   	sdhci_am654->itap_del_sel[timing] = itap;
>> @@ -908,6 +923,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>>   		goto err_pltfm_free;
>>   	}
>>   
>> +	sdhci_am654->tuning_loop = 0;
> 
> So this is 10 retries ever, since sdhci_am654->tuning_loop is never
> set back to 0.  Is that the intention?

Yes, maximum of 10 re-tries. So far we have only seen issues during
boot.

~ Judith

> 
>>   	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
>>   
>>   	pm_runtime_get_noresume(dev);
> 

