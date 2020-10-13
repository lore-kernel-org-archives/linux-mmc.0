Return-Path: <SRS0=f1/V=DU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF1DC433E7
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Oct 2020 15:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19321248F5
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Oct 2020 15:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRt3/UN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbgJMPKv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Oct 2020 11:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgJMPKu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Oct 2020 11:10:50 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A002C0613D0;
        Tue, 13 Oct 2020 08:10:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b8so11275143wrn.0;
        Tue, 13 Oct 2020 08:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JuBX8r/Y6bGRUCSeRJ3CivsANkHlQS6AI/ICS0f0yZY=;
        b=pRt3/UN2sjp/Id17E5+iGB+94CwhIYyP+J0ZVxahLZjhYewvdy85p6E9qVH8mcDu/w
         Ma3byumuQbCvWjoxsAbJW0h9gvZLfP0hODyLYPb4jaAc6LzlEhDGij6xWsWm3n9sxLUf
         Y5rBrxFXjECN11m9EMkIOKoMbnLZAve13uQMowkDZfElmt1rBDlqBQDqGG5xuxoTZTGn
         A6f85//dkMxRUTK45bcV3JGGijKAaJzUd4tVdcH6w2iU+1IQzZjujWhrlRnaPHFO/u5I
         TwoDZIkPmDhBYcERTV9R8lQD/E/99qfus11PWOKi7U7sNRgo9fP4mXVVptNJKNu/orur
         1eGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JuBX8r/Y6bGRUCSeRJ3CivsANkHlQS6AI/ICS0f0yZY=;
        b=lc/swWILOmF9u8ypz39We7eo0kmyJ4ooklmUvKrdLT+atY2bUE5Z5rTnTVXjwvSjrG
         vCNP06GpOt1jO1I5P8SJ6SXCtLr8k4oRsaoHE0CDSm52Cp8QTEXwJb+qnCvcW1A5c1gC
         bF+cJryD6/+X6Kr+qGXhUOxe4innhzugxCEVfLkQEr1vpF3fzo6UeUzPgP3ud6IMGoam
         dHCfOm+BXl+WkoZmVv1IESnwGjRXvb+ZhJ+iSSivItevnnqMgc7j90Eqfe+NJ1h4TX/t
         iS53MXV75cMWq37AR55gFXCLVdCgay8Gbp5uPFhU2N7iO1B1NqfkiylAPzL+8YHnNUhc
         wo+w==
X-Gm-Message-State: AOAM530d+gdlk7pl53GPOcO38u6PZBIZNQwL27V++xx8nAd3sbR8JkpV
        c2BEYr07ToGNrM7BskrFTFPcxtNbT86hXw==
X-Google-Smtp-Source: ABdhPJxvj/okZcxLvRTRo8EX8POYCQcaPyYdM1hZZbF6KXlzxIMolIv8YA31Et7icSS3qcMo/t9L9g==
X-Received: by 2002:adf:f4d1:: with SMTP id h17mr107075wrp.41.1602601848929;
        Tue, 13 Oct 2020 08:10:48 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id l11sm31014653wrt.54.2020.10.13.08.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 08:10:47 -0700 (PDT)
Subject: Re: [PATCH v6 4/4] mmc: mediatek: Add subsys clock control for MT8192
 msdc
To:     Wenbin Mei <wenbin.mei@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
References: <20201012124547.16649-1-wenbin.mei@mediatek.com>
 <20201012124547.16649-5-wenbin.mei@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <72ae1d89-fe31-4f50-15c0-29119d662ea1@gmail.com>
Date:   Tue, 13 Oct 2020 17:10:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201012124547.16649-5-wenbin.mei@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 12/10/2020 14:45, Wenbin Mei wrote:
> MT8192 msdc is an independent sub system, we need control more bus
> clocks for it.
> Add support for the additional subsys clocks to allow it to be
> configured appropriately.
> 
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> ---
>   drivers/mmc/host/mtk-sd.c | 74 +++++++++++++++++++++++++++++----------
>   1 file changed, 56 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index a704745e5882..c7df7510f120 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
[...]
> +static int msdc_of_clock_parse(struct platform_device *pdev,
> +			       struct msdc_host *host)
> +{
> +	int ret;
> +
> +	host->src_clk = devm_clk_get(&pdev->dev, "source");
> +	if (IS_ERR(host->src_clk))
> +		return PTR_ERR(host->src_clk);
> +
> +	host->h_clk = devm_clk_get(&pdev->dev, "hclk");
> +	if (IS_ERR(host->h_clk))
> +		return PTR_ERR(host->h_clk);
> +
> +	host->bus_clk = devm_clk_get_optional(&pdev->dev, "bus_clk");
> +	if (IS_ERR(host->bus_clk))
> +		host->bus_clk = NULL;
> +
> +	/*source clock control gate is optional clock*/
> +	host->src_clk_cg = devm_clk_get_optional(&pdev->dev, "source_cg");
> +	if (IS_ERR(host->src_clk_cg))
> +		host->src_clk_cg = NULL;
> +
> +	host->sys_clk_cg = devm_clk_get_optional(&pdev->dev, "sys_cg");
> +	if (IS_ERR(host->sys_clk_cg))
> +		host->sys_clk_cg = NULL;
> +
> +	/* If present, always enable for this clock gate */
> +	clk_prepare_enable(host->sys_clk_cg);
> +
> +	host->bulk_clks[0].id = "pclk_cg";
> +	host->bulk_clks[1].id = "axi_cg";
> +	host->bulk_clks[2].id = "ahb_cg";

That looks at least suspicious. The pointers of id point to some strings defined 
in the function. Aren't they out of scope once msdc_of_clock_parse() has returned?

Regards,
Matthias
