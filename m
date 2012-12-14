From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH 0/3] mmc: Signal voltage switch procedure for UHS mode (sdhci)
Date: Fri, 14 Dec 2012 23:09:32 +0800
Message-ID: <CADz5_gLCOS8=t9MBVxCo5jJCQibMG8gM-sXg1e5one1TXD+D0w@mail.gmail.com>
References: <1355482438-16836-1-git-send-email-kliu5@marvell.com>
	<CAPDyKFqWjZQkEGh2-AmOx+9+sC2GJg-J8RybOEHY9DZqCCZjbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:39195 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755524Ab2LNPJd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Dec 2012 10:09:33 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so1408934wgb.1
        for <linux-mmc@vger.kernel.org>; Fri, 14 Dec 2012 07:09:32 -0800 (PST)
In-Reply-To: <CAPDyKFqWjZQkEGh2-AmOx+9+sC2GJg-J8RybOEHY9DZqCCZjbQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Liu <kliu5@marvell.com>, linux-mmc@vger.kernel.org, cjb@laptop.org, johan.rudholm@stericsson.com, per.forlin@stericsson.com, fredrik.soderstedt@stericsson.com, dsd@laptop.org, leafy.myeh@allwinnertech.com, subhashj@codeaurora.org, prakity@nvidia.com, zhangfei.gao@gmail.com, haojian.zhuang@gmail.com, cxie4@marvell.com

2012/12/14 Ulf Hansson <ulf.hansson@linaro.org>:
> Hi Kevin,
>
> Thanks for looking into this for SDHCI.
>
> On 14 December 2012 11:53, Kevin Liu <kliu5@marvell.com> wrote:
>>
>> This patchset is based on Johan's below patch series submitted recently:
>>   mmc: core: Add mmc_power_cycle
>>   mmc: core: Add card_busy to host_ops
>>   mmc: core: Fixup signal voltage switch
>>
>> This patchset mainly update sdhci.c to co-work with Johan's above patches.
>> The first two patches are some update for the core stack with Johan's patch.
>> The third patch add the card_busy function and change the voltage_switch function in sdhci driver to work with the new code.
>>
>> Kevin Liu (3):
>>  mmc: core: enhance the code for signal voltage setting
>>  mmc: core: cycle power the card in voltage switch rather than mmc_sd_get_cid
>
> Regarding you patches on the core layer. I think it would make sense
> to instead of patching on top of Johan patchset, if needed, it is
> better that you put review comment directly on Johans patches. Would
> that be possible for you?
>

Sure, it's better to integrate related change into one patch.
I can update my patch, then Johan can just integrate my patch if he agree.
Or Johan change his patch directly if needed.

Thanks
Kevin
