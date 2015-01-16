From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] mmc: sdhci-s3c: solve problem with sleeping in atomic
 context
Date: Fri, 16 Jan 2015 15:54:57 +0100
Message-ID: <1421420097.21067.2.camel@AMDC1943>
References: <1421418605-457-1-git-send-email-p.osmialowsk@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52561 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbbAPOzB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jan 2015 09:55:01 -0500
In-reply-to: <1421418605-457-1-git-send-email-p.osmialowsk@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Osmialowski <p.osmialowsk@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On pi=C4=85, 2015-01-16 at 15:30 +0100, Paul Osmialowski wrote:
> This change addresses following problem:
>=20
> [    2.560726] ------------[ cut here ]------------
> [    2.565341] WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:274=
4 lockdep_trace_alloc+0xec/0x118()
> [    2.574439] DEBUG_LOCKS_WARN_ON(irqs_disabled_flags(flags))
> [    2.579821] Modules linked in:
> [    2.583038] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W     =
 3.18.0-next-20141216-00002-g4ff197fc1902-dirty #1318
> [    2.593796] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [    2.599892] [<c0014c44>] (unwind_backtrace) from [<c0011bbc>] (sho=
w_stack+0x10/0x14)
> [    2.607612] [<c0011bbc>] (show_stack) from [<c04953b8>] (dump_stac=
k+0x70/0xbc)
> [    2.614822] [<c04953b8>] (dump_stack) from [<c0023444>] (warn_slow=
path_common+0x74/0xb0)
> [    2.622885] [<c0023444>] (warn_slowpath_common) from [<c0023514>] =
(warn_slowpath_fmt+0x30/0x40)
> [    2.631569] [<c0023514>] (warn_slowpath_fmt) from [<c0063644>] (lo=
ckdep_trace_alloc+0xec/0x118)
> [    2.640246] [<c0063644>] (lockdep_trace_alloc) from [<c00df52c>] (=
__kmalloc+0x3c/0x1cc)
> [    2.648240] [<c00df52c>] (__kmalloc) from [<c0394970>] (clk_fetch_=
parent_index+0xb8/0xd4)
> [    2.656390] [<c0394970>] (clk_fetch_parent_index) from [<c0394a6c>=
] (clk_calc_new_rates+0xe0/0x1fc)
> [    2.665415] [<c0394a6c>] (clk_calc_new_rates) from [<c0394b40>] (c=
lk_calc_new_rates+0x1b4/0x1fc)
> [    2.674181] [<c0394b40>] (clk_calc_new_rates) from [<c0395408>] (c=
lk_set_rate+0x50/0xc8)
> [    2.682265] [<c0395408>] (clk_set_rate) from [<c0377708>] (sdhci_c=
mu_set_clock+0x68/0x16c)
> [    2.690503] [<c0377708>] (sdhci_cmu_set_clock) from [<c03735cc>] (=
sdhci_do_set_ios+0xf0/0x64c)
> [    2.699095] [<c03735cc>] (sdhci_do_set_ios) from [<c0373b48>] (sdh=
ci_set_ios+0x20/0x2c)
> [    2.707080] [<c0373b48>] (sdhci_set_ios) from [<c035ddf0>] (mmc_po=
wer_up+0x118/0x1fc)
> [    2.714889] [<c035ddf0>] (mmc_power_up) from [<c035ecd0>] (mmc_sta=
rt_host+0x44/0x6c)
> [    2.722615] [<c035ecd0>] (mmc_start_host) from [<c035fd60>] (mmc_a=
dd_host+0x58/0x7c)
> [    2.730341] [<c035fd60>] (mmc_add_host) from [<c037454c>] (sdhci_a=
dd_host+0x968/0xd94)
> [    2.738240] [<c037454c>] (sdhci_add_host) from [<c0377b60>] (sdhci=
_s3c_probe+0x354/0x52c)
> [    2.746406] [<c0377b60>] (sdhci_s3c_probe) from [<c0283b58>] (plat=
form_drv_probe+0x48/0xa4)
> [    2.754733] [<c0283b58>] (platform_drv_probe) from [<c02824e8>] (d=
river_probe_device+0x13c/0x37c)
> [    2.763585] [<c02824e8>] (driver_probe_device) from [<c02827bc>] (=
__driver_attach+0x94/0x98)
> [    2.772003] [<c02827bc>] (__driver_attach) from [<c0280a60>] (bus_=
for_each_dev+0x54/0x88)
> [    2.780163] [<c0280a60>] (bus_for_each_dev) from [<c0281b48>] (bus=
_add_driver+0xe4/0x200)
> [    2.788322] [<c0281b48>] (bus_add_driver) from [<c0282dfc>] (drive=
r_register+0x78/0xf4)
> [    2.796308] [<c0282dfc>] (driver_register) from [<c00089b0>] (do_o=
ne_initcall+0xac/0x1f0)
> [    2.804473] [<c00089b0>] (do_one_initcall) from [<c0673d94>] (kern=
el_init_freeable+0x10c/0x1d8)
> [    2.813153] [<c0673d94>] (kernel_init_freeable) from [<c0490058>] =
(kernel_init+0x28/0x108)
> [    2.821398] [<c0490058>] (kernel_init) from [<c000f268>] (ret_from=
_fork+0x14/0x2c)
> [    2.828939] ---[ end trace 03cc00e539849d1f ]---
>=20

+Cc Stephen Boyd
This is the fix for issue mentioned here:
https://lkml.org/lkml/2014/12/22/125


Best regards,
Krzysztof

> clk_set_rate() tries to take clk's prepare_lock mutex while being in =
atomic
> context entered in sdhci_do_set_ios().
> The solution is inspired by similar situation in sdhci_set_power() al=
so called
> from sdhci_do_set_ios():
>=20
>                 spin_unlock_irq(&host->lock);
>                 mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
>                 spin_lock_irq(&host->lock);
>=20
> Note that since sdhci_s3c_set_clock() sets SDHCI_CLOCK_CARD_EN, propo=
sed change
> first resets this bit. It is reset anyway (by setting SDHCI_CLOCK_INT=
_EN bit
> only) after call to clk_set_rate() in order to wait for the clock to =
stabilize
> and is set again as soon as the clock becomes stable.
>=20
> Signed-off-by: Paul Osmialowski <p.osmialowsk@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3=
c.c
> index c45b893..115f556 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -12,6 +12,7 @@
>   * published by the Free Software Foundation.
>   */
> =20
> +#include <linux/spinlock.h>
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/platform_device.h>
> @@ -312,7 +313,14 @@ static void sdhci_cmu_set_clock(struct sdhci_hos=
t *host, unsigned int clock)
> =20
>  	sdhci_s3c_set_clock(host, clock);
> =20
> +	/* Reset SD Clock Enable */
> +	clk =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	clk &=3D ~SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	spin_unlock_irq(&host->lock);
>  	ret =3D clk_set_rate(ourhost->clk_bus[ourhost->cur_clk], clock);
> +	spin_lock_irq(&host->lock);
>  	if (ret !=3D 0) {
>  		dev_err(dev, "%s: failed to set clock rate %uHz\n",
>  			mmc_hostname(host->mmc), clock);

