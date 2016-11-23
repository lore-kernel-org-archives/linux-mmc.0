From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: block: delete packed command support
Date: Wed, 23 Nov 2016 18:34:47 +0900
Message-ID: <c270399f-65a1-4b3b-24d6-e76ac83ece32@samsung.com>
References: <1479722937-19551-1-git-send-email-linus.walleij@linaro.org>
 <2697103.lML87IM8sj@wuerfel>
 <CGME20161121142337epcas2p2089bae3d66c796b0013dfe4ed09f9573@epcas2p2.samsung.com>
 <0420FC2A-518F-49D5-90A0-556A0BA5395A@sandisk.com>
 <22ef57c2-4e09-afaa-8349-32e4ae687c8d@samsung.com>
 <CAPDyKFqVJeurr2jZcKRMxbvEuJfttnnFz_JWjqoCvP584h_byg@mail.gmail.com>
 <CACRpkdZ_aaq5hA=LG5k0OM52Sx-ca8ntdpohsi8j47VH60ucNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:39244 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934636AbcKWJet (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Nov 2016 04:34:49 -0500
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OH302Q6U99UG8E0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 23 Nov 2016 18:34:47 +0900 (KST)
In-reply-to: <CACRpkdZ_aaq5hA=LG5k0OM52Sx-ca8ntdpohsi8j47VH60ucNw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alex Lemberg <Alex.Lemberg@sandisk.com>, Arnd Bergmann <arnd@arndb.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Namjae Jeon <namjae.jeon@samsung.com>, Maya Erez <qca_merez@qca.qualcomm.com>, Luca Porzio <lporzio@micron.com>

Hi Linus,

On 11/22/2016 09:49 PM, Linus Walleij wrote:
> On Tue, Nov 22, 2016 at 9:49 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 22 November 2016 at 04:53, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> 
>>>> Correct, in general there is no value in using packed for Read.
>>>> But I can’t say this for all existing flash management solution.
>>>> The eMMC spec allows to use it for Read as well.
>>>
>>> As i know, when packed command had implemented, early eMMC had the firmware problem
>>> for Packed Read operation. but so I can't say Packed Read doesn't have the benefit for performance.
>>> But Packed Write command can see the benefit for performance.
>>
>> Regarding "performance", are you merely thinking about increased
>> throughput? With packed command we decrease the communication overhead
>> with the card so less commands becomes sent/received.
>>
>> Or, did you also observed an improved behaviour of the card from a
>> garbage collect point of view? In other words also a decreased latency
>> when the device is becoming more and more used?
>>
>> Finally, did you compare the packed command, towards using the
>> asynchronous request mechanisms (using the ->pre|post_req() mmc host
>> ops)?
> 
> Packed write (and read, if we had implemented it) can only happen when
> we get a number of requests to different areas of the card.
> 
> If they are to consecutive sectors (such as with a dd-test) it will not
> improve performance, as that case is already optimized by the block
> layer by front-merging of the requests into large chunks, I guess?
> 
> Indeed commit ce39f9d17c14 mentions improvement on lmdd but not
> how it was invoked. I suspect it was invoked with random writes...

Well, I don't know those improvements was right or not..

> 
> It is important to do everything we can to improve random small writes
> though, and it seems packed command can do that.

Agreed...but i have checked with latest kernel and older version(v3.18).
I saw the random write performance with small chunk size was increased with v3.18, not v4.9-rc5.
I don't know what happens.

> 
> (...)
>>> Actually, some shipping Samsung devices with eMMC4.5 might be used packed command.
>>> (For Android/Tizen OS and ARTIK boards)
>>
>> Thanks for sharing this information!
>>
>> It seems like we need to run another round of performance
>> measurements, as to get some fresh number of the benefit of packed
>> command.
>> I would really appreciate if you could help out with that.
> 
> I would add: do it on the upstream kernel and submit the stuff needed
> to make it work for you out-of-the box.
> 
> This is on Exynos I guess?
> 
> Can we have this flag set for the Exynos host controller, and/or
> proper DT bindings to mark it as packed command enabled?

Actually, I can add the property or flags..but i think it's meaningless..
If you ask me my opinion, i don't want to add the enabling packed command at this time.

Because i didn't see the increasing performance dynamically at this time.
But i can say..when we had applied the packed command (2~3years ago.), there were some benefit to use this command.

Yes..my comments might be confused..
but i just mentioned about some Samsung guys are using packed command for their devices with eMMC4.5.
I'm not sure which kernel version they used..maybe older version.

> 
> Hell I don't even know if this is a feature that needs anything special
> from the host controller. Does it? Should we rather just enable it for all
> host controllers if the card supports packed command? I'm lost.
> 

I'm also feeling likes you...Now I'm checking about performance with all exynos devices that i have.

Best Regards,
Jaehoon Chung

> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

