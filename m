Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CEDC636D4
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Feb 2023 06:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjBQGU5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Feb 2023 01:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjBQGUx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Feb 2023 01:20:53 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E530459722
        for <linux-mmc@vger.kernel.org>; Thu, 16 Feb 2023 22:20:48 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id l11so940896edb.11
        for <linux-mmc@vger.kernel.org>; Thu, 16 Feb 2023 22:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BRkjJ0KLE9J+CcGIe05KhZhO9mfc3EF7Sogidy3iVPY=;
        b=hY0hL6ELqaPw14EoZv37Vw6HJ3IP6bT/HdNEYPcjN8UG61G5RQlJRUUrNhpqGgLjVE
         dmmTAvcI71gPuYMK5r6S44jNPdBzx0nErSMkNlEPIC/XlUr3Sw+EgZtbKpSqfdqWne0E
         72blv4KtKdAVw9UdDPcwUBbtdp6jN0kLyV/M5j5tplllUNB4nc99QTR1Z+5FkKkOdHjz
         rFfJj8Lve31rI0Tqq3x+RqHlvsYDXhk6ufHkphHN3c5aqOLG9F1PDySHLDegvAb1zsZP
         FX1PMnh3UHnlwDJWYJ8ud9taPLvDAdHlX32iUqDgSlvDJuY2NxfcfPGIkJTHQAYI0vWT
         aWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRkjJ0KLE9J+CcGIe05KhZhO9mfc3EF7Sogidy3iVPY=;
        b=nGmOckBfY0zUWllpePoRHEXMerqULrnhAK+BUqFy3KlPPaOS9MAK5IAmBnJxvwZQRJ
         b4edPe9dKwcroatjWOkanUhXjf5CJQ1vDH7giUSVSyVRB19A+Btq91rpvNLgdyRN7+7B
         3wnenVSNnkaHlrJ/KHlgCXj58H91po5WCBoLFUYwVAvN2qOqT6D4/yabFIT/FhYwS0EZ
         hkYKSQs/uxiM7BpUINKB0Dq4uFOekumgfF7D/IpF9qroK2zGdGrmc+Ws2F9I8ZbAsG+B
         BNoVEX35Of6DGazj/DHFI8KRLjvu7ewxkhX3XPkfvV0QKSQlWu/xhJtUhbBhKk9mhwvn
         p4Gg==
X-Gm-Message-State: AO0yUKWeQlpHqqxfbhzZgyK3F474xMgRJMS7aXBQhDJOZBSJWIcFNJP2
        XalRv6zAdiwVP+TvoeMJPcRvWsJnQOo=
X-Google-Smtp-Source: AK7set9+rRNaYnmolED2ixU68ydl1kH0ZPxSxkwPdWug+Ie1v7SCCIgdvr33HkYm4xWuSgojSGczDQ==
X-Received: by 2002:a17:907:a70f:b0:8ae:6b88:e52d with SMTP id vw15-20020a170907a70f00b008ae6b88e52dmr4098993ejc.7.1676614847263;
        Thu, 16 Feb 2023 22:20:47 -0800 (PST)
Received: from ?IPV6:2a01:c23:c0ef:9000:ad67:93c6:77de:151f? (dynamic-2a01-0c23-c0ef-9000-ad67-93c6-77de-151f.c23.pool.telefonica.de. [2a01:c23:c0ef:9000:ad67:93c6:77de:151f])
        by smtp.googlemail.com with ESMTPSA id m24-20020a1709060d9800b0084bfd56fb3bsm1690723eji.162.2023.02.16.22.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 22:20:46 -0800 (PST)
Message-ID: <7cb4aa55-6ab1-fbf2-8990-2a6de38ec881@gmail.com>
Date:   Fri, 17 Feb 2023 07:20:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH -next] mmc: core: fix return value check in
 devm_mmc_alloc_host()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org
References: <20230217024333.4018279-1-yangyingliang@huawei.com>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20230217024333.4018279-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 17.02.2023 03:43, Yang Yingliang wrote:
> mmc_alloc_host() returns NULL pointer not PTR_ERR(), if it
> fails, so replace the IS_ERR() check with NULL pointer check.
> 
> In commit 418f7c2de133 ("mmc: meson-gx: use devm_mmc_alloc_host"),
> it checks NULL pointer not PTR_ERR, if devm_mmc_alloc_host() fails,
> so make it to return NULL pointer to keep same with mmc_alloc_host(),
> the drivers don't need to change the error handle when switch to
> use devm_mmc_alloc_host().
> 
> Fixes: 80df83c2c57e ("mmc: core: add devm_mmc_alloc_host")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---

Right, my bad.

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>


>  drivers/mmc/core/host.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 6a7475ad7685..096093f7be00 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -599,12 +599,12 @@ struct mmc_host *devm_mmc_alloc_host(struct device *dev, int extra)
>  
>  	dr = devres_alloc(devm_mmc_host_release, sizeof(*dr), GFP_KERNEL);
>  	if (!dr)
> -		return ERR_PTR(-ENOMEM);
> +		return NULL;
>  
>  	host = mmc_alloc_host(extra, dev);
> -	if (IS_ERR(host)) {
> +	if (!host) {
>  		devres_free(dr);
> -		return host;
> +		return NULL;
>  	}
>  
>  	*dr = host;

