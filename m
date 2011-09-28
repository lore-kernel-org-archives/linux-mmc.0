From: J Freyensee <james_p_freyensee@linux.intel.com>
Subject: Re: slow eMMC write speed
Date: Wed, 28 Sep 2011 12:59:05 -0700
Message-ID: <4E837C89.9020109@linux.intel.com>
References: <CAHzg1A9usWP8o3xjEq3yFn56bEqk_Qp0a8-2FJzoRZG1MqPRPA@mail.gmail.com> <CACRpkdYamRVpBbhAcgn7rXBGcgHUp7+9PCrmOUkXV1BvZ+4pDw@mail.gmail.com> <CAHzg1A9H31hWdEKR5+_p8HuA_oq6o8EkESpJ22kQ4e4oFDH8GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:64910 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753644Ab1I1Tvw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 28 Sep 2011 15:51:52 -0400
In-Reply-To: <CAHzg1A9H31hWdEKR5+_p8HuA_oq6o8EkESpJ22kQ4e4oFDH8GQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Praveen G K <praveen.gk@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On 09/28/2011 12:06 PM, Praveen G K wrote:
> On Tue, Sep 27, 2011 at 10:42 PM, Linus Walleij
> <linus.walleij@linaro.org>  wrote:
>> On Fri, Sep 23, 2011 at 7:05 AM, Praveen G K<praveen.gk@gmail.com>  wrote:
>>
>>> I am working on the block driver module of the eMMC driver (SDIO 3.0
>>> controller).  I am seeing very low write speed for eMMC transfers.  On
>>> further debugging, I observed that every 63rd and 64th transfer takes
>>> a long time.
>>
>> Are you not just seeing the card-internal garbage collection?
>> http://lwn.net/Articles/428584/
> Does this mean, theoretically, I should be able to achieve larger
> speeds if I am not using linux?

In theory in a fairy-tale world, maybe, in reality, not really.  In R/W 
performance measurements we have done, eMMC performance in products 
users would buy falls well, well short of any theoretical numbers.  We 
believe in theory, the eMMC interface should be able to support up to 
100MB/s, but in reality on real customer platforms write bandwidths (for 
example) barely approach 20MB/s, regardless if it's a Microsoft Windows 
environment or Android (Linux OS environment we care about).  So maybe 
it is software implementation issues of multiple OSs preventing higher 
eMMC performance numbers (hence the reason why I sometimes ask basic 
coding questions of the MMC subsystem- the code isn't the easiest to 
follow); however, one looks no further than what Apple has done with the 
iPad2 to see that eMMC probably just is not a good solution to use in 
the first place.  We have measured Apple's iPad2 write performance on 
*WHAT A USER WOULD SEE* being double what we see with products using 
eMMC solutions. The big difference?  Apple doesn't use eMMC at all for 
the iPad2.

So, is this a software issue? or if
> there is a way to increase the size of bounce buffers to 4MB?
>



>> Yours,
>> Linus Walleij
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
J (James/Jay) Freyensee
Storage Technology Group
Intel Corporation
