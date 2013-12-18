From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] mmc: core: don't decrement qty when calculating max_discard
Date: Wed, 18 Dec 2013 09:36:23 -0700
Message-ID: <52B1CF07.7050907@wwwdotorg.org>
References: <1387303344-11802-1-git-send-email-swarren@wwwdotorg.org> <52B1822F.8080404@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52B1822F.8080404-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Dong Aisheng <dongas86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 12/18/2013 04:08 AM, Adrian Hunter wrote:
> On 17/12/13 20:02, Stephen Warren wrote:
>> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>
>> In mmc_do_calc_max_discard(), if any value has been assigned to qty,
>> that value must have passed the timeout checks in the loop. Hence,
>> qty is the maximum number of erase blocks that fit within the timeout,
>> not the first value that does not fit into the timeout. In turn, this
>> means we don't need any special case for (qty == 1); any value of qty
>> needs to be multiplied by the card's erase shift, and we don't need to
>> decrement qty before doing so.
>>
>> Without this patch, on the NVIDIA Tegra Cardhu board, the loops result
>> in qty == 1, which is immediately returned. This causes discard to
>> operate a single sector at a time, which is chronically slow. With this
>> patch in place, discard operates a single erase block at a time, which
>> is reasonably fast.
...
> The quantity is decreased by 1 to account for the fact that the erase can
> cross the boundary between 1 erase block and another. i.e. even though the
> size is 1 erase block it touches 2 erase blocks.

Don't erases have to be aligned to the erase block alignment; surely
that's what the eMMC's preferred erase alignment is all about?

If that isn't the case, a comment in the code would be extremely useful...
