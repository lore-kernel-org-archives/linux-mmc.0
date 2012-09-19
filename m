From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 1/5] mmc: host: sdhci-s3c: Add broken-voltage DT
 property for broken voltage quirk
Date: Wed, 19 Sep 2012 20:02:37 +0900
Message-ID: <5059A64D.6000700@samsung.com>
References: <1346748609-11115-1-git-send-email-t.figa@samsung.com>
 <1587150.uFGRdL0s8e@amdc1227> <m3a9wmgvip.fsf@pullcord.laptop.org>
 <1907099.4JSZthrgh2@amdc1227> <m3627aguhl.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:34283 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852Ab2ISLC6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Sep 2012 07:02:58 -0400
In-reply-to: <m3627aguhl.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tomasz Figa <t.figa@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com, jy0922.shim@samsung.com, kgene.kim@samsung.com, thomas.abraham@linaro.org, Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

Hi,

On 09/19/2012 07:47 PM, Chris Ball wrote:
> Hi,
> 
> On Wed, Sep 19 2012, Tomasz Figa wrote:
>> We could just check if the regulator provides the capability to change the 
>> voltage.
>>
>> I don't see any direct way of querying the regulator for provided 
>> capabilities (correct me if I'm just blind), but calling 
>> regulator_count_voltages() on the regulator and checking if the returned 
>> value is 1 should be enough to assume that the regulator is fixed.
> 
> Sounds good, I agree.  Are you able to test that the obvious patch below
> works on your fixed-regulator board?
> 
> Jaehoon and Adrian, can you think of any reason why we shouldn't replace
> MMC_CAP2_BROKEN_VOLTAGE with the regulator_count_voltages() call below?
> Thanks.
I think this is better than using MMC_CAP2_BROKEN_VOLTAGE.
I tested with this..and working fine.

Best Regards,
Jaehoon Chung
> 
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 044cd01..a3cc740 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1132,7 +1132,7 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
>  		 */
>  		voltage = regulator_get_voltage(supply);
>  
> -		if (mmc->caps2 & MMC_CAP2_BROKEN_VOLTAGE)
> +		if (regulator_count_voltages(supply) == 1)
>  			min_uV = max_uV = voltage;
>  
>  		if (voltage < 0)
> 

