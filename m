From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 0/3] mmc: Wait for card_busy before starting sdio requests
Date: Fri, 25 Sep 2015 14:35:50 +0900
Message-ID: <5604DD36.3010202@samsung.com>
References: <1442935826-16758-1-git-send-email-hdegoede@redhat.com>
 <CAPDyKFqvnVTL0pDLc8S1Ssqmy5WXR9+=uCWq8ONmgrYU=Zzoow@mail.gmail.com>
 <5603C020.80603@redhat.com>
 <CAD=FV=UacwyVcX+ZwCJ+iuhTGyr8ktOw7EiMxng8G1EmwXomJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:56139 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbbIYFfx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Sep 2015 01:35:53 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NV702ASZWVRPO50@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 25 Sep 2015 14:35:51 +0900 (KST)
In-reply-to: <CAD=FV=UacwyVcX+ZwCJ+iuhTGyr8ktOw7EiMxng8G1EmwXomJQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Arend van Spriel <arend@broadcom.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alim Akhtar <alim.akhtar@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>

Hi,

On 09/25/2015 01:04 AM, Doug Anderson wrote:
> Hi,
> 
> On Thu, Sep 24, 2015 at 2:19 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 23-09-15 23:43, Ulf Hansson wrote:
>>>
>>> On 22 September 2015 at 17:30, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Hi Ulf,
>>>>
>>>> Here is a non RFC version of my patch-set to wait for card_busy before
>>>> starting sdio requests. It is the same as the RFC version of the set,
>>>> but this time it has been tested no hardware which actually needs this
>>>> and I can confirm now that this fixes wifi on that hardware.
>>>
>>>
>>> Great! Thanks, applied for next!
>>
>>
>> Great, thanks, I guess it is too late for this to go as a fix into
>> 4.3-rcX (no worries if it is) ?
>>
>>>> This patch-set should also allow removing this dw_mmc specific fix:
>>>>
>>>>
>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/host/dw_mmc.c?id=0bdbd0e88cf6b603a2196418672715b0890fb040
>>>>
>>>> As this patch-set fixes this problem in a generic manner.
>>>
>>>
>>> Care to send a patch to remove the above hack/fix?
>>
>>
>> I do not have any hardware to test this.
>>
>> I've added Doug the original author of that patch to the Cc.
>>
>> Dough, can you test if with the patch set from this mail thread
>> (merged into mmc/next) this patch:
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/host/dw_mmc.c?id=0bdbd0e88cf6b603a2196418672715b0890fb040
>>
>> Is still necessary ? Since this patch-set fixes the same issue
>> in the mmc core I believe that this commit can be reverted now.
> 
> I'll try to find some time in the next few days to test, but I'm not
> terribly hopeful we can just revert the patch because:
> 
> 1. Only one of the two callers of dw_mci_wait_while_busy() is handled
> by your patch.  mci_send_cmd() is used internally in dw_mmc to throw
> something in the CMD register without going through the normal MMC
> path.  This is used exclusively to update the clock registers in
> dw_mmc.  I'm pretty sure this needs the wait, too.  It's always seemed
> weird / awkward to me that you need to use the CMD register to update
> clock settings in dw_mmc, but c'est la vie.
> 
> 2. If I remember correctly, we ran into other instances where non-SDIO
> cards needed the busy check.  It wasn't terribly common, but I think I
> ran into this when stress testing, but only on a few cards.  The patch
> referenced here only seems to check for SDIO commands.  As I
> understand it, to be correct, it should check for all data commands
> (other than stop or voltage change commands).  The Designware Databook
> makes no reference to only needing the wait for SDIO commands.

I agreed absolutely for Doug's comment.

Best Regards,
Jaehoon Chung

> 
> 
> ...of course, it's always possible that some of the things I saw above
> will no longer happen with all the other fixes we've done in the
> meantime (turning on voltages at the right time, adding the right
> delays, etc).
> 
> 
> Note that I've hardly looked at sdhci at all, but on SDHCI is this
> handled by the "SDHCI_DATA_INHIBIT" bits?
> 
> 
> -Doug
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

