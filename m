Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0E3C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C114A233CE
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbhAMLeN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 06:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbhAMLeM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 06:34:12 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE28C061575
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:33:32 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id x4so916786vsp.7
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4YKqseSivN07pOExipzm0CSnXMc2W9yENVH6etrYREQ=;
        b=ewZIG1/ACpd0tugZbt9VoGJMSx5MbiFpyWb/s9oKL4oLBXO2GMmNR5ZqnmmhsaIPsN
         wvdRdsl0APwqxJaiVsphIrRljLX6WoAoF75Il/Ni4Snfrbq/o1iqpFU6Zm7jfk39lElY
         fMvA15R+YA6jfKPZvyUnN7e2igKOJFMhPK/1x1kdHSYbrxF60zBZKk/beJR/3pfpM6nf
         Yea3JGApg0b+oHzdlu1k+E9rvvoBO+x0e/o3RYraSDktuf4C1GQuwU8R7ftoNkIm3mMd
         j3EsUJ3XYnrai7P/4g4AH6cykCPOdYDUvegk7eRQXO0A2KR/0H2YnTEhi7gu33YY1bC5
         v6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4YKqseSivN07pOExipzm0CSnXMc2W9yENVH6etrYREQ=;
        b=LivyVUQSgusu2ExxFTA+eZlMQJPk7WuVajjxixMjYfy8RpJYcFasnnPXyaQ846J2fx
         1XWLVwGu+z787CesMle3/y4v0cPC28k0NAezmgCcj9ekO0apSk9c5V8ixvwr+tnn/1Ox
         xBAlXbAp0km/+smzRxfSojpd+Sj3MdnpTlAEfgwSlnAfFn01IzjH8O+xXSxQH3B0p8++
         ZJhwEAlSLQmWmuqRqz6f8mdMq6Sd57AGWBY3peGN293aNgrhtrxD96s6eSyS62BhBG/Z
         E+KNkpxabnehnJ+G/iHAWbe9eOiw4QgbjJlt/Bcqfi1qfce+B4nVWTC+/znURPImBPNb
         7Lkg==
X-Gm-Message-State: AOAM533pQ7EP54WEUSvq1IFLt97mAgUF4UiQaL64+RQzIYjWGuo/XBNB
        VACF9NGRr/fTwohynk7qO3xBbvFwx5HFiAjXFCDd9w==
X-Google-Smtp-Source: ABdhPJyMllODoK52mXu5bEqNNfxetwluwVOGQ/3R/dgnJnIoJpXYBfooMYknCG45gVq+zJBOLOsjpsIXCmgk/+8DvSM=
X-Received: by 2002:a05:6102:2127:: with SMTP id f7mr1475391vsg.48.1610537611543;
 Wed, 13 Jan 2021 03:33:31 -0800 (PST)
MIME-Version: 1.0
References: <20210113052421.36553-1-samuel@sholland.org>
In-Reply-To: <20210113052421.36553-1-samuel@sholland.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 12:32:55 +0100
Message-ID: <CAPDyKFofFTSZOP=0n_-Qn9RX11cOB1kiJZe8CV3oQ_gSO_Za7w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sunxi-mmc: Ensure host is suspended during system sleep
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 13 Jan 2021 at 06:24, Samuel Holland <samuel@sholland.org> wrote:
>
> If the device suspend process begins before the mmc host's autosuspend
> timeout, the host will continue running during system sleep. Avoid
> this by forcing runtime suspend during a global suspend transition.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sunxi-mmc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 6310693f2ac0..cfee8db7b76d 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1507,6 +1507,8 @@ static int sunxi_mmc_runtime_suspend(struct device *dev)
>  #endif
>
>  static const struct dev_pm_ops sunxi_mmc_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +                               pm_runtime_force_resume)
>         SET_RUNTIME_PM_OPS(sunxi_mmc_runtime_suspend,
>                            sunxi_mmc_runtime_resume,
>                            NULL)
> --
> 2.26.2
>
