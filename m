Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95064C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Dec 2021 13:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbhLUNDX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Dec 2021 08:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238024AbhLUNDW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Dec 2021 08:03:22 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A91C061574
        for <linux-mmc@vger.kernel.org>; Tue, 21 Dec 2021 05:03:22 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bu9so7640109lfb.7
        for <linux-mmc@vger.kernel.org>; Tue, 21 Dec 2021 05:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EbFMqfLUV7jqbg8sJZLc2clgBzqbVKTSLl3KdaBAXZM=;
        b=U8DREYfaMAZ0dbfgkMS4Up6G506OcBayGPwepAX98LgXHrPGUKa05zz8TLvojVHKnl
         Sdj61ODtqDJhJQVxESkLRYQXETkYCozpuqQ9KNxSHaW9+pj7vs7Y/f/fDxepaOuDQpVN
         NetS8jpTdck2zqqiiVfqm9tc9IaojIB9SOhfUWZUkbFz9l9qExgqRFwgjVuZB2wu3aAP
         ylRNY58GUklfXnWjxJ4Vs7wzTwJpWvXZHEeQs38D/wIdyLfUqwrjH2ejhRu5sChshk9t
         LnDNgx2kqu3kcT5/v7WTZjuPk02YfrrARdYf1Y9pdnYayUE0A1p/MdJr/EZTQt9Fk99c
         67sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EbFMqfLUV7jqbg8sJZLc2clgBzqbVKTSLl3KdaBAXZM=;
        b=BE9BgiuwDmV1svisslGGO6To3pObhFqUitJa01nJZt5RYAgUHk2XTjeL0WbPh1Ap2E
         VXXws/CFsFmnOrMk0edmKoQIro6PUOdhwU8i7J0a20CA2L4nESO6in+fS9kOcvJgHCi3
         bGUNQXq2wUzCtKjpwlrDKA59uAZV+FGRsOaFVTdm2dUbG/BRWjeEgCiwHfvxpFg3p6Vn
         wIUOvafiVjhoNLYFW+oSjJ2xrKMwprgOosKog2HJ7RlHw3Y8LDFmCY5aEwSSRNQJEHQs
         LTnMVKO8KzP60TKOjb9CR0Y7r2+JsZ/Arj0L3HlID7HQ5l2JpDADvrcU6VRaNkP8HkSt
         HMxA==
X-Gm-Message-State: AOAM531Jc0oSpsqdIJbxlBCIEowj0DOcSHp5yBdu/8kNca9ePQrzrvJC
        1Cu8MhN5pSnqtnj+CIFLli1NeSfUtuvOYl+peFZJlIg50+0=
X-Google-Smtp-Source: ABdhPJyj2JiEdgIr2ylZYEDZ2Yav+CgsmjJXAaF1llCj1oEB9JMNfTLdHSw0NUdOMpsK1Wsgmg9lPE+EcZv+5rRY4cA=
X-Received: by 2002:a05:6512:310e:: with SMTP id n14mr2985967lfb.167.1640091800421;
 Tue, 21 Dec 2021 05:03:20 -0800 (PST)
MIME-Version: 1.0
References: <20211219153442.463863-1-martin.blumenstingl@googlemail.com> <20211219153442.463863-3-martin.blumenstingl@googlemail.com>
In-Reply-To: <20211219153442.463863-3-martin.blumenstingl@googlemail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Dec 2021 14:02:42 +0100
Message-ID: <CAPDyKFrbWqMSTPvpsYD40yiHvowkVrTRDrjqpt-v3yhJZ9JRgQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: meson-mx-sdhc: Drop unused
 MESON_SDHC_NUM_BUILTIN_CLKS macro
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 19 Dec 2021 at 16:34, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Remove MESON_SDHC_NUM_BUILTIN_CLKS because it is not used anywhere in
> the driver.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-mx-sdhc-clkc.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-mx-sdhc-clkc.c b/drivers/mmc/host/meson-mx-sdhc-clkc.c
> index e1f29b279123..19200b7079a6 100644
> --- a/drivers/mmc/host/meson-mx-sdhc-clkc.c
> +++ b/drivers/mmc/host/meson-mx-sdhc-clkc.c
> @@ -12,8 +12,6 @@
>
>  #include "meson-mx-sdhc.h"
>
> -#define MESON_SDHC_NUM_BUILTIN_CLKS    6
> -
>  struct meson_mx_sdhc_clkc {
>         struct clk_mux                  src_sel;
>         struct clk_divider              div;
> --
> 2.34.1
>
