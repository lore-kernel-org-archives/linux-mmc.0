Return-Path: <SRS0=/Wn+=DB=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AE5C4727D
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Sep 2020 12:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E21A235FD
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Sep 2020 12:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KddwqHQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgIXMuP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Sep 2020 08:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgIXMuO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Sep 2020 08:50:14 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B776C0613CE
        for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2020 05:50:14 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id y194so2043540vsc.4
        for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2020 05:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OcB75CatxSBC6Q8DXJ3S92Eqm9+H7JpB8Tl4CEWfRhk=;
        b=KddwqHQxghpVSslYiIx32YQQApT0cpHmLyGtc8IV84lvik+RyS6CCe/IN0LjSYbuKX
         37HNL0Bmy3JErrMxQa8DjS+/7RImTFCgNOh7UiSbMa9UqEv6BK/UfcsSHOFvVbJxH9YS
         HKeTmHBnfRo4oFyGZNZVppV3jrS058nAfVRkFaHWL5gvKRR8ybDGXUeQfZmshHDQWy4Z
         2p6I99+ZVgANZ1Q+vBTgkv5E6QXHG03OuD04PctJLwgG+8COIjBw8DA6kDJ7mKxTOZZn
         L0hyZ6XQCsdp6ZYZM+2cf+EYI+LqyiYIRdVxmlm0wwIdbBbiSM264kGC0J1WdVF+qTbP
         J58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OcB75CatxSBC6Q8DXJ3S92Eqm9+H7JpB8Tl4CEWfRhk=;
        b=oG+INTk75ZXNgCYqumXnnpx9sRUiY0yU/w2FxchAA2K1Mvn/Q3gEgxrC7EhqPthKA0
         RlBcrRP8x/49fcumtIMxdsQIXAmRaCmLhhgFjj6YaQp4nbnZ9F7W4n9F+KpfrYNnII7/
         MeO2TkQ2YAykRjhe+UOMwYNfxzMa+N5SSnSAkMUZCAJ4/NQYmea47x9cEsRcb1przYUA
         GGCpQa9OCA8sp/IEEBwUH/7tre3cdF6UdHSlZ1Q46UfC65v4gdkbbCQArCdK2Xl0i4jF
         I062/C0wqQqlmZuyU4YrZaBR/j7LrAmEZCWN0Wsg1cVg0j85EWcloxH6hxleoCVo87Lt
         0ztg==
X-Gm-Message-State: AOAM530aBQc06nAy8UqxVZ+6KnFcTGSiz+2940ZntDaC8NWlGVR4rgqo
        Y+ybI4ug467yHhzO8aVrCyOOAFzOV0XPg3WPf878iVZ+kY7buw==
X-Google-Smtp-Source: ABdhPJy/VMNbUhEgnpsD3rP5lBsuTs7RvAdeWEDJ1kVpaQ8aGNjOrrQ3/nctlWDNLjW7VWKEv+odaJxdERo87iDQAZM=
X-Received: by 2002:a67:ec9a:: with SMTP id h26mr3598723vsp.34.1600951813551;
 Thu, 24 Sep 2020 05:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200918215446.65654-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20200918215446.65654-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Sep 2020 14:49:35 +0200
Message-ID: <CAPDyKFoSvXrgZubey7On7fC65kpGXQ9zsRUq5CWoL5tuHYq1OQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: document mmc_hw_reset()
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 18 Sep 2020 at 23:54, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Add documentation for mmc_hw_reset to make sure the intended use case is
> clear.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Changes since v1:
> * make clear it is a full reset
> * don't say "remote card"
>
>  drivers/mmc/core/core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 8ccae6452b9c..d42037f0f10d 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2063,6 +2063,16 @@ static void mmc_hw_reset_for_init(struct mmc_host *host)
>         host->ops->hw_reset(host);
>  }
>
> +/**
> + * mmc_hw_reset - reset the card in hardware
> + * @host: MMC host to which the card is attached
> + *
> + * Hard reset the card. This function is only for upper layers, like the
> + * block layer or card drivers. You cannot use it in host drivers (struct
> + * mmc_card might be gone then).
> + *
> + * Return: 0 on success, -errno on failure
> + */
>  int mmc_hw_reset(struct mmc_host *host)
>  {
>         int ret;
> --
> 2.28.0
>
