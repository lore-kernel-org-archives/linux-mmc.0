Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E2EC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Oct 2021 15:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E3F560F92
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Oct 2021 15:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbhJZPnG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Oct 2021 11:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236977AbhJZPnC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Oct 2021 11:43:02 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FBCC061767
        for <linux-mmc@vger.kernel.org>; Tue, 26 Oct 2021 08:40:38 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id q16so16762469ljg.3
        for <linux-mmc@vger.kernel.org>; Tue, 26 Oct 2021 08:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yuAeUf9uZkiKUJDSGobKdOnKcJ1uapOPXzgjXviYDro=;
        b=muMlBrRY3/QCQrarET+Xe5M31Y3VLic0gR0j41gMQ8eAYF2HxZCDUd70WvE/Bjnei1
         3trPRvzaln8YUcRy/jJuZHGB6oLaj8+pGuquEVE9DTSkynGZh7xu7wmSHE4+7HppLKC4
         vCVkTDeOxXwWvOw8qLTsHnT17A8koWmSw+oMKXawstQD4FxN/Cz6elLurwvZr8bPPKP2
         odkXmLs/l8g0ppbEwBN11TGIKFIzR3sHgzAiBL0nCGTSeuy4RI/HW5Hs3vKJcmbb3C9Q
         gFONbN8eIhLX/VvQGoQnXN1ZalnTFHjt+eaLd7bzOA6cqN44tyLJ+vCdtfyK+TEyeYuh
         W8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yuAeUf9uZkiKUJDSGobKdOnKcJ1uapOPXzgjXviYDro=;
        b=rMM/Sw1fsg5fR6fRZcdE7YkTdsu80jYiqBRjbcYXPl7zz9KErhgJxdeQkmYd0HERXk
         OuyCO+ZvG8C2oOuVmNcjMMiZG+WqxRFrth/LPAK3aEQERFJNhsFL21N8bu1xgGq5Gwdz
         xFv8+itZ3dGJUeOBDM1VHVYr8sAF/SbBYuQNKT4cZXcDQV4tgAt0rYD4DG1ykEt5f2eN
         c8vV33msRlYK9QAdw/8RGZUOdyJcNzF5M2fyTVKOCm17q7WDpLylZbvXuUtdvfyEnyRE
         ivbjhVna1eo7SoW/ee37djEp5BNqd45bjDXj507VOoBYvPvVqoYXpBLJN3e/DAKSOvYY
         CiJg==
X-Gm-Message-State: AOAM532mHH9AlftwbseAMvIuqN0atw/2Q03wnNWADtnA9bCl3gbnfDe4
        DifP8yrghmWbUbVEsVuz3BR/7DDcOrz2OwEpqUVYtw==
X-Google-Smtp-Source: ABdhPJwJxayy3+qErnJw+sJ9TklHlWV26/nGoMVeRjTBnpEsMJAPY+suHEdAsQ4L/4uK7Ul8VoW5H9CPVhbKCZWsnjk=
X-Received: by 2002:a2e:874d:: with SMTP id q13mr27385797ljj.16.1635262836382;
 Tue, 26 Oct 2021 08:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211022054740.25222-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20211022054740.25222-1-lukas.bulwahn@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Oct 2021 17:39:59 +0200
Message-ID: <CAPDyKFqt9a+WhoRiyyQWSsJugSqbzoWniba0xL=w_0Rw3Xn0hQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: drop obsolete file pattern in SDHCI DRIVER section
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 22 Oct 2021 at 07:47, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 5c67aa59bd8f ("mmc: sdhci-pci: Remove dead code (struct
> sdhci_pci_data et al)") removes ./include/linux/mmc/sdhci-pci-data.h;
> so, there is no further file that matches 'include/linux/mmc/sdhci*'.
>
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:
>
>   warning: no file matches    F:    include/linux/mmc/sdhci*
>
> Drop this obsolete file pattern in SECURE DIGITAL HOST CONTROLLER
> INTERFACE (SDHCI) DRIVER.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> applies cleanly on next-20211021
>
> Ulf, please pick this minor non-urgent cleanup patch on top of the
> commit above.
>
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 44c590b762d1..c47ac3e938b7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17024,7 +17024,6 @@ M:      Adrian Hunter <adrian.hunter@intel.com>
>  L:     linux-mmc@vger.kernel.org
>  S:     Maintained
>  F:     drivers/mmc/host/sdhci*
> -F:     include/linux/mmc/sdhci*
>
>  SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) MICROCHIP DRIVER
>  M:     Eugen Hristev <eugen.hristev@microchip.com>
> --
> 2.26.2
>
