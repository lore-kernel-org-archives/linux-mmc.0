From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/3i v6] MMC/SD: Add callback function to detect card
Date: Fri, 22 Mar 2013 14:44:13 +0900
Message-ID: <514BEFAD.50606@samsung.com>
References: <1363758095-32378-1-git-send-email-Chang-Ming.Huang@freescale.com>
 <CAPDyKFqV4M7YzfOAvOMX5vjbw7pf1XA8tbPK+cVNVERWhox6eg@mail.gmail.com>
 <110EED8CC96DFC488B7E717A2027A27C3342D9@039-SN1MPN1-003.039d.mgd.msft.net>
 <CAPDyKFqM709s_er_mc0Gu+uh5+2GMf4sE62p_UNNwqFv9EwK7A@mail.gmail.com>
 <110EED8CC96DFC488B7E717A2027A27C335A1E@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:29832 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753989Ab3CVFoJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Mar 2013 01:44:09 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MK100LSZRXJ3U60@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 22 Mar 2013 14:44:07 +0900 (KST)
In-reply-to: <110EED8CC96DFC488B7E717A2027A27C335A1E@039-SN1MPN1-003.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

Hi,

As my understanding, You means that controller is sending CMD13 to detect the card at every time.
Right?
If card is nonremovable (eMMC), need not to send the CMD13 to card detect and actually didn't send the command.
Then how do you implement the code in get_cd?

Actually, i didn't see the any performance degrade with sdhci-s3c.c

Best Regards,
Jaehoon Chung

On 03/21/2013 12:28 PM, Huang Changming-R66093 wrote:
> In the current codes, SDHCI use the CMD13 to detect the card status. So there are many interrupt for this command, regardless of the card is absent or present.
> When the card is removed, these interrupts are still generated, which will cause the performance degrade (such as Iozone for SATA I/O pressure test).
> 
> And in the current SD/MMC stack, there is one callback "get_cd" which is used on some platforms.
> So I introduce it to SDHCI, if the driver support this callback, we first use it, instead of CMD13.
> 
> Best Regards
> Jerry Huang
> 
> 
>> -----Original Message-----
>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> Sent: Wednesday, March 20, 2013 5:29 PM
>> To: Huang Changming-R66093
>> Cc: linux-mmc@vger.kernel.org; Chris Ball
>> Subject: Re: [PATCH 1/3i v6] MMC/SD: Add callback function to detect card
>>
>> On 20 March 2013 10:04, Huang Changming-R66093 <r66093@freescale.com>
>> wrote:
>>> They have different function, Kevin's patch is for slowly removed, it
>> can't resolve the performance issue.
>>
>> Actually I am not sure what your patch is trying to solve. Kevin's patch
>> makes sense.
>>
>> Can you elaborate a bit on what performance issues that needs to be
>> considered during card removal?
>>
>>> First, we should use get_cd to get the card status, if it is not
>> supported, then use the alive to send CMD13.
>>> For the driver that supports get_cd, the system performance can upgrade.
>>> Maybe Kevin can base on this patch.
>>>
>>> Best Regards
>>> Jerry Huang
>>>
>>>
>>>> -----Original Message-----
>>>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>>>> Sent: Wednesday, March 20, 2013 4:43 PM
>>>> To: Huang Changming-R66093
>>>> Cc: linux-mmc@vger.kernel.org; Chris Ball
>>>> Subject: Re: [PATCH 1/3i v6] MMC/SD: Add callback function to detect
>>>> card
>>>>
>>>> On 20 March 2013 06:41,  <Chang-Ming.Huang@freescale.com> wrote:
>>>>> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
>>>>>
>>>>> In order to check whether the card has been removed, the function
>>>>> mmc_send_status() will send command CMD13 to card and ask the card
>>>>> to send its status register to sdhc driver, which will generate
>>>>> many interrupts repeatedly and make the system performance bad.
>>>>> From the performance test on Freescale's board (such as Iozone for
>>>>> SD), the performance will degrade about 4~6%.
>>>>>
>>>>> There is one another way to get this information, which is to read
>>>>> the register PRSSTAT and check the bit CDPL or CINS.
>>>>> If the card is present, these two bit will set to one.
>>>>> Therefore, add callback function get_cd() to check whether the card
>>>>> has been inserted/removed when the driver supports this feature.
>>>>> If the card is present, 0 will return, if the card is absent, 1
>>>>> will
>>>> return.
>>>>> If the controller will not support this feature, -ENOSYS will return.
>>>>>
>>>>> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
>>>>> Reviewed-by: Johan Rudholm <johan.rudholm@stericsson.com>
>>>>> Reviewed-by: Anton Vorontsov <cbouatmailru@gmail.com>
>>>>> CC: Chris Ball <cjb@laptop.org>
>>>>> ---
>>>>> changes for v2:
>>>>>         - when controller don't support get_cd, return -ENOSYS
>>>>>         - add the CC
>>>>> changes for v3:
>>>>>         - enalbe the controller clock in platform, instead of core
>>>>> changes for v4:
>>>>>         - move the detect code to core.c according to the new
>>>>> structure changes for v5:
>>>>>         - reviewed by Anton and Johan, add the reviewed-by.
>>>>> changes for v6:
>>>>>         - add more comment.
>>>>>
>>>>>  drivers/mmc/core/core.c |   16 ++++++++++++++--
>>>>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>>> index 08a3cf2..e225deb 100644
>>>>> --- a/drivers/mmc/core/core.c
>>>>> +++ b/drivers/mmc/core/core.c
>>>>> @@ -2280,7 +2280,7 @@ static int mmc_rescan_try_freq(struct
>>>>> mmc_host *host, unsigned freq)
>>>>>
>>>>>  int _mmc_detect_card_removed(struct mmc_host *host)  {
>>>>> -       int ret;
>>>>> +       int ret = -ENOSYS;
>>>>>
>>>>>         if ((host->caps & MMC_CAP_NONREMOVABLE) || !host->bus_ops-
>>>>> alive)
>>>>>                 return 0;
>>>>> @@ -2288,7 +2288,19 @@ int _mmc_detect_card_removed(struct mmc_host
>>>> *host)
>>>>>         if (!host->card || mmc_card_removed(host->card))
>>>>>                 return 1;
>>>>>
>>>>> -       ret = host->bus_ops->alive(host);
>>>>> +       /* First, try host-controller's card detect callback */
>>>>> +       if (host->ops->get_cd) {
>>>>> +               ret = host->ops->get_cd(host);
>>>>> +               /*
>>>>> +                * The return value from get_cd: 1 for present, 0
>>>>> + for
>>>> absent,
>>>>> +                * we need to convert it to: 1 for absent, 0 for
>>>> present.
>>>>> +                */
>>>>> +               if (ret >= 0)
>>>>> +                       ret = !ret;
>>>>> +       }
>>>>> +       /* If failed, back to the bus_ops alive() callback */
>>>>> +       if (ret < 0)
>>>>> +               ret = host->bus_ops->alive(host);
>>>>>         if (ret) {
>>>>>                 mmc_card_set_removed(host->card);
>>>>>                 pr_debug("%s: card remove detected\n",
>>>> mmc_hostname(host));
>>>>
>>>> I guess this already has been fixed by Kevin's patch below.
>>>>
>>>> http://article.gmane.org/gmane.linux.kernel.mmc/19481
>>>>
>>>>> --
>>>>> 1.7.9.5
>>>>>
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>> linux-mmc" in the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>> Kind regards
>>>> Ulf Hansson
>>>
>>>
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

