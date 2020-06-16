Return-Path: <SRS0=InOK=75=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33200C433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Jun 2020 11:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1293A20B80
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Jun 2020 11:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r8/O5yID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgFPLdT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728617AbgFPLdS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jun 2020 07:33:18 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FCAC08C5C2
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2020 04:33:18 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id v25so6780446uau.4
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2020 04:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ivK3dmsummt7EV44R6DFOrgPObNk1BU5eKIbWQwOGQ=;
        b=r8/O5yIDKHeXpEfyfXSGx1Srt7tU5pjmgcIIs5OOvAG54o9KMk8uUA3FJ7m2xzAwbU
         pXkYD3WLfibjfipMtAcbJbqi82z99GIsDRn4f7TchXpf5N8acm7SE6GprFxDkKAmluPn
         EDLAV8wjgEssBZ3JAjkjo0A/ASNilJv0Hblc04HyLmFmTrrZNAvB5KZkH5SIqKbHhOIS
         j/cLyeo73c86n6iK1LH+0aMVKbYC5P9Em8MQCXe8ydLhCNilNTvHNEpLhxrdGjWmveZG
         +vEzo+ub5cdJeMCIbDh1oqn1fSYLObZOjJeRIjI8B4caizTfc3sEcqdpgRzaXf6+GMQA
         SW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ivK3dmsummt7EV44R6DFOrgPObNk1BU5eKIbWQwOGQ=;
        b=eqLl4DMIKqTECLdOB7pWXp8p0CFqZBjV3pueB8CoIydsunjOuingnrGY4Ig+dyYW3L
         Cw0oWrgPAGaB85J89/MFHSRVt8J4TvqWQ4ZxG6kNjO1ZXjOr8fNjTFACJp9036mYOiza
         HROwvC2/YpnxVqZ7q7M3anFLZYFyXA4eRZPNWxdS8jwTAHHXA5MvAszR+LpA9U+4CPHC
         TyGrBhDYEQvPxSfETZw87q4LGuHN1cH23wS/PKPb054xlsiKHtD/+dXQFlxTuy80mrkU
         20GBms0N9ptZGPqbe1ge+DQMkDbOceUpMTy9mkhgtXSDjdb64e4puvXX0VRLprkqoBQ9
         3kMw==
X-Gm-Message-State: AOAM532eZ0qi8h71+o5mAA5z0CcRc2mLGgOyJobd9ftC38mdypjdUweg
        ywx3NNNWkfWbV/oc2OSnBcpuHPfdNZxSlf8Bnf4x2g==
X-Google-Smtp-Source: ABdhPJznasSiUlG9LYRhwTB+cV5iX3RICv2A1ILynnKhE2BsFTmsoSvlDX2QwGaHJnNN8r0ztFAssa0sdRO9z2Aldi4=
X-Received: by 2002:a9f:22e1:: with SMTP id 88mr1406026uan.19.1592307197568;
 Tue, 16 Jun 2020 04:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200608103009.5000-1-zbestahu@gmail.com>
In-Reply-To: <20200608103009.5000-1-zbestahu@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 16 Jun 2020 13:32:41 +0200
Message-ID: <CAPDyKFqoD0WoszEPHnr7MdibXuy6OXGUXZePX1OaJGBT=Hr8zQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdio: Enable SDIO 4-bit bus if not support
 SD_SCR_BUS_WIDTH_4 for SD combo card
To:     Yue Hu <zbestahu@gmail.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        huyue2@yulong.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 8 Jun 2020 at 12:30, Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> If the card type is SD combo(MMC_TYPE_SD_COMBO) and the memory part does
> not support wider bus(SD_SCR_BUS_WIDTH_4), nothing will be done except
> return 0. However, we should check whether IO part support wider bus or
> not. We should use available IO ability if supported.
>
> In addition, there's a duplicated check to MMC_CAP_4_BIT_DATA since
> sdio_enable_wide() will include that check. And we can also save one
> call site to sdio_enable_wide() after this change.
>
> Change-Id: Iaeb31fba4050ec9d248c415bef6696d38332afe6

Dropping this.

> Signed-off-by: Yue Hu <huyue2@yulong.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2: commit message changed.
>
>  drivers/mmc/core/sdio.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 1e42c6b..59f197d 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -367,25 +367,23 @@ static int sdio_enable_4bit_bus(struct mmc_card *card)
>  {
>         int err;
>
> +       err = sdio_enable_wide(card);
> +       if (err <= 0)
> +               return err;
>         if (card->type == MMC_TYPE_SDIO)
> -               err = sdio_enable_wide(card);
> -       else if ((card->host->caps & MMC_CAP_4_BIT_DATA) &&
> -                (card->scr.bus_widths & SD_SCR_BUS_WIDTH_4)) {
> +               goto out;
> +
> +       if (card->scr.bus_widths & SD_SCR_BUS_WIDTH_4) {
>                 err = mmc_app_set_bus_width(card, MMC_BUS_WIDTH_4);
> -               if (err)
> +               if (err) {
> +                       sdio_disable_wide(card);
>                         return err;
> -               err = sdio_enable_wide(card);
> -               if (err <= 0)
> -                       mmc_app_set_bus_width(card, MMC_BUS_WIDTH_1);
> -       } else
> -               return 0;
> -
> -       if (err > 0) {
> -               mmc_set_bus_width(card->host, MMC_BUS_WIDTH_4);
> -               err = 0;
> +               }
>         }
> +out:
> +       mmc_set_bus_width(card->host, MMC_BUS_WIDTH_4);
>
> -       return err;
> +       return 0;
>  }
>
>
> --
> 1.9.1
>
