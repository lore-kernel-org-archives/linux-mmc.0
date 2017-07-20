From: Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>
Subject: Re: [PATCH] powerpc/asm/cacheflush: Cleanup cacheflush function params
Date: Thu, 20 Jul 2017 23:01:56 +1000
Message-ID: <87h8y7gt2z.fsf@concordia.ellerman.id.au>
References: <20170720062850.2195-1-matthew.brown.dev@gmail.com> <87mv7zgwpl.fsf@concordia.ellerman.id.au> <CAMuHMdXU-R8kBs_xp7XDK0pnC5fakpghchuEPD8jtEcHLmgyHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdXU-R8kBs_xp7XDK0pnC5fakpghchuEPD8jtEcHLmgyHg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Matt Brown <matthew.brown.dev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-ide@vger.kernel.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, DRI Development <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "adi-buildroot-devel@lists.sourceforge.net" <adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial@vger.kernel.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> writes:

> On Thu, Jul 20, 2017 at 1:43 PM, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org> wrote:
>> Matt Brown <matthew.brown.dev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>>> The cacheflush prototypes currently use start and stop values and each
>>> call requires typecasting the address to an unsigned long.
>>> This patch changes the cacheflush prototypes to follow the x86 style of
>>> using a base and size values, with base being a void pointer.
>>>
>>> All callers of the cacheflush functions, including drivers, have been
>>> modified to conform to the new prototypes.
>>>
>>> The 64 bit cacheflush functions which were implemented in assembly code
>>> (flush_dcache_range, flush_inval_dcache_range) have been translated into
>>> C for readability and coherence.
>
>>> --- a/arch/powerpc/include/asm/cacheflush.h
>>> +++ b/arch/powerpc/include/asm/cacheflush.h
>>> @@ -51,13 +51,13 @@ static inline void __flush_dcache_icache_phys(unsigned long physaddr)
>>>   * Write any modified data cache blocks out to memory and invalidate them.
>>>   * Does not invalidate the corresponding instruction cache blocks.
>>>   */
>>> -static inline void flush_dcache_range(unsigned long start, unsigned long stop)
>>> +static inline void flush_dcache_range(void *start, unsigned long size)
>>>  {
>>> -     void *addr = (void *)(start & ~(L1_CACHE_BYTES - 1));
>>> -     unsigned long size = stop - (unsigned long)addr + (L1_CACHE_BYTES - 1);
>>> +     void *addr = (void *)((u32)start & ~(L1_CACHE_BYTES - 1));
>>
>> unsigned long would be nicer than u32.
>
> Indeed. That would make this work on ppc64, too.
> After which ppc64 has an identical copy (u64 = unsigned long on ppc64) below?

That was Matt's homework to notice that ;)

cheers
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
