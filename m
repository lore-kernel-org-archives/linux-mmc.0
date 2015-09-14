From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] mmc: core: Don't return an error for CD/WP GPIOs when
 GPIOLIB is unset
Date: Mon, 14 Sep 2015 12:19:42 +0200
Message-ID: <55F69F3E.40301@xilinx.com>
References: <1442220993-20468-1-git-send-email-ulf.hansson@linaro.org>
 <4eff4eb075224f319fffff389e7b2423@bgmail103.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0085.outbound.protection.outlook.com ([157.56.111.85]:23842
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753881AbbINKT7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Sep 2015 06:19:59 -0400
In-Reply-To: <4eff4eb075224f319fffff389e7b2423@bgmail103.nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venu Byravarasu <vbyravarasu@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Michal Simek <michal.simek@xilinx.com>

On 09/14/2015 11:53 AM, Venu Byravarasu wrote:
> 
> 
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> owner@vger.kernel.org] On Behalf Of Ulf Hansson
>> Sent: Monday, September 14, 2015 2:27 PM
>> To: linux-mmc@vger.kernel.org; Ulf Hansson
>> Cc: Michal Simek
>> Subject: [PATCH] mmc: core: Don't return an error for CD/WP GPIOs when
>> GPIOLIB is unset
>>
>> When CONFIG_GPIOLIB is unset, its stubs will return -ENOSYS. That means
>> when the mmc core parses DT for CD/WP GPIOs via mmc_of_parse(), -
>> ENOSYS becomes propagated to the caller. Typically this means that the mmc
>> host driver fails to probe.
>>
>> As the CD/WP GPIOs are already treated as optional, let's extend that to
>> cover the case when CONFIG_GPIOLIB is unset.
>>
>> Reported-by: Michal Simek <michal.simek@xilinx.com>
>> Fixes: 16b23787fc70 ("mmc: sdhci-of-arasan: Call OF parsing for MMC")
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/mmc/core/host.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c index
>> abd933b..ad11425 100644
>> --- a/drivers/mmc/core/host.c
>> +++ b/drivers/mmc/core/host.c
>> @@ -457,7 +457,7 @@ int mmc_of_parse(struct mmc_host *host)
>>  					   0, &cd_gpio_invert);
>>  		if (!ret)
>>  			dev_info(host->parent, "Got CD GPIO\n");
>> -		else if (ret != -ENOENT)
>> +		else if (ret != -ENOENT && ret != ENOSYS)
> 
> Seems "-" is missing before "ENOSYS".
> 
>>  			return ret;
>>
>>  		/*
>> @@ -481,7 +481,7 @@ int mmc_of_parse(struct mmc_host *host)
>>  	ret = mmc_gpiod_request_ro(host, "wp", 0, false, 0,
>> &ro_gpio_invert);
>>  	if (!ret)
>>  		dev_info(host->parent, "Got WP GPIO\n");
>> -	else if (ret != -ENOENT)
>> +	else if (ret != -ENOENT && ret != ENOSYS)
> 
> Same here.


yes. With -ENOSYS it is working fine.

For v2 with this fix here is my
Tested-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

