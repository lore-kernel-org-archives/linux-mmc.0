Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14971C4332F
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Nov 2022 09:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiKIJrJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Nov 2022 04:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiKIJq6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Nov 2022 04:46:58 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2430F23177
        for <linux-mmc@vger.kernel.org>; Wed,  9 Nov 2022 01:46:53 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id l14so24926183wrw.2
        for <linux-mmc@vger.kernel.org>; Wed, 09 Nov 2022 01:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SjAxgNVa5Iy7P1HQop4+LeiywcSnOALtrSCXa4yCO2s=;
        b=mwsOvQxikY4BQ8qam13FHKX5DNYwgrq90MGapnaTlTrrN0vHqoxjTy0YqYOj7O80uo
         JwBBMapqr/G0rK3he5L+pVR+r6CiQYE7SXyCRsmTdtoVnm2XVQQSYL5mYTP3tE4+ayJw
         bNtQIrliaZuYxaR2QT7pRFfDwBrwz77XWpT7wJ7MBTLFs620Vcye/4GUmVnPpySkB3bV
         /Koxz4qUvuxW0XgjFRVVRw2xL65XqRoblIdLpie23eLeV9kHeDn/ipg0M8mGS5Mm+YsX
         lukmySDwqGY+/osGMxIe4RF4US5ECF3fzFEdXgxI/xMHHyY+pSAhRqAj5s0qsTRLGUsh
         eBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjAxgNVa5Iy7P1HQop4+LeiywcSnOALtrSCXa4yCO2s=;
        b=V+luyATVhJJScYxRXpXPXrSn5XGu/tgygs0YmdPez3RTkIOrXPMDigWY88mRycpugt
         0G0bfe2USVB4/zorefTlUc2++wGrVe+qn5BWqx481e4nXKxEnQJniwoewDRQSwYK6V5m
         EC/HmhgiR+fLeCP1yW6Ud++6lx8xZF1QG1gMHVeOK/CGoG8zvCVm899pyp28ijFcoV/B
         cgMXIl/aDBhrTju5q9c6h0y3XTtnmmWlZlsoZ1+lJHwbSwS6bED9uLRS4nflsrYpVLbt
         RegjhM2y2WixTBZYW9Viba0C0sW52BoqvChFnr6y8Iwuld+o6927C0GvzlRprhtFN6te
         yiBw==
X-Gm-Message-State: ACrzQf1aEnBsJualCLol++R4fYQMcSXokNvFa31x584tXJODDrrqL1Ke
        9Zc6tic0HN1bPXEOu4fVJbE+ZA==
X-Google-Smtp-Source: AMsMyM42vjoWHmtle3AuJ4DjbxcufaFgTYg2QBcGe4karhQ/6wycyzv9vc5rqjul6OZ02PdWuTXGpw==
X-Received: by 2002:a5d:534b:0:b0:236:73ff:3605 with SMTP id t11-20020a5d534b000000b0023673ff3605mr36782817wrv.521.1667987211662;
        Wed, 09 Nov 2022 01:46:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5e95:d543:1caf:4e60? ([2a01:e0a:982:cbb0:5e95:d543:1caf:4e60])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d420a000000b0023682011c1dsm12496766wrq.104.2022.11.09.01.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 01:46:51 -0800 (PST)
Message-ID: <ac749b53-c768-0266-0173-9bdbf154be46@linaro.org>
Date:   Wed, 9 Nov 2022 10:46:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] mmc: meson-gx: fix return value check of mmc_add_host()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     ulf.hansson@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
References: <20221108123417.479045-1-yangyingliang@huawei.com>
Organization: Linaro Developer Services
In-Reply-To: <20221108123417.479045-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 08/11/2022 13:34, Yang Yingliang wrote:
> mmc_add_host() may return error, if we ignore its return value,
> it will lead two issues:
> 1. The memory that allocated in mmc_alloc_host() is leaked.
> 2. In the remove() path, mmc_remove_host() will be called to
>     delete device, but it's not added yet, it will lead a kernel
>     crash because of null-ptr-deref in device_del().
> 
> Fix this by checking the return value and goto error path which
> will call mmc_free_host().
> 
> Fixes: 51c5d8447bd7 ("MMC: meson: initial support for GX platforms")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   drivers/mmc/host/meson-gx-mmc.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index df05e60bed9a..6e5ea0213b47 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1335,7 +1335,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
>   	}
>   
>   	mmc->ops = &meson_mmc_ops;
> -	mmc_add_host(mmc);
> +	ret = mmc_add_host(mmc);
> +	if (ret)
> +		goto err_free_irq;
>   
>   	return 0;
>   


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
