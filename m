Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48B9C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Jan 2021 04:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B194D64DFF
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Jan 2021 04:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhA2Exo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 Jan 2021 23:53:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:53110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232001AbhA2Exa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 28 Jan 2021 23:53:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDC9364DFA;
        Fri, 29 Jan 2021 04:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611895966;
        bh=ndgDpQHViGjLxgWz2mWzqn5rMQh0pUwe6J4ppc2KnCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BXDgAwxLXCU6dvakCJnY30q6Riwi9vWKQLvDubrnfakI4NqSgFKt6u+813qPGPAnp
         4Mnxdu18GNGiqunHSGgWakuJn1j5JLy6YZLLrP9P/hFSw+QM5kFY0OcCl0kKOR2yvG
         RczjpHR74byUulMBW8xuJvjNMRrg8bfcfL1OFAJ9yWLxMZEGC0bPCJyLNqAKois5JD
         4HBOXlnTDVx1Gtjah/zkxrazny1OKX3rmqWtTbJvq8l4hk1AGJ/q8WI2WmKhcTDXBH
         7r8PYcJFCpGKj+Z2tdlUZdEX5ImtlIRQ7kiW7oLJSbsC5Ex/jU3AQIpdySX5mP5IRI
         ndEU6KgPez6Hw==
Date:   Thu, 28 Jan 2021 20:52:44 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Peng Zhou <peng.zhou@mediatek.com>
Cc:     linux-mmc@vger.kernel.org,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Satya Tangirala <satyat@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wulin Li <wulin.li@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: Re: [PATCH 1/2] mmc: mediatek: add Inline Crypto Engine support
Message-ID: <YBOUnFvaqO9ukNCa@sol.localdomain>
References: <20210129033916.26508-1-peng.zhou@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129033916.26508-1-peng.zhou@mediatek.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Peng,

On Fri, Jan 29, 2021 at 11:39:16AM +0800, Peng Zhou wrote:
> Add Inline Crypto Engine(ICE) support into Mediatek MMC Host.
> 
> - add crypto clock control and ungate it before CQHCI init
> - set MMC_CAP2_CRYPTO property of MMC
> 
> Change-Id: I6dc35391fd2841609c5be0df1fe1d12ec28ee0c4
> Signed-off-by: Peng Zhou <peng.zhou@mediatek.com>

This is patch 1 of 2, but I only received patch 1.  Is there a cover letter and
patch 2 as well?

Also, what branch does this apply too?  I tried mmc/next as well as v5.11-rc5,
but neither works.

> ---
>  drivers/mmc/host/mtk-sd.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index de09c6347524..e870afd66ae8 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -441,6 +441,7 @@ struct msdc_host {
>  	struct clk *bus_clk;	/* bus clock which used to access register */
>  	struct clk *src_clk_cg; /* msdc source clock control gate */
>  	struct clk *sys_clk_cg;	/* msdc subsys clock control gate */
> +	struct clk *crypto_clk; /* msdc crypto clock */
>  	struct clk_bulk_data bulk_clks[MSDC_NR_CLOCKS];

Perhaps the new clock should go in bulk_clks so that it doesn't have to be
handled separately?

>  
> +	/* only eMMC has crypto property */
> +#ifdef CONFIG_MMC_CRYPTO
> +	if ((mmc->caps2 & MMC_CAP2_NO_SD) && (mmc->caps2 & MMC_CAP2_NO_SDIO))
> +		mmc->caps2 |= MMC_CAP2_CRYPTO;
> +#endif


This #ifdef is unnecessary (i.e., the code can just be unconditional) because
MMC_CAP2_CRYPTO is #defined to 0 when !CONFIG_MMC_CRYPTO.

> +	if (mmc->caps2 & MMC_CAP2_CRYPTO) {
> +		host->crypto_clk = devm_clk_get(&pdev->dev, "crypto_clk");
> +		if (IS_ERR(host->crypto_clk))
> +	}
> +

Why is there nothing under IS_ERR()?

- Eric
