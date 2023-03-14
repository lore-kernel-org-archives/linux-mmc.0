Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EE6C05027
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Mar 2023 19:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCNTpo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Mar 2023 15:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCNTpn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Mar 2023 15:45:43 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD95265A8
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2023 12:45:37 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x13so19323509edd.1
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2023 12:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678823136;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dx+upmH7N2zp5Ua2gEK276tD+Y89nrLKL0Tl8k2Wdc=;
        b=Pt7sBXo66cdFGiG3vWh+CkVp1Bw91P5irWH136K9kdGym+9hymOenz0KmDzLZVIcV8
         OEKTgypmdaudkq+DxSm2tJLLZopgcaMLWKHlNaxICjUdo/gaSLTSCk+n9fJauJu5RzFg
         ZOPAF/E46gRArq+R/9dVS+NeOZ8iE6nFxlYBg4trr0py8i0HbMz4QV5OOUFU4jpXgJta
         uVkNv2fC9p0UCdDlXfhmfLsIsGswBZ3BqKzq04IsnVltdATy6u36w6u/Wdb0wboiuCxw
         RGV5jfWbK/LcrIpdPhqabhTi5MvDS2VrXmrCn1zJn1cnPx0XVsL+D22k3rBfcuReB1bw
         u1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678823136;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dx+upmH7N2zp5Ua2gEK276tD+Y89nrLKL0Tl8k2Wdc=;
        b=IwkRAvfBscW3OAFhTe1ELd2vZXmfXIkmjRUCNObBg/fjbZ3i+HSo/MKle6uKjRwek7
         Z4+dYXbjpE3oapZ+aD3vLap+25lw5qXWFejIEqZGi5+6l2Sqs4ibbAYqQU0Uyizlb17X
         7ETrSdS1TKXQY+XidZjYq0TwoBnReGYuWc5XZE7Os07pSY3uNvlzwErp9Dyt33aQn5zf
         /0oMBOt8vmeN+Kkd1dZ+zKJsnPeSupLCcT7hIuLM5FlcNYlDA+0MTqoc9rMKuMbXqsMq
         z/TkeW5ykFjkGxokqxFmDUe2mxCis4vdKB5cstrt7im++IQgOsrtrgEViYX/oDNKvNgl
         svlQ==
X-Gm-Message-State: AO0yUKXr3Mct+gcUXTKa0Mr8/u20fctY+H0KHB2OT5otSouWumpB/QwU
        7+Um1EK4gY8J1cVU2azlCYU=
X-Google-Smtp-Source: AK7set/bC6AB9ZG6QuoyPuS0ice1lrRUPEGYyY2vHo9H52eQjXoTVY10NNrAcAgb92Vxbow9Cdbi/w==
X-Received: by 2002:aa7:d49a:0:b0:4fb:994d:42c9 with SMTP id b26-20020aa7d49a000000b004fb994d42c9mr225680edr.24.1678823136165;
        Tue, 14 Mar 2023 12:45:36 -0700 (PDT)
Received: from ?IPV6:2a01:c22:772b:ab00:fde6:8525:8145:a65e? (dynamic-2a01-0c22-772b-ab00-fde6-8525-8145-a65e.c22.pool.telefonica.de. [2a01:c22:772b:ab00:fde6:8525:8145:a65e])
        by smtp.googlemail.com with ESMTPSA id h1-20020a50c381000000b004c0c5864cc5sm1494480edf.25.2023.03.14.12.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 12:45:35 -0700 (PDT)
Message-ID: <0696106f-8d70-6410-999a-fcda6c5b39c2@gmail.com>
Date:   Tue, 14 Mar 2023 20:45:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pierre-Hugues Husson <phh@phh.me>,
        Rong Chen <rong.chen@amlogic.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     MMC <linux-mmc@vger.kernel.org>,
        AML <linux-amlogic@lists.infradead.org>
References: <11a8a0c8-a5b1-8f38-a139-97172ab7be68@free.fr>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: increase power-up delay
In-Reply-To: <11a8a0c8-a5b1-8f38-a139-97172ab7be68@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 14.03.2023 18:24, Marc Gonzalez wrote:
> With the default power-up delay, on small kernels, the host probes
> too soon, and mmc_send_io_op_cond() times out.
> 
Looking at mmc_power_up() and how power_delay_ms is used
I wonder what you mean with "host probes too soon".
Are you sure that the additional delay is needed for the Amlogic MMC
block IP in general? Or could it be that your issue is caused by
a specific regulator and you need to add a delay there?

> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
> Stress-tested with 80 cold boots, checking every time
> mmc2: new ultra high speed SDR50 SDIO card at address 0001
> IIUC, this will also slow down SD & MMC probing,
> but an additional 20 ms seems acceptable?
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 6e5ea0213b477..73ecbcf588c65 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1182,6 +1182,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
>  	mmc = mmc_alloc_host(sizeof(struct meson_host), &pdev->dev);
>  	if (!mmc)
>  		return -ENOMEM;
> +	mmc->ios.power_delay_ms = 20;
>  	host = mmc_priv(mmc);
>  	host->mmc = mmc;
>  	host->dev = &pdev->dev;

