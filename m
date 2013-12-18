From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: max_discard anomaly on certain Sandisk eMMC
Date: Wed, 18 Dec 2013 11:42:29 -0700
Message-ID: <52B1EC95.7070008@wwwdotorg.org>
References: <52AB8DA2.9000001@wwwdotorg.org>	<CAA+hA=R3wnbuJrJQhfG9PQEHrwE9nrwg_+xSpyXryOeM2Wtwcw@mail.gmail.com>	<52B0897B.5010700@wwwdotorg.org> <CAA+hA=Rm1b_ah1uTyps71BLjturJXDHKyWTgiU+z2ELYZKSAWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAA+hA=Rm1b_ah1uTyps71BLjturJXDHKyWTgiU+z2ELYZKSAWw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dong Aisheng <dongas86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 12/17/2013 08:32 PM, Dong Aisheng wrote:
> On Wed, Dec 18, 2013 at 1:27 AM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>> On 12/17/2013 02:25 AM, Dong Aisheng wrote:
>>> Hi Stephen,
>>>
>>> On Sat, Dec 14, 2013 at 6:43 AM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>>>> On one of my eMMC devices, I see the following results from calling
>>>> mmc_do_calc_max_discard() with various parameters:
>>>>
>>>> [    3.057263] MMC_DISCARD_ARG max_discard 1
>>>> [    3.057266] MMC_ERASE_ARG   max_discard 4096
>>>> [    3.057267] MMC_TRIM_ARG    max_discard 1
>>>>
>>>> This causes mmc_calc_max_discard() to return 1, which makes the discard
>>>> IOCTL extremely slow.
>>>>
>>>
>>> IMX met the similar issue.
>>> http://www.spinics.net/lists/linux-mmc/msg23375.html
>>> It's caused by the max_discard_to supported by host is too small.
>>>
>>> I submitted the fix patches:
>>> http://www.spinics.net/lists/arm-kernel/msg294924.html
>>> Please see if it helps for you, especially patch #5.
>>> It could increase the max_discard_to if Tegra has same problem.
>>
...
>> Even on the boards where your patch solves the problem, isn't it just a
>> temporary measure; as soon as we upstream the changes to enable the
>> faster transfer modes, we'll have a faster SDCLK, and hence again be
>> limited in the discard size, perhaps down to a single sector again.
> 
> Actually my patch is intend to fix 1) IMX incorrect max timeout issue
> 2) should not use max_clock
> to calculate max_discard_to issue for using SDCLK as timeout clock.
> The issue discussed here is a different issue that the card timeout
> may still be bigger than
> the host capability and how to use discard for such case.
> So your problem may exist if you meet some more big timeout cards.
> For IMX, when running at 50Mhz, the max timeout is more than 5s.
> It looks bigger enough currently and i tested many eMMC cards(Samsung,
> Toshiba, Sandisk, Hynix)
> and all they worked well with discard after fix.
> I don't know which eMMC cards you meet the issue and don't know what
> is Tegra max timeout.
> Just for SD3.0 cards working on 200Mhz, i observed one Toshiba
> SDHC U1 card could not do discard, since its AU erase timeout is 2s+
> which exceeds the host
> capability 1335ms. Thus discard is automatically disabled.
> But another Sandisk SDXC can still work well since it has small
> ERASE_OFFSET as 1s.

On the more recent Tegra boards, the eMMC devices appear to have an
erase timeout of 4200ms for a single erase block! That's more than the
~2600ms max controller timeout at 48MHz on Tegra:-( (that is unless
Tegra also supports more than 27 bits of timeout register)
