From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/8] mmc: dw_mmc-rockchip: allow tuning using the
 clk-phase api
Date: Thu, 8 Oct 2015 19:36:04 +0200
Message-ID: <CAPDyKFqeo--AiW_zHHrSqoOdFNZ3J_FgJpz2L7Z8gZnNmQZSig@mail.gmail.com>
References: <1443622064-14362-1-git-send-email-heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1443622064-14362-1-git-send-email-heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: Alexandru Stan <amstan-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 30 September 2015 at 16:07, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org> wrote:
> This series resurrects and adapts some individual patches whose sum
> enable the dw_mmc hosts on Rockchip socs to tune clock phases using
> the generic phase api (rk3288 and following have this capability).
>
> The changes to the original mmc-phase clocks are expanded by further
> findings resulting from devices being used in the field.
>
> Similarly the regulator handling changes do use the brand new
> regulator_set_voltage_triplet call to allow specifying lower and upper
> limits. One possible point of discussion are the two voltage ranges
> that are tried for the 3.3V signal level. Trying to stay near vmmc
> at first and only then opening the range to the full 2.7-3.6V.
>
> This mainly circumvents a shortcoming of the regulator voltage
> setting, in that even with regulator_set_voltage_triplet the regulator
> framework will take the lowest possible voltage when the possible
> voltages are below the target voltage. While it may be ideal to solve
> this on the regulator side, I'm not seeing this appearing in the short
> term, mainly because all regulator parts (including regulator drivers)
> are keyed to selecting the lowest voltage from the range, while on the
> mmc side we know which voltages may work and trying this in two steps
> does not create to much overhead, as unsupported voltages are already
> filtered out by the regulator_is_voltage_selected calls.
>
> changes since v1:
> - address comment from Jaehoon Chung and keep this local to Rockchip
>   for the time being
> - address comments from Ulf and Doug in making it more explicit
>   that the two-step 3.3V voltage setting essentially works around
>   a limitation of regulator_set_voltage_triplet
>
> Alexandru M Stan (3):
>   mmc: dw_mmc-rockchip: dt-binding: Add tuning related things
>   mmc: dw_mmc: Generic MMC tuning with the clock phase framework
>   ARM: dts: rockchip: Add drive/sample clocks for rk3288 dw_mmc devices
>
> Douglas Anderson (4):
>   clk: rockchip: Allow more precision for some mmc clock phases
>   clk: rockchip: Make calculations use rounding
>   mmc: core: Add mmc_regulator_set_vqmmc()
>   mmc: dw_mmc: Use mmc_regulator_set_vqmmc in
>     start_signal_voltage_switch
>
> Heiko Stuebner (1):
>   ARM: dts: rockchip: add tuning related settings to veyron devices
>
>  .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |  13 ++
>  arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi         |   7 +-
>  arch/arm/boot/dts/rk3288-veyron.dtsi               |   6 +
>  arch/arm/boot/dts/rk3288.dtsi                      |  20 ++-
>  drivers/clk/rockchip/clk-mmc-phase.c               |  54 ++++---
>  drivers/mmc/core/core.c                            |  74 ++++++++++
>  drivers/mmc/host/dw_mmc-rockchip.c                 | 162 +++++++++++++++++++++
>  drivers/mmc/host/dw_mmc.c                          |  17 +--
>  include/linux/mmc/host.h                           |   7 +
>  9 files changed, 321 insertions(+), 39 deletions(-)
>
> --
> 2.5.1
>

Thanks, applied for next!

Kind regards
Uffe
