From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/4 v3] MMC/core: Add f_min to mmc_power_on()
Date: Wed, 31 Oct 2012 13:21:19 +0900
Message-ID: <5090A73F.2020103@samsung.com>
References: <1351584769-16662-1-git-send-email-r66093@freescale.com>
 <CAPDyKFqM0cUkDDadm8MBK=+wHHYOSH3CVEHyiY1ybLkmPqSX7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:32814 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777Ab2JaEV0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Oct 2012 00:21:26 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MCQ00KUYPFH2BO0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 31 Oct 2012 13:21:25 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MCQ00GCWPFOSJC0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 31 Oct 2012 13:21:24 +0900 (KST)
In-reply-to: <CAPDyKFqM0cUkDDadm8MBK=+wHHYOSH3CVEHyiY1ybLkmPqSX7w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: r66093@freescale.com, linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Chris Ball <cjb@laptop.org>

On 10/31/2012 08:08 AM, Ulf Hansson wrote:
> On 30 October 2012 09:12,  <r66093@freescale.com> wrote:
>> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
>>
>> When f_init is zero, the SDHC can't work correctly. So f_min will replace
>> f_init, when f_init is zero.
>>
>> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
>> CC: Anton Vorontsov <cbouatmailru@gmail.com>
>> CC: Chris Ball <cjb@laptop.org>
>> ---
>> changes for v2:
>>         - add the CC
>> changes for v3:
>>         - enalbe the controller clock in platform, instead of core
>>
>>  drivers/mmc/core/core.c |    5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 06c42cf..9c162cd 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1319,7 +1319,10 @@ static void mmc_power_up(struct mmc_host *host)
>>          */
>>         mmc_delay(10);
>>
>> -       host->ios.clock = host->f_init;
>> +       if (host->f_init)
>> +               host->ios.clock = host->f_init;
>> +       else
>> +               host->ios.clock = host->f_min;
> 
> This should not be needed. host->f_init should never become zero, I believe.
I agree for Ulf's comment.
> 
>>
>>         host->ios.power_mode = MMC_POWER_ON;
>>         mmc_set_ios(host);
>> --
>> 1.7.9.5
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> Kind regards
> Ulf Hansson
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

