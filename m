Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BFAC433EF
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Nov 2021 14:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6331D6109D
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Nov 2021 14:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhKBOhB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Nov 2021 10:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhKBOg7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Nov 2021 10:36:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76659C061714
        for <linux-mmc@vger.kernel.org>; Tue,  2 Nov 2021 07:34:24 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mhurk-0006U6-OU; Tue, 02 Nov 2021 15:34:20 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mhurk-004FSe-3e; Tue, 02 Nov 2021 15:34:20 +0100
Message-ID: <a79a72c25dc4ab3a07ec74459edb1e8169be8504.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] mmc: Add SD/SDIO driver for Sunplus SP7021
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     "LH.Kuo" <lhjeff911@gmail.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     dvorkin@tibbo.com, qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Date:   Tue, 02 Nov 2021 15:34:20 +0100
In-Reply-To: <1635487055-18494-2-git-send-email-lh.kuo@sunplus.com>
References: <1635487055-18494-1-git-send-email-lh.kuo@sunplus.com>
         <1635487055-18494-2-git-send-email-lh.kuo@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 2021-10-29 at 13:57 +0800, LH.Kuo wrote:
[...]
> --- /dev/null
> +++ b/drivers/mmc/host/sunplus_sd2.c
> @@ -0,0 +1,1069 @@
[...]
> +static void spsdc_controller_init(struct spsdc_host *host)
> +{
> +	u32 value;
> +	int ret = reset_control_assert(host->rstc);
> +
> +	if (!ret) {
> +		mdelay(1);

Consider using usleep_range(), see Documentation/timers/timers-howto.rst

[...]
> +static int spsdc_drv_probe(struct platform_device *pdev)
> +{
> +	int ret = 0;
> +	struct mmc_host *mmc;
> +	struct resource *resource;
> +	struct spsdc_host *host;
> +	unsigned int mode;
> +
> +	mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);
> +	if (!mmc) {
> +		ret = -ENOMEM;
> +		goto probe_free_host;
> +	}
> +
> +	host = mmc_priv(mmc);
> +	host->mmc = mmc;
> +	host->power_state = MMC_POWER_OFF;
> +	host->dma_int_threshold = 1024;
> +	host->dmapio_mode = SPSDC_DMA_MODE;
> +
> +	host->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(host->clk)) {
> +		spsdc_pr(ERROR, "Can not find clock source\n");
> +		ret = PTR_ERR(host->clk);
> +		goto probe_free_host;
> +	}
> +
> +	host->rstc = devm_reset_control_get(&pdev->dev, NULL);

Please use devm_reset_control_get_exclusive() instead.

regards
Philipp
