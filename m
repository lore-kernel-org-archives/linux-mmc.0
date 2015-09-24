From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/3] mmc: Wait for card_busy before starting sdio requests
Date: Thu, 24 Sep 2015 11:19:28 +0200
Message-ID: <5603C020.80603@redhat.com>
References: <1442935826-16758-1-git-send-email-hdegoede@redhat.com>
 <CAPDyKFqvnVTL0pDLc8S1Ssqmy5WXR9+=uCWq8ONmgrYU=Zzoow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56444 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752968AbbIXJTb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 24 Sep 2015 05:19:31 -0400
In-Reply-To: <CAPDyKFqvnVTL0pDLc8S1Ssqmy5WXR9+=uCWq8ONmgrYU=Zzoow@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Doug Anderson <dianders@chromium.org>
Cc: Chris Ball <chris@printf.net>, Arend van Spriel <arend@broadcom.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

On 23-09-15 23:43, Ulf Hansson wrote:
> On 22 September 2015 at 17:30, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi Ulf,
>>
>> Here is a non RFC version of my patch-set to wait for card_busy before
>> starting sdio requests. It is the same as the RFC version of the set,
>> but this time it has been tested no hardware which actually needs this
>> and I can confirm now that this fixes wifi on that hardware.
>
> Great! Thanks, applied for next!

Great, thanks, I guess it is too late for this to go as a fix into
4.3-rcX (no worries if it is) ?

>> This patch-set should also allow removing this dw_mmc specific fix:
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/host/dw_mmc.c?id=0bdbd0e88cf6b603a2196418672715b0890fb040
>>
>> As this patch-set fixes this problem in a generic manner.
>
> Care to send a patch to remove the above hack/fix?

I do not have any hardware to test this.

I've added Doug the original author of that patch to the Cc.

Dough, can you test if with the patch set from this mail thread
(merged into mmc/next) this patch:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/host/dw_mmc.c?id=0bdbd0e88cf6b603a2196418672715b0890fb040

Is still necessary ? Since this patch-set fixes the same issue
in the mmc core I believe that this commit can be reverted now.

Thanks & Regards,

Hans
