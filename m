From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH 0/9] Enable dw-mmc multi-card support
Date: Tue, 17 Oct 2017 09:36:07 +0800
Message-ID: <8e433531-8f67-d575-635e-c6ced29f6804@rock-chips.com>
References: <cover.1507315433.git.lsun@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1507315433.git.lsun-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liming Sun <lsun-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


On 2017/10/7 3:21, Liming Sun wrote:
> This series of commits enables the multi-card support for the dw-mmc
> controller. It includes two parts as below.
> 
> The first part (patches 1-7) reverts the series of recent commits that
> removed the multi-card support with comments saying there was no such
> use case in the real world. Actually this feature is being used in
> Mellanox Bluefield SoC and has been requested by customers.

Hrm.... it's so unlucky that your patchset comes a little late. As
your patch 8 and 9 said, you need them to fix problem for multi-card
support, so definitely there was no such use case, and even the code
was buggy to support it right? That makes the code hard to read and
maintain, so we decide to remove it.

> 
> The second part (patches 8-9) fixes the DesignWare multi-card support
> according to the dw-mmc databook (synnopsys: DesignWare Cores Mobile
> Storage Host Databook, 2.70a). It has changes to set the card number
> into the CMD register to multiplex requests to different cards when
> working in SD_MMC_CEATA mode, set the CTYPE / CLKENA / CDTHRCTL
> registers properly according to the spec, and parse the per-card
> configuration to match the Linux Documentation
> (bindings/mmc/synopsys-dw-mshc.txt).

Havn'e check the databook for details yet, but I think it's ok
to re-introduce multi-slot support if a real user benefits from
it. But you need a new patch to silent the log "num-slots property not
found, assuming 1 slot is available" as we removed all the num-slots
from DT at that time.


> 
> Liming Sun (9):
>    Revert "Documentation: dw-mshc: deprecate num-slots"
>    Revert "mmc: dw_mmc: remove the unnecessary slot variable"
>    Revert "mmc: dw_mmc: use the 'slot' instead of 'cur_slot'"
>    Revert "mmc: dw_mmc: remove the 'id' arguments about functions
>      relevant to slot"
>    Revert "mmc: dw_mmc: change the array of slots"
>    Revert "mmc: dw_mmc: remove the loop about finding slots"
>    Revert "mmc: dw_mmc: deprecated the "num-slots" property"
>    mmc: dw_mmc: Support two SD_MMC_CE-ATA cards
>    mmc: dw_mmc: Parse slot-specific configuration
> 
>   .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  16 +-
>   drivers/mmc/host/dw_mmc-exynos.c                   |   4 +-
>   drivers/mmc/host/dw_mmc.c                          | 277 ++++++++++++++++-----
>   drivers/mmc/host/dw_mmc.h                          |  17 +-
>   4 files changed, 236 insertions(+), 78 deletions(-)
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
