From: Yisheng Xie <xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 00/27] kill devm_ioremap_nocache
Date: Wed, 3 Jan 2018 14:42:14 +0800
Message-ID: <e9f6805c-2dd7-f9c6-d615-5e25cff241a3@huawei.com>
References: <1514026525-32538-1-git-send-email-xieyisheng1@huawei.com>
 <20171223134831.GB10103@kroah.com>
 <f7632cf5-2bcc-4d74-b912-3999937a1269@roeck-us.net>
 <c28ac0bc-8bd2-3dce-3167-8c0f80ec601e@c-s.fr>
 <6c0ade63-f4d3-d44d-c622-b091eb2ba902@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6c0ade63-f4d3-d44d-c622-b091eb2ba902-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: christophe leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, starvik-VrBV9hrLPhE@public.gmane.org, jesper.nilsson-VrBV9hrLPhE@public.gmane.org, tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org, shorne-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ysxie-H32Fclmsjq1BDgjK7y7TUQ@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, richard-/L3Ra7n9ekc@public.gmane.org, marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, industrypack-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

+ cris/ia64/mn10300/openrisc maintainers

On 2017/12/25 9:09, Yisheng Xie wrote:
> hi Christophe and Greg,
> 
> On 2017/12/24 16:55, christophe leroy wrote:
>>
>>
>> Le 23/12/2017 à 16:57, Guenter Roeck a écrit :
>>> On 12/23/2017 05:48 AM, Greg KH wrote:
>>>> On Sat, Dec 23, 2017 at 06:55:25PM +0800, Yisheng Xie wrote:
>>>>> Hi all,
>>>>>
>>>>> When I tried to use devm_ioremap function and review related code, I found
>>>>> devm_ioremap and devm_ioremap_nocache is almost the same with each other,
>>>>> except one use ioremap while the other use ioremap_nocache.
>>>>
>>>> For all arches?  Really?  Look at MIPS, and x86, they have different
>>>> functions.
>>>>
>>>
>>> Both mips and x86 end up mapping the same function, but other arches don't.
>>> mn10300 is one where ioremap and ioremap_nocache are definitely different.
>>
>> alpha: identical
>> arc: identical
>> arm: identical
>> arm64: identical
>> cris: different        <==
>> frv: identical
>> hexagone: identical
>> ia64: different        <==
>> m32r: identical
>> m68k: identical
>> metag: identical
>> microblaze: identical
>> mips: identical
>> mn10300: different     <==
>> nios: identical
>> openrisc: different    <==
>> parisc: identical
>> riscv: identical
>> s390: identical
>> sh: identical
>> sparc: identical
>> tile: identical
>> um: rely on asm/generic
>> unicore32: identical
>> x86: identical
>> asm/generic (no mmu): identical
> 
> Wow, that's correct, sorry for I have just checked the main archs, I means
> x86,arm, arm64, mips.
> 
> However, I stall have no idea about why these 4 archs want different ioremap
> function with others. Drivers seems cannot aware this? If driver call ioremap
> want he really want for there 4 archs, cache or nocache?

Could you please help about this? it is out of my knowledge.

Thanks
Yisheng

> 
>>
>> So 4 among all arches seems to have ioremap() and ioremap_nocache() being different.
>>
>> Could we have a define set by the 4 arches on which ioremap() and ioremap_nocache() are different, something like HAVE_DIFFERENT_IOREMAP_NOCACHE ?
> 
> Then, what the HAVE_DIFFERENT_IOREMAP_NOCACHE is uesed for ?
> 
> Thanks
> Yisheng
>>
>> Christophe
>>
>>>
>>> Guenter
>>>
>>>>> While ioremap's
>>>>> default function is ioremap_nocache, so devm_ioremap_nocache also have the
>>>>> same function with devm_ioremap, which can just be killed to reduce the size
>>>>> of devres.o(from 20304 bytes to 18992 bytes in my compile environment).
>>>>>
>>>>> I have posted two versions, which use macro instead of function for
>>>>> devm_ioremap_nocache[1] or devm_ioremap[2]. And Greg suggest me to kill
>>>>> devm_ioremap_nocache for no need to keep a macro around for the duplicate
>>>>> thing. So here comes v3 and please help to review.
>>>>
>>>> I don't think this can be done, what am I missing?  These functions are
>>>> not identical, sorry for missing that before.
> 
> Never mind, I should checked all the arches, sorry about that.
> 
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>>
>>>
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> ---
>> L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
>> https://www.avast.com/antivirus
>>
>>
>> .
>>
> 
> 
> .
> 
