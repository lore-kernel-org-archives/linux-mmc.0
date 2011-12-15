From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 3/4 v5] SDHCI: add sdhci_get_cd callback to detect the card
Date: Thu, 15 Dec 2011 19:04:10 +0900
Message-ID: <4EE9C61A.30103@samsung.com>
References: <1323829093-29655-1-git-send-email-r66093@freescale.com>
 <144B2D54-4027-4815-833F-C5D91626382B@marvell.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F11646CFB@039-SN1MPN1-006.039d.mgd.msft.net>
 <1A3D9F4B-2CA9-42E4-863D-F2E457D9593A@marvell.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F1164F1EF@039-SN1MPN1-005.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:13794 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab1LOKEN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Dec 2011 05:04:13 -0500
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LW800393PAIYUV0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 15 Dec 2011 19:04:12 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LW8004WXPAZ8580@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 15 Dec 2011 19:04:11 +0900 (KST)
In-reply-to: <8A2FC72B45BB5A4C9F801431E06AE48F1164F1EF@039-SN1MPN1-005.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: Philip Rakity <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

On 12/15/2011 03:56 PM, Huang Changming-R66093 wrote:

> 
> 
>> -----Original Message-----
>> From: Philip Rakity [mailto:prakity@marvell.com]
>> Sent: Thursday, December 15, 2011 2:42 PM
>> To: Huang Changming-R66093
>> Cc: linux-mmc@vger.kernel.org; Chris Ball
>> Subject: Re: [PATCH 3/4 v5] SDHCI: add sdhci_get_cd callback to detect
>> the card
>>
>>
>> On Dec 14, 2011, at 6:32 PM, Huang Changming-R66093 wrote:
>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Philip Rakity [mailto:prakity@marvell.com]
>>>> Sent: Wednesday, December 14, 2011 12:52 PM
>>>> To: Huang Changming-R66093
>>>> Cc: linux-mmc@vger.kernel.org; Huang Changming-R66093; Chris Ball
>>>> Subject: Re: [PATCH 3/4 v5] SDHCI: add sdhci_get_cd callback to
>>>> detect the card
>>>>
>>>>
>>>> On Dec 13, 2011, at 6:18 PM, <r66093@freescale.com> wrote:
>>>>
>>>>> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
>>>>>
>>>>> Add callback function sdhci_get_cd to detect the card.
>>>>> And one new callback added to implement the card detect in sdhci
>>>> struncture.
>>>>> If special platform has the card detect callback, it will return the
>>>>> card state, the value zero is for absent cardi and one is for
>>>>> present
>>>> card.
>>>>> If the controller don't support card detect, sdhci_get_cd will
>>>>> return -
>>>> ENOSYS.
>>>>>
>>>>> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
>>>>> CC: Chris Ball <cjb@laptop.org>
>>>>> ---
>>>>> changes for v2:
>>>>> 	- when controller don't support get_cd, return -ENOSYS
>>>>> 	- add new callback for sdhci to detect the card
>>>>> 	- add the CC
>>>>> changes for v3:
>>>>> 	- use pin_lock only when get_cd defined changes for v4:
>>>>> 	- enalbe the controller clock in platform, instead of core changes
>>>>> for v5:
>>>>> 	- remove the copyright
>>>>>
>>>>> drivers/mmc/host/sdhci.c |   21 ++++++++++++++++++++++
>>>>> drivers/mmc/host/sdhci.h |    2 ++
>>>>> 2 files changed, 23 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>>> index
>>>>> 6d8eea3..fbe2f46 100644
>>>>> --- a/drivers/mmc/host/sdhci.c
>>>>> +++ b/drivers/mmc/host/sdhci.c
>>>>> @@ -1518,6 +1519,26 @@ static int sdhci_get_ro(struct mmc_host *mmc)
>>>>> 	return ret;
>>>>> }
>>>>>
>>>>> +/* Return values for the sdjco_get_cd callback:
>>>>> + *   0 for a absent card
>>>>> + *   1 for a present card
>>>>> + *   -ENOSYS when not supported (equal to NULL callback)
>>>>> + */
>>>>> +static int sdhci_get_cd(struct mmc_host *mmc) {
>>>>> +	struct sdhci_host *host = mmc_priv(mmc);
>>>>> +	unsigned long flags;
>>>>> +	int present = -ENOSYS;
>>>>> +
>>>>> +	if (host->ops->get_cd) {
>>>>> +		spin_lock_irqsave(&host->lock, flags);
>>>>> +		present = host->ops->get_cd(host);
>>>>> +		spin_unlock_irqrestore(&host->lock, flags);
>>>>> +	}
>>>>> +
>>>>> +	return present;
>>>>> +}
>>>>
>>>> In  static void sdhci_request(struct mmc_host *mmc, struct
>>>> mmc_request
>>>> *mrq)
>>>>
>>>> there is code below to handle broken card detect.
>>>>
>>>> 1257
>>>> 1258         /* If polling, assume that the card is always present. */
>>>> 1259         if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
>>>> 1260                 present = true;
>>>> 1261         else
>>>> 1262                 present = sdhci_readl(host, SDHCI_PRESENT_STATE)
>> &
>>>> 1263                                 SDHCI_CARD_PRESENT;
>>>>
>>>> The problem with this code is that it assumes broken card detect is
>>>> broken since the present state register cannot be read.
>>>>
>>>> would it make more sense to do something like
>>>>        if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) {
>>>> 		if (host->ops->get_cd)
>>>> 			present = present = host->ops->get_cd(host);
>>>> 		else
>>>> 			present = true;
>>>>
>>>> and adjust the code in host->ops->get_cd() to not -ENOSYS.
>>>
>>> I think we should not detect the card present state in sdhci_request
>>> function, Because if we do it, this detection will be performed with
>>> any command to card, which will down the performance.
>>>
>>> And if the quirks has SDHCI_QUIRK_BROKEN_CARD_DETECTION, that means
>>> the card is always present, We don't need to detect the card state.

I think SDHCI_QUIRK_BROKEN_CARD_DETECTION is just _assume_ "the card is present."

>>
>> currently WE do read the present state register on every request.  All
>> the above suggestion does is try to use your code
>>
>> maybe we want something like
>>>>          if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
>>>>                  present = true;
>>>>          else if (host->ops->get_cd)
>>>> 			present = present = host->ops->get_cd(host);
>>>> 	else
>>>>                  present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
>>>>                                  SDHCI_CARD_PRESENT;
>>
> I am very confused, why do we read the present state register on every request?

How long time read the present state register?

> My codes are added to the function mmc_sd_detect in file core/sd.c
> Function mmc_rescan has detect the card present state repeatedly, so I think we don't need to detect the card state on every request.
> So I think the codes to detect the card present state in sdhci_request should be removed to improve the performance.

How did you get the performance benefit? 
And mmc_rescan is repeatedly for SD-card?
If mmc_rescan is repeatedly, that reason is the below code. (just my thinking)

if (host->caps & MMC_CAP_NEEDS_POLL)
	mmc_schedule_delayed_work(&host->detect, HZ);

what is your point related with mmc_rescan?
I didn't understand yours..

Thanks,
Jaehoon Chung

> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


