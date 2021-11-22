Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E27C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Nov 2021 11:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbhKVL3S (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Nov 2021 06:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhKVL3S (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Nov 2021 06:29:18 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF35C061574
        for <linux-mmc@vger.kernel.org>; Mon, 22 Nov 2021 03:26:11 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id z34so79176321lfu.8
        for <linux-mmc@vger.kernel.org>; Mon, 22 Nov 2021 03:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rW1/VgALAkZ3nb3cl8Bi1XiiOYhnYXrdk1V2a4DmNNg=;
        b=mEBa1oznyUIpXRSE20cyvTsstdDlCRqlM41CnDUvXRiymnNjeeOxGXWAHOjV0Z6NR7
         ZJCuMphsyi0FM+uXooSiEko8QK30FwrjUj78hop6lrY0oaOsbp/TLzIab9BpmaGqWV4G
         I685gL6rFSNMkR73Pul5PAdAmDi7Qd0gHhbYVqDwPM01wBMG3qAyv42HleZpqbvX8D5I
         PvTzKp7UqgGv5ZHsGI472s3tdSzQ49pwJ+ZFKmjJdaTi2p3AzwMLoiuHiH+4v1g1zXJT
         Mm8Dfpu0ln9nCb1hJQjCOPCHbB5WUSAAWStnVGTTp0yZ1llYTOmEmNcExGLILGOZbdQa
         e+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rW1/VgALAkZ3nb3cl8Bi1XiiOYhnYXrdk1V2a4DmNNg=;
        b=5MDq0U/Elt0GvxguxlUYf1o9g09NWjtUt+xc9Xdkp7v3Jzm8wjG0CQSYsShUr2yLgl
         eS9REA+DnVAeV8gJyKu5YfqSl3xV5ojucy41805fI/APh/53miSNqWcXlSRjq8M4rHxn
         kE65aQTTBAx2IpR4QTyk/PBM5iQkeS5UkvdaLpYDY+wG+BvfQMpKneiM1MbalEqQ5gvP
         zoyZPptZESIYvKRb8ANVVJeVtPwr0wA+mHxBk3itl+pOzmP2+YDpG5ZpD5cX+//Ue2bD
         UTwaxZvwxy2sYAK2rawA/LHqycXY/Ice9e7t2h1ckO26FAQSD+eGuiHDRw0Ob2Cch2jc
         2YQg==
X-Gm-Message-State: AOAM532SsvQxP2xT2rs/hQEstnVuFT6K6zR3CRD35zz5Z87qYPu2rjgQ
        SJlCUGXdAGPQULysu69ZAYl/tFGr94/qgrXcS4xi9A==
X-Google-Smtp-Source: ABdhPJx89vw4NxJVsbTLfJIil/W4FAN3Lr8rtRcei4f3cIIw4oREzKXc9/9eW0EQprQa9QtkWL8k7SddoTwI/U6xwV8=
X-Received: by 2002:a05:6512:3d07:: with SMTP id d7mr56423224lfv.233.1637580369872;
 Mon, 22 Nov 2021 03:26:09 -0800 (PST)
MIME-Version: 1.0
References: <540d803d31bf9aa1d0f78f431cae0ccd05387edc.1637069733.git.geert+renesas@glider.be>
In-Reply-To: <540d803d31bf9aa1d0f78f431cae0ccd05387edc.1637069733.git.geert+renesas@glider.be>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 22 Nov 2021 12:25:33 +0100
Message-ID: <CAPDyKFphP-Zx878DOw9YaVKE8EvBPhtq9SdJNK5HEDiW8Ly50g@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: Use devm_clk_get_optional() to obtain
 CD clock
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 16 Nov 2021 at 14:36, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Use the existing devm_clk_get_optional() helper to obtain the optional
> Card Detect clock, instead of open-coding the same operation.
> a side effect, real errors will now be handled correctly instead of
> being ignored.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

I guess it's best if you continue to funnel renesas_sdhi changes
through your tree for the current cycle, to avoid conflicts. Right?

Kind regards
Uffe

> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index a6c47362035a0415..f41225a34f4ae863 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -936,9 +936,9 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>          * to the card detect circuit. That leaves us with if separate clocks
>          * are presented, we must treat them both as virtually 1 clock.
>          */
> -       priv->clk_cd = devm_clk_get(&pdev->dev, "cd");
> +       priv->clk_cd = devm_clk_get_optional(&pdev->dev, "cd");
>         if (IS_ERR(priv->clk_cd))
> -               priv->clk_cd = NULL;
> +               return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk_cd), "cannot get cd clock");
>
>         priv->pinctrl = devm_pinctrl_get(&pdev->dev);
>         if (!IS_ERR(priv->pinctrl)) {
> --
> 2.25.1
>
