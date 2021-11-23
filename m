Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB67C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Nov 2021 19:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238939AbhKWTiM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Nov 2021 14:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbhKWTiH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Nov 2021 14:38:07 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7D4C061574
        for <linux-mmc@vger.kernel.org>; Tue, 23 Nov 2021 11:34:58 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id d11so329160ljg.8
        for <linux-mmc@vger.kernel.org>; Tue, 23 Nov 2021 11:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eAMWwENTmC7DzHcgX7E/tW+4+EEPwisOX8kGjUdddTY=;
        b=YF6gOICxsFKSGsCKGEnlRdknU4T7rQ2D+vR7fhPq+flRWwgs8jYEWXZ3RrOY0m23cP
         jyRrELQ4i1OwvAxclElGmeuj8dmIaPKHwE5LtTdTiwyc9qMwCn20KvjSMqG80b71Y/SO
         hYUJ/gQaLNHZprcrlKRehj9zm5fE9Bye4W2yEKpuBQfRw2cMCMLYgjHE416JiwCWHr68
         NJsIaObwr6s61lfkEnSurC9kEcuvAaOvgY2g7YE2CFk9SXI3zEi8ZdSWV3e4CNxIwz+c
         +CVOrkFegJlJBfGlQq+4yScr0gMVdlTps0usPOWCov/Tnm7Ys0im+RYvR0mIGD3M35rM
         6Npg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eAMWwENTmC7DzHcgX7E/tW+4+EEPwisOX8kGjUdddTY=;
        b=ixCDgTxTnNU4/zHD6wcGG5BBrAeP901JjVDRCn4pH5FdEBYKiXiUTEi0GSpOMxi1Cu
         geSelzIJHYmT93EAdK1psb0/1Qg6QKSs/sECymFUTIUu0XIixiwsa+EjzjQtRkItqNHL
         oe1iuJqPlJy2mU7ZyTnQFXyxdqjpLdCEbaV02MJB6NY+awOtbIIHSkcbmxwipb4uzyn6
         k554/4nvO4R1ZmTCqgcydXHjpPFTN7DLK75e1F5bgfJI7U4YGxsoAnCMLUZZ3dX2IX3c
         9VbX3Q6jRvAWuFt40KhSpYeep0/elsH2/AKJKSAEoICoGdFwyRGW8yNttMRyWpGI5PR6
         I50w==
X-Gm-Message-State: AOAM530kBYMiQ+2tvD3adIE2vO9apCm1ZdoJxT2SaVAR1TkfjHpbP5AV
        MRfmz1NtqWICtDNM2oVDQWW21bk7/5DxMk2/EpdeMA==
X-Google-Smtp-Source: ABdhPJwrjHz86W+VahcN/ogSmg3g2k2OHcHKcRD40FmzVFDWnMKV0fz6haEETY3J8bDF4QtQN9WFXdVoWSBwT7iGa6k=
X-Received: by 2002:a2e:a5c8:: with SMTP id n8mr8391990ljp.367.1637696097076;
 Tue, 23 Nov 2021 11:34:57 -0800 (PST)
MIME-Version: 1.0
References: <20211116190244.1417591-1-john@metanate.com> <20211116190244.1417591-3-john@metanate.com>
In-Reply-To: <20211116190244.1417591-3-john@metanate.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Nov 2021 20:34:20 +0100
Message-ID: <CAPDyKFp1zMBUfK7LteW0yEfTpqtU+P+EybLsJBFx_r54HwFdMg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: use standard "mmc" alias stem
To:     John Keeping <john@metanate.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 16 Nov 2021 at 20:02, John Keeping <john@metanate.com> wrote:
>
> The standard stem for MMC aliases is "mmc" and this is used by the MMC
> core to set the slot index.

This isn't the correct description of the mmc aliases. The below text
is copied from the DT doc:

"It is possible to assign a fixed index mmcN to an MMC host controller
(and the corresponding mmcblkN devices) by defining an alias in the
/aliases device tree node."

>
> Use this in preference to the non-standard "mshc" stem when setting the
> controller ID to avoid needing two aliases for each MMC device in order
> to cover both the core and dw_mmc-specific functionality.
>
> The old "mshc" lookup is kept for backwards compatibility.

The mshc alias is really weird!

It looks like some leftover from when the dw_mmc controller supported
multiple slots. This support was dropped a long time ago, simply
because it never really worked - and it was not worth trying to. Only
one slot per controller is supported.

Rather than re-using the mmc alias in the same weird way as the mshc
alias, I suggest we try to remove parsing of the mshc aliases
completely. By looking at the corresponding code and in combination
with the DTS files, it certainly looks doable to me. Do you want to
have a look at it?

Additionally, there is no need to deprecate the mshc alias binding, as
it seems like it has never been documented. :-)

Kind regards
Uffe

>
> Signed-off-by: John Keeping <john@metanate.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 37af1245304b..6ffaa354410a 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -112,7 +112,11 @@ int dw_mci_of_alias_get_id(struct dw_mci *host)
>         if (WARN_ON(!host->dev->of_node))
>                 return 0;
>
> -       ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
> +       ctrl_id = of_alias_get_id(host->dev->of_node, "mmc");
> +
> +       /* Compatibility fallback for old device trees. */
> +       if (ctrl_id < 0)
> +               ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
>
>         if (ctrl_id < 0)
>                 ctrl_id = 0;
> --
> 2.34.0
>
