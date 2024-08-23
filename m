Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E030E1925B9;
	Fri, 23 Aug 2024 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724445851; cv=none; b=dh5Mqg3WI/lQ6itru/U123ybONwXhthxhqPQoVX7kgbaN4a0Y2sYRQw4TpRwLPVYBafgvC7q0CoZKHYT3QjX6jq1cztosjpup2XG+VK+gPxFk9RiBROnuT6aR9ScktB2cj6FZidqouizuLOPJfNmPTxRyYEcACaQhCJtQa8ZSvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724445851; c=relaxed/simple;
	bh=mY3ZlZr4LGd16AFsJBkwi3pqwy2Dk9HleHVv62NxpnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ByfCD5s5Dll7R8SdDXwxSWnd+x+lNX84BtMJsIp0xm87v3zI57vAm+7Xes+1hcq+BvdnL9s9UI/unC5x2tAV/PC7tBnE/E+lIY//ZXyR8dKOszjGJO9HUOIQOmFyfT1eqh8tP1qPgaBcqoRM0Vm5RRhpEEH/XkNMyPVU2IWJ3lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IZCX53sM; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IZCX53sM"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47NKi0gP024462;
	Fri, 23 Aug 2024 15:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724445840;
	bh=UgT1CQV66JpbZILH2YaDRh4UGWeqfWk110ZStUenq+w=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=IZCX53sMWKs2CfjBxR/YeQihIjcTtndCS2xpyeouxaRo02qOIvVK0Zw5nRGbtnUsr
	 jxLjDxRO7p7D9qdnxh3lJ3uYb+Ra9j3zmZkwa5pbnIvEEFsMgu2gl6FZ8fIa6FkXlY
	 01C6Wvwlr/ViI42798TwQAsL/z1xIit8yJxhrDko=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47NKi0Ga018820
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Aug 2024 15:44:00 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Aug 2024 15:44:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Aug 2024 15:44:00 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47NKi0ZW056531;
	Fri, 23 Aug 2024 15:44:00 -0500
Message-ID: <feee18cc-e75b-49d9-ac09-a0afbb0b00ca@ti.com>
Date: Fri, 23 Aug 2024 15:44:00 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mmc: sdhci_am654: Add retry tuning
To: Adrian Hunter <adrian.hunter@intel.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240821192435.1619271-1-jm@ti.com>
 <20240821192435.1619271-2-jm@ti.com>
 <47ed0a0b-dfaa-40e1-825a-9a42e66b887e@intel.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <47ed0a0b-dfaa-40e1-825a-9a42e66b887e@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Adrian,

On 8/23/24 8:45 AM, Adrian Hunter wrote:
> On 21/08/24 22:24, Judith Mendez wrote:
>> Add retry tuning up to 10 times if we fail to find
>> a failing region or no passing itapdly. This is
>> necessary since some eMMC has been observed to never
>> find a failing itapdly on the first couple of tuning
>> iterations, but eventually does. It has been observed that
>> the tuning algorithm does not need to loop more than 10
>> times before finding a failing itapdly.
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
> 
> Seems to have compile errors. Looks like 'dev' lines belong in
> next patch.
> 
> drivers/mmc/host/sdhci_am654.c: In function ‘sdhci_am654_calculate_itap’:
> drivers/mmc/host/sdhci_am654.c:453:24: error: unused variable ‘dev’ [-Werror=unused-variable]
>    453 |         struct device *dev = mmc_dev(host->mmc);
>        |                        ^~~
> drivers/mmc/host/sdhci_am654.c: In function ‘sdhci_am654_do_tuning’:
> drivers/mmc/host/sdhci_am654.c:508:24: error: unused variable ‘dev’ [-Werror=unused-variable]
>    508 |         struct device *dev = mmc_dev(host->mmc);
>        |                        ^~~
> drivers/mmc/host/sdhci_am654.c: In function ‘sdhci_am654_platform_execute_tuning’:
> drivers/mmc/host/sdhci_am654.c:553:24: error: unused variable ‘dev’ [-Werror=unused-variable]
>    553 |         struct device *dev = mmc_dev(host->mmc);
>        |                        ^~~
> cc1: all warnings being treated as errors

ok, will move to second patch.

> 
>> ---
>> Changes since v1:
>> - Change logic in patch 1/2 from using recursive aproach
>>    to calling a function iteratively for retuning
>> ---
>>   drivers/mmc/host/sdhci_am654.c | 54 ++++++++++++++++++++++++++--------
>>   1 file changed, 42 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>> index 64e10f7c9faa3..612f29fd7dfef 100644
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
> 
> Could use a comment explaining tuning_loop usage.

Sure no problem, will add.
> 
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
>> @@ -494,16 +498,18 @@ static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
>>   	return (itap > ITAPDLY_LAST_INDEX) ? ITAPDLY_LAST_INDEX >> 1 : itap;
>>   }
>>   
>> -static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>> -					       u32 opcode)
>> +static int sdhci_am654_do_tuning(struct sdhci_host *host,
>> +				 u32 opcode)
>>   {
>>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>   	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>>   	unsigned char timing = host->mmc->ios.timing;
>>   	struct window fail_window[ITAPDLY_LENGTH];
>> +	struct device *dev = mmc_dev(host->mmc);
>>   	u8 curr_pass, itap;
>>   	u8 fail_index = 0;
>>   	u8 prev_pass = 1;
>> +	int ret = 0;
>>   
>>   	memset(fail_window, 0, sizeof(fail_window));
>>   
>> @@ -532,15 +538,38 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>>   	if (fail_window[fail_index].length != 0)
>>   		fail_index++;
>>   
>> -	itap = sdhci_am654_calculate_itap(host, fail_window, fail_index,
>> -					  sdhci_am654->dll_enable);
>> +	ret = sdhci_am654_calculate_itap(host, fail_window, fail_index,
>> +					 sdhci_am654->dll_enable);
>>   
>> -	sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
>> +	return ret;
> 
> Kernel style is to return directly i.e.
> 
> 	return sdhci_am654_calculate_itap(host, fail_window, fail_index, sdhci_am654->dll_enable);
> 
> then don't need ret.

Will fix.

> 
>> +}
>>   
>> -	/* Save ITAPDLY */
>> -	sdhci_am654->itap_del_sel[timing] = itap;
>> +static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>> +					       u32 opcode)
>> +{
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>> +	unsigned char timing = host->mmc->ios.timing;
>> +	struct device *dev = mmc_dev(host->mmc);
>> +	int itapdly;
>> +	int ret = 0;
>>   
>> -	return 0;
>> +	itapdly = sdhci_am654_do_tuning(host, opcode);
>> +
>> +	while (sdhci_am654->tuning_loop < RETRY_TUNING_MAX && itapdly < 0) {
>> +		sdhci_am654->tuning_loop++;
>> +		itapdly = sdhci_am654_do_tuning(host, opcode);
>> +	}
> 
> Better to try to have sdhci_am654_do_tuning() appear only once
> e.g. something like:
> 
> 	do {
> 		itapdly = sdhci_am654_do_tuning(host, opcode);
> 		if (itapdly >= 0)
> 			break;
> 	} while (++sdhci_am654->tuning_loop < RETRY_TUNING_MAX);
> 

I generally do not like using do while loops, but in this case
it is the more appropriate solution, thanks, will fix.

> 
>> +
>> +	if (itapdly >= 0) {
>> +		sdhci_am654_write_itapdly(sdhci_am654, itapdly, sdhci_am654->itap_del_ena[timing]);
>> +		/* Save ITAPDLY */
>> +		sdhci_am654->itap_del_sel[timing] = itapdly;
>> +	} else {
>> +		ret = -1;
>> +	}
> 
> It is easier to read if the error path is separate e.g.
> 
> 	if (itapdly < 0)
> 		return -1;
> 
> 	sdhci_am654_write_itapdly(sdhci_am654, itapdly, sdhci_am654->itap_del_ena[timing]);
> 	/* Save ITAPDLY */
> 	sdhci_am654->itap_del_sel[timing] = itapdly;
> 
> 	return 0;
> 
> Doesn't need ret then either.


ok, yes this looks cleaner, thanks.

> 
>> +
>> +	return ret;
>>   }
>>   
>>   static const struct sdhci_ops sdhci_am654_ops = {
>> @@ -908,6 +937,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>>   		goto err_pltfm_free;
>>   	}
>>   
>> +	sdhci_am654->tuning_loop = 0;
> 
> It is a bit arbitrary having this at probe time.  Something like
> putting it in an mmc card_init callback might make more sense?

Sure I can move this. Thanks for reviewing!
~ Judith

> 
>>   	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
>>   
>>   	pm_runtime_get_noresume(dev);
> 

