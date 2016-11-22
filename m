From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: delete packed command support
Date: Tue, 22 Nov 2016 09:49:26 +0100
Message-ID: <CAPDyKFqVJeurr2jZcKRMxbvEuJfttnnFz_JWjqoCvP584h_byg@mail.gmail.com>
References: <1479722937-19551-1-git-send-email-linus.walleij@linaro.org>
 <2697103.lML87IM8sj@wuerfel> <CGME20161121142337epcas2p2089bae3d66c796b0013dfe4ed09f9573@epcas2p2.samsung.com>
 <0420FC2A-518F-49D5-90A0-556A0BA5395A@sandisk.com> <22ef57c2-4e09-afaa-8349-32e4ae687c8d@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35909 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755219AbcKVIt3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2016 03:49:29 -0500
Received: by mail-wm0-f51.google.com with SMTP id g23so12730713wme.1
        for <linux-mmc@vger.kernel.org>; Tue, 22 Nov 2016 00:49:28 -0800 (PST)
In-Reply-To: <22ef57c2-4e09-afaa-8349-32e4ae687c8d@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Alex Lemberg <Alex.Lemberg@sandisk.com>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Namjae Jeon <namjae.jeon@samsung.com>, Maya Erez <qca_merez@qca.qualcomm.com>, Luca Porzio <lporzio@micron.com>

On 22 November 2016 at 04:53, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> On 11/21/2016 11:23 PM, Alex Lemberg wrote:
>> Hi,
>>
>>
>> On 11/21/16, 1:11 PM, "Arnd Bergmann" <arnd@arndb.de> wrote:
>>
>>> On Monday, November 21, 2016 11:08:57 AM CET Linus Walleij wrote:
>>>> I've had it with this code now.
>>>>
>>>> The packed command support is a complex hurdle in the MMC/SD block
>>>> layer, around 500+ lines of code which was introduced in 2013 in
>>>> commits
>>>>
>>>> ce39f9d17c14 ("mmc: support packed write command for eMMC4.5 devices")
>>>> abd9ac144947 ("mmc: add packed command feature of eMMC4.5")
>>>>
>>>> ...and since then it has been rotting. The original author of the
>>>> code has disappeared from the community and the mail address is
>>>> bouncing.
>>>>
>>>> For the code to be exercised the host must flag that it supports
>>>> packed commands, so in mmc_blk_prep_packed_list() which is called for
>>>> every single request, the following construction appears:
>>>>
>>>> u8 max_packed_rw =3D 0;
>>>>
>>>> if ((rq_data_dir(cur) =3D=3D WRITE) &&
>>>>     mmc_host_packed_wr(card->host))
>>>>         max_packed_rw =3D card->ext_csd.max_packed_writes;
>>>>
>>>> if (max_packed_rw =3D=3D 0)
>>>>     goto no_packed;
>>>>
>>>> This has the following logical deductions:
>>>>
>>>> - Only WRITE commands can really be packed, so the solution is
>>>>   only half-done: we support packed WRITE but not packed READ.
>>>>   The packed command support has not been finalized by supporting
>>>>   reads in three years!
>>>
>>> Packed reads don't make a lot of sense, there is very little
>>> for an MMC to optimize in reads that it can't already do without
>>> the packing. For writes, packing makes could be an important
>>> performance optimization, if the eMMC supports it.
>>>
>>> I've added Luca Porzio  and Alex Lemberg to Cc. I think they
>>> are subscribed to the list already, but it would be good to
>>> get some estimate from them too about how common the packed
>>> write support is on existing hardware from their respective
>>> employers before we kill it off.
>>
>> Correct, in general there is no value in using packed for Read.
>> But I can=E2=80=99t say this for all existing flash management solution.
>> The eMMC spec allows to use it for Read as well.
>
> As i know, when packed command had implemented, early eMMC had the firmwa=
re problem
> for Packed Read operation. but so I can't say Packed Read doesn't have th=
e benefit for performance.
> But Packed Write command can see the benefit for performance.

Regarding "performance", are you merely thinking about increased
throughput? With packed command we decrease the communication overhead
with the card so less commands becomes sent/received.

Or, did you also observed an improved behaviour of the card from a
garbage collect point of view? In other words also a decreased latency
when the device is becoming more and more used?

Finally, did you compare the packed command, towards using the
asynchronous request mechanisms (using the ->pre|post_req() mmc host
ops)?

>
>>
>>>
>>> If none of Samsung/Micron/Sandisk are currently shipping
>>> devices that support eMMC-4.5 packed commands but don't
>>> support the eMMC-5.1 command queuing (which IIRC is a more
>>> general way to achieve the same), we probably don't need to
>>> worry about it too much.
>>
>> Please note that even by having eMMC-5.1 device,
>> not all chipset vendors are having HW/SW CMDQ support.
>> So they might be using packed commands instead.
>>
>>>
>>>> - mmc_host_packed_wr() is just a static inline that checks
>>>>   host->caps2 & MMC_CAP2_PACKED_WR. The problem with this is
>>>>   that NO upstream host sets this capability flag! No driver
>>>>   in the kernel is using it, and we can't test it. Packed
>>>>   command may be supported in out-of-tree code, but I doubt
>>>>   it. I doubt that the code is even working anymore due to
>>>>   other refactorings in the MMC block layer, who would
>>>>   notice if patches affecting it broke packed commands?
>>>>   No one.
>>>
>>> This is a very good indication that it's not really used.
>>> It would be useful to also check out the Android AOSP
>>> kernel tree to see if it's in there, if anything important
>>> supports packed commands, it's probably in there.
>>
>> As far as I can say from reviewing the mobile (Android)
>> platforms kernel source (from different vendors),
>> many of them are enabling Packed Commands.
>
> Actually, some shipping Samsung devices with eMMC4.5 might be used packed=
 command.
> (For Android/Tizen OS and ARTIK boards)

Thanks for sharing this information!

It seems like we need to run another round of performance
measurements, as to get some fresh number of the benefit of packed
command.
I would really appreciate if you could help out with that.

Kind regards
Uffe
