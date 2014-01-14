From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 1/2] clk: hisilicon: add hi3620_mmc_clks
Date: Tue, 14 Jan 2014 18:47:11 +0900
Message-ID: <002901cf110d$993b4880$cbb1d980$%jun@samsung.com>
References: <1389604469-8064-1-git-send-email-zhangfei.gao@linaro.org>
 <1389604469-8064-2-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:15008 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbaANJrN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jan 2014 04:47:13 -0500
In-reply-to: <1389604469-8064-2-git-send-email-zhangfei.gao@linaro.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Zhangfei Gao' <zhangfei.gao@linaro.org>, 'Chris Ball' <cjb@laptop.org>, 'Arnd Bergmann' <arnd@arndb.de>, 'Mike Turquette' <mturquette@linaro.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Haojian Zhuang' <haojian.zhuang@linaro.org>, brooke.wangzhigang@huawei.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org

On Mon, January 13, 2014, Zhangfei Gao wrote:
> Suggest by Arnd: abstract mmc tuning as clock behavior,
> also because different soc have different tuning method and registers.
> hi3620_mmc_clks is added to handle mmc clock specifically on hi3620.
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  .../bindings/arm/hisilicon/hisilicon.txt           |   14 +
>  .../devicetree/bindings/clock/hi3620-clock.txt     |    1 +
>  drivers/clk/hisilicon/clk-hi3620.c                 |  267 ++++++++++++++++++++
>  include/dt-bindings/clock/hi3620-clock.h           |    5 +
>  4 files changed, 287 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> index 8c7a4653508d..df0a452b8526 100644
> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> @@ -30,3 +30,17 @@ Example:
>  		resume-offset = <0x308>;
>  		reboot-offset = <0x4>;
>  	};
> +
> +PCTRL: Peripheral misc control register
> +
> +Required Properties:
> +- compatible: "hisilicon,pctrl"
> +- reg: Address and size of pctrl.
> +
> +Example:
> +
> +	/* for Hi3620 */
> +	pctrl: pctrl@fca09000 {
> +		compatible = "hisilicon,pctrl";
> +		reg = <0xfca09000 0x1000>;
> +	};
> diff --git a/Documentation/devicetree/bindings/clock/hi3620-clock.txt
> b/Documentation/devicetree/bindings/clock/hi3620-clock.txt
> index 4b71ab41be53..dad6269f52c5 100644
> --- a/Documentation/devicetree/bindings/clock/hi3620-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/hi3620-clock.txt
> @@ -7,6 +7,7 @@ Required Properties:
> 
>  - compatible: should be one of the following.
>    - "hisilicon,hi3620-clock" - controller compatible with Hi3620 SoC.
> +  - "hisilicon,hi3620-mmc-clock" - controller specific for Hi3620 mmc.
> 
>  - reg: physical base address of the controller and length of memory mapped
>    region.
> diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
> index f24ad6a3a797..54cc3475ec36 100644
> --- a/drivers/clk/hisilicon/clk-hi3620.c
> +++ b/drivers/clk/hisilicon/clk-hi3620.c
> @@ -240,3 +240,270 @@ static void __init hi3620_clk_init(struct device_node *np)
>  				   base);
>  }
>  CLK_OF_DECLARE(hi3620_clk, "hisilicon,hi3620-clock", hi3620_clk_init);
> +
> +struct hisi_mmc_clock {
> +	unsigned int		id;
> +	const char		*name;
> +	const char		*parent_name;
> +	unsigned long		flags;
> +	u32			clken_reg;
> +	u32			clken_bit;
> +	u32			div_reg;
> +	u32			div_off;
> +	u32			div_bits;
> +	u32			drv_reg;
> +	u32			drv_off;
> +	u32			drv_bits;
> +	u32			sam_reg;
> +	u32			sam_off;
> +	u32			sam_bits;
> +};
> +
> +struct clk_mmc {
> +	struct clk_hw	hw;
> +	u32		id;
> +	void __iomem	*clken_reg;
> +	u32		clken_bit;
> +	void __iomem	*div_reg;
> +	u32		div_off;
> +	u32		div_bits;
> +	void __iomem	*drv_reg;
> +	u32		drv_off;
> +	u32		drv_bits;
> +	void __iomem	*sam_reg;
> +	u32		sam_off;
> +	u32		sam_bits;
> +};
> +
> +#define to_mmc(_hw) container_of(_hw, struct clk_mmc, hw)
> +
> +static struct hisi_mmc_clock hi3620_mmc_clks[] __initdata = {
> +	{ HI3620_SD_CIUCLK,	"sd_bclk1", "sd_clk", CLK_SET_RATE_PARENT, 0x1f8, 0, 0x1f8, 1, 3, 0x1f8, 4,
> 4, 0x1f8, 8, 4},
> +	{ HI3620_MMC_CIUCLK1,   "mmc_bclk1", "mmc_clk1", CLK_SET_RATE_PARENT, 0x1f8, 12, 0x1f8, 13, 3,
> 0x1f8, 16, 4, 0x1f8, 20, 4},
> +	{ HI3620_MMC_CIUCLK2,   "mmc_bclk2", "mmc_clk2", CLK_SET_RATE_PARENT, 0x1f8, 24, 0x1f8, 25, 3,
> 0x1f8, 28, 4, 0x1fc, 0, 4},
> +	{ HI3620_MMC_CIUCLK3,   "mmc_bclk3", "mmc_clk3", CLK_SET_RATE_PARENT, 0x1fc, 4, 0x1fc, 5, 3,
> 0x1fc, 8, 4, 0x1fc, 12, 4},
> +};
> +
> +static unsigned long mmc_clk_recalc_rate(struct clk_hw *hw,
> +		       unsigned long parent_rate)
> +{
> +	switch (parent_rate) {
> +	case 26000000:
> +		return 13000000;
> +	case 180000000:
> +		return 25000000;
> +	case 360000000:
> +		return 50000000;
> +	case 720000000:
> +		return 100000000;
> +	default:
> +		return parent_rate;
> +	}
> +}
> +
> +static long mmc_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
> +			      unsigned long *best_parent_rate,
> +			      struct clk **best_parent_p)
> +{
> +	struct clk_mmc *mclk = to_mmc(hw);
> +	unsigned long best = 0;
> +
> +	if ((rate <= 13000000) && (mclk->id == HI3620_MMC_CIUCLK1)) {
No need to check HI3620_MMC_CIUCLK2 and HI3620_MMC_CIUCLK3?

> +		rate = 13000000;
> +		best = 26000000;
> +	} else if (rate <= 26000000) {
> +		rate = 25000000;
> +		best = 180000000;
> +	} else if (rate <= 52000000) {
> +		rate = 50000000;
> +		best = 360000000;
> +	} else if (rate <= 100000000) {
> +		rate = 100000000;
> +		best = 720000000;
> +	} else {
> +		/* max is 180M */
> +		rate = 180000000;
> +		best = 1440000000;
> +	}
> +	*best_parent_rate = best;
> +	return rate;
> +}
> +
> +static u32 mmc_clk_delay(u32 val, u32 para, u32 off, u32 len)
> +{
> +	u32 i;
> +
> +	if (para >= 0) {
> +		for (i = 0; i < len; i++) {
> +			if (para % 2)
> +				val |= 1 << (off + i);
> +			else
> +				val &= ~(1 << (off + i));
> +			para = para >> 1;
> +		}
> +	}
> +	return val;
> +}
> +
> +static int mmc_clk_set_timing(struct clk_hw *hw, unsigned long rate)
> +{
> +	struct clk_mmc *mclk = to_mmc(hw);
> +	unsigned long flags;
> +	u32 sam, drv, div, val;
> +	static DEFINE_SPINLOCK(mmc_clk_lock);
> +
> +	switch (rate) {
> +	case 13000000:
> +		sam = 3;
> +		drv = 1;
> +		div = 1;
> +		break;
> +	case 25000000:
> +		sam = 13;
> +		drv = 6;
> +		div = 6;
> +		break;
> +	case 50000000:
> +		sam = 3;
> +		drv = 6;
> +		div = 6;
> +		break;
> +	case 100000000:
> +		sam = 6;
> +		drv = 4;
> +		div = 6;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	spin_lock_irqsave(&mmc_clk_lock, flags);
> +
> +	val = readl_relaxed(mclk->clken_reg);
> +	val &= ~(1 << mclk->clken_bit);
> +	writel_relaxed(val, mclk->clken_reg);
> +
> +	val = readl_relaxed(mclk->sam_reg);
> +	val = mmc_clk_delay(val, sam, mclk->sam_off, mclk->sam_bits);
> +	writel_relaxed(val, mclk->sam_reg);
> +
> +	val = readl_relaxed(mclk->drv_reg);
> +	val = mmc_clk_delay(val, drv, mclk->drv_off, mclk->drv_bits);
> +	writel_relaxed(val, mclk->drv_reg);
> +
> +	val = readl_relaxed(mclk->div_reg);
> +	val = mmc_clk_delay(val, div, mclk->div_off, mclk->div_bits);
> +	writel_relaxed(val, mclk->div_reg);
> +
> +	val = readl_relaxed(mclk->clken_reg);
> +	val |= 1 << mclk->clken_bit;
> +	writel_relaxed(val, mclk->clken_reg);
> +
> +	spin_unlock_irqrestore(&mmc_clk_lock, flags);
> +
> +	return 0;
> +}
> +
> +static int mmc_clk_prepare(struct clk_hw *hw)
> +{
> +	struct clk_mmc *mclk = to_mmc(hw);
> +	unsigned long rate;
> +
> +	if (mclk->id == HI3620_MMC_CIUCLK1)
HI3620_SD_CIUCLK was used in previous version.
Is it fixed with HI3620_MMC_CIUCLK1?
And, please clarify in case of HI3620_MMC_CIUCLK2 and HI3620_MMC_CIUCLK3 as well.

Thanks,
Seungwon Jeon

> +		rate = 13000000;
> +	else
> +		rate = 25000000;
> +
> +	return mmc_clk_set_timing(hw, rate);
> +}
> +
> +static int mmc_clk_set_rate(struct clk_hw *hw, unsigned long rate,
> +			     unsigned long parent_rate)
> +{
> +	return mmc_clk_set_timing(hw, rate);
> +}
> +
> +static struct clk_ops clk_mmc_ops = {
> +	.prepare = mmc_clk_prepare,
> +	.determine_rate = mmc_clk_determine_rate,
> +	.set_rate = mmc_clk_set_rate,
> +	.recalc_rate = mmc_clk_recalc_rate,
> +};
> +
> +static struct clk *hisi_register_clk_mmc(struct hisi_mmc_clock *mmc_clk,
> +			void __iomem *base, struct device_node *np)
> +{
> +	struct clk_mmc *mclk;
> +	struct clk *clk;
> +	struct clk_init_data init;
> +
> +	mclk = kzalloc(sizeof(*mclk), GFP_KERNEL);
> +	if (!mclk) {
> +		pr_err("%s: fail to allocate mmc clk\n", __func__);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	init.name = mmc_clk->name;
> +	init.ops = &clk_mmc_ops;
> +	init.flags = mmc_clk->flags | CLK_IS_BASIC;
> +	init.parent_names = (mmc_clk->parent_name ? &mmc_clk->parent_name : NULL);
> +	init.num_parents = (mmc_clk->parent_name ? 1 : 0);
> +	mclk->hw.init = &init;
> +
> +	mclk->id = mmc_clk->id;
> +	mclk->clken_reg = base + mmc_clk->clken_reg;
> +	mclk->clken_bit = mmc_clk->clken_bit;
> +	mclk->div_reg = base + mmc_clk->div_reg;
> +	mclk->div_off = mmc_clk->div_off;
> +	mclk->div_bits = mmc_clk->div_bits;
> +	mclk->drv_reg = base + mmc_clk->drv_reg;
> +	mclk->drv_off = mmc_clk->drv_off;
> +	mclk->drv_bits = mmc_clk->drv_bits;
> +	mclk->sam_reg = base + mmc_clk->sam_reg;
> +	mclk->sam_off = mmc_clk->sam_off;
> +	mclk->sam_bits = mmc_clk->sam_bits;
> +
> +	clk = clk_register(NULL, &mclk->hw);
> +	if (WARN_ON(IS_ERR(clk)))
> +		kfree(mclk);
> +	return clk;
> +}
> +
> +static void __init hi3620_mmc_clk_init(struct device_node *node)
> +{
> +	void __iomem *base;
> +	int i, num = ARRAY_SIZE(hi3620_mmc_clks);
> +	struct clk_onecell_data *clk_data;
> +
> +	if (!node) {
> +		pr_err("failed to find pctrl node in DTS\n");
> +		return;
> +	}
> +
> +	base = of_iomap(node, 0);
> +	if (!base) {
> +		pr_err("failed to map pctrl\n");
> +		return;
> +	}
> +
> +	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
> +	if (WARN_ON(!clk_data))
> +		return;
> +
> +	clk_data->clks = kzalloc(sizeof(struct clk *) * num, GFP_KERNEL);
> +	if (!clk_data->clks) {
> +		pr_err("%s: fail to allocate mmc clk\n", __func__);
> +		return;
> +	}
> +
> +	for (i = 0; i < num; i++) {
> +		struct hisi_mmc_clock *mmc_clk = &hi3620_mmc_clks[i];
> +		clk_data->clks[mmc_clk->id] =
> +			hisi_register_clk_mmc(mmc_clk, base, node);
> +	}
> +
> +	clk_data->clk_num = num;
> +	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +}
> +
> +CLK_OF_DECLARE(hi3620_mmc_clk, "hisilicon,hi3620-mmc-clock", hi3620_mmc_clk_init);
> diff --git a/include/dt-bindings/clock/hi3620-clock.h b/include/dt-bindings/clock/hi3620-clock.h
> index 6eaa6a45e110..21b9d0e2eb0c 100644
> --- a/include/dt-bindings/clock/hi3620-clock.h
> +++ b/include/dt-bindings/clock/hi3620-clock.h
> @@ -147,6 +147,11 @@
>  #define HI3620_MMC_CLK3		217
>  #define HI3620_MCU_CLK		218
> 
> +#define HI3620_SD_CIUCLK	0
> +#define HI3620_MMC_CIUCLK1	1
> +#define HI3620_MMC_CIUCLK2	2
> +#define HI3620_MMC_CIUCLK3	3
> +
>  #define HI3620_NR_CLKS		219
> 
>  #endif	/* __DTS_HI3620_CLOCK_H */
> --
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

