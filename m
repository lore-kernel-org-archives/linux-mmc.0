From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v5 2/5] mmc: core: add mmc-hs400-enhanced-strobe support
Date: Mon, 23 May 2016 13:53:32 -0700
Message-ID: <CAD=FV=Xoegu1cb6QtaDRPf9gz7BVKVw1sfzzKM7NDKpTXL0jvA@mail.gmail.com>
References: <1463976789-29618-1-git-send-email-shawn.lin@rock-chips.com>
 <1463976823-29739-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1463976823-29739-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Shawn,

On Sun, May 22, 2016 at 9:13 PM, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
> This patch introduce mmc-hs400-enhanced-strobe for platforms
> which want to enable enhanced strobe function from DT if the
> mmc host controller claims to support enhanced strobe.
>
> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>
> ---
>
> Changes in v5:
> - avoid to call hs400_enhanced+_strobe in mmc_set_initial_state
>   if no setting MMC_CAP2_HS400_ES.
> - add Adrian's ack for patch[5/5]
>
> Changes in v4:
> - check avail_type with EXT_CSD_CARD_TYPE_HS400 instead of
>   card_type
> - check if host support 8-bit when selecting hs400es
> - some minor fix suggested by Douglas and add his review tag
>
> Changes in v3:
> - remove helper function and shorten cap2 to MMC_CAP2_HS400_ES
> - rename callback to hs400_enhanced_strobe and make it return void
> - add enhanced_strobe in mmc_ios and pass it to hs400_enhanced_strobe
> - disable host's enhanced strobe in mmc_set_initial_state
> - remove bus checking after switching hs400es
> - add new function for hs400es timing selection
> - fix wrong judgement of mmc_card_hs400es
>
> Changes in v2:
> - switch to HS400ES from Highspeed mode directly
>
>  drivers/mmc/core/host.c  | 2 ++
>  include/linux/mmc/host.h | 1 +
>  2 files changed, 3 insertions(+)

Reviewed-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
