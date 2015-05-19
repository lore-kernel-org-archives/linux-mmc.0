From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4 2/7] mmc: mediatek: Add Mediatek MMC driver
Date: Tue, 19 May 2015 13:15:58 +0200
Message-ID: <20150519111558.GD6325@pengutronix.de>
References: <1432017411-2996-1-git-send-email-chaotian.jing@mediatek.com>
 <1432017411-2996-3-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42968 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932080AbbESLQN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 May 2015 07:16:13 -0400
Content-Disposition: inline
In-Reply-To: <1432017411-2996-3-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, srv_heupstream@mediatek.com, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Hongzhou Yang <hongzhou.yang@mediatek.com>, Catalin Marinas <catalin.marinas@arm.com>, bin.zhang@mediatek.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, linux-arm-kernel@lists.infradead.org

On Tue, May 19, 2015 at 02:36:46PM +0800, Chaotian Jing wrote:
> Add Mediatek MMC driver code
> Support eMMC/SD/SDIO
> 
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/host/Kconfig  |    8 +
>  drivers/mmc/host/Makefile |    1 +
>  drivers/mmc/host/mtk-sd.c | 1422 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1431 insertions(+)
>  create mode 100644 drivers/mmc/host/mtk-sd.c
> 
> +
> +	host->src_clk = devm_clk_get(&pdev->dev, "source");
> +	if (IS_ERR(host->src_clk)) {
> +		ret = PTR_ERR(host->src_clk);
> +		goto host_free;
> +	}
> +
> +	host->h_clk = devm_clk_get(&pdev->dev, "hclk");
> +	if (IS_ERR(host->h_clk)) {
> +		/* host->h_clk is optional, Only for MSDC0/3 at MT8173 */
> +		dev_dbg(&pdev->dev,
> +				"Invalied hclk from the device tree!\n");
> +	}

s/Invalied/Invalid/

According to my reference manual the controller always needs a hclk. It
seems on some controllers it is just not software controllable. If
that's the case you should always provide a hclk to the driver and make
this clock mandatory.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
