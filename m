From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/1] mmc: mmc: Relax checking for switch errors after HS200
 switch
Date: Thu, 01 Dec 2016 18:18:11 +0900
Message-ID: <b878cebd-97ba-056d-76f6-f99f69368697@samsung.com>
References: <1479988969-1747-1-git-send-email-adrian.hunter@intel.com>
 <1479988969-1747-2-git-send-email-adrian.hunter@intel.com>
 <CGME20161201082033epcas4p2ea1df707c857441875114f7a144f590e@epcas4p2.samsung.com>
 <49e45a44-64ff-3898-ef44-aaef0f103ca5@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:37037 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753785AbcLAJSg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2016 04:18:36 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OHI01N821UBUAA0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 01 Dec 2016 18:18:11 +0900 (KST)
In-reply-to: <49e45a44-64ff-3898-ef44-aaef0f103ca5@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>

Hi Adrian,

On 12/01/2016 05:15 PM, Adrian Hunter wrote:
> On 24/11/16 14:02, Adrian Hunter wrote:
>> The JEDEC specification indicates CMD13 can be used after a HS200 switch
>> to check for errors. However in practice some boards experience CRC errors
>> in the CMD13 response. Consequently, for HS200, CRC errors are not a
>> reliable way to know the switch failed. If there really is a problem, we
>> would expect tuning will fail and the result ends up the same. So change
>> the error condition to ignore CRC errors in that case.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Any comments on this?

I agreed your opinion..CMD13 can't know whether switch is failed or not with CRC error.
It might just know whether HS200 is working fine or not with CRC error.

If CRC error is occurred, then user can knows when transfer some data.
Then i think it's more easier to debug than now..does it make sense?

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> 
> 
>> ---
>>  drivers/mmc/core/mmc.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 3268fcd3378d..34d30e2a09ff 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1223,7 +1223,12 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>>  	mmc_set_timing(host, MMC_TIMING_MMC_HS200);
>>  
>>  	err = mmc_switch_status(card);
>> -	if (err)
>> +	/*
>> +	 * For HS200, CRC errors are not a reliable way to know the switch
>> +	 * failed. If there really is a problem, we would expect tuning will
>> +	 * fail and the result ends up the same.
>> +	 */
>> +	if (err && err != -EILSEQ)
>>  		goto out_err;
>>  
>>  	mmc_set_bus_speed(card);
>> @@ -1387,6 +1392,14 @@ static int mmc_select_hs200(struct mmc_card *card)
>>  
>>  		err = mmc_switch_status(card);
>>  		/*
>> +		 * For HS200, CRC errors are not a reliable way to know the
>> +		 * switch failed. If there really is a problem, we would expect
>> +		 * tuning will fail and the result ends up the same.
>> +		 */
>> +		if (err == -EILSEQ)
>> +			err = 0;
>> +
>> +		/*
>>  		 * mmc_select_timing() assumes timing has not changed if
>>  		 * it is a switch error.
>>  		 */
>>
> 
> 
> 
> 

