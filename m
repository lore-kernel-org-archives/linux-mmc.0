From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v5 3/5] mmc: core: implement enhanced strobe support
Date: Mon, 23 May 2016 17:39:32 -0700
Message-ID: <CAD=FV=WYB4Pg7HcXHVVN-rWAfrV8bGY+MhNFJ+DRJRbhcbXNpQ@mail.gmail.com>
References: <1463976789-29618-1-git-send-email-shawn.lin@rock-chips.com> <1463976835-29780-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463976835-29780-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Shawn,

On Sun, May 22, 2016 at 9:13 PM, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
> Controllers use data strobe line to latch data from devices
> under hs400 mode, but not for cmd line. So since emmc 5.1, JEDEC
> introduces enhanced strobe mode for latching cmd response from
> emmc devices to host controllers. This new feature is optional,
> so it depends both on device's cap and host's cap to decide
> whether to use it or not.
>
> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
>
> Changes in v5: None
> Changes in v4: None

Not terribly important, but things certainly did change in this patch
since previous versions.

> Changes in v3: None
> Changes in v2: None
>
>  drivers/mmc/core/bus.c   |  3 +-
>  drivers/mmc/core/core.c  |  9 ++++++
>  drivers/mmc/core/mmc.c   | 84 ++++++++++++++++++++++++++++++++++++++++++++++--
>  include/linux/mmc/card.h |  1 +
>  include/linux/mmc/host.h | 11 +++++++
>  include/linux/mmc/mmc.h  |  3 ++
>  6 files changed, 108 insertions(+), 3 deletions(-)

I don't see anything obviously bad about this patch, but I haven't
gone deep into all the details of mmc_select_hs400es(), so I'm not
sure I can really provide a full Reviewed tag.  At least I have tested
this, so:

Tested-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
