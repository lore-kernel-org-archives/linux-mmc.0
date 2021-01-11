Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7CCC433DB
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jan 2021 18:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE304223E0
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jan 2021 18:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389620AbhAKSGs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Jan 2021 13:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389419AbhAKSGs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jan 2021 13:06:48 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FDFC061795
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jan 2021 10:06:08 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id h18so49993vsg.8
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jan 2021 10:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3hIqbsA4z2h5Be7bj6HoZKJF66sCsHJwjbSpsq6eWvA=;
        b=aUlPgCzGPzZzDNtYDzKEyB+O7zqmMVvkT8RMKQLx2BnTm1W/fvnNT4Ne447W02+HK1
         2frubjc9IsAP40/PvfoDBX304y/MU1Q1cHzNL9SHHCcymIrVeUfPtfMgTrgp5z+EiVh3
         9v/JIlo0LK5MICwuuEmV8iWR+ZdNI6m2JH+ZBogOVd0fnpqwR848vGqOLlEgE4DSY22N
         Eh5XPALV6ZpDdbmHNq55mB8kv0dlJ3oFEjBc0ZYpc9S0ZOlZLkCDa9bz9M110rZm+pa/
         zwc0V+q0uCRLOoWeR83URUz3Ijvmj5yOv55kvWYjjNWrSQrMcfzJq981qc3MUOtOnsjR
         RsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3hIqbsA4z2h5Be7bj6HoZKJF66sCsHJwjbSpsq6eWvA=;
        b=eNpEcjlFYWPbGGH6/07wOZgrRvu7kriaNNOoxIpSjpkUIctd/tTeieEeMgvfiL/1tZ
         AZz3K1VkNC91gJuzOolowfyPxPc384cUrcEnMwXWETk/zuOK6cIlHD5BOpWS38MGeDe3
         95yl1VE1Nbof7M1HYznhmH7aDxK9yQeAtx7QAnMGmqq2br/WY9TQ6Q78WEg8CK67RML2
         35Y2qV5wmR+LVLbsdKPHTns3/GQbS5NS6XE4PomWbM0dk6ESTH7gDCf7Mh3YFOHR2FKX
         eGiv52meNSx8ZLvGNULRjmfZq4kHyhv3sdaUV+RhxROprhxNPJhej+nnHxjm7S3jjaEj
         yUiA==
X-Gm-Message-State: AOAM532a6YWYN4QIxrcLSD3bhsT7qIbqbBY5Bc1soE+u7kT8DLzKuPN1
        J8RjKmQ3KAqJQCEAwGOO6D/SsUbkqLFxELpI6hrUVw==
X-Google-Smtp-Source: ABdhPJyeYIqH+aQarOVipg/BAePxI08f6Oj9Bi/3WI85Am3nrYgm68R8VtPzjEwjGDaARlcEuWhtOwdmH1AK++XV7Ds=
X-Received: by 2002:a67:70c6:: with SMTP id l189mr825996vsc.34.1610388366074;
 Mon, 11 Jan 2021 10:06:06 -0800 (PST)
MIME-Version: 1.0
References: <20201208203527.49262-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20201208203527.49262-1-christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 11 Jan 2021 19:05:29 +0100
Message-ID: <CAPDyKFpvjdbWnCD9KRnZAimc_X0CaYS9uCVceuEOX+7THifLpQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mxs-mmc: Fix a resource leak in an error handling
 path in 'mxs_mmc_probe()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Doug Anderson <dianders@chromium.org>,
        Chris Ball <cjb@laptop.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 8 Dec 2020 at 21:35, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> If 'mmc_of_parse()' fails, we must undo the previous 'dma_request_chan()'
> call.
>
> Fixes: abd37cccd47f ("mmc: mxs: use mmc_gpio_get_ro for detecting read-only status")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for next (by dropping the fixes tag as it seems non-critical
anyway), thanks!

Kind regards
Uffe



> ---
> I'm not 100% sure of the Fixes tag, but it seems to be the root cause. The
> erroneous 'out_clk_disable' has then been kept around in the following
> commits
> ---
>  drivers/mmc/host/mxs-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 56bbc6cd9c84..947581de7860 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -628,7 +628,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>
>         ret = mmc_of_parse(mmc);
>         if (ret)
> -               goto out_clk_disable;
> +               goto out_free_dma;
>
>         mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
>
> --
> 2.27.0
>
