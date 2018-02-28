From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4] mmc: dw_mmc: Fix the DTO/CTO timeout overflow
 calculation for 32-bit systems
Date: Wed, 28 Feb 2018 08:16:20 -0800
Message-ID: <CAD=FV=XSSpevXKO7h0s826qt7Fdo7Zzp6SrNa4VCzEgCJ-zWCA@mail.gmail.com>
References: <20180228115318.20154-1-Evgeniy.Didin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180228115318.20154-1-Evgeniy.Didin@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Evgeniy Didin <Evgeniy.Didin@synopsys.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Ulf Hansson <ulf.hansson@linaro.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Shawn Lin <shawn.lin@rock-chips.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, LKML <linux-kernel@vger.kernel.org>, linux-snps-arc@lists.infradead.org, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Feb 28, 2018 at 3:53 AM, Evgeniy Didin
<Evgeniy.Didin@synopsys.com> wrote:
> In commit 9d9491a7da2a ("mmc: dw_mmc: Fix the DTO timeout calculation") and
> commit 4c2357f57dd5 ("mmc: dw_mmc: Fix the CTO timeout calculation")
> have been made changes which cause multiply overflow for 32-bit systems.
> The broken timeout calculations leads to unexpected ETIMEDOUT errors and
> causes stacktrace splat (such as below) during normal data exchange
> with SD-card.
>
> | Running :  4M-check-reassembly-tcp-cmykw2-rotatew2.out -v0 -w1
> | -  Info: Finished target initialization.
> | mmcblk0: error -110 transferring data, sector 320544, nr 2048, cmd response
> |  0x900, card status 0x0
>
> DIV_ROUND_UP_ULL helps to escape usage of __udivdi3() from libgcc and so
> code gets compiled on all 32-bit platforms as opposed to usage
> of DIV_ROUND_UP when we may only compile stuff on a very few arches.
>
> Lets cast this multiply to u64 type which prevents overflow.
>
> Tested-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
> Reported-by: Vineet Gupta <Vineet.Gupta1@synopsys.com> # ARC STAR 9001306872 HSDK, sdio: board crashes when copying big files
> Fixes: 9d9491a7da2a ("mmc: dw_mmc: Fix the DTO timeout calculation")
> Fixes: 4c2357f57dd5 ("mmc: dw_mmc: Fix the CTO timeout calculation")
>
> Signed-off-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
>
> CC: Alexey Brodkin <abrodkin@synopsys.com>
> CC: Eugeniy Paltsev <paltsev@synopsys.com>
> CC: Douglas Anderson <dianders@chromium.org>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: Andy Shevchenko <andy.shevchenko@gmail.com>
> CC: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> CC: Shawn Lin <shawn.lin@rock-chips.com>
> CC: Vineet Gupta <Vineet.Gupta1@synopsys.com>
> CC: linux-kernel@vger.kernel.org
> CC: linux-snps-arc@lists.infradead.org
> Cc: <stable@vger.kernel.org>
> ---
> Changes since v3:
> -Switch DIV_ROUND_UP macro to DIV_ROUND_UP_ULL
> -Make one patch from two patches
> -Modify commit message
>
> Changes sinve v2:
> -add fix for cto_ms
>
> Changes since v1:
> -uint64_t switched to u64
>
>  drivers/mmc/host/dw_mmc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

FYI that your messages keep ending up in my spam folder and I just see
other people's replies.  Not exactly sure why...  Note also that your
patch really doesn't have all the tags in the right places.  All the
Tags including the Signed-off-by and Cc are supposed to be squashed in
one paragraph  ...and I believe "CC" is canonically supposed to be
"Cc".  Presumably the maintainer can fix this up when applying, but
please try to do better in the future.  Speaking of which, you didn't
include the dw_mmc maintainer (Jaehoon Chung) in your post?  That
seems not so great unless you know something that get_maintainers
doesn't know about who will apply this patch.

$ ./scripts/get_maintainer.pl -f drivers/mmc/host/dw_mmc.c
Jaehoon Chung <jh80.chung@samsung.com> (maintainer:SYNOPSYS DESIGNWARE
MMC/SD/SDIO DRIVER)


As far as the actual patch, at first I thought maybe we could avoid
the 64-bit math and just pre-divide bus_hz by MSEC_PER_SEC (just like
used to happen before my change), but I think there's still a chance
of overflow, right?  Because, for instance:

drto_clks can be a full 24 bits
drto_div can be effectively 9 bits

...we could do further tricks (further rounding up the result), but it
seems like just doing the 64-bit math is fine too unless someone has
any strong objections...

Reviewed-by: Douglas Anderson <dianders@chromium.org>
