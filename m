From: J Freyensee <james_p_freyensee@linux.intel.com>
Subject: Re: slow eMMC write speed
Date: Wed, 28 Sep 2011 14:01:55 -0700
Message-ID: <4E838B43.5090605@linux.intel.com>
References: <CAHzg1A9usWP8o3xjEq3yFn56bEqk_Qp0a8-2FJzoRZG1MqPRPA@mail.gmail.com> <CACRpkdYamRVpBbhAcgn7rXBGcgHUp7+9PCrmOUkXV1BvZ+4pDw@mail.gmail.com> <CAHzg1A9H31hWdEKR5+_p8HuA_oq6o8EkESpJ22kQ4e4oFDH8GQ@mail.gmail.com> <4E837C89.9020109@linux.intel.com> <CAHzg1A8Cgz8DNje_We9MKJ90E4=9BDw9XzvEQU5h2et8HPHBjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33305 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752733Ab1I1Uyl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 28 Sep 2011 16:54:41 -0400
In-Reply-To: <CAHzg1A8Cgz8DNje_We9MKJ90E4=9BDw9XzvEQU5h2et8HPHBjw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Praveen G K <praveen.gk@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On 09/28/2011 01:34 PM, Praveen G K wrote:
> On Wed, Sep 28, 2011 at 12:59 PM, J Freyensee
> <james_p_freyensee@linux.intel.com>  wrote:
>> On 09/28/2011 12:06 PM, Praveen G K wrote:
>>>
>>> On Tue, Sep 27, 2011 at 10:42 PM, Linus Walleij
>>> <linus.walleij@linaro.org>    wrote:
>>>>
>>>> On Fri, Sep 23, 2011 at 7:05 AM, Praveen G K<praveen.gk@gmail.com>
>>>>   wrote:
>>>>
>>>>> I am working on the block driver module of the eMMC driver (SDIO 3.0
>>>>> controller).  I am seeing very low write speed for eMMC transfers.  On
>>>>> further debugging, I observed that every 63rd and 64th transfer takes
>>>>> a long time.
>>>>
>>>> Are you not just seeing the card-internal garbage collection?
>>>> http://lwn.net/Articles/428584/
>>>
>>> Does this mean, theoretically, I should be able to achieve larger
>>> speeds if I am not using linux?
>>
>> In theory in a fairy-tale world, maybe, in reality, not really.  In R/W
>> performance measurements we have done, eMMC performance in products users
>> would buy falls well, well short of any theoretical numbers.  We believe in
>> theory, the eMMC interface should be able to support up to 100MB/s, but in
>> reality on real customer platforms write bandwidths (for example) barely
>> approach 20MB/s, regardless if it's a Microsoft Windows environment or
>> Android (Linux OS environment we care about).  So maybe it is software
>> implementation issues of multiple OSs preventing higher eMMC performance
>> numbers (hence the reason why I sometimes ask basic coding questions of the
>> MMC subsystem- the code isn't the easiest to follow); however, one looks no
>> further than what Apple has done with the iPad2 to see that eMMC probably
>> just is not a good solution to use in the first place.  We have measured
>> Apple's iPad2 write performance on *WHAT A USER WOULD SEE* being double what
>> we see with products using eMMC solutions. The big difference?  Apple
>> doesn't use eMMC at all for the iPad2.
>
> Thanks for all the clarification.  The problem is I am seeing write
> speeds of about 5MBps on a Sandisk eMMC product and I can clearly see
> the time lost when measured between sending a command and receiving a
> data irq.  I am not sure what kind of an issue this is.  5MBps feels
> really slow but can the internal housekeeping of the card take so much
> time?

Have you tried to trace through all structs used for an MMC operation??! 
  Good gravy, there are request, mmc_queue, mmc_card, mmc_host, 
mmc_blk_request, mmc_request, multiple mmc_command and multiple 
scatterlists that these other structs use...I've been playing around on 
trying to cache some things to try and improve performance and it blows 
me away how many variables and pointers I have to keep track of for one 
operation going to an LBA on an MMC.  I keep wondering if more of the 
'struct request' could have been used, and 1/3 of these structures could 
be eliminated.  And another thing I wonder too is how much of this 
infrastructure is really needed, that when I do ask "what is this for?" 
question on the list and no one responds, if anyone else understands if 
it's needed either.

I mean, for the usual transfers it takes about 3ms to transfer
> 64kB of data, but for the 63rd and 64th transfers, it takes 250 ms.
> The thing is this is not on a file system.  I am measuring the speed
> using basic "dd" command to write directly to the block device.
>
>> So, is this a software issue? or if
>>>
>>> there is a way to increase the size of bounce buffers to 4MB?
>>>
>>
>>
>>
>>>> Yours,
>>>> Linus Walleij
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>> --
>> J (James/Jay) Freyensee
>> Storage Technology Group
>> Intel Corporation
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
J (James/Jay) Freyensee
Storage Technology Group
Intel Corporation
