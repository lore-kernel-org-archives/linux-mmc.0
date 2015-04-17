From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 2/5] mmc: mediatek: Add Mediatek MMC driver
Date: Fri, 17 Apr 2015 15:45:47 +0200
Message-ID: <20150417134547.GN4946@pengutronix.de>
References: <1426562035-16709-1-git-send-email-chaotian.jing@mediatek.com>
 <1426562035-16709-3-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40525 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932977AbbDQNqH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Apr 2015 09:46:07 -0400
Content-Disposition: inline
In-Reply-To: <1426562035-16709-3-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, srv_heupstream@mediatek.com, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Hongzhou Yang <hongzhou.yang@mediatek.com>, Catalin Marinas <catalin.marinas@arm.com>, bin.zhang@mediatek.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, linux-arm-kernel@lists.infradead.org

Hi Chaotian,

On Tue, Mar 17, 2015 at 11:13:52AM +0800, Chaotian Jing wrote:
> Add Mediatek MMC driver code
> 

[...]

> +	host->dev = &pdev->dev;
> +	host->mmc = mmc;
> +	/* Set host parameters to mmc */
> +	mmc->ops = &mt_msdc_ops;
> +	mmc->f_min = 260000;
> +	mmc->ocr_avail = MMC_VDD_30_31 | MMC_VDD_31_32 | MMC_VDD_32_33;
> +
> +	mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
> +	/* MMC core transfer sizes tunable parameters */
> +	mmc->max_segs = MAX_BD_NUM;
> +	mmc->max_seg_size = 64 * 1024;

Earlier versions of this driver had 64 * 1024 - 512 here. Using 64k
breaks SD card support here. Reading the partition table still works
fine, but the next transfers fail with messages like:

mtk-msdc 11240000.mmc: msdc_request_timeout: aborting cmd/data/mrq
mtk-msdc 11240000.mmc: msdc_request_timeout: aborting mrq=ffffffc06e586860 cmd=18
mtk-msdc 11240000.mmc: msdc_request_timeout: abort data: cmd18; 136 blocks
mmcblk1: error -110 transferring data, sector 338488, nr 136, cmd response 0x900, card status 0xb00
mtk-msdc 11240000.mmc: set mclk to 0 mmc1: tried to reset card

Can you confirm this?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
