From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH] mmc: core: Add option to prevent eMMC sleep command
Date: Wed, 14 Dec 2011 17:48:17 +0100
Message-ID: <4EE8D351.50508@stericsson.com>
References: <1323876036-10206-1-git-send-email-ulf.hansson@stericsson.com> <000601ccba74$afdb0180$0f910480$@org> <4EE8C1FB.5080205@stericsson.com> <000c01ccba76$787f7cf0$697e76d0$@org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:53723 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755146Ab1LNQtJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Dec 2011 11:49:09 -0500
In-Reply-To: <000c01ccba76$787f7cf0$697e76d0$@org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 'Chris Ball' <cjb@laptop.org>, Per FORLIN <per.forlin@stericsson.com>, Johan RUDHOLM <johan.rudholm@stericsson.com>, 'Lee Jones' <lee.jones@linaro.org>

Subhash Jadavani wrote:
> 
>> -----Original Message-----
>> From: Ulf Hansson [mailto:ulf.hansson@stericsson.com]
>> Sent: Wednesday, December 14, 2011 9:04 PM
>> To: Subhash Jadavani
>> Cc: linux-mmc@vger.kernel.org; 'Chris Ball'; Per FORLIN; Johan RUDHOLM;
>> 'Lee Jones'
>> Subject: Re: [PATCH] mmc: core: Add option to prevent eMMC sleep
>> command
>>
>> Subhash Jadavani wrote:
>>> Why is this patch needed? Do you see any issue with eMMC sleep on
>> particular
>>> cards?
>>>
>>> Regards,
>>> Subhash
>> Suppose the eMMC is put in sleep state when doing suspend, at that
>> point
>> the kernel crashes. The kernel crash is supposed to be dumped to the
>> same eMMC by some other software than the kernel itself. But this
>> software do not have support for waking up the eMMC from sleep and is
>> thus not able to store the dump.
> 
> Ok. This means that SW still has some support to read/write eMMC. As part of
> suspend, we also deselect the card. So does that SW is capable of
> re-selecting the card and the do read/write transfer? I know this discussion
> might not be required. But still it's good to know.

Sorry, but I can't go into too much details, since this software is 
proprietary. :-)

> 
> As far as patch is concerned, it looks good. You might want to mention the
> motivation for this patch in commit text.

I fix in a V2 patch.

> 
>> Br
>> Ulf Hansson
> 
> 

