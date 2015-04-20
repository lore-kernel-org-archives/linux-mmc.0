From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 3/5] mmc: mediatek: Add PM support for MMC driver
Date: Mon, 20 Apr 2015 08:52:29 +0200
Message-ID: <20150420065229.GP4946@pengutronix.de>
References: <1426562035-16709-1-git-send-email-chaotian.jing@mediatek.com>
 <1426562035-16709-4-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38334 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbbDTGwl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Apr 2015 02:52:41 -0400
Content-Disposition: inline
In-Reply-To: <1426562035-16709-4-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, srv_heupstream@mediatek.com, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Hongzhou Yang <hongzhou.yang@mediatek.com>, Catalin Marinas <catalin.marinas@arm.com>, bin.zhang@mediatek.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, linux-arm-kernel@lists.infradead.org

On Tue, Mar 17, 2015 at 11:13:53AM +0800, Chaotian Jing wrote:
> Add PM support for Mediatek MMC driver
> 
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 93 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 86c999b..e02f6a6 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1186,6 +1232,8 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	int ret;
>  	u32 ddr = 0;
>  
> +	pm_runtime_get_sync(host->dev);
> +
>  	if (ios->timing == MMC_TIMING_UHS_DDR50)
>  		ddr = 1;
>  
> @@ -1230,6 +1278,9 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  
>  	if (host->mclk != ios->clock || host->ddr != ddr)
>  		msdc_set_mclk(host, ddr, ios->clock);
> +
> +	pm_runtime_mark_last_busy(host->dev);
> +	pm_runtime_put_autosuspend(host->dev);

This may also be imbalanced. This function can return between
pm_runtime_get_sync() and pm_runtime_put_autosuspend().

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
