Return-Path: <SRS0=9HeC=D6=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73083C4363A
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Oct 2020 12:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 018B624248
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Oct 2020 12:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ROZCwsIR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370489AbgJWM0M (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 23 Oct 2020 08:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898406AbgJWM0L (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Oct 2020 08:26:11 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE96AC0613CE
        for <linux-mmc@vger.kernel.org>; Fri, 23 Oct 2020 05:26:11 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id s15so756609vsm.0
        for <linux-mmc@vger.kernel.org>; Fri, 23 Oct 2020 05:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SbiM058sppBM2ejB0BKsLTyfit1usvLgD9lTKm1udBQ=;
        b=ROZCwsIRP2IVMu9iOTAMvfqGoXLdd4eDrvuamqNxCT7kMI1yF2ub3ixtnQ2y/MS79R
         d8s6eDXGU4X/PXaPwHuWSq5j+WXU9aExYxJp9eby/IYOmGbI80nYUBr1tVLefYOeciNV
         L9v5hKp1+BWlZFTA8UJGITaIM+7D6NPRl5V+fOsLIm4O8/i1GpytSCVonKaQyFXF7eot
         9zmBawTgHsdb9dEoWzzA896vnMLKqccUd/+udRPFp9Kq3eJxhASbVctIDw+6TP/k/vTb
         Tv2b7vvTwehg7ExRWLoO5VQEPxfwrIyxEg1HFRrR1bGznWIRM9Q5IPU45oRwrUun+aH1
         8DEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SbiM058sppBM2ejB0BKsLTyfit1usvLgD9lTKm1udBQ=;
        b=p6Gs657wx3pWLUvfYc45jqqvTj1kwrwcbRXE0ZaEknAjwdj1dGEzfrBszBklL3tuqx
         4uksVGFUX5f1FmMEludnQT5mbkCyXKAmVYQbvY9xh7H9RVAz6zTPJA5iyx/6rO7WE83I
         Y0cI0wEYh6zeA/0LdV8V+ACxRzH/r62bq8graX0q9/AkV10qBC+fjXvJpk1ouJq5cuUT
         2qb08k+ZjcYfXySuIY0n9nx3jHyRISFhgox3NHw+DJVzhuIGvxEoKSwJYrzKd6Ev2mhw
         Aw8IMoxZQKymZOxygMdOvxV1o7+4VDNgRppY7IMIYKlkwcSGFl1w7pFIqvOyofT7/lzG
         1q9Q==
X-Gm-Message-State: AOAM532+TtKbiq6ec78QSab2eAQQWG2J9E9tHecMwFDbuUX8gz9sH6pF
        vfZ3IdywvUxXjwxC/ss6m7//RYv7H1sOkZyyQMdPTg==
X-Google-Smtp-Source: ABdhPJwCWRGvbGLHU8VapiWEJeresFqhayakEx40w5ZiKSNlLE07YGg25rKi83MAt/isEEkTOm5D8TzAOtGuWwOF22A=
X-Received: by 2002:a67:6c86:: with SMTP id h128mr1072002vsc.42.1603455970903;
 Fri, 23 Oct 2020 05:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201022222337.19857-1-michael@walle.cc>
In-Reply-To: <20201022222337.19857-1-michael@walle.cc>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 23 Oct 2020 14:25:34 +0200
Message-ID: <CAPDyKFrH=G58fSMExb+QA794BhAXk-NFV2djNRObyHTH9R7W3w@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-esdhc: set timeout to max before tuning
To:     Michael Walle <michael@walle.cc>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 23 Oct 2020 at 00:24, Michael Walle <michael@walle.cc> wrote:
>
> On rare occations there is the following error:
>
>   mmc0: Tuning timeout, falling back to fixed sampling clock
>
> There are SD cards which takes a significant longer time to reply to the
> first CMD19 command. The eSDHC takes the data timeout value into account
> during the tuning period. The SDHCI core doesn't explicitly set this
> timeout for the tuning procedure. Thus on the slow cards, there might be
> a spurious "Buffer Read Ready" interrupt, which in turn triggers a wrong
> sequence of events. In the end this will lead to an unsuccessful tuning
> procedure and to the above error.
>
> To workaround this, set the timeout to the maximum value (which is the
> best we can do) and the SDHCI core will take care of the proper timeout
> handling.
>
> Fixes: ba49cbd0936e ("mmc: sdhci-of-esdhc: add tuning support")
> Signed-off-by: Michael Walle <michael@walle.cc>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for fixes and by adding a stable tag, thanks!

I am not sure for what stable kernel this applies to, but I guess we
will get notified about that, sooner or later.

Kind regards
Uffe


>
> ---
> Changes since v1:
>  - Added fixes tag. Suggested by Ulf Hansson.
>
>  drivers/mmc/host/sdhci-of-esdhc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 0b45eff6fed4..baf7801a1804 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -1052,6 +1052,17 @@ static int esdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>
>         esdhc_tuning_block_enable(host, true);
>
> +       /*
> +        * The eSDHC controller takes the data timeout value into account
> +        * during tuning. If the SD card is too slow sending the response, the
> +        * timer will expire and a "Buffer Read Ready" interrupt without data
> +        * is triggered. This leads to tuning errors.
> +        *
> +        * Just set the timeout to the maximum value because the core will
> +        * already take care of it in sdhci_send_tuning().
> +        */
> +       sdhci_writeb(host, 0xe, SDHCI_TIMEOUT_CONTROL);
> +
>         hs400_tuning = host->flags & SDHCI_HS400_TUNING;
>
>         do {
> --
> 2.20.1
>
