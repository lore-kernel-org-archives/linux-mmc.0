From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: remove unused EVENT_XFER_ERROR
Date: Fri, 12 Feb 2016 19:31:44 +0800
Message-ID: <56BDC2A0.1000702@rock-chips.com>
References: <1454469964-21365-1-git-send-email-shawn.lin@rock-chips.com>
 <56B2EBE7.3030008@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:52185 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbcBLLb7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Feb 2016 06:31:59 -0500
In-Reply-To: <56B2EBE7.3030008@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 2016/2/4 14:12, Jaehoon Chung wrote:
> Hi, Shawn.
>
> On 02/03/2016 12:26 PM, Shawn Lin wrote:
>> EVENT_XFER_ERROR isn't been used now, so we can
>> remove it.
>
> If you are ok, after changing the commit message, I will apply this.
> Thanks!

Should I respin v2 to amend the commit msg? :-)

>
> Best Regards,
> Jaehoon Chung
>
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   include/linux/mmc/dw_mmc.h | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
>> index 89df7ab..b29e06e 100644
>> --- a/include/linux/mmc/dw_mmc.h
>> +++ b/include/linux/mmc/dw_mmc.h
>> @@ -36,7 +36,6 @@ enum {
>>   	EVENT_XFER_COMPLETE,
>>   	EVENT_DATA_COMPLETE,
>>   	EVENT_DATA_ERROR,
>> -	EVENT_XFER_ERROR
>>   };
>>
>>   struct mmc_data;
>>
>
>
>
>


-- 
Best Regards
Shawn Lin

