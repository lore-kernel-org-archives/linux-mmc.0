From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: delete packed command support
Date: Mon, 21 Nov 2016 15:02:32 +0100
Message-ID: <CAPDyKFrW+Jge-Kd=PhRJvHG1Y==MMYinXxgHM1ySSG8gOx3tyA@mail.gmail.com>
References: <1479722937-19551-1-git-send-email-linus.walleij@linaro.org>
 <2697103.lML87IM8sj@wuerfel> <d0722644-2922-b580-9bfe-01dd3c38ec67@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35339 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753088AbcKUOJh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Nov 2016 09:09:37 -0500
Received: by mail-wm0-f50.google.com with SMTP id a197so149051082wmd.0
        for <linux-mmc@vger.kernel.org>; Mon, 21 Nov 2016 06:09:36 -0800 (PST)
In-Reply-To: <d0722644-2922-b580-9bfe-01dd3c38ec67@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-mmc <linux-mmc@vger.kernel.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Namjae Jeon <namjae.jeon@samsung.com>, Maya Erez <qca_merez@qca.qualcomm.com>, Luca Porzio <lporzio@micron.com>, Alex Lemberg <Alex.Lemberg@sandisk.com>

On 21 November 2016 at 13:44, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 21/11/16 13:11, Arnd Bergmann wrote:
>> On Monday, November 21, 2016 11:08:57 AM CET Linus Walleij wrote:
>>> I've had it with this code now.
>>>
>>> The packed command support is a complex hurdle in the MMC/SD block
>>> layer, around 500+ lines of code which was introduced in 2013 in
>>> commits
>>>
>>> ce39f9d17c14 ("mmc: support packed write command for eMMC4.5 devices")
>>> abd9ac144947 ("mmc: add packed command feature of eMMC4.5")
>>>
>>> ...and since then it has been rotting. The original author of the
>>> code has disappeared from the community and the mail address is
>>> bouncing.
>>>
>>> For the code to be exercised the host must flag that it supports
>>> packed commands, so in mmc_blk_prep_packed_list() which is called for
>>> every single request, the following construction appears:
>>>
>>> u8 max_packed_rw = 0;
>>>
>>> if ((rq_data_dir(cur) == WRITE) &&
>>>     mmc_host_packed_wr(card->host))
>>>         max_packed_rw = card->ext_csd.max_packed_writes;
>>>
>>> if (max_packed_rw == 0)
>>>     goto no_packed;
>>>
>>> This has the following logical deductions:
>>>
>>> - Only WRITE commands can really be packed, so the solution is
>>>   only half-done: we support packed WRITE but not packed READ.
>>>   The packed command support has not been finalized by supporting
>>>   reads in three years!
>>
>> Packed reads don't make a lot of sense, there is very little
>> for an MMC to optimize in reads that it can't already do without
>> the packing. For writes, packing makes could be an important
>> performance optimization, if the eMMC supports it.
>>
>> I've added Luca Porzio  and Alex Lemberg to Cc. I think they
>> are subscribed to the list already, but it would be good to
>> get some estimate from them too about how common the packed
>> write support is on existing hardware from their respective
>> employers before we kill it off.
>>
>> If none of Samsung/Micron/Sandisk are currently shipping
>> devices that support eMMC-4.5 packed commands but don't
>> support the eMMC-5.1 command queuing (which IIRC is a more
>> general way to achieve the same), we probably don't need to
>> worry about it too much.
>>
>>> - mmc_host_packed_wr() is just a static inline that checks
>>>   host->caps2 & MMC_CAP2_PACKED_WR. The problem with this is
>>>   that NO upstream host sets this capability flag! No driver
>>>   in the kernel is using it, and we can't test it. Packed
>>>   command may be supported in out-of-tree code, but I doubt
>>>   it. I doubt that the code is even working anymore due to
>>>   other refactorings in the MMC block layer, who would
>>>   notice if patches affecting it broke packed commands?
>>>   No one.
>>
>> This is a very good indication that it's not really used.
>> It would be useful to also check out the Android AOSP
>> kernel tree to see if it's in there, if anything important
>> supports packed commands, it's probably in there.
>>
>>> - There is no Device Tree binding or code to mark a host as
>>>   supporting packed read or write commands, just this flag
>>>   in caps2, so for sure there are not any DT systems using
>>>   it either.
>>>
>>> It has other problems as well: mmc_blk_prep_packed_list() is
>>> speculatively picking requests out of the request queue with
>>> blk_fetch_request() making the MMC/SD stack harder to convert
>>> to the multiqueue block layer. By this we get rid of an
>>> obstacle.
>
> SDHCIv4 has a feature (ADMA3) which is slightly similar to packed
> commands but it does not require card support.
>
> Why is it a problem for blk-mq to allow some extra requests to
> pick from for packing?
>

In blk-mq, requests don't get picked from the queue, but instead those
gets "pushed" to the block device driver.

First, to support packing, it seems like we would need to specify a
queue-depth > 1, more or less lie to blk-mq layer about the device's
capability. Okay, we can do that. But..

I also believe, the implementation would become really complex, as you
would need to "hold" the first write request, while waiting for a
second to arrive. Then for how long shall you hold it? And then what
if you are unlucky so the next is read request, thus you can't pack
them. The solution will be suboptimal, won't it?

Perhaps Linus can add something, or confirm?

Kind regards
Uffe
