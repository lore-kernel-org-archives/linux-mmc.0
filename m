Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3C1C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Nov 2021 11:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239057AbhKVLai (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Nov 2021 06:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbhKVLai (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Nov 2021 06:30:38 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B0BC061714
        for <linux-mmc@vger.kernel.org>; Mon, 22 Nov 2021 03:27:31 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id c32so79192066lfv.4
        for <linux-mmc@vger.kernel.org>; Mon, 22 Nov 2021 03:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jnObts4yEssBRq0CgcfLFbel5BvHBgSVDLhsYI1t6EE=;
        b=smABZihhhLvltoiO3qJwcDIhRFz6AWvUMaRVfLdFagOmWWozWjkyYpuWSdHHq5U8FL
         LWdnlvRkacqp8rhjwSw3kEmQ8/4BzEmBx3xqhCpuoQSY+bQSUWGiSBTx8N0IW4RQ+9SH
         CZiJqe6RYaP+Ou8QWgtcMdoIA/rFBjh7K2sh5r57zt/gOdyOulaKNQnMNYVanAD3R7vc
         PtVZX1DtEcq4oSbVwsOU2W7i4Dt9pHLrQ86fWOcQffr1xNOoVh1TSHM4VliSXPue5+CZ
         y7gKSQOPGsK11tnHfWpr2nGgKHp8OA095/KE+x658jy0+FrpjQ7Cyf36Wguf9iG639z1
         qkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jnObts4yEssBRq0CgcfLFbel5BvHBgSVDLhsYI1t6EE=;
        b=RTHqs1la7IScg1h0izrTXDPlirRGZltRDZIxuffSzeAHBxX6VRIdBK4iSlCbppBNcl
         ZIOjnaNMjqI7CQfLOhjrwOcU+EZ4dzutZEq7BoYhdfcwnxjDdZi3AJ6aFhjF7wL0/jL+
         u1xDyRJVyVu5y+oX35tVg+GBhA29SaiOjZEgUb8r+zegjohfCmD9SSyr/Y1bfy8mZ/1S
         XV9O7yCOwV8+CqBcfUQT6055jme9i6pMsNGhkvwuZVPTJTV2AnOwT+XLDK2mfKWAY1zY
         bIIr7Pcq4I7RdWxQZs4ZzFvAjMQjLEQtyyAdnPx4oGS1LJOVVzoZ9qRX+g2GKYT0tusG
         l96g==
X-Gm-Message-State: AOAM533hSuZls/rAAC5ifZWc7AnNIvbd5OKBvbceKhTnoZpYDIoEIh4A
        dfcatl18sraXpH7n3Yj7fe3RPvu51jK0ibgiAIHbjw==
X-Google-Smtp-Source: ABdhPJzRCcOUHwbvuB1FfUSOQDxqniiTd5zq/5cPFqGOG32yYqXzzVUq/LHFwAEL8cMfn5DxvuKkHXB8fEV9l+Slz4g=
X-Received: by 2002:a05:6512:10c4:: with SMTP id k4mr36611066lfg.373.1637580449865;
 Mon, 22 Nov 2021 03:27:29 -0800 (PST)
MIME-Version: 1.0
References: <20211117103850.28397-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20211117103850.28397-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 22 Nov 2021 12:26:53 +0100
Message-ID: <CAPDyKFp=hMOY==VXhOh_KssKE5wWe6AnsNcJ2VdP+GVa-m5LGw@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: simplify an expression
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 17 Nov 2021 at 11:38, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> We already have 'quirks', no need to go via 'priv'.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index a4407f391f66..29bc086f6cb5 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -1044,7 +1044,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>              host->mmc->caps2 & (MMC_CAP2_HS200_1_8V_SDR |
>                                  MMC_CAP2_HS400_1_8V))) {
>                 const struct renesas_sdhi_scc *taps = of_data->taps;
> -               bool use_4tap = priv->quirks && priv->quirks->hs400_4taps;
> +               bool use_4tap = quirks && quirks->hs400_4taps;
>                 bool hit = false;
>
>                 for (i = 0; i < of_data->taps_num; i++) {
> --
> 2.30.2
>
