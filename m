From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v12] mmc: support BKOPS feature for eMMC
Date: Mon, 17 Sep 2012 19:38:06 +0900
Message-ID: <5056FD8E.5090200@samsung.com>
References: <5056E25A.6070207@samsung.com> <m3wqztx7op.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:46053 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306Ab2IQKiX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Sep 2012 06:38:23 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MAH00MZNPJU5R70@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 17 Sep 2012 19:38:21 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MAH00DBIPJXAQB0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 17 Sep 2012 19:38:21 +0900 (KST)
In-reply-to: <m3wqztx7op.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Maya Erez <merez@codeaurora.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Adrian Hunter <adrian.hunter@intel.com>, Per FORLIN <per.forlin@stericsson.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, Minchan Kim <minchan@kernel.org>

Dear Chris,

On 09/17/2012 07:30 PM, Chris Ball wrote:
> Hi Jaehoon,
> 
> On Mon, Sep 17 2012, Jaehoon Chung wrote:
>> @@ -2334,7 +2471,13 @@ int mmc_suspend_host(struct mmc_host *host)
>>  	mmc_bus_get(host);
>>  	if (host->bus_ops && !host->bus_dead) {
>>  
>> -		if (host->bus_ops->suspend)
>> +		if (host->bus_ops->suspend) {
>> +			if (mmc_card_doing_bkops(host->card)) {
>> +				err = mmc_stop_bkops(host->card);
>> +				if (err)
>> +					goto out;
>> +			}
>> +		}
>>  			err = host->bus_ops->suspend(host);
>>  
>>  		if (err == -ENOSYS || !host->bus_ops->resume) {
> 
> Something's gone very wrong with the closing brace here.  Maybe you want
> the closing brace to be a line later than it is?
Sorry. you're right. it's my mistake. I will fix this.

Best Regards,
Jaehoon Chung
> 
> Thanks,
> 
> - Chris.
> 

