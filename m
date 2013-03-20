From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: Re: [PATCH 0/3] mmc: Use runtime pm for blkdevice
Date: Wed, 20 Mar 2013 21:14:03 +0530
Message-ID: <5149D943.8030903@codeaurora.org>
References: <ED64882F200EF5419CDAC2E6B5C4B3A2097FC4412E@SC-VEXCH1.marvell.com> <25B60CDC2F704E4E9D88FFD52780CB4C0BDE9E0DE9@SC-VEXCH1.marvell.com> <CADz5_gLDMUYNEz32z+BANYdDid5ANPx5t48m=1bgTDjV52FK3A@mail.gmail.com> <CAPDyKFoHXMkDhmGHQJ88FvT1kv888y8QYBpz0uXMm8Yyk7ZheQ@mail.gmail.com> <CADz5_gKqDvgP-uOpjsPk6zPo0XC9YdM0nTwCDUucO+dhRYwj_g@mail.gmail.com> <CADz5_gLiwusyVHehA6G0BkTgxfs31T=FALmQRv1GPaxH_Xe-mA@mail.gmail.com> <CAPDyKFoPxQLg+U6=rp+wTnTyfLDbwMd5orX=-Kw2Qp7nhpuSsg@mail.gmail.com> <5142A105.3090505@codeaurora.org> <CAPDyKFr0UT1aPxhg69hicC6xBHoMPwfNVP688gjoJQMZrPspzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:65305 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975Ab3CTPoI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Mar 2013 11:44:08 -0400
In-Reply-To: <CAPDyKFr0UT1aPxhg69hicC6xBHoMPwfNVP688gjoJQMZrPspzw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Liu <keyuan.liu@gmail.com>, Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Johan Rudholm <johan.rudholm@stericsson.com>

>>> According the eMMC spec I can't see any requirement that the bus clock
>>> needs to be on while a BKOPS is running. Moreover it is clearly stated
>>> it is allowed to gate the bus clock for a device which indicates busy.
>>> So, I can't see that this is needed.
>>>
>>
>> What if host is aggressive and wants to keep eMMC in sleep-mode and turn off
>> VCC regulator during runtime power management? I believe that eMMC card
>> needs VCC supply as well in addition to VCCQ to carry out BKOPS. Do you
>> think that the block device also needs to take a reference for VCC regulator
>> while BKOPS is started in runtime suspend of block device?
>
> What you are thinking of would be exactly the same scenario as doing
> "mmc_suspend_host" from a host runtime suspend callback, which have
> been discussed here earlier. Right now, no up-streamed host driver is
> doing this and I would guess it would never happen either. Anyway,
> still worth to consider somehow.

If any driver wants to implement this then the runtime PM code would be 
refactored again. So I guess we might want to think about this now itself?

What about SD cards? For SD cards the runtime PM is not doing any 
advantage but instead waste cpu cycles with a timer interrupt and 
running noop runtime PM callbacks? I guess allowing to power off cards 
in such cases would have decent power savings.

>
> Please have a look at below thread to find the answers to your questions:
> http://thread.gmane.org/gmane.linux.kernel.mmc/19444/focus=19443
>

Thanks a lot. I have missed this discussion :(
I have some comments on the possible solutions:

"In mmc bus_ops runtime callback, do a pm_runtime_get_sync("host plf
device"), and vice verse in the runtime resume callback. This will
prevent the host driver from entering runtime power save sate while
for example doing BKOPS, thus preventing your host driver from doing
mmc_suspend_host while BKOPS is running"

[Sujit] In addition, probably we can allow host to turn off the clocks 
while carrying out BKOPS. But, how can we know whether card is done with 
BKOPS and is idle so that we can call mmc_suspend_host()?

"Move mmc_suspend|resume_host from your host runtime callbacks, into
the bus_ops runtime callbacks. Typically, when no BKOPS is needed
mmc_suspend_host can be done."

[Sujit] Doesn't it look like we are establishing parent child 
relationship here? If the card has nothing to do, suspend the host?


-- 
Regards,
Sujit
