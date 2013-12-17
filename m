From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: max_discard anomaly on certain Sandisk eMMC
Date: Tue, 17 Dec 2013 10:27:23 -0700
Message-ID: <52B0897B.5010700@wwwdotorg.org>
References: <52AB8DA2.9000001@wwwdotorg.org> <CAA+hA=R3wnbuJrJQhfG9PQEHrwE9nrwg_+xSpyXryOeM2Wtwcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAA+hA=R3wnbuJrJQhfG9PQEHrwE9nrwg_+xSpyXryOeM2Wtwcw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dong Aisheng <dongas86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 12/17/2013 02:25 AM, Dong Aisheng wrote:
> Hi Stephen,
> 
> On Sat, Dec 14, 2013 at 6:43 AM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>> On one of my eMMC devices, I see the following results from calling
>> mmc_do_calc_max_discard() with various parameters:
>>
>> [    3.057263] MMC_DISCARD_ARG max_discard 1
>> [    3.057266] MMC_ERASE_ARG   max_discard 4096
>> [    3.057267] MMC_TRIM_ARG    max_discard 1
>>
>> This causes mmc_calc_max_discard() to return 1, which makes the discard
>> IOCTL extremely slow.
>>
> 
> IMX met the similar issue.
> http://www.spinics.net/lists/linux-mmc/msg23375.html
> It's caused by the max_discard_to supported by host is too small.
> 
> I submitted the fix patches:
> http://www.spinics.net/lists/arm-kernel/msg294924.html
> Please see if it helps for you, especially patch #5.
> It could increase the max_discard_to if Tegra has same problem.

Thanks for the pointer!

Yes, Tegra has SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK set, and has a max
clock of 208MHz specified in HW, yet we only run the HW at 48MHz
upstream, since we haven't actually implemented any of the
advanced/faster transfer rates yet. Hence that patch does avoid/solve
the issue on 2 of my boards.

However, the patch doesn't solve the problem on 2 other boards, since
the eMMC device on those boards specifies a much larger timeout, which
still causes max_discard to be set to 0. It sounds like the real
solution is what was discussed elsewhere in this thread; to use command
polling for erases?

Even on the boards where your patch solves the problem, isn't it just a
temporary measure; as soon as we upstream the changes to enable the
faster transfer modes, we'll have a faster SDCLK, and hence again be
limited in the discard size, perhaps down to a single sector again.

(Incidentally, I think the code should be limiting to a single erase
block, not a single sector. I'll send a separate patch to fix that, and
Cc everyone here).
