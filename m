From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v4 0/2] Add eMMC and SD card support for rk3288-evb
Date: Thu, 14 Aug 2014 00:15:19 +0200
Message-ID: <1896828.oB75TXBbSp@phil>
References: <1407885674-16469-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1407885674-16469-1-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Kever Yang <kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Am Dienstag, 12. August 2014, 16:21:12 schrieb Doug Anderson:
> This series adds basic eMMC and SD card support for the rk3288-evb
> board based on Addy's dw_mmc patch.

I've added both patches to the general dts branch for 3.18.
Currently as WIP and temporarily on github [0] until we reach -rc1.


Heiko


[0] https://github.com/mmind/linux-rockchip/tree/wip/v3.18-next/dts

> 
> Note that we don't have regulators specified yet (no regulator driver
> for rk808-based board).  We also don't yet support UHS modes or MMC
> DDR50 (which require regulator support plus dw_mmc driver support for
> tuning).  Those features can come later.
> 
> Changes in v4:
> - Add status="disabled".
> - Squash patch #1 and #4 since Jaehoon's patch landed.
> - Squashed patches #2 and #3 since Jaehoon's patch landed.
> 
> Changes in v3:
> - Removed DDR50 mode since it needs tuning, which isn't there yet.
> 
> Changes in v2:
> - Refer to the new title of Jaehoon's patch
> - New patchwork link for Addy's patch
> - Squashed in the DDR50 mode since Addy spun his patch.
> 
> Doug Anderson (2):
>   ARM: dts: Add emmc and sdmmc to the rk3288 device tree
>   ARM: dts: Enable emmc and sdmmc on the rk3288-evb boards
> 
>  arch/arm/boot/dts/rk3288-evb.dtsi | 24 ++++++++++++++++++++++++
>  arch/arm/boot/dts/rk3288.dtsi     | 20 ++++++++++++++++++++
>  2 files changed, 44 insertions(+)

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
