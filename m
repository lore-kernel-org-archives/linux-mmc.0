Return-Path: <SRS0=8+sB=DW=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5141EC433E7
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Oct 2020 10:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E10902224A
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Oct 2020 10:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EH8oOIvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbgJOKcG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Oct 2020 06:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgJOKcG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Oct 2020 06:32:06 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3F9C0613D2
        for <linux-mmc@vger.kernel.org>; Thu, 15 Oct 2020 03:32:05 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id v23so1190393vsp.6
        for <linux-mmc@vger.kernel.org>; Thu, 15 Oct 2020 03:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/SatyKykuj6+wusU+fkldlSz6zvf7g6aQpEzSmisHQo=;
        b=EH8oOIvPDHGmcjJEUjI+FbC0PcyeU8y82EV3e6ObXVFcyRPXGjcgvogHfmr2Ok5yrl
         VAsQv36g7PijaMu3KlNS9XkgUaDprdHdPjXAoNf5zA+hg1FNGsphd4kE1DRnBCDM0+SM
         WbCmAMjfZPZIVg33dLGDvErXvGinMN8eQj8YPifuuVDJVz/u6tfNcheNyt/XYqZPYB2V
         vmENhjjHg8NgqUlYVkGLikIKl18GbZ7qBlsjuVX0Vw5js71va2Y2MiTvI95yK+6E07MW
         F9A0RD1751G/JW3JJHamGi4iCrbHYq3iYxW6o2Vv3uigGMeG+kjt3MxW+jfwwI4Vq3cu
         W+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/SatyKykuj6+wusU+fkldlSz6zvf7g6aQpEzSmisHQo=;
        b=Zgi27usqlgRH9+MBhSwcxTZFbWvMcDCRif7quT4uV39wrnjizfOx3XXeC+w+zjMGJ3
         gXuMv/THTHntqm4PRDDQGHBaezGR4T0YKgR2XxbIiuu8q4VJSukAt+dgisVfIDtu14Dn
         TpdxgP+2Xss4+4829Z8hwG8byxLJZPJ8lJ4P+t7alYIQvU7Sr8sAd4x48n04G+djVAMO
         F+6pakys/PNXvgqXiIjm/AQYkVmGw79n7i1fBr8Nsv3iNkqUFE0u8PprSThNZn/r6QXa
         BL/pF3DzQvHO6F39ylmc3zoqsNyLC2YyGl1m3KkpYb+kJ1/zcZNtaFDwWrQSPVlRqYsY
         pbMw==
X-Gm-Message-State: AOAM5302zDtGS34hJHsUea2aHXqbBnAm1xtz2iqjIFE+7/hUuQUTGWHM
        IKFSCVmx+s7A86rcrdoivkpKc+s9ezEJsDFE5ub1fA==
X-Google-Smtp-Source: ABdhPJxuM0JbleJ7I2fLfYg5p+bT/r6vgA7Gd3CFnq+uGIUxv5tWvw3VJ52PgtnsBx/zvJdTZtCOVrdTZ0ZsD3tuGVs=
X-Received: by 2002:a67:f24e:: with SMTP id y14mr1940388vsm.55.1602757925004;
 Thu, 15 Oct 2020 03:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201015174115.4cf2c19a@xhacker.debian>
In-Reply-To: <20201015174115.4cf2c19a@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 15 Oct 2020 12:31:29 +0200
Message-ID: <CAPDyKFrmYO-Y8kxdzz=XLDJPWCv0mwUL374N=RDGvFS-uPTaLA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci: Use Auto CMD Auto Select only when v4_mode
 is true
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 15 Oct 2020 at 11:41, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> sdhci-of-dwcmshc meets an eMMC read performance regression with below
> command after commit 427b6514d095 ("mmc: sdhci: Add Auto CMD Auto
> Select support"):
>
> dd if=/dev/mmcblk0 of=/dev/null bs=8192 count=100000
>
> Before the commit, the above command gives 120MB/s
> After the commit, the above command gives 51.3 MB/s
>
> So it looks like sdhci-of-dwcmshc expects Version 4 Mode for Auto
> CMD Auto Select. Fix the performance degradation by ensuring v4_mode
> is true to use Auto CMD Auto Select.
>
> Fixes: 427b6514d095 ("mmc: sdhci: Add Auto CMD Auto Select support")
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe

> ---
> Since v1:
>   - add the performance degradation on sdhci-of-dwcmshc explanation in
>     commit msg
>   - add a comment in the code explaining we require Version 4 Mode because some
>     controllers(e.g sdhci-of-dwcmshc) expect it that way.
>
>  drivers/mmc/host/sdhci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 592a55a34b58..3561ae8a481a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1384,9 +1384,11 @@ static inline void sdhci_auto_cmd_select(struct sdhci_host *host,
>         /*
>          * In case of Version 4.10 or later, use of 'Auto CMD Auto
>          * Select' is recommended rather than use of 'Auto CMD12
> -        * Enable' or 'Auto CMD23 Enable'.
> +        * Enable' or 'Auto CMD23 Enable'. We require Version 4 Mode
> +        * here because some controllers (e.g sdhci-of-dwmshc) expect it.
>          */
> -       if (host->version >= SDHCI_SPEC_410 && (use_cmd12 || use_cmd23)) {
> +       if (host->version >= SDHCI_SPEC_410 && host->v4_mode &&
> +           (use_cmd12 || use_cmd23)) {
>                 *mode |= SDHCI_TRNS_AUTO_SEL;
>
>                 ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> --
> 2.28.0
>
