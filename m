From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: Re: [PATCH] mmc: core: Kill block requests if card is removed
Date: Thu, 24 Nov 2011 17:01:15 +0530
Message-ID: <4ECE2B03.5000501@codeaurora.org>
References: <1320813119-24383-1-git-send-email-sthumma@codeaurora.org> <loom.20111122T210615-276@post.gmane.org> <CAFEEs1nBFFLNvRDfwFkkp5SaifmKeykS-jrEtiSHw2ahR_38Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:43528 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637Ab1KXLbX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2011 06:31:23 -0500
In-Reply-To: <CAFEEs1nBFFLNvRDfwFkkp5SaifmKeykS-jrEtiSHw2ahR_38Zg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.lkml@gmail.com>
Cc: David Taylor <dmtaylor@skytex.net>, linux-mmc@vger.kernel.org

On 11/24/2011 3:00 PM, Per Forlin wrote:
> Hi David,
>
> On Tue, Nov 22, 2011 at 9:18 PM, David Taylor<dmtaylor@skytex.net>  wrote:
>> Sujit Reddy Thumma<sthumma<at>  codeaurora.org>  writes:
>>
>>>
>>> Kill block requests when the host knows that the card is
>>> removed from the slot and is sure that subsequent requests
>>> are bound to fail. Do this silently so that the block
>>> layer doesn't output unnecessary error messages.
>>>
>>> This patch implements suggestion from Adrian Hunter,
>>> http://thread.gmane.org/gmane.linux.kernel.mmc/2714/focus=3474
>>>
>>> Signed-off-by: Sujit Reddy Thumma<sthumma<at>  codeaurora.org>
>>> ---
>>>   drivers/mmc/card/queue.c |    5 +++++
>>>   drivers/mmc/core/bus.c   |    2 ++
>>>   include/linux/mmc/card.h |    3 +++
>>>   3 files changed, 10 insertions(+), 0 deletions(-)
>>>
>>
>> Thanks, this patch worked nicely to control a seemingly endless series of
>> driver complaints when the SD card was removed during a transfer.
>>
>> The OMAP4 I'm working on has hardware assisted detection of card removal, and
>> this patch looks like it will be sufficient.
>>
> What happens if you run "dd if=/dev/zero of=/dev/mmcblk0 bs=1M
> count=1000" and during dd the card is ejected?
> When I test this, the host is claimed until the dd has tried to
> transfer all 1000MB.

That is true only when we are using >3.0 kernel.

--
Thanks,
Sujit
