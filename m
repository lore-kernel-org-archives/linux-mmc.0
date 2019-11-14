From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: arm64: dts: rockchip: Disable HS400 for mmc on rk3399-roc-pc
Date: Thu, 14 Nov 2019 14:10:39 +0100
Message-ID: <2766673.iMURPl8gB5@phil>
References: <20190301153348.29870-1-christoph.muellner@theobroma-systems.com> <20190301153348.29870-2-christoph.muellner@theobroma-systems.com> <367bf78a-f079-f0b4-68fe-52c86823c174@fivetechno.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <367bf78a-f079-f0b4-68fe-52c86823c174@fivetechno.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Reichl <m.reichl@fivetechno.de>
Cc: Christoph Muellner <christoph.muellner@theobroma-systems.com>, robh+dt@kernel.org, mark.rutland@arm.com, shawn.lin@rock-chips.com, devicetree@vger.kernel.org, Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Vicente Bergas <vicencb@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-rockchip@lists.infradead.org, Tony Xie <tony.xie@rock-chips.com>, Klaus Goger <klaus.goger@theobroma-systems.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Randy Li <ayaka@soulik.info>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@lists.infradead.or
List-Id: linux-mmc@vger.kernel.org

Hi Markus,

$subject is missing the [PATCH] prefix

Am Montag, 11. November 2019, 10:51:04 CET schrieb Markus Reichl:
> Working with rootfs on two 128GB mmcs on rk3399-roc-pc.
> 
> One (mmc name 128G72, one screw hole) works fine in HS400 mode.
> Other (mmc name DJNB4R, firefly on pcb, two screw holes) gets lots of
> mmc1: "running CQE recovery", even hangs with damaged fs,
> when running under heavy load, e.g. compiling kernel.
> Both run fine with HS200.
> 
> Disabling CQ with patch mmc: core: Add MMC Command Queue Support kernel parameter [0] did not help.
> [0] https://gitlab.com/ayufan-repos/rock64/linux-mainline-kernel/commit/54e264154b87dfe32a8359b2726e2d5611adbaf3

I'm hoping for some input from other people in Cc but your mail headers
also referenced the drive-impendance series from Christoph [0], which
it seems we need to poke the phy maintainer again.

Did you check if changing the impedance helped (like the signal dampening
Philipp described in one of the replies there).

[0] https://patchwork.kernel.org/patch/10835567/
most current v2 it seems is https://patchwork.kernel.org/patch/10842421/

> Therefore I propose to disable HS400 mode on roc-pc for now.

Hoping for more input :-)


Heiko


> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> index 29a50a083c42..33df95e384b4 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> @@ -660,8 +660,6 @@
>  
>  &sdhci {
>  	bus-width = <8>;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
>  	non-removable;
>  	status = "okay";
>  };
> 
