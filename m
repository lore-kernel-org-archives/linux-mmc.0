From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [RFC][PATCH] mmc: add an ioctl for erasing
Date: Mon, 31 May 2010 14:14:35 +0300
Message-ID: <4C039A1B.8040405@nokia.com>
References: <4BF68EFC.70101@nokia.com> <20100521140714.GB15070@infradead.org> <4C037731.5030301@nokia.com> <20100531084709.GA7784@infradead.org> <4C037E0D.6030708@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C037E0D.6030708@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Adrian Hunter wrote:
> Christoph Hellwig wrote:
>> On Mon, May 31, 2010 at 11:45:37AM +0300, Adrian Hunter wrote:
>>> Sorry for the slow reply, I have been away.
>>>
>>> Connecting erase to discard was rejected for performance reasons in 2008.
>>> Refer:
>>>
>>> 	http://thread.gmane.org/gmane.linux.file-systems/25378/focus=25606
>> The discard implementation changed a lot since those days.  Discard
>> requests now have their own request size limitation which is separate
>> form that for normal requests, and we also store the alignment
>> requirement for them separately.
>>
> 
> 
> I tested extensively at that time with all changes necessary to allow
> discards to produce MMC erases that work with maximum efficacy.  There was
> no performance benefit and operations like file deletion were much slower.
> 
> If connecting discard to MMC erase does not always improve performance, then
> many people will have to change their mount options to include nodiscard.
> Alternatively, if the connection is an optional configuration, then the
> ioctl won't work all the time.
> 
> The erase ioctl needs to be separate from discard, which means it can be
> made to support secure erase also.
> 

Looking at the code for BLKDISCARD, I saw BLKDISCARDZEROS which confirms
another reason that 'discard' is different to 'erase', which is that some
devices leave stale data in the discarded region i.e. no erase takes place.

So there are 2 ways that discard is slightly different semantically:
	1. discard is an optimisation - it does not have to happen whereas
	'erase' is like 'write', it is an error for it not to take place
	(if it is supported)
	2. discard does not guarantee to zero the discarded region

(A minor complication for some cards is that MMC erase will set the erased
region to all 1's or all 0's depending on the card)
