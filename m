Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262D6C54EED
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Jan 2023 11:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbjA3LHf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Jan 2023 06:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236582AbjA3LHE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2023 06:07:04 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C1434313
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jan 2023 03:06:29 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h12so10652403wrv.10
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jan 2023 03:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yNDMPXDJxIWFepXsoEIg2J6UzCqMyzPQRKfo3ReKfmw=;
        b=PL+/eKkvazCt3dk8l8KY94lK2apVCyduLPa131ikd12aEmLhpoT1gB/UqvSqrdewoC
         n6eyYkahPsoh6CqFNCqh4YLAHEWFDUwI4FdlLLjcJScm8A5gOxT873HdnZpFMZVxuAug
         gAqL8iyuBoc97QVazaAEi9NC2o81fDhrnKAu6OkFkd8bU0+qSV9GUrc4WyZI3aSvACLp
         DkfRe/TUcKVM39UgeGI8RGScBFCwyRjZ90op7RgUY2PRzMozVYOAMqnrR+LddNLkDC8D
         Q71BOdvfCJ53dsYkAI9qzBZcUnMPuwjiexcFTjxhJC6rVmzZW5qis7y/LUr1TM4R3vCQ
         S1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNDMPXDJxIWFepXsoEIg2J6UzCqMyzPQRKfo3ReKfmw=;
        b=Lwbjrzvjm5dGbWYjopJEsbDdjqT7hlF86gVto3yJ8ufBLOtfFKx5QaE3HYJbKOUwNQ
         8oB0JoOZqE4sJvRlJxE2yNNcd2lq14iEJbqaFtzLUIdKKA3oXrBKd/p0YaZK9r/WItW8
         bTyeFClMNwif7bmGSNveMOUKUNXAsl7sZCvSB5ftYRtoqwUT133mnNK2iYXriWc2zHPh
         JSlzJlUaTtFFKUdSNRRWpaJrZy0OK15O0oV4lhCPSDs+w19mhKE5mmFKENWr/Z6DNugK
         rXlasDuSk9HKChXLJ0KLFBtmHYF7o5fFPCxCVTceZoy4jScjs1YTCUzqA1YcCJi0kZ27
         oCTw==
X-Gm-Message-State: AO0yUKUFwBiDeOmLmHgQpmVPZLUits95y39NEVj4RYYXkrS6CwQ+7VUi
        8HkQarPGmiG9LtDuchc4fCIH0Mezak4I4pe/vQE=
X-Google-Smtp-Source: AK7set9LUEaXBRP2ZmoaxSwk+r+D6tWi7u/YOFTSzqbjX/zFUp6z8R3Fo1IdcrdXUSUB91bWbAL9bg==
X-Received: by 2002:adf:f38f:0:b0:2bf:bf05:85ac with SMTP id m15-20020adff38f000000b002bfbf0585acmr15695242wro.23.1675076787638;
        Mon, 30 Jan 2023 03:06:27 -0800 (PST)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id t8-20020a5d6908000000b002bc7e5a1171sm11670124wru.116.2023.01.30.03.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 03:06:27 -0800 (PST)
Message-ID: <7789e36f-f13a-9837-5432-c16754922fa3@linaro.org>
Date:   Mon, 30 Jan 2023 12:06:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] mmc: meson-gx: support platform interrupt as card
 detect interrupt
Content-Language: en-US
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <dfb90ca4-1f62-e3ed-2ce4-a7b5f661e36d@gmail.com>
 <9e08411b-20cb-874f-8915-6f8dc32e9fcf@gmail.com>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <9e08411b-20cb-874f-8915-6f8dc32e9fcf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 30/01/2023 00:10, Heiner Kallweit wrote:
> Use a new mmc core feature and support specifying the card detect
> gpio interrupt in device tree.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   drivers/mmc/host/meson-gx-mmc.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index be1a972c2..c87bc31d0 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1236,6 +1236,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
>   		goto free_host;
>   	}
>   
> +	/* gpio card detect interrupt */
> +	mmc->cd_irq = platform_get_irq_optional(pdev, 1);

Ok it's fine but beware GXBB/GXL/AXG doesn't support Rising + Falling GPIO IRQ,
so this should only be used on G12A/B/SM1 and later.

Neil

> +
>   	host->pinctrl = devm_pinctrl_get(&pdev->dev);
>   	if (IS_ERR(host->pinctrl)) {
>   		ret = PTR_ERR(host->pinctrl);

