Return-Path: <SRS0=wLMj=2I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4B2C43603
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 06:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515AF218AC
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 06:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WVTTapXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfLRGad (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Dec 2019 01:30:33 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41200 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfLRGac (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2019 01:30:32 -0500
Received: by mail-pg1-f195.google.com with SMTP id x8so699711pgk.8
        for <linux-mmc@vger.kernel.org>; Tue, 17 Dec 2019 22:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QUqCKPDBExCLLAwVtzgi61MYbDhx2OZCOHrZup6vycw=;
        b=WVTTapXo9831RocflUB0ikHKFJuh9iAvfg6my6hM4pUeSOGR+cnsYT1tCVdopTiQHg
         a9iyF7SBYSz9UrCG2ZhM5bNW2gpuyr4iZK+AREwohsVYFPGEm3aJRxhiJoNKRvDCWBHH
         4E9e9gsfZo2EyGyj4UVSpFyMPwZKH/MGKHkN/6w3Dc+ayTlnFZSl8dy9UlJEuimtMebw
         hR1PyhRC8cTn/D+OJt/V/RKflu+iF9f35hC5f/4d3DJNrgZ6hbymq2gc7V/5oso7HO6F
         xqeBCMVDMd5B6szz4pJ9wsJuj00hJjcZf+ZH3dqw1+1/63XOgvTlvCVrQzT4/Etad3w1
         4QYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QUqCKPDBExCLLAwVtzgi61MYbDhx2OZCOHrZup6vycw=;
        b=c+LsDhxszXQqISgyX2jLwPJ+dCvQsnU4X3OHcgYLl0M/EYGX3qB/pLHdmALNpqnypH
         dBzlOGp+vJckYsrTdhSZwf+MG9YAPlCub0eCnUXfsr5eSNfwiRmSr5Kb4CSn6cUZmJPm
         s4MPfAM80Tsel4d5ZIj65f2Jq8yUKd3rwXRmaJaYdaw/czFLAQ6QLIN3pt2XcbZKwzZE
         YaKyRHmTQ/mp4ocCIIudBqehont2LXD877bznkhDH7hF5EKDTtlC22wfwGK5jmtG/ObO
         A/CGvRp55bpa3DIqB967bv8BOj+YHKBqlGIA4sjW0KYmbk37AW/cnF56wcTKYTVlkA6b
         PCqQ==
X-Gm-Message-State: APjAAAWqUEAN7mhM9ExqhTJLvDH6LvRyzusBt0MpSByijdvb0+Htl5aN
        nVEWfSL3w8YWKvTv85JPfHX/hg==
X-Google-Smtp-Source: APXvYqzIvX0pWBlNmYdcCxRQD7mXEfg6Upgu8h5ATMfO9O8MRrkIOt+XJa8qeUETe/PDXbEwm9iagA==
X-Received: by 2002:aa7:848c:: with SMTP id u12mr1237038pfn.12.1576650631883;
        Tue, 17 Dec 2019 22:30:31 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p5sm1253789pgs.28.2019.12.17.22.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 22:30:31 -0800 (PST)
Date:   Tue, 17 Dec 2019 22:30:28 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     manuel.lauss@gmail.com, ulf.hansson@linaro.org,
        khilman@baylibre.com, chaotian.jing@mediatek.com,
        matthias.bgg@gmail.com, nico@fluxnic.net, adrian.hunter@intel.com,
        agross@kernel.org, ben-linux@fluff.org, jh80.chung@samsung.com,
        vireshk@kernel.org, mripard@kernel.org, wens@csie.org,
        wsa+renesas@sang-engineering.com, gregkh@linuxfoundation.org,
        kstewart@linuxfoundation.org, yamada.masahiro@socionext.com,
        tglx@linutronix.de, allison@lohutok.net,
        yoshihiro.shimoda.uh@renesas.com, geert+renesas@glider.be,
        linus.walleij@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 10/13] mmc: sdhci-msm: convert to
 devm_platform_ioremap_resource
Message-ID: <20191218063028.GC3755841@builder>
References: <20191215175120.3290-1-tiny.windzz@gmail.com>
 <20191215175120.3290-10-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191215175120.3290-10-tiny.windzz@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun 15 Dec 09:51 PST 2019, Yangtao Li wrote:

> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/mmc/host/sdhci-msm.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 3d0bb5e2e09b..6daacef4ceec 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1746,7 +1746,6 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	struct sdhci_host *host;
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_msm_host *msm_host;
> -	struct resource *core_memres;
>  	struct clk *clk;
>  	int ret;
>  	u16 host_version, core_minor;
> @@ -1847,9 +1846,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	}
>  
>  	if (!msm_host->mci_removed) {
> -		core_memres = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -		msm_host->core_mem = devm_ioremap_resource(&pdev->dev,
> -				core_memres);
> +		msm_host->core_mem = devm_platform_ioremap_resource(pdev, 1);
>  

This would now look better without this empty line.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

>  		if (IS_ERR(msm_host->core_mem)) {
>  			ret = PTR_ERR(msm_host->core_mem);
> -- 
> 2.17.1
> 
