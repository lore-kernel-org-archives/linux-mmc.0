Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0B5C2B9F4
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Jun 2021 12:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6995061626
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Jun 2021 12:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhFYMIa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 25 Jun 2021 08:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhFYMIa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Jun 2021 08:08:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0158CC061574
        for <linux-mmc@vger.kernel.org>; Fri, 25 Jun 2021 05:06:09 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lwkav-00082P-Tq; Fri, 25 Jun 2021 14:06:01 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1lwkav-0007Xd-3u; Fri, 25 Jun 2021 14:06:01 +0200
Date:   Fri, 25 Jun 2021 14:06:01 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] i2c: imx: : use proper DMAENGINE API for termination
Message-ID: <20210625120601.vmwn4ct7mrnusijb@pengutronix.de>
References: <20210623095942.3325-1-wsa+renesas@sang-engineering.com>
 <20210623095942.3325-3-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210623095942.3325-3-wsa+renesas@sang-engineering.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 14:03:03 up 205 days,  2:09, 48 users,  load average: 0.18, 0.21,
 0.09
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello Wolfram,

On Wed, Jun 23, 2021 at 11:59:36AM +0200, Wolfram Sang wrote:
> dmaengine_terminate_all() is deprecated in favor of explicitly saying if
> it should be sync or async. Here, we want dmaengine_terminate_sync()
> because there is no other synchronization code in the driver to handle
> an async case.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de

Thank you!

> ---
>  drivers/i2c/busses/i2c-imx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index dc5ca71906db..b224e82924d2 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -423,7 +423,7 @@ static int i2c_imx_dma_xfer(struct imx_i2c_struct *i2c_imx,
>  	return 0;
>  
>  err_submit:
> -	dmaengine_terminate_all(dma->chan_using);
> +	dmaengine_terminate_sync(dma->chan_using);
>  err_desc:
>  	dma_unmap_single(chan_dev, dma->dma_buf,
>  			dma->dma_len, dma->dma_data_dir);
> @@ -899,7 +899,7 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
>  				&i2c_imx->dma->cmd_complete,
>  				msecs_to_jiffies(DMA_TIMEOUT));
>  	if (time_left == 0) {
> -		dmaengine_terminate_all(dma->chan_using);
> +		dmaengine_terminate_sync(dma->chan_using);
>  		return -ETIMEDOUT;
>  	}
>  
> @@ -954,7 +954,7 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
>  				&i2c_imx->dma->cmd_complete,
>  				msecs_to_jiffies(DMA_TIMEOUT));
>  	if (time_left == 0) {
> -		dmaengine_terminate_all(dma->chan_using);
> +		dmaengine_terminate_sync(dma->chan_using);
>  		return -ETIMEDOUT;
>  	}
>  
> -- 
> 2.30.2
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
