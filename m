Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC582C4338F
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Aug 2021 08:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9113461075
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Aug 2021 08:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238241AbhHJIbo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Aug 2021 04:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbhHJIbl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Aug 2021 04:31:41 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07971C0617A1
        for <linux-mmc@vger.kernel.org>; Tue, 10 Aug 2021 01:31:20 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y34so9882215lfa.8
        for <linux-mmc@vger.kernel.org>; Tue, 10 Aug 2021 01:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ynQTKEGDP6NR/lni5MvcIsSt260QCeKiNoA5Wse+aPo=;
        b=Gx62q8P5fLhFnhpipxRLavIIPFy4RdIgnzdZACFl2Org26KMXiJN2gEhvjD8s0tT/Z
         3iPHc+UpdrBGH3p8c+4mDsSebE4iY7P4n48BvaLYKF7lNc9gyPTdx8F6JA248yZgrDAA
         /zr6Uump74MLHz8F7FHr9nlb+yC5ofwEwYyZ6JPo8rCOMqq7nCFEJXk9T/wpGksQgeLd
         gdK8Bi4FVCYZsCdgNyDVKDE9+rY3BNdMnJyZN4T3yLt+sMwiLhb6IRK/Ij/HBEjjM82/
         963Bmq2b1Wzv0YBdRRHuKmhK9FlgQ7xkuZ4Bqz5pLeYfOnZ65oq7F/5GJY0D7O5XqTow
         zWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ynQTKEGDP6NR/lni5MvcIsSt260QCeKiNoA5Wse+aPo=;
        b=OTK7k6KVzKXV20lETvvp6KETem/+N+YEQg/jI1c5Irf9JJJFXFYDmt5skZTNSxx4Rc
         zsADj3wP/e3CP0YpTy26emO2ip9HaAmStCeZsYl7zNXTairSutEKowAexClEoDz1Fwjp
         yzqA2Ysfy5VGKDT8JDdUz44cuRnl3R8Iu3nW+SN11eEdlIUlUD1t4n9PtZ8R3KCEArqF
         SuMzZIKrEEhW8/uIiClfwTKNk/egyLeIp11VBRiaHG7fYW8CDQTodRF1dHr1aaBniQK3
         dzg+zKTRnXcwu8DIftjGyLmI1OjyfiWiu2w/UqVlwO9nx95nLDJ07nSc9KKR2TqOsE6F
         8/pw==
X-Gm-Message-State: AOAM530CeSIznU4LnipfkvJlQGHbZ0rCfqP/sUrSnPJ5YhQjRX7L8j11
        aZEnBZx3kSQeIiAN/8SRm3s=
X-Google-Smtp-Source: ABdhPJzjF+IQGsLLBfY0nWI9CZfNm/eMUNhYWXMKjPurmf/FIZfk10rkIwqoyaBdU9gW0oTsXpWwLg==
X-Received: by 2002:ac2:5dd2:: with SMTP id x18mr20481360lfq.81.1628584278361;
        Tue, 10 Aug 2021 01:31:18 -0700 (PDT)
Received: from [10.0.0.40] (91-155-111-71.elisa-laajakaista.fi. [91.155.111.71])
        by smtp.gmail.com with ESMTPSA id x11sm1982682lfq.91.2021.08.10.01.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 01:31:17 -0700 (PDT)
Subject: Re: [PATCH 1/3] mmc: sdhci: Fix issue with uninitialized
 dma_slave_config
To:     Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>, Vinod Koul <vkoul@kernel.org>
References: <20210810081644.19353-1-tony@atomide.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Message-ID: <8ce97ae6-31ce-1704-6dd3-cc0d7a17a22a@gmail.com>
Date:   Tue, 10 Aug 2021 11:31:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210810081644.19353-1-tony@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 10/08/2021 11:16, Tony Lindgren wrote:
> Depending on the DMA driver being used, the struct dma_slave_config may
> need to be initialized to zero for the unused data.
> 
> For example, we have three DMA drivers using src_port_window_size and
> dst_port_window_size. If these are left uninitialized, it can cause DMA
> failures at least if external TI SDMA is ever configured for sdhci.
> 
> For other external DMA cases, this is probably not currently an issue but
> is still good to fix though.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> Fixes: 18e762e3b7a7 ("mmc: sdhci: add support for using external DMA devices")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Chunyan Zhang <zhang.chunyan@linaro.org>
> Cc: Faiz Abbas <faiz_abbas@ti.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mmc/host/sdhci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1222,6 +1222,7 @@ static int sdhci_external_dma_setup(struct sdhci_host *host,
>  	if (!host->mapbase)
>  		return -EINVAL;
>  
> +	memset(&cfg, 0, sizeof(cfg));
>  	cfg.src_addr = host->mapbase + SDHCI_BUFFER;
>  	cfg.dst_addr = host->mapbase + SDHCI_BUFFER;
>  	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> 

-- 
Péter
