Return-Path: <SRS0=1974=Z2=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40BAC2BD09
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Dec 2019 18:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EC12073B
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Dec 2019 18:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="WeN1DYFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfLDS00 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:26:26 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43246 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729136AbfLDR7g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Dec 2019 12:59:36 -0500
Received: by mail-lf1-f68.google.com with SMTP id 9so252563lfq.10
        for <linux-mmc@vger.kernel.org>; Wed, 04 Dec 2019 09:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NnAlVzxQqhMroKn01NkSHhH1AiWzcz1PmI9bavfgrJc=;
        b=WeN1DYFuz6qbTSF8zkhoLbKbzuVNfXk+eheYaSR5sl8l7VT6/FMYDWq5WGPRfvnH5J
         H8MNUBNoQSqE+4vcLxWE/RWUdaD5IJYzcwo2JfK9YuWz41unCrfR+Qle48w3QCILjEWg
         Ez8MnNPMhxsbPuMM85br73MnhlWzFpCKhze2qQ8EDeAAHJIQrD+3im361r2/IB+J/n2t
         9igTyAlwpmR73SdwjOSYIC//gTGuSGn/CSdokQtjL7m+3KBVu3fK4kUDiDumG+jiva4h
         AzZMu0hKHEdyM7AjQM9lk9YJfzTS8vCI0Z5Ib+M7uKWvqfRHH/Qqvyf7taVRTPVuB0cA
         2BTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NnAlVzxQqhMroKn01NkSHhH1AiWzcz1PmI9bavfgrJc=;
        b=HB5KuhUI+ASojWL+0Ecce+PTkWRBqu+8oXCJvmlWPi6S6VOxnKBaQHRZWEe8ssITyK
         T59uPf4SKl99gy2aUZcchSmvBW1FjnTFf89Mt6RQwCpVG/PogmHUcqZC4muLg2fvI2+s
         AWNxbE+mc2w+Rc7A+Dton+YUXO1vVqwRjp6zr07jZCnG76VE+AaqtAdMN603z52vG/sx
         z0hLvGRmb6geOsURE02xVePmqDe+VocMdxIjhkmeBE64sqn8j6ow0CspyUjMnSn/zxN1
         SPNYUgAmsvfanon1K7MtLe9DnF5Z2AGYXw+InES7UE9zu6/zeY5ZaBYIN44aL2P5MPoF
         5wOA==
X-Gm-Message-State: APjAAAXemPsQRIcpu5L6GeDoHGwAs7c0txr0fA1LKmQngVdnJMEEMwZH
        5O3gmKsylH617nHm8sVLF6BF7g==
X-Google-Smtp-Source: APXvYqxAicaegGYqhgVeHIRwqaquF9yndaug/Pn5IjDuFHRTfXfishhbMH/UMK7nJZNlprMmTtCHBg==
X-Received: by 2002:ac2:5310:: with SMTP id c16mr2918290lfh.101.1575482374477;
        Wed, 04 Dec 2019 09:59:34 -0800 (PST)
Received: from localhost (h-93-159.A463.priv.bahnhof.se. [46.59.93.159])
        by smtp.gmail.com with ESMTPSA id q25sm3661450lji.7.2019.12.04.09.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 09:59:33 -0800 (PST)
Date:   Wed, 4 Dec 2019 18:59:33 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: remove whitelist for internal DMAC
Message-ID: <20191204175933.GD28879@bigcity.dyn.berto.se>
References: <20191203194859.917-1-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191203194859.917-1-wsa@the-dreams.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Wolfram,

Thanks for your work.

On 2019-12-03 20:48:59 +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> We know now that there won't be Gen3 SoCs with both, SYS-DMAC and
> internal DMAC. We removed the blacklisting for SYS-DMAC already, so we
> can remove the whitelisting for internal DMAC, too. This makes adding
> new SoCs easier. We keep the quirk handling, of course.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 23 ++++---------------
>  1 file changed, 4 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index 68fb39a74b8b..47ac53e91241 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -298,38 +298,23 @@ static const struct tmio_mmc_dma_ops renesas_sdhi_internal_dmac_dma_ops = {
>   * Whitelist of specific R-Car Gen3 SoC ES versions to use this DMAC
>   * implementation as others may use a different implementation.
>   */
> -static const struct soc_device_attribute soc_whitelist[] = {
> -	/* specific ones */
> +static const struct soc_device_attribute soc_dma_quirks[] = {
>  	{ .soc_id = "r7s9210",
>  	  .data = (void *)BIT(SDHI_INTERNAL_DMAC_ADDR_MODE_FIXED_ONLY) },
>  	{ .soc_id = "r8a7795", .revision = "ES1.*",
>  	  .data = (void *)BIT(SDHI_INTERNAL_DMAC_ONE_RX_ONLY) },
>  	{ .soc_id = "r8a7796", .revision = "ES1.0",
>  	  .data = (void *)BIT(SDHI_INTERNAL_DMAC_ONE_RX_ONLY) },
> -	/* generic ones */
> -	{ .soc_id = "r8a774a1" },
> -	{ .soc_id = "r8a774b1" },
> -	{ .soc_id = "r8a774c0" },
> -	{ .soc_id = "r8a77470" },
> -	{ .soc_id = "r8a7795" },
> -	{ .soc_id = "r8a7796" },
> -	{ .soc_id = "r8a77965" },
> -	{ .soc_id = "r8a77970" },
> -	{ .soc_id = "r8a77980" },
> -	{ .soc_id = "r8a77990" },
> -	{ .soc_id = "r8a77995" },
>  	{ /* sentinel */ }
>  };
>  
>  static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
>  {
> -	const struct soc_device_attribute *soc = soc_device_match(soc_whitelist);
> +	const struct soc_device_attribute *soc = soc_device_match(soc_dma_quirks);
>  	struct device *dev = &pdev->dev;
>  
> -	if (!soc)
> -		return -ENODEV;
> -
> -	global_flags |= (unsigned long)soc->data;
> +	if (soc)
> +		global_flags |= (unsigned long)soc->data;
>  
>  	dev->dma_parms = devm_kzalloc(dev, sizeof(*dev->dma_parms), GFP_KERNEL);
>  	if (!dev->dma_parms)
> -- 
> 2.20.1
> 

-- 
Regards,
Niklas Söderlund
