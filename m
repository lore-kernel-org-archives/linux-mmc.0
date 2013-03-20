From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] mmc: Use runtime pm for blkdevice
Date: Wed, 20 Mar 2013 22:58:25 +0100
Message-ID: <CAPDyKFqgo+zG9C7Do-7sE9iJxN8my70ZGPKK4b8UBx24sxP+Ew@mail.gmail.com>
References: <ED64882F200EF5419CDAC2E6B5C4B3A2097FC4412E@SC-VEXCH1.marvell.com>
	<25B60CDC2F704E4E9D88FFD52780CB4C0BDE9E0DE9@SC-VEXCH1.marvell.com>
	<CADz5_gLDMUYNEz32z+BANYdDid5ANPx5t48m=1bgTDjV52FK3A@mail.gmail.com>
	<CAPDyKFoHXMkDhmGHQJ88FvT1kv888y8QYBpz0uXMm8Yyk7ZheQ@mail.gmail.com>
	<CADz5_gKqDvgP-uOpjsPk6zPo0XC9YdM0nTwCDUucO+dhRYwj_g@mail.gmail.com>
	<CADz5_gLiwusyVHehA6G0BkTgxfs31T=FALmQRv1GPaxH_Xe-mA@mail.gmail.com>
	<CAPDyKFoPxQLg+U6=rp+wTnTyfLDbwMd5orX=-Kw2Qp7nhpuSsg@mail.gmail.com>
	<5142A105.3090505@codeaurora.org>
	<CAPDyKFr0UT1aPxhg69hicC6xBHoMPwfNVP688gjoJQMZrPspzw@mail.gmail.com>
	<5149D943.8030903@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:45509 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348Ab3CTV60 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Mar 2013 17:58:26 -0400
Received: by mail-vc0-f170.google.com with SMTP id lf10so1807058vcb.29
        for <linux-mmc@vger.kernel.org>; Wed, 20 Mar 2013 14:58:25 -0700 (PDT)
In-Reply-To: <5149D943.8030903@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: Kevin Liu <keyuan.liu@gmail.com>, Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Johan Rudholm <johan.rudholm@stericsson.com>

On 20 March 2013 16:44, Sujit Reddy Thumma <sthumma@codeaurora.org> wrote:
>>>> According the eMMC spec I can't see any requirement that the bus clock
>>>> needs to be on while a BKOPS is running. Moreover it is clearly stated
>>>> it is allowed to gate the bus clock for a device which indicates busy.
>>>> So, I can't see that this is needed.
>>>>
>>>
>>> What if host is aggressive and wants to keep eMMC in sleep-mode and turn
>>> off
>>> VCC regulator during runtime power management? I believe that eMMC card
>>> needs VCC supply as well in addition to VCCQ to carry out BKOPS. Do you
>>> think that the block device also needs to take a reference for VCC
>>> regulator
>>> while BKOPS is started in runtime suspend of block device?
>>
>>
>> What you are thinking of would be exactly the same scenario as doing
>> "mmc_suspend_host" from a host runtime suspend callback, which have
>> been discussed here earlier. Right now, no up-streamed host driver is
>> doing this and I would guess it would never happen either. Anyway,
>> still worth to consider somehow.
>
>
> If any driver wants to implement this then the runtime PM code would be
> refactored again. So I guess we might want to think about this now itself?

Refactored, no.

It is just a new feature that needs to be added, should be a rather
simple patch. Since this kind of code has not been upstreamed for your
host driver I did not consider it in this initial step. Do you want me
to create an additional patch on top of this patchset? I can help out
if you like.

>
> What about SD cards? For SD cards the runtime PM is not doing any advantage
> but instead waste cpu cycles with a timer interrupt and running noop runtime
> PM callbacks? I guess allowing to power off cards in such cases would have
> decent power savings.

We will waste some cpu cycles, true.

Do you think that will have bad impact on performance? In that case
why do we even bother doing runtime PM in host drivers and in many
other places in the kernel? Of course we could optmize the code and
only enable runtime PM if there are a corresponding runtime pm
callbacks implemented in the bus_ops, but is it needed?

>
>
>>
>> Please have a look at below thread to find the answers to your questions:
>> http://thread.gmane.org/gmane.linux.kernel.mmc/19444/focus=19443
>>
>
> Thanks a lot. I have missed this discussion :(
> I have some comments on the possible solutions:
>
> "In mmc bus_ops runtime callback, do a pm_runtime_get_sync("host plf
> device"), and vice verse in the runtime resume callback. This will
> prevent the host driver from entering runtime power save sate while
> for example doing BKOPS, thus preventing your host driver from doing
> mmc_suspend_host while BKOPS is running"
>
> [Sujit] In addition, probably we can allow host to turn off the clocks while
> carrying out BKOPS. But, how can we know whether card is done with BKOPS and
> is idle so that we can call mmc_suspend_host()?

We are then going into details about how to implement IDLE BKOPS,
which is a bit out of scope for this patch, but let me try to comment
anyway.

The initial patch for BKOPS could skip your consideration, and just
check for BKOPS complete once runtime suspend callback gets called.
This will then be rather simple to implement and work for all cases
but yours. I realize that a new blk request will be needed to move out
from BKOPS state then.

The next step could be to schedule a timer/work when issuing BKOPS,
that polls for completion. I belive it should be rather simple to
extend the runtime pm callbacks with this support, right?

>
> "Move mmc_suspend|resume_host from your host runtime callbacks, into
> the bus_ops runtime callbacks. Typically, when no BKOPS is needed
> mmc_suspend_host can be done."
>
> [Sujit] Doesn't it look like we are establishing parent child relationship
> here? If the card has nothing to do, suspend the host?

Well, the naming of these functions are not correct. It is not the
host that actually gets suspended, it is the card.

Right now these functions happens to be called when a host enters
suspend though, which indeed is also kind of strange. It would make
more sense to handle card suspend from the mmc/sdio bus instead; but
let's leave that for a separate discussion. :-)

I also assume that if your host driver runtime pm callbacks calls
mmc_suspend|resume_host, your host driver system suspend|resume
callbacks must not - otherwise you will have races! Instead upper
layers like a power domain, must force your device into runtime
suspend when entering system suspend and vice verse when doing system
resume. These issues exists with or without my patches.


>
>
> --
> Regards,
> Sujit

Thanks a lot for comment, Sujit!

Kind regards
Ulf Hansson
