From: Jens Axboe <axboe@kernel.dk>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Tue, 01 Mar 2011 14:15:30 -0500
Message-ID: <4D6D45D2.2020900@kernel.dk>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com> <201102251321.09232.arnd@arndb.de> <4D6D3F71.4040605@kernel.dk> <201103012011.51855.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <201103012011.51855.arnd@arndb.de>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrei Warkentin <andreiw@motorola.com>, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 2011-03-01 14:11, Arnd Bergmann wrote:
> On Tuesday 01 March 2011 19:48:17 Jens Axboe wrote:
>>
>> On 2011-02-25 07:21, Arnd Bergmann wrote:
>>> On Friday 25 February 2011, Andrei Warkentin wrote:
>>>> Yup. I understand :-).  That's the strategy I'm going to follow. For
>>>> page_size-alignment/splitting I'm looking at the block layer now. Is
>>>> that the right approach or should I still submit a (cleaned up) patch
>>>> to mmc/card/block.c for that performance improvement.
>>>
>>> I guess it should live in block/cfq-iosched in the long run, but I don't
>>> know how easy it is to implement it there for test purposes.
>>
>> I don't think I saw the original patch(es) for this?
> 
> Nobody has posted one yet, only discussions. Andrei made a patch for the
> MMC block driver to split requests in some cases, but I think the
> concept has changed enough that it's probably not useful to look at
> that patch.
> 
> I think what needs to be done here is to split requests in these cases:
> 
> * Small requests should be split on flash page boundaries, where a page
> is typically 8 to 32 KB. Sending one hardware request that spans two
> partial pages can be slower than sending two requests with the same
> data, but on page boundaries.
> 
> * If a hardware transfer is limited to a few sectors, these should be
> aligned to page boundaries. E.g. assuming a 16 sector page and 32 sector
> maximum transfers, a request that spans from sector 7 to 62 should be
> split into three transfers: 7-15, 16-47 and 48-62, not 7-38 and 39-62.
> This reduces the number of page read-modify-write cycles that the drive
> does.
> 
> * No request should ever span multiple erase blocks. Most flash drives today
> have 4MB erase blocks (sometimes 1, 2 or 8), and the I/O scheduler should
> treat the erase block boundary like a seek on a hard drive. The I/O
> scheduler should try to send all sector writes of an erase block in sequence,
> but after that it can chose any other erase block to write to next.
> 
> I think if we get this logic, we can deal well with all cheap flash drives.
> The two parameters we need are the page size and the erase block size,
> which the kernel can sometimes guess, but should also be tunable in
> sysfs for devices that don't tell us or lie to the kernel about them.
> 
> I'm not sure if we want to do this for all nonrotational media, or
> add another flag to enable these optimizations. On proper SSDs that have
> an intelligent controller and enough RAM, they probably would not help
> all that much, or even make it slightly slower due to a higher number
> of separate write requests.

Thanks for the recap. One way to handle this would be to have a dm
target that ensures that requests are never built up to violate any of
the above items. Doing splitting is a little silly, when you can prevent
it from happening in the first place.

Alternatively, a queue ->merge_bvec_fn() with a settings table could
provide the same.

As this is of limited scope, I would prefer having this done via a
plugin of some sort (like a dm target).

-- 
Jens Axboe

