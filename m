Return-Path: <SRS0=RiNA=5T=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E055CC43331
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Apr 2020 10:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF83C20787
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Apr 2020 10:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oEObsjON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgDCKEc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:04:32 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40969 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgDCKEb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Apr 2020 06:04:31 -0400
Received: by mail-vs1-f67.google.com with SMTP id a63so4538416vsa.8
        for <linux-mmc@vger.kernel.org>; Fri, 03 Apr 2020 03:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IcuuGYdgklqk+winEbs7DcGIola/E6UKhqQxnRnFJ0o=;
        b=oEObsjON49x1B9AquUmECVyS5SGa4MKWtq+aZT2PI+2vtJOrEt46X3NRvBNjmKymu5
         nZCf4NW48kMPCeE0EvebZmvV+Olc/lWrTfhyT9lkMC/vucW2guaQA+74wp0+jNXtIunf
         Bgb2J11abzn59wqmNR3vINrlhYV7XEj+ldC0SyJg1Ze+RdtHttl78SA2+Xx7rzb7JzP/
         XeBreEojzcDn3zehbIIafQbzZKZu8DX5WDzv/OhhG+oXfq25tcU5zwKkoJyk580lNkLw
         TO4tMI04JNHxxvXL+sJugmBhzsu1DIgiInDIF0hdrBaMwomxgmX1BUZp1R3LyNaVTWIv
         FgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IcuuGYdgklqk+winEbs7DcGIola/E6UKhqQxnRnFJ0o=;
        b=i0bw41jeWw/RRFuVyrZKAbuj9hh34eWN/VEPCOEhKxS4E0k5Rc0dx5/JOXVdDXVZSJ
         IXyMtRyJ9N0r2ZLuklVO29hhQgkP/T6UeIQH7+RKExSn61fwWbOmvZI5zif+M+rwC1lI
         JyPWc+x6Bba3g9ggT+ksVBSa0uxvsmsCsIF5128lgwi0hv9kUQ/DwWonUbUdLwQoR8yt
         368XOg7+hssp/7XdQDXXPVSudY6WeqwOXpoj38rtB5xBpK69mtimccSiylLo3rzah8K6
         WGThP567LskRvuTmKE2HIdVc7jUCOSiywI9e+8tjRKpVydUzf6RLqk28o3OuHW+BZBgv
         bibw==
X-Gm-Message-State: AGi0PuZNqb+LUrvBvKLbcwzstNhZCugkHiwHJwyOqjWxUcW9FHbzq5Qu
        OkmkNiTlpcOcCyjMgCWE0YAMbkKpRS0u51rSZfmOgA==
X-Google-Smtp-Source: APiQypKOxM2oDktjh3SoUb2BNAZwXnsKheHuKzLTrVxvEPS0qbcEfdtMSt53HpmvWrWQ3xkELtNNcDPDZfyCJzwu6cw=
X-Received: by 2002:a05:6102:2051:: with SMTP id q17mr5924097vsr.165.1585908270607;
 Fri, 03 Apr 2020 03:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200403034727.11879-1-yanaijie@huawei.com>
In-Reply-To: <20200403034727.11879-1-yanaijie@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Apr 2020 12:03:54 +0200
Message-ID: <CAPDyKFrXXMJ13-=qy9C5WUmNvcTC5QzKL=EFNKn28BD4h=5ufg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: make mmc_interrupt_hpi() static
To:     Jason Yan <yanaijie@huawei.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 3 Apr 2020 at 05:49, Jason Yan <yanaijie@huawei.com> wrote:
>
> Fix the following sparse warning:
>
> drivers/mmc/core/mmc_ops.c:881:5: warning: symbol 'mmc_interrupt_hpi'
> was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied for fixes, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc_ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 5bd0ab8b236a..baa6314f69b4 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -878,7 +878,7 @@ static int mmc_send_hpi_cmd(struct mmc_card *card)
>   *     Issued High Priority Interrupt, and check for card status
>   *     until out-of prg-state.
>   */
> -int mmc_interrupt_hpi(struct mmc_card *card)
> +static int mmc_interrupt_hpi(struct mmc_card *card)
>  {
>         int err;
>         u32 status;
> --
> 2.17.2
>
