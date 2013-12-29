From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Sun, 29 Dec 2013 22:05:01 +0100
Message-ID: <201312292205.02135.arnd@arndb.de>
References: <1388241295-20051-1-git-send-email-zhangfei.gao@linaro.org> <1388241295-20051-3-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:62711 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394Ab3L2VFl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Dec 2013 16:05:41 -0500
In-Reply-To: <1388241295-20051-3-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, Mike Turquette <mturquette@linaro.org>, Rob Herring <robherring2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Kumar Gala <galak@codeaurora.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org, Zhigang Wang <brooke.wangzhigang@huawei.com>

On Saturday 28 December 2013, Zhangfei Gao wrote:
> Add dw_mmc-k3.c for k3v2, support sd/emmc
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Zhigang Wang <brooke.wangzhigang@huawei.com>
> ---
>  .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   60 ++++++++++
>  drivers/mmc/host/Kconfig                           |   10 ++
>  drivers/mmc/host/Makefile                          |    1 +
>  drivers/mmc/host/dw_mmc-k3.c                       |  126 ++++++++++++++++++++
>  4 files changed, 197 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
>  create mode 100644 drivers/mmc/host/dw_mmc-k3.c
> 
> diff --git a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> new file mode 100644
> index 000000000000..d7e2d7f159bb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> @@ -0,0 +1,60 @@
> +* Hisilicon specific extensions to the Synopsys Designware Mobile
> +  Storage Host Controller
> +
> +Read synopsys-dw-mshc.txt for more details
> +
> +The Synopsys designware mobile storage host controller is used to interface
> +a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
> +differences between the core Synopsys dw mshc controller properties described
> +by synopsys-dw-mshc.txt and the properties used by the Hisilicon specific
> +extensions to the Synopsys Designware Mobile Storage Host Controller.
> +
> +Required Properties:
> +
> +* compatible: should be one of the following.
> +  - "hisilicon,hi4511-dw-mshc": for controllers with hi4511 specific extentions.

I wonder if this is actually a different variant of the mshc hardware, or just
wired up in a different way. Do you know details?

Since the only difference in the binding is the presence of the "clock-freq-table"
property, we could also make this property generic for the mshc driver and use
it if present but fall back to the normal behavior when it is absent.

> +* clock-freq-table: should be the frequency (in Hz) array of the ciu clock
> +	in each	supported mode.
> +	0. CIU clock rate in Hz for DS mode
> +	1. CIU clock rate in Hz for MMC HS mode
> +	2. CIU clock rate in Hz for SD HS mode
> +	3. CIU clock rate in Hz for SDR12 mode
> +	4. CIU clock rate in Hz for SDR25 mode
> +	5. CIU clock rate in Hz for SDR50 mode
> +	6. CIU clock rate in Hz for SDR104 mode
> +	7. CIU clock rate in Hz for DDR50 mode
> +	8. CIU clock rate in Hz for HS200 mode

This looks god now.

> +static void dw_mci_k3_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> +{
> +	struct dw_mci_k3_priv_data *priv = host->priv;
> +	u32 rate = priv->clk_table[ios->timing];
> +	int ret;

I think this should have some range checking to see if the mode that is
being set had a clock frequency set in the DT.

> +
> +	ret = clk_set_rate(host->ciu_clk, rate);
> +	if (ret)
> +		dev_warn(host->dev, "failed to set clock rate %uHz\n", rate);
> +
> +	host->bus_hz = clk_get_rate(host->ciu_clk);
> +}

Why do you call clk_get_rate() here, shouldn't it always be the same
rate that you have just set?

> +static int dw_mci_k3_parse_dt(struct dw_mci *host)
> +{
> +	struct dw_mci_k3_priv_data *priv;
> +	struct device_node *node = host->dev->of_node;
> +	struct property *prop;
> +	const __be32 *cur;
> +	u32 val, num = 0;
> +
> +	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		dev_err(host->dev, "mem alloc failed for private data\n");
> +		return -ENOMEM;
> +	}
> +	host->priv = priv;
> +
> +	of_property_for_each_u32(node, "clock-freq-table", prop, cur, val) {
> +		if (num >= MAX_NUMS)
> +			break;
> +		priv->clk_table[num++] = val;
> +	}
> +	return 0;
> +}

If we make this property part of the generic binding, this function could
also get moved to the main dw_mci driver.

> +static int dw_mci_k3_suspend(struct device *dev)
> +{
> +	struct dw_mci *host = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	ret = dw_mci_suspend(host);

You should never initialize local variables when they are set later in the
function (the ret = 0 part above). For more complex functions, this prevents
gcc from warning you about accidentally uninitialized uses.

> +	if (!ret)
> +		clk_disable_unprepare(host->ciu_clk);
> +
> +	return ret;
> +}

The suspend/resume code also looks very generic. Can't we make these the
default for dw-mci? If you do both, you won't even need a k3 specific driver.
I think in general we should try hard to add code like this to the common
driver when there is a chance that it can be shared with other platforms.

	Arnd
