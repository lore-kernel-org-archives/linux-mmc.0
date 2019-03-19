From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: =?UTF-8?Q?Re=3a_ulfh/next_boot_bisection=3a_v5=2e1-rc1-22-gb3725d97?=
 =?UTF-8?B?YmE3NSBvbiByazMzOTktZ3J1LWtldmlu44CQ6K+35rOo5oSP77yM6YKu5Lu255Sx?=
 =?UTF-8?B?bGludXgtbW1jLW93bmVyQHZnZXIua2VybmVsLm9yZ+S7o+WPkeOAkQ==?=
Date: Tue, 19 Mar 2019 08:38:05 +0800
Message-ID: <f75224ca-c0e5-94be-84b0-90c252784eb0@rock-chips.com>
References: <5c9020bc.1c69fb81.6977e.d27a@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5c9020bc.1c69fb81.6977e.d27a@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "kernelci.org bot" <bot@kernelci.org>, tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com, mgalka@collabora.com, Ziyuan Xu <xzy.xu@rock-chips.com>, broonie@kernel.org, matthew.hart@linaro.org, khilman@baylibre.com, enric.balletbo@collabora.com, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


On 2019/3/19 6:50, kernelci.org bot wrote:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> ulfh/next boot bisection: v5.1-rc1-22-gb3725d97ba75 on rk3399-gru-kevin
> 
> Summary:
>    Start:      b3725d97ba75 Merge branch 'fixes' into next
>    Details:    https://kernelci.org/boot/id/5c8fa85d59b5148afcfe6052
>    Plain log:  https://storage.kernelci.org//ulfh/next/v5.1-rc1-22-gb3725d97ba75/arm64/defconfig/gcc-7/lab-collabora/boot-rk3399-gru-kevin.txt
>    HTML log:   https://storage.kernelci.org//ulfh/next/v5.1-rc1-22-gb3725d97ba75/arm64/defconfig/gcc-7/lab-collabora/boot-rk3399-gru-kevin.html
>    Result:     d6a6d722481f mmc: dw_mmc-rockchip: Enable hardware unbusy interrupt support

Thanks for report!

Ulf,

It's a known issue already but didn't got managed to post v3 due to
weekend. Should I post a increamental patch on top? or just resend a
v3 series?

> 
> Checks:
>    revert:     PASS
>    verify:     PASS
> 
> Parameters:
>    Tree:       ulfh
>    URL:        https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
>    Branch:     next
>    Target:     rk3399-gru-kevin
>    CPU arch:   arm64
>    Lab:        lab-collabora
>    Compiler:   gcc-7
>    Config:     defconfig
>    Test suite: boot
> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit d6a6d722481f357eafe7b798fe6fdadd2f5ac6bd
> Author: Shawn Lin <shawn.lin@rock-chips.com>
> Date:   Tue Mar 12 15:35:09 2019 +0800
> 
>      mmc: dw_mmc-rockchip: Enable hardware unbusy interrupt support
>      
>      The new register for controlling hardware unbusy interrupt
>      is in 0x120. It looks like:
>      
>      |------------------------------------------------------------|
>      |Bit    |  Attribute |  Reset Value  | Description           |
>      |------------------------------------------------------------|
>      |31:25  |    RO      |      0x0      |  reserved             |
>      |------------------------------------------------------------|
>      |24     |    RO      |      0x0      |  rdyint_cnt_finish    |
>      |       |            |               |When high, it indicates|
>      |       |            |               |that the rdyint counter|
>      |       |            |               |is finished.           |
>      |------------------------------------------------------------|
>      |23:16  |    RO      |      0x0      |  rdyint_cnt_status    |
>      |       |            |               |Couner status, reflect |
>      |       |            |               |internal counter value.|
>      |------------------------------------------------------------|
>      |15:9   |    RO      |      0x0      |  reserved             |
>      |------------------------------------------------------------|
>      |8      |    RW      |      0x0      |  rdyint_gen_working   |
>      |       |            |               |When set, IP starts to |
>      |       |            |               |count and generate one |
>      |       |            |               |rdyint trigger. After  |
>      |       |            |               |the rdyint trigger is  |
>      |       |            |               |generated, it will be  |
>      |       |            |               |cleaned automatically. |
>      |       |            |               |Software should set it |
>      |       |            |               |again next time.       |
>      |------------------------------------------------------------|
>      |7:0    |    RW      |      0xff     |   rdyint_gen_maxval   |
>      |       |            |               |Max counter value for  |
>      |       |            |               |the IP to count when   |
>      |       |            |               |rdyint_gen_working is  |
>      |       |            |               |set. This counter is   |
>      |       |            |               |based on biu_clk.      |
>      |------------------------------------------------------------|
>      
>      Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>      Tested-by: Ziyuan Xu <xzy.xu@rock-chips.com>
>      Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index 8c86a800a8fd..85b1e42782a0 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -20,6 +20,9 @@
>   #include "dw_mmc-pltfm.h"
>   
>   #define RK3288_CLKGEN_DIV       2
> +#define RKMMC_RDYINT_GEN	0x120
> +#define RKMMC_RDYINT_GEN_WORKING BIT(8)
> +#define RKMMC_RDYINT_GEN_MAXVAL GENMASK(7, 0)
>   
>   struct dw_mci_rockchip_priv_data {
>   	struct clk		*drv_clk;
> @@ -28,6 +31,23 @@ struct dw_mci_rockchip_priv_data {
>   	int			num_phases;
>   };
>   
> +static int dw_mci_rockchip_prepare_hw_unbusy(struct dw_mci *host,
> +					     bool enable)
> +{
> +	u32 reg = readl(host->regs + RKMMC_RDYINT_GEN);
> +
> +	if (enable)
> +		/* Self-clean when generating unbusy int */
> +		reg |= RKMMC_RDYINT_GEN_WORKING;
> +	else
> +		/* Otherwise do it manually to avoid racing condition */
> +		reg &= ~RKMMC_RDYINT_GEN_WORKING;
> +
> +	writel(reg, host->regs + RKMMC_RDYINT_GEN);
> +
> +	return 0;
> +}
> +
>   static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>   {
>   	struct dw_mci_rockchip_priv_data *priv = host->priv;
> @@ -301,6 +321,15 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
>   				    "rockchip,rk3288-dw-mshc"))
>   		host->bus_hz /= RK3288_CLKGEN_DIV;
>   
> +	/* Some Rockchip SoCs use hw unbusy int */
> +	if (of_device_is_compatible(host->dev->of_node,
> +				    "rockchip,rk1808-dw-mshc")) {
> +		host->hw_unbusy_int = 16;
> +		writel(~(RKMMC_RDYINT_GEN_WORKING |
> +			 RKMMC_RDYINT_GEN_MAXVAL),
> +		       host->regs + RKMMC_RDYINT_GEN);
> +	}
> +
>   	return 0;
>   }
>   
> @@ -322,6 +351,7 @@ static const struct dw_mci_drv_data rk3288_drv_data = {
>   	.set_ios		= dw_mci_rk3288_set_ios,
>   	.execute_tuning		= dw_mci_rk3288_execute_tuning,
>   	.parse_dt		= dw_mci_rk3288_parse_dt,
> +	.prepare_hw_unbusy      = dw_mci_rockchip_prepare_hw_unbusy,
>   	.init			= dw_mci_rockchip_init,
>   };
> -------------------------------------------------------------------------------
> 
> 
> Git bisection log:
> 
> -------------------------------------------------------------------------------
> git bisect start
> # good: [4d3d534e9fd596e6f70ee19c75f0cd9aa5be2588] Merge branch 'fixes' into next
> git bisect good 4d3d534e9fd596e6f70ee19c75f0cd9aa5be2588
> # bad: [b3725d97ba75b0cf6d0eb1e3836915ad234f6f3d] Merge branch 'fixes' into next
> git bisect bad b3725d97ba75b0cf6d0eb1e3836915ad234f6f3d
> # good: [e266ca36da7de45b64b05698e98e04b578a88888] Merge tag 'staging-5.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
> git bisect good e266ca36da7de45b64b05698e98e04b578a88888
> # good: [36011ddc78395b59a8a418c37f20bcc18828f1ef] Merge tag 'gfs2-5.1.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2
> git bisect good 36011ddc78395b59a8a418c37f20bcc18828f1ef
> # good: [6bc3fe8e7e172d5584e529a04cf9eec946428768] tools: mark 'test_vmalloc.sh' executable
> git bisect good 6bc3fe8e7e172d5584e529a04cf9eec946428768
> # good: [dc2535be1fd547fbd56aff091370280007b0a1af] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
> git bisect good dc2535be1fd547fbd56aff091370280007b0a1af
> # good: [e8a71a38668919c53e6ca9dd1bfa977e5690523f] Merge tag 'ntb-5.1' of git://github.com/jonmason/ntb
> git bisect good e8a71a38668919c53e6ca9dd1bfa977e5690523f
> # good: [636deed6c0bc137a7c4f4a97ae1fcf0ad75323da] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
> git bisect good 636deed6c0bc137a7c4f4a97ae1fcf0ad75323da
> # good: [477558d7e8d82b59a650e193a5651cf25b794dbc] Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> git bisect good 477558d7e8d82b59a650e193a5651cf25b794dbc
> # good: [80b98e92ebcb4433b86fd32b5d82ec6b0d75cf59] Merge branch 'x86-asm-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good 80b98e92ebcb4433b86fd32b5d82ec6b0d75cf59
> # good: [9e98c678c2d6ae3a17cb2de55d17f69dddaa231b] Linux 5.1-rc1
> git bisect good 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b
> # good: [311f059c6aaeb6f5c21459041523a07459d7369b] mmc: sdhci-of-esdhc: add erratum A-009204 support
> git bisect good 311f059c6aaeb6f5c21459041523a07459d7369b
> # good: [705a0f28811322cb8c578c35a9d07fae7c683845] mmc: dw_mmc: Add hardware unbusy interrupt support
> git bisect good 705a0f28811322cb8c578c35a9d07fae7c683845
> # bad: [60cbf5c5e71dab0586455ae846fb67353d2554bf] mmc: renesas_sdhi: update copyright information
> git bisect bad 60cbf5c5e71dab0586455ae846fb67353d2554bf
> # bad: [eeddc8e5fb23e85ea71e7f03d44b1a3845305213] mmc: mxs-mmc: Enable MMC_CAP_ERASE
> git bisect bad eeddc8e5fb23e85ea71e7f03d44b1a3845305213
> # bad: [d6a6d722481f357eafe7b798fe6fdadd2f5ac6bd] mmc: dw_mmc-rockchip: Enable hardware unbusy interrupt support
> git bisect bad d6a6d722481f357eafe7b798fe6fdadd2f5ac6bd
> # first bad commit: [d6a6d722481f357eafe7b798fe6fdadd2f5ac6bd] mmc: dw_mmc-rockchip: Enable hardware unbusy interrupt support
> -------------------------------------------------------------------------------
> 
> 
