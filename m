Return-Path: <SRS0=InOK=75=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7641C433E3
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Jun 2020 11:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8373D20C09
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Jun 2020 11:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nDIBdjVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgFPLde (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbgFPLdd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jun 2020 07:33:33 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19ADC08C5C2
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2020 04:33:32 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id j13so11235922vsn.3
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2020 04:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z4+Iz5hXHc4KqHs/Siy+ZWN5Iucm03GbQ2VElO3GIbE=;
        b=nDIBdjVmKagHvZo44/5GnMutd+R9LOzqdj7KoKAjZCeARsNRBWF+9cGFnYMjSfV7Vs
         r4303MeB7Zgsz3BHhUBei2NxgJ77BYTNOA6KEqwV2dziFSfcZeH/37omrb/OhrA2FVhN
         iVNLxGGtaXs8BSbxMcqI1p1jIEB5fmqAanfN0b/EtI8ut38Sql4N/26QCNTV3WypKHL7
         Zt940MpjDG13b3XlCEGfJ5u6HOdKds0M50x4KT+fPeZ+d5gjJmO3/4sxjcS67kQrPfUf
         wAagBLnmntF9pcPlTMGp34+8QiVEPqy3ZyRCeSFCk6rky6z01YGR03XLjBKgUcGL6oXy
         h9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z4+Iz5hXHc4KqHs/Siy+ZWN5Iucm03GbQ2VElO3GIbE=;
        b=gFI53QOsy1dJxdlOJBb3jdq/ZQrd0+CHlv0G/s1re4asv7yBWlnm+xazGn6I31zpgn
         yjkOv2oTnLZPsDTzWrkNTsQPGHSzzvQnD4zjrZ5SyVgefY9aCu5G1leZ3Ev32RiJ0iMO
         xXus8ZSbDlbh3gWBSP9A2WW4VvbK6StmDwJvh5RRKxRcAzq11XJtp0dkydlQxHfFERVY
         e3UBl8ccMXno+xBJby2UZZstuAsVipsXJYnzRRyiS2SI+mNbf3Ys+8aVnPHqhj13t9mM
         mrWht0ggNR5n+rhJ+nti5+428++jVtQ0Pr3IT8NAnNz5MuU25oNO38fMSdGfsTq0iFrY
         W7Wg==
X-Gm-Message-State: AOAM531npz4fNKQfZxrIlGH4MbJTcLIou6WwxpFeaK3/B9FWlZ1yiYwn
        NODpS/5hzv9NP0HmVpdHM6VGsxJRy9bfYXgTX5/dwA==
X-Google-Smtp-Source: ABdhPJyGZERfhW1QKFPZ5+rChUj0a55YKn9tZGUbhrD+eRw5UOrhMGu/7HPk1pqELV9Q/H4lqZhJMwIGM2yDSPP9sLo=
X-Received: by 2002:a67:903:: with SMTP id 3mr1156423vsj.191.1592307212063;
 Tue, 16 Jun 2020 04:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200608162226.3259186-1-hslester96@gmail.com>
In-Reply-To: <20200608162226.3259186-1-hslester96@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 16 Jun 2020 13:32:55 +0200
Message-ID: <CAPDyKFrrrydrUaOVGB+VTgLSGMn41JO+ughhza_BzGPE7wm_yw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add missed checks for devm_clk_register()
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Douglas Anderson <dianders@chromium.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 8 Jun 2020 at 18:22, Chuhong Yuan <hslester96@gmail.com> wrote:
>
> These functions do not check the return value of devm_clk_register():
>   - sdhci_arasan_register_sdcardclk()
>   - sdhci_arasan_register_sampleclk()
>
> Therefore, add the missed checks to fix them.
>
> Fixes: c390f2110adf1 ("mmc: sdhci-of-arasan: Add ability to export card clock")
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index db9b544465cd..fb26e743e1fd 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1299,6 +1299,8 @@ sdhci_arasan_register_sdcardclk(struct sdhci_arasan_data *sdhci_arasan,
>         clk_data->sdcardclk_hw.init = &sdcardclk_init;
>         clk_data->sdcardclk =
>                 devm_clk_register(dev, &clk_data->sdcardclk_hw);
> +       if (IS_ERR(clk_data->sdcardclk))
> +               return PTR_ERR(clk_data->sdcardclk);
>         clk_data->sdcardclk_hw.init = NULL;
>
>         ret = of_clk_add_provider(np, of_clk_src_simple_get,
> @@ -1349,6 +1351,8 @@ sdhci_arasan_register_sampleclk(struct sdhci_arasan_data *sdhci_arasan,
>         clk_data->sampleclk_hw.init = &sampleclk_init;
>         clk_data->sampleclk =
>                 devm_clk_register(dev, &clk_data->sampleclk_hw);
> +       if (IS_ERR(clk_data->sampleclk))
> +               return PTR_ERR(clk_data->sampleclk);
>         clk_data->sampleclk_hw.init = NULL;
>
>         ret = of_clk_add_provider(np, of_clk_src_simple_get,
> --
> 2.26.2
>
