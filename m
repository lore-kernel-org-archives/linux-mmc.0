From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] mmc: Prevent 1.8V switch for SD hosts that don't
 support UHS modes.
Date: Tue, 3 Apr 2012 20:58:12 -0700
Message-ID: <0CC34BD4-748D-464A-A57B-C36565B9289E@marvell.com>
References: <1331927657-2849-1-git-send-email-acooper@gmail.com>
 <CAOGqxeWdOjkSTa2N5GwCvGb02zge+66_CT=0u7upznoWVfUCcw@mail.gmail.com>
 <87r4w5ir2k.fsf@laptop.org>
 <B0C59D0E4E9BA24EB5E08604F8E228540423DF0E@sausexdag03.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:60489 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751088Ab2DDD7E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 3 Apr 2012 23:59:04 -0400
In-Reply-To: <B0C59D0E4E9BA24EB5E08604F8E228540423DF0E@sausexdag03.amd.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Alan Cooper <alcooperx@gmail.com>, Girish K S <girish.shivananjappa@linaro.org>, "Nath, Arindam" <Arindam.Nath@amd.com>, Ulf Hansson <ulf.hansson@stericsson.com>


Acked-by: Philip Rakity <prakity@marvell.com>

On Apr 3, 2012, at 8:46 PM, Nath, Arindam wrote:

> Hi,
> 
> 
>> -----Original Message-----
>> From: Chris Ball [mailto:cjb@laptop.org]
>> Sent: Tuesday, April 03, 2012 6:12 AM
>> To: Alan Cooper
>> Cc: linux-mmc@vger.kernel.org; Girish K S; Ulf Hansson; Nath, Arindam;
>> Philip Rakity
>> Subject: Re: [PATCH] mmc: Prevent 1.8V switch for SD hosts that don't
>> support UHS modes.
>> 
>> Hi Al,
>> 
>> On Mon, Apr 02 2012, Alan Cooper wrote:
>>> Still hoping for comments on the patch.
>> 
>> Thanks for the reminder; adding a few potential reviewers to CC:.
> 
> Acked-by: Arindam Nath <arindam.nath@amd.com>
> 
> Regards,
> Arindam
> 
>> 
>> - Chris.
>> 
>>> On Fri, Mar 16, 2012 at 3:54 PM, Al Cooper <acooper@gmail.com> wrote:
>>>> The driver should not try to switch to 1.8V when the SD 3.0 host
>>>> controller does not have any UHS capabilities bits set (SDR50, DDR50
>>>> or SDR104). See page 72 of "SD Specifications Part A2 SD Host
>>>> Controller Simplified Specification Version 3.00" under
>>>> "1.8V Signaling Enable". Instead of setting SDR12 and SDR25 in the
>> host
>>>> capabilities data structure for all V3.0 host controllers, only set
>> them
>>>> if SDR104, SDR50 or DDR50 is set in the host capabilities register.
>> This
>>>> will prevent the switch to 1.8V later.
>>>> 
>>>> Signed-off-by: Al Cooper <acooper@gmail.com>
>>>> ---
>>>>  drivers/mmc/host/sdhci.c |    5 +++--
>>>>  1 files changed, 3 insertions(+), 2 deletions(-)
>>>> 
>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>> index 8d66706..cdf900e 100644
>>>> --- a/drivers/mmc/host/sdhci.c
>>>> +++ b/drivers/mmc/host/sdhci.c
>>>> @@ -2762,8 +2762,9 @@ int sdhci_add_host(struct sdhci_host *host)
>>>>            mmc_card_is_removable(mmc))
>>>>                mmc->caps |= MMC_CAP_NEEDS_POLL;
>>>> 
>>>> -       /* UHS-I mode(s) supported by the host controller. */
>>>> -       if (host->version >= SDHCI_SPEC_300)
>>>> +       /* Any UHS-I mode in caps implies SDR12 and SDR25 support.
>> */
>>>> +       if (caps[1] & (SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
>>>> +                      SDHCI_SUPPORT_DDR50))
>>>>                mmc->caps |= MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25;
>>>> 
>>>>        /* SDR104 supports also implies SDR50 support */
>>>> --
>>>> 1.7.6
>> 
>> --
>> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
>> One Laptop Per Child
> 

