From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/7] mmc: dw_mmc-rockchip: allow tuning using the
 clk-phase api
Date: Fri, 16 Oct 2015 10:25:41 +0200
Message-ID: <CAPDyKFo5jvsv+wpo4cSgetb9CfjXF6Y7DGDGRBXDSZkTnXzj-A@mail.gmail.com>
References: <1444654110-32293-1-git-send-email-heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:34837 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbbJPIZn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Oct 2015 04:25:43 -0400
Received: by lbbes7 with SMTP id es7so4940790lbb.2
        for <linux-mmc@vger.kernel.org>; Fri, 16 Oct 2015 01:25:41 -0700 (PDT)
In-Reply-To: <1444654110-32293-1-git-send-email-heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Doug Anderson <dianders@chromium.org>, Alexandru Stan <amstan@chromium.org>

On 12 October 2015 at 14:48, Heiko Stuebner <heiko@sntech.de> wrote:
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
> changes since v2:
> - use host->ios.vdd to read vmmc from instead of requiring the vmmc
>   regulator. Suggested by Ulf this makes the voltage setting still work
>   even if only the vqmmc but not the vmmc regulator is supplied.
> - add Acks from Jaehoon Chung to the dw_mmc parts
> - drop first two clock patches that already got applied to the mmc tree
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
>   mmc: dw_mmc-rockchip: MMC tuning with the clock phase framework
>   ARM: dts: rockchip: Add drive/sample clocks for rk3288 dw_mmc devices
>
> Douglas Anderson (2):
>   mmc: core: Add mmc_regulator_set_vqmmc()
>   mmc: dw_mmc: Use mmc_regulator_set_vqmmc in
>     start_signal_voltage_switch
>
> Heiko Stuebner (2):
>   mmc: core: move ocr-bit to voltage translation into separate function
>   ARM: dts: rockchip: add tuning related settings to veyron devices
>
>  .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |  13 ++
>  arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi         |   7 +-
>  arch/arm/boot/dts/rk3288-veyron.dtsi               |   6 +
>  arch/arm/boot/dts/rk3288.dtsi                      |  20 ++-
>  drivers/mmc/core/core.c                            | 129 ++++++++++++++--
>  drivers/mmc/host/dw_mmc-rockchip.c                 | 162 +++++++++++++++++++++
>  drivers/mmc/host/dw_mmc.c                          |  17 +--
>  include/linux/mmc/host.h                           |   7 +
>  8 files changed, 325 insertions(+), 36 deletions(-)
>
> --
> 2.6.1
>

Thanks, applied for next (with v3.1 of patch1)!

Kind regards
Uffe
