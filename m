From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 3/5] mmc: mediatek: Add PM support for MMC driver
Date: Mon, 20 Apr 2015 08:49:10 +0200
Message-ID: <20150420064910.GO4946@pengutronix.de>
References: <1426562035-16709-1-git-send-email-chaotian.jing@mediatek.com>
 <1426562035-16709-4-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38273 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbbDTGtZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Apr 2015 02:49:25 -0400
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
> @@ -1003,6 +1042,8 @@ static int msdc_ops_switch_volt(struct mmc_host *mmc, struct mmc_ios *ios)
>  
>  	if (!IS_ERR(mmc->supply.vqmmc)) {
>  
> +		pm_runtime_get_sync(host->dev);
> +
>  		if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
>  			min_uv = 3300000;
>  			max_uv = 3300000;
> @@ -1011,6 +1052,9 @@ static int msdc_ops_switch_volt(struct mmc_host *mmc, struct mmc_ios *ios)
>  			max_uv = 1800000;
>  		} else {
>  			dev_err(host->dev, "Unsupported signal voltage!\n");
> +
> +			pm_runtime_mark_last_busy(host->dev);
> +			pm_runtime_put_autosuspend(host->dev);
>  			return -EINVAL;
>  		}
>  
> @@ -1022,6 +1066,8 @@ static int msdc_ops_switch_volt(struct mmc_host *mmc, struct mmc_ios *ios)
>  		}
>  	}
>  
> +	pm_runtime_mark_last_busy(host->dev);
> +	pm_runtime_put_autosuspend(host->dev);

This is unbalanced. You do a pm_runtime_get_sync() depending on
!IS_ERR(mmc->supply.vqmmc), but you call pm_runtime_put_autosuspend()
unconditionally. Besides, I don't see that the pm_ops are necessary here
at all. This function does nothing on the controller.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
