From: Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [1/2] mmc: dw_mmc: set to MMC_CAP_ERASE by default
Date: Fri, 15 Jul 2016 16:08:18 +0530
Message-ID: <5788BD1A.1070302@samsung.com>
References: <1468547691-4525-1-git-send-email-jh80.chung@samsung.com>
 <CGME20160715043908epcas1p1b7e0bfd005de1f12547096ff7e184459@epcas1p1.samsung.com>
 <578868D3.4080905@samsung.com> <57886BCF.5090108@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:58630 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932668AbcGOKiq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jul 2016 06:38:46 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0OAC02TI7QWJMNC0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 15 Jul 2016 19:38:43 +0900 (KST)
In-reply-to: <57886BCF.5090108@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com



On 07/15/2016 10:21 AM, Jaehoon Chung wrote:
> On 07/15/2016 01:38 PM, Alim Akhtar wrote:
>> Hi Jaehoon
>>
>> On 07/15/2016 07:24 AM, Jaehoon Chung wrote:
>>> This flag needs to use the trim/discard/erase commands.
>>> dwmmc controller enables this flag by default.
>>>
>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
>>> ---
>>>    drivers/mmc/host/dw_mmc.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index 9fab5ed..d16de19 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -2604,6 +2604,12 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>>>        if (host->pdata->caps)
>>>            mmc->caps = host->pdata->caps;
>>>
>>> +    /*
>>> +     * Support MMC_CAP_ERASE by default.
>>> +     * It needs to use trim/discard/erase commands.
>>> +     */
>>> +    mmc->caps |= MMC_CAP_ERASE;
>>> +
>> Just a thought, probably this should be move to mmc_of_parse() and let the board/platform configure this via device-tree.
>
> I don't think so...I think best solution is supported by default.
> I didn't see the platform/board that don't need to use MMC_CAP_ERASE.
>
> If MMC_CAP_ERASE should be moved into mmc_of_parse(), it also needs to modify the almost all device-trees.
> If setting by default will have side effect,
> i will consider about abandoning this patch or adding other things to prevent side-effect. :)
>
My point was, MMC_CAP_ERASE is a generic capability not dw_mmc specific. 
Suppose some other controller wants to enable this, then they need to 
add this CAP to their files/drivers. And probably thats why 
mmc_of_parse() was introduced at common place.

Since you are adding this, lets add in a common place for a large use.
Anyway this was just a though, if you don't like this, I am ok. :-)

> Best Regards,
> Jaehoon Chung
>
>>
>>>        if (host->pdata->pm_caps)
>>>            mmc->pm_caps = host->pdata->pm_caps;
>>>
>>>
>>
>>
>
>
