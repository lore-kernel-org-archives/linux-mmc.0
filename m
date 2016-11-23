From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: block: delete packed command support
Date: Wed, 23 Nov 2016 18:40:14 +0900
Message-ID: <a323dea9-098a-4bc8-a2e0-6faf83fa7c28@samsung.com>
References: <1479722937-19551-1-git-send-email-linus.walleij@linaro.org>
 <22ef57c2-4e09-afaa-8349-32e4ae687c8d@samsung.com>
 <CAPDyKFqVJeurr2jZcKRMxbvEuJfttnnFz_JWjqoCvP584h_byg@mail.gmail.com>
 <44199908.WIlGo4b061@wuerfel>
 <CGME20161122160654epcas2p4308e4876c07b0ceebc5ff4a66f9bbea7@epcas2p4.samsung.com>
 <CAPDyKFppA8P=KNPNp1D+9gTxTM4MN7eBJ+rdG4JzSrPRdYqYFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:53995 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933724AbcKWJkP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Nov 2016 04:40:15 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OH301EVD9J2FO90@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 23 Nov 2016 18:40:14 +0900 (KST)
In-reply-to: <CAPDyKFppA8P=KNPNp1D+9gTxTM4MN7eBJ+rdG4JzSrPRdYqYFQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Alex Lemberg <Alex.Lemberg@sandisk.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Namjae Jeon <namjae.jeon@samsung.com>, Maya Erez <qca_merez@qca.qualcomm.com>, Luca Porzio <lporzio@micron.com>

On 11/23/2016 01:06 AM, Ulf Hansson wrote:
> [...]
> 
>>>
>>> Regarding "performance", are you merely thinking about increased
>>> throughput? With packed command we decrease the communication overhead
>>> with the card so less commands becomes sent/received.
>>>
>>> Or, did you also observed an improved behaviour of the card from a
>>> garbage collect point of view? In other words also a decreased latency
>>> when the device is becoming more and more used?
>>>
>>> Finally, did you compare the packed command, towards using the
>>> asynchronous request mechanisms (using the ->pre|post_req() mmc host
>>> ops)?
>>
>> The main point of command packing is that the device can be smarter
>> about garbage collection as well as combine sub-page sized writes.
> 
> Ideally, yes! But I am not sure that is the case. Vendors would have to confirm.
> 
> By following the evolution of development of the eMMC spec one could
> make some guesses. Let me try it :-).
> 
> In the eMMC 4.5 spec, "data tag", "context ID" and "packed command"
> was added. It seems to me that "data tag" and "context ID" was
> intended to help the device to be smarter about garbage collection,
> while "packed command" is about reducing overhead.
> 
> The below is quoted from the packed command section in the spec:
> 
> "Read and write commands can be packed in groups of commands (either
> all read or all write) that transfer the data for all commands in the
> group in one transfer on the bus, to reduce overheads."
> 
>>
>> The communication overhead is nearly irrelevant in comparison,
>> and we would probably not have done anything for that.
> 
> I think we did.
> 
> And that's particularly why I am interested to see a fresh comparison
> against the async request transfer mechanism.
> 
>>
>>>>> As far as I can say from reviewing the mobile (Android)
>>>>> platforms kernel source (from different vendors),
>>>>> many of them are enabling Packed Commands.
>>>>
>>>> Actually, some shipping Samsung devices with eMMC4.5 might be used packed command.
>>>> (For Android/Tizen OS and ARTIK boards)
>>>
>>> Thanks for sharing this information!
>>>
>>> It seems like we need to run another round of performance
>>> measurements, as to get some fresh number of the benefit of packed
>>> command.
>>> I would really appreciate if you could help out with that.
>>
>> As far as I'm concerned, there are already two conclusions and
>> I don't think those measurements would help much:
>>
>> - It's a problem that none of our upstream drivers support this
>>   feature, and we really want them to do so, at least after the
>>   blk_mq change.
>>
>> - Linus' analysis is still valid: there is no regression in removing
>>   it from the traditional blk code today, anyone who has a private
>>   driver that uses it can simply revert the removal in their next
>>   private product release.

It looks like makes sense..I agreed this..

>>
>> If removing it helps us enable blk_mq support more easily, then
>> I think we can take out the packed command handling, but we have
>> to be prepared to put it back later on top of blk_mq.
>>
> 
> Thanks for the summary. This do seems like a nice approach.
> 
> Let's see what other people thinks about this.
> 
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

