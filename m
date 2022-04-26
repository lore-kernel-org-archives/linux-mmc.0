Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C6DC433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Apr 2022 13:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351293AbiDZN7R (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Apr 2022 09:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351313AbiDZN65 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2022 09:58:57 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30E215F58C
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2022 06:55:49 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id e12so4243180ybc.11
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2022 06:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bPX6SvIVsdPnKcky53/GZaWz62scba5UabXhwraMtuM=;
        b=XEnrBtWa5HaGUJxa66ENrsJIM/eQE3SIv/G70LSsYT79QH0u9+1kgku0wHZMM39ypg
         rQDOk1U3thbNoo/MhkX1711FUwhmRK3x4K7LxzA/g/PWU6h/cAdk8QTZk/akDYiCz49t
         VI0L4ARJcVK+wQO75cTnotgq2TolInRBt5JSxKMieCggGk4xCvoTmk/rtehH5OqQwcd2
         1TPp7sMar15fLoFeRFB/He3UIUvvuYwP/V7GVD9a53NbSzgTVCX/YtDq0Hielh8ZXZD1
         vUSaB6dLOnC8G27xIsUyTu8KuJ/pjGWZRYxopwty2gGNhxAUGHGNdDGUSoi74EIvB4JA
         0dxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bPX6SvIVsdPnKcky53/GZaWz62scba5UabXhwraMtuM=;
        b=JPid2YcD+sltPxIEVlnjAHlDi5xA8t0VosT/kC7M148RYa6td47K09WYJnetX621IN
         oLy1to5XHFXdc7HbmbsTK71/he4maG4Rfq8iROgmmQkQ72yc0NPUcTgbNbry5QE8ybRh
         3OzgJ/amow+x/mlPltJEC2aBHttDmAkycG/kuxmeWCbR9L0zL2huZH/PbHY+A+1yf/NX
         rI0C4LnZ5XVbES4Db7YM+18jvvMhrDlP6Y5JKg2nVlSTF6vXn5+CaF7hwiLUXnsJoDbS
         +0noqwh0gUcnU+RlsggK+zUxjQP96TA6suPEpZZ4RdDwDyIrxomYl74Ptuf5xqIHkwv2
         zNIw==
X-Gm-Message-State: AOAM531dU/3iLNk5Bo0pve1lDD4LQO1Hlywh37opb2Vd8j9bGAuss31I
        NRfb2ePhwcFhi1Tc8h4RMWX2oKXr0lnvGip/14CM/zcW+60=
X-Google-Smtp-Source: ABdhPJwXhTbd5GPMKzrNimOCcoB8RuBTleCY6fd68g0McV0xcPOumYJnrnbSw9UjGE6dryOfU4VD2sre4bZBSrC/AuI=
X-Received: by 2002:a25:8250:0:b0:645:8834:b91f with SMTP id
 d16-20020a258250000000b006458834b91fmr19931258ybn.553.1650981349101; Tue, 26
 Apr 2022 06:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220425205442.1347837-1-linus.walleij@linaro.org>
In-Reply-To: <20220425205442.1347837-1-linus.walleij@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Apr 2022 15:55:12 +0200
Message-ID: <CAPDyKFo8CxOG6Fz8mEDJ-NWgeMN56Ta=dV5AiM6TX8gdHTPb8A@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: Add CIDs for cards to the entropy pool
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 25 Apr 2022 at 22:56, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> To make the entropy pool a bit better we can toss in the
> CID for eMMC and SD cards into it, usually the serial
> number portion is at least unique.
>
> This does not count as improvement of the entropy but
> in practice it makes it a bit more random to mix in these
> numbers.
>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> ChangeLog v1->v2:
> - Move the device_add_randomness() into each mmc_decode_cid()
>   function for MMC and SD card.
> - Use the raw cid, no reason to unpack the data before using
>   it for this purpose.
> ---
>  drivers/mmc/core/mmc.c | 7 +++++++
>  drivers/mmc/core/sd.c  | 7 +++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 6b78ae45c4c9..9804a06ffadd 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -12,6 +12,7 @@
>  #include <linux/slab.h>
>  #include <linux/stat.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/random.h>
>  #include <linux/sysfs.h>
>
>  #include <linux/mmc/host.h>
> @@ -71,6 +72,12 @@ static int mmc_decode_cid(struct mmc_card *card)
>  {
>         u32 *resp = card->raw_cid;
>
> +       /*
> +        * Add the raw card ID (cid) data to the entropy pool. It doesn't
> +        * matter that not all of it is unique, it's just bonus entropy.
> +        */
> +       add_device_randomness(&card->raw_cid, sizeof(card->raw_cid));
> +
>         /*
>          * The selection of the format here is based upon published
>          * specs from sandisk and from what people have reported.
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 68df6b2f49cc..c5f1df6ce4c0 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -12,6 +12,7 @@
>  #include <linux/slab.h>
>  #include <linux/stat.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/random.h>
>  #include <linux/scatterlist.h>
>  #include <linux/sysfs.h>
>
> @@ -83,6 +84,12 @@ void mmc_decode_cid(struct mmc_card *card)
>  {
>         u32 *resp = card->raw_cid;
>
> +       /*
> +        * Add the raw card ID (cid) data to the entropy pool. It doesn't
> +        * matter that not all of it is unique, it's just bonus entropy.
> +        */
> +       add_device_randomness(&card->raw_cid, sizeof(card->raw_cid));
> +
>         /*
>          * SD doesn't currently have a version field so we will
>          * have to assume we can parse this.
> --
> 2.35.1
>
