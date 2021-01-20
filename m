Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085BFC43219
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 23:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC65E23619
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 23:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbhATV2A (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Jan 2021 16:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731770AbhATNnb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jan 2021 08:43:31 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4ADC061757
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jan 2021 05:41:17 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id o125so11762872vsc.6
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jan 2021 05:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D3rkP3sTkrcG+gjHiR+284Vvr0UULqneoyGJYqtXMhY=;
        b=RRW2kvSzIJp4rJU/Kqn0fcqX+MmV/Rxfbu+0qeGnPqTQaCOSEFO9jzWYxtlEpylmg1
         0RaOwqsIYS0IPUR3OqEfujosWXn0PpeJdZKSKTpcms2WLPBcbCT4Oh4jZoIxRslPJ1ef
         dXB6mDJ2KxNjURiaak4Z9QrP26A55ZankVQ/W1XEcDgv23sqhlZtsATp65kA80f6L3NT
         tHn4DTKyog2t34FT4mcVSAcYbEATj0jxc2UiNYTQ9DheZfUlvrz1qKilmcufjaKsUOP6
         zl6xw3M3idN4j+LCiHNC311d+yjNd4diIr1qUFftwi+F22WXlrqSkwjs60fS1V7jlXcp
         RYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D3rkP3sTkrcG+gjHiR+284Vvr0UULqneoyGJYqtXMhY=;
        b=nViP8JMnZOWIfmwv4V1RUIw0WtyGMNYrjX2LY7CuMEk3Cvh1LxqtCpziacwr2vsQvt
         SmGsjEd75lwsy4/R/EYZJuGoMWNYa4LrUGtSLLmxM8xXpP4G3J2if5uQfwC5vHdviG9P
         +amVwvSGOHFhM8JBkCX5qFIKLHmU+5NehzS2vxzDkxq0E8ayrEg8QWRAPl6rjUa84A1P
         CQjxSydjymMQbA7ZKVrXhkkDuJ8wHqaj8fSidCWzJqY7yGorysxj2bNYRbsqKu4+uc+N
         jn+ExiaA2S0wlD9tXkcJzQEgMVfsJpfTM4x8haO5voPJaZ0IEHmz+wFQ5TjbtjbIugHg
         cPsg==
X-Gm-Message-State: AOAM532/JftiHbdCt4fLb8YniPvkjaCPWNehnlVz+oj4L5IZC26yuqJT
        hRFy6pW/4QGmycJAvA2LWWX0qT3uKitQaZ+niEQvTw==
X-Google-Smtp-Source: ABdhPJzBqLW0bV1P+US75mAyLIbxmsCSRB1Sa7MywrWLUGSxtciKJ5Z6c6+1S9PAMrKFwB+6/zwn1h0zDkOfj8dx9TQ=
X-Received: by 2002:a67:7f41:: with SMTP id a62mr6403069vsd.55.1611150077036;
 Wed, 20 Jan 2021 05:41:17 -0800 (PST)
MIME-Version: 1.0
References: <20210118042717.2549123-1-xiaolei.wang@windriver.com>
In-Reply-To: <20210118042717.2549123-1-xiaolei.wang@windriver.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 Jan 2021 14:40:41 +0100
Message-ID: <CAPDyKFq+qyuHGbduGp30AeLefN1ie9ZL2Bvm9PrPZUwmdfQeYg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Apply trim broken quirk to R1J57L
To:     Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 18 Jan 2021 at 05:27, Xiaolei Wang <xiaolei.wang@windriver.com> wrote:
>
> R1J57L mmc chip hw capibility indicates that it supports trim function,
> but this function does not work properly, the SDIO bus does not respond,
> and the IO has been waiting so set quirks to skip trim

Are you sure this is an eMMC problem and not a mmc host driver issue?

Can you elaborate more what happens?

Kind regards
Uffe

>
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
>  drivers/mmc/core/quirks.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index d68e6e513a4f..63e02391c133 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -89,6 +89,8 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>                   MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
>         MMC_FIXUP("VZL00M", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
>                   MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
> +       MMC_FIXUP("R1J57L", CID_MANFID_MICRON, CID_OEMID_ANY, add_quirk_mmc,
> +                 MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
>
>         /*
>          *  On Some Kingston eMMCs, performing trim can result in
> @@ -98,6 +100,8 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>                   MMC_QUIRK_TRIM_BROKEN),
>         MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
>                   MMC_QUIRK_TRIM_BROKEN),
> +       MMC_FIXUP("R1J57L", CID_MANFID_MICRON, CID_OEMID_ANY, add_quirk_mmc,
> +                 MMC_QUIRK_TRIM_BROKEN),
>
>         END_FIXUP
>  };
> --
> 2.25.1
>
