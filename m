From: Dong Aisheng <dongas86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: max_discard anomaly on certain Sandisk eMMC
Date: Tue, 17 Dec 2013 17:25:41 +0800
Message-ID: <CAA+hA=R3wnbuJrJQhfG9PQEHrwE9nrwg_+xSpyXryOeM2Wtwcw@mail.gmail.com>
References: <52AB8DA2.9000001@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52AB8DA2.9000001-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Stephen,

On Sat, Dec 14, 2013 at 6:43 AM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> On one of my eMMC devices, I see the following results from calling
> mmc_do_calc_max_discard() with various parameters:
>
> [    3.057263] MMC_DISCARD_ARG max_discard 1
> [    3.057266] MMC_ERASE_ARG   max_discard 4096
> [    3.057267] MMC_TRIM_ARG    max_discard 1
>
> This causes mmc_calc_max_discard() to return 1, which makes the discard
> IOCTL extremely slow.
>

IMX met the similar issue.
http://www.spinics.net/lists/linux-mmc/msg23375.html
It's caused by the max_discard_to supported by host is too small.

I submitted the fix patches:
http://www.spinics.net/lists/arm-kernel/msg294924.html
Please see if it helps for you, especially patch #5.
It could increase the max_discard_to if Tegra has same problem.

Regards
Dong Aisheng

> For almost all my other eMMC devices, either:
>
> * Both arguments to mmc_do_calc_max_discard() yield zero. Hence, the
> discard IOCTL is not supported.
>
> * Both arguments to mmc_do_calc_max_discard() yield some reasonable
> large value. Hence, the discard IOCTL executes reasonably quickly.
>
> Do you think that TRIM_ARG result is expected, or is the eMMC firmware
> simply buggy?
>
> If I modify mmc_calc_max_discard() to simply ignore the TRIM_ARG result
> and always use the ERASE_ARG result, I see no errors when executing
> discard operations from either mke2fs, or from the blkdiscard utility. I
> have no idea if the discard operation is doing anything useful though.
>
> As an aside, another eMMC device (with same manfid/oemid/name) I have
> returns the same 1 for TRIM_ARG, but returns 0 for ERASE_ARG, and hence
> discard is disabled, so I don't see this problem:
>
> [    1.835747] MMC_DISCARD_ARG max_discard 1
> [    1.839779] MMC_ERASE_ARG   max_discard 0
> [    1.843791] MMC_TRIM_ARG    max_discard 1
>
> To solve my slow discard operations, I'm tempted to modify
> mmc_calc_max_discard() as follows:
>
> if (max_discard == 1)
>         max_discard = 0;
>
> ... but I'm not sure if that would be seen as a regression, since it'd
> disable the discard operation completely on theoretically working (but
> perhaps practically useless) systems.
>
> Alternatively, perhaps I should replace:
>
>         if (mmc_can_trim(card)) {
>                 max_trim = mmc_do_calc_max_discard(card, MMC_TRIM_ARG);
>                 if (max_trim < max_discard)
>                         max_discard = max_trim;
>
> with:
>
>         if (mmc_can_trim(card)) {
>                 max_trim = mmc_do_calc_max_discard(card, MMC_TRIM_ARG);
>                 if (max_trim > 1 && max_trim < max_discard)
>                         max_discard = max_trim;
>
> Alternatively, should I install a quirk for the specific eMMC device,
> which guards one of the changes above, or completely ignores the
> TRIM_ARG result?
>
> The eMMC device is question is:
>
> manfid = 0x45
> oemid = 0x100
> name = SEM16G
>
> Strangely, this is apparently a Sandisk eMMC device, yet there already
> exist some quirks for a set of similarly named Sandisk devices, yet they
> are triggered by manfid == 2, not 0x45. I'm not sure why Sandisk uses
> two separate manufacturer IDs...
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
