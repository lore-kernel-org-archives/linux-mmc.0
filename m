Return-Path: <SRS0=5vaz=BW=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9331DC433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Aug 2020 12:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7942A207F7
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Aug 2020 12:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgHLMIZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbgHLMIZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Aug 2020 08:08:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6D7C06174A
        for <linux-mmc@vger.kernel.org>; Wed, 12 Aug 2020 05:08:24 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1k5pYK-0007Gt-NL; Wed, 12 Aug 2020 14:08:20 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1k5pYJ-00087Y-7J; Wed, 12 Aug 2020 14:08:19 +0200
Message-ID: <f65aeebb6c372a7138e496a30ce39f879d4e24ed.camel@pengutronix.de>
Subject: Re: [PATCH 3/3] mmc: mediatek: add optional module reset property
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Wenbin Mei <wenbin.mei@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
Date:   Wed, 12 Aug 2020 14:08:19 +0200
In-Reply-To: <20200812093726.10123-4-wenbin.mei@mediatek.com>
References: <20200812093726.10123-1-wenbin.mei@mediatek.com>
         <20200812093726.10123-4-wenbin.mei@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2020-08-12 at 17:37 +0800, Wenbin Mei wrote:
> This patch adds a optional reset management for msdc.
> Sometimes the bootloader does not bring msdc register
> to default state, so need reset the msdc controller.
> 
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 39e7fc54c438..2b243c03c9b2 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -22,6 +22,7 @@
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/interrupt.h>
> +#include <linux/reset.h>
>  
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/core.h>
> @@ -434,6 +435,7 @@ struct msdc_host {
>  	struct msdc_save_para save_para; /* used when gate HCLK */
>  	struct msdc_tune_para def_tune_para; /* default tune setting */
>  	struct msdc_tune_para saved_tune_para; /* tune result of CMD21/CMD19 */
> +	struct reset_control *reset;
>  };
>  
>  static const struct mtk_mmc_compatible mt8135_compat = {
> @@ -1516,6 +1518,12 @@ static void msdc_init_hw(struct msdc_host *host)
>  	u32 val;
>  	u32 tune_reg = host->dev_comp->pad_tune_reg;
>  
> +	if (!IS_ERR(host->reset)) {
> +		reset_control_assert(host->reset);
> +		usleep_range(10, 50);
> +		reset_control_deassert(host->reset);
> +	}
> +

This should be:

	if (host->reset) {
		reset_control_assert(host->reset);
		usleep_range(10, 50);
		reset_control_deassert(host->reset);
	}

>  	/* Configure to MMC/SD mode, clock free running */
>  	sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_MODE | MSDC_CFG_CKPDN);
>  
> @@ -2273,6 +2281,11 @@ static int msdc_drv_probe(struct platform_device *pdev)
>  	if (IS_ERR(host->src_clk_cg))
>  		host->src_clk_cg = NULL;
>  
> +	host->reset = devm_reset_control_get_optional_exclusive(&pdev->dev,
> +								"hrst");
> +	if (PTR_ERR(host->reset) == -EPROBE_DEFER)
> +		return PTR_ERR(host->reset);
> +

This should be:

	host->reset = devm_reset_control_get_optional_exclusive(&pdev->dev,
								"hrst");
	if (IS_ERR(host->reset))
		return PTR_ERR(host->reset);

If the reset is configured in DT then it should be used, even if the
reset driver is loaded later.

If the DT does not contain the reset-names = "hrst" property at all,
devm_reset_control_get_optional_*() will return NULL.

With these two changes,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
