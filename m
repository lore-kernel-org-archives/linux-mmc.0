From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: Disable DCMDs on RK3399's
 eMMC controller.
Date: Mon, 25 Mar 2019 14:27:26 +0100
Message-ID: <CAPDyKFpPh7TZqRfUX7x52aUeY69-i3NSo5XtuwTjN8yHqdAVDw@mail.gmail.com>
References: <20190322113808.16858-1-christoph.muellner@theobroma-systems.com> <20190322113808.16858-3-christoph.muellner@theobroma-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322113808.16858-3-christoph.muellner@theobroma-systems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Michal Simek <michal.simek@xilinx.com>, Matthias Brugger <matthias.bgg@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Lin Huang <hl@rock-chips.com>, Randy Li <ayaka@soulik.info>, Tony Xie <tony.xie@rock-chips.com>, Vicente Bergas <vicencb@gmail.com>, Ezequiel Garcia <ezequiel@collabora.com>, Klaus Goger <klaus.goger@theobroma-systems.com>, "linux-mmc@vger.kernel.org" <linux->
List-Id: linux-mmc@vger.kernel.org

On Fri, 22 Mar 2019 at 12:39, Christoph Muellner
<christoph.muellner@theobroma-systems.com> wrote:
>
> When using direct commands (DCMDs) on an RK3399, we get spurious
> CQE completion interrupts for the DCMD transaction slot (#31):
>
> [  931.196520] ------------[ cut here ]------------
> [  931.201702] mmc1: cqhci: spurious TCN for tag 31
> [  931.206906] WARNING: CPU: 0 PID: 1433 at /usr/src/kernel/drivers/mmc/host/cqhci.c:725 cqhci_irq+0x2e4/0x490
> [  931.206909] Modules linked in:
> [  931.206918] CPU: 0 PID: 1433 Comm: irq/29-mmc1 Not tainted 4.19.8-rt6-funkadelic #1
> [  931.206920] Hardware name: Theobroma Systems RK3399-Q7 SoM (DT)
> [  931.206924] pstate: 40000005 (nZcv daif -PAN -UAO)
> [  931.206927] pc : cqhci_irq+0x2e4/0x490
> [  931.206931] lr : cqhci_irq+0x2e4/0x490
> [  931.206933] sp : ffff00000e54bc80
> [  931.206934] x29: ffff00000e54bc80 x28: 0000000000000000
> [  931.206939] x27: 0000000000000001 x26: ffff000008f217e8
> [  931.206944] x25: ffff8000f02ef030 x24: ffff0000091417b0
> [  931.206948] x23: ffff0000090aa000 x22: ffff8000f008b000
> [  931.206953] x21: 0000000000000002 x20: 000000000000001f
> [  931.206957] x19: ffff8000f02ef018 x18: ffffffffffffffff
> [  931.206961] x17: 0000000000000000 x16: 0000000000000000
> [  931.206966] x15: ffff0000090aa6c8 x14: 0720072007200720
> [  931.206970] x13: 0720072007200720 x12: 0720072007200720
> [  931.206975] x11: 0720072007200720 x10: 0720072007200720
> [  931.206980] x9 : 0720072007200720 x8 : 0720072007200720
> [  931.206984] x7 : 0720073107330720 x6 : 00000000000005a0
> [  931.206988] x5 : ffff00000860d4b0 x4 : 0000000000000000
> [  931.206993] x3 : 0000000000000001 x2 : 0000000000000001
> [  931.206997] x1 : 1bde3a91b0d4d900 x0 : 0000000000000000
> [  931.207001] Call trace:
> [  931.207005]  cqhci_irq+0x2e4/0x490
> [  931.207009]  sdhci_arasan_cqhci_irq+0x5c/0x90
> [  931.207013]  sdhci_irq+0x98/0x930
> [  931.207019]  irq_forced_thread_fn+0x2c/0xa0
> [  931.207023]  irq_thread+0x114/0x1c0
> [  931.207027]  kthread+0x128/0x130
> [  931.207032]  ret_from_fork+0x10/0x20
> [  931.207035] ---[ end trace 0000000000000002 ]---
>
> The driver shows this message only for the first spurious interrupt
> by using WARN_ONCE(). Changing this to WARN() shows, that this is
> happening quite frequently (up to once a second).
>
> Since the eMMC 5.1 specification, where CQE and CQHCI are specified,
> does not mention that spurious TCN interrupts for DCMDs can be simply
> ignored, we must assume that using this feature is not working reliably.
>
> The current implementation uses DCMD for REQ_OP_FLUSH only, and
> I could not see any performance/power impact when disabling
> this optional feature for RK3399.
>
> Therefore this patch disables DCMDs for RK3399.
>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>

FYI, I leave this for arm-soc to pick up.

Kind regards
Uffe


> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index db9d948c0b03..1a16d6ce3ea8 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -333,6 +333,7 @@
>                 phys = <&emmc_phy>;
>                 phy-names = "phy_arasan";
>                 power-domains = <&power RK3399_PD_EMMC>;
> +               disable-cqe-dcmd;
>                 status = "disabled";
>         };
>
> --
> 2.11.0
>
