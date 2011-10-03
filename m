From: J Freyensee <james_p_freyensee@linux.intel.com>
Subject: Re: slow eMMC write speed
Date: Mon, 03 Oct 2011 14:00:37 -0700
Message-ID: <4E8A2275.3050009@linux.intel.com>
References: <1680748273.3852.1317673156420.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17070 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755033Ab1JCUwR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Oct 2011 16:52:17 -0400
In-Reply-To: <1680748273.3852.1317673156420.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <awarkentin@vmware.com>
Cc: Praveen G K <praveen.gk@gmail.com>, =?UTF-8?B?UGVyIEbDtnJsaW4=?= <per.forlin@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jon Medhurst <tixy@linaro.org>, "Andrei E. Warkentin" <andrey.warkentin@gmail.com>

On 10/03/2011 01:19 PM, Andrei Warkentin wrote:
> Hi James,
>
> ----- Original Message -----
>> From: "J Freyensee"<james_p_freyensee@linux.intel.com>
>>
>> Yeah, I know I'd be doing myself a huge favor by working off of
>> mmc-next
>> (or close to it), but product-wise, my department doesn't care for
>> sustaining current platforms...yet (still trying to convince).
>>
>
> I'd suggest working on linux-mmc. You can always back-port.
>
>> So I was looking into sticking a write cache into block.c driver as a
>> parameter, so it can be turned on and off upon driver load.  Any
>> write
>> operation goes to the cache and only on a cache collision will the
>> write operation get sent to the host controller for a write.  What I
>> have working so far is just with an MMC card in an MMC slot of a
>> laptop,
>> and just bare-bones.  No general flush routine, error-handling, etc.
>>   From a couple performance measurements I did on the MMC slot using
>> blktrace/blkparse and 400MB write transactions, I was seeing huge
>> performance boost with no data corruption.  So it is not looking like
>> a
>> total hair-brained idea.  But I am still pretty far from
>> understanding
>> everything here.  And the real payoff we want to see is performance a
>> user can see on a handheld (i.e., Android) systems.
>>
>
> Interesting. Thanks for sharing. I don't want to seem silly, but how is what you're doing different from
> the page cache? The page cache certainly defers write back (and I believe this is tunable...I'm not too
> familiar yet or comfortable around the rest of blk I/O and VM).

The idea is the page cache is too generic for hand-held (i.e. Android) 
workloads.  Page cache handles regular files, directories, 
user-swappable processes, etc, and all of that has to contend with the 
resource available for the page cache.  This is specific to eMMC 
workloads.  Namely, for games and even .pdf files on an Android system 
(ARM or Intel), there are a lot of 1-2 sector writes and almost 0 reads.

But by no means am I an expert on the page cache area either.

You are certainly right that the page cache is tunable.  I briefly 
looked at this, but then I decided I need to start writing something to 
start understanding stuff.

What are your test workloads?

For the MMC tests I conducted, they were just write blasts, like writing 
200 1MB files 200 times.  I just did enough as a 'thumb' test to see if 
it's worth killing myself on an Android box...it's a little more 
challenging getting it to work on an Android system since block.c is 
*THE* driver, whereas an MMC slot on a laptop is like some peon 
extension the laptop doesn't need.

I would
> guess this wouldn't have too great of an impact on a non O_DIRECT access, and O_DIRECT access anyway have
> to bypass any caching logic.

You are correct; I've already discovered I'd need to bypass the cache on 
O_DIRECT access.

>
> A


-- 
J (James/Jay) Freyensee
Storage Technology Group
Intel Corporation
