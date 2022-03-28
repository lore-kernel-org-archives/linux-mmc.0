Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C82CC433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Mar 2022 14:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243653AbiC1OG7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Mar 2022 10:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243638AbiC1OGy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Mar 2022 10:06:54 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35C31CFD7
        for <linux-mmc@vger.kernel.org>; Mon, 28 Mar 2022 07:05:12 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id d134so15335087ybc.13
        for <linux-mmc@vger.kernel.org>; Mon, 28 Mar 2022 07:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=53hfCds/HOn34hVWrA7541rRTz3YTdreaZ+mvzS7WRE=;
        b=Cx62eGgcgtXYkGjFpRxnw9cG3E1PTmxLGrWqwA/zYtPl9JBOdDem519S2UoyoOHnJ2
         7JnULEL1svsTOyITUGi25DlUzszhdXc4um0N5RXWQZ71aXnLFdRokP3kEujq97AXymtV
         75IAs+4jax2YMyu/9YkSOg4nN64rFw55wbkMc/xPJj39M0o7ibOT2rCoGSPGDZzW99Eb
         MznbzLtmE/j4qrTSAAX3arhLaVYiSVp9HKe0Xc7OMSt7d7EKmLEqCqk6WpE+N0/2UjZV
         5InW4u9eqLKk0kPwrUgWWEd+AtPRHc35XU3RqIJQzMVdZIPsskNQKDpYCiE2LU1Faslx
         5QBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=53hfCds/HOn34hVWrA7541rRTz3YTdreaZ+mvzS7WRE=;
        b=ZSEXl5e5GQWUZ+7/Wtq4cyeE5eY9Jhpc03wKQHINQl0Z1uCejus+hWvagNBppbMfOI
         9n4rWIxEPmUCMh1B4rYHdPfy+aKA82i4IgIXPMTfUhrIL81xPTs3/9sfjGnzaHYmGRUF
         VmrwPJ8l1/LP1H1TFemTbeHblmfRwOletbjuVB+Xf4TV5Y8Z9TMdovQPWtu0dVavCHvb
         bqRqoh7xbRHALlxhD/HP41fXE+vI2CVRlayj7i1YNyWEyZnEun4wb6ndsdBrF24RUlxf
         8kLbw90P+/9VcSr5m11HVkBcTc0cRQI0u/y7Ywqu6bKMwvorF04bpNlZy4p5599Im7Jr
         S2eg==
X-Gm-Message-State: AOAM532KGrJ4bgxf+0SSheohHEmrWS397ylwfugR36fHsigMrsWQ3Tnh
        0X2IBr0Rew0NCB+WqFr5V9dZkFG8OQnb2ZHP/IbdqMpc/XA=
X-Google-Smtp-Source: ABdhPJwS1cf/SA/NQaVx2IlTtQpE6Zm6uckyjLWileFFOnVlhsE+7jQYLkUhbPoSZmGhmdocSjQLYT/bWvm/mPvTQSQ=
X-Received: by 2002:a25:4289:0:b0:633:7135:1689 with SMTP id
 p131-20020a254289000000b0063371351689mr23074419yba.397.1648476311808; Mon, 28
 Mar 2022 07:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220320123016.57991-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220320123016.57991-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Mar 2022 16:04:35 +0200
Message-ID: <CAPDyKFq=f3R_37nLq=Vm+6ZaDCqOU_9q-4A1X0r55z9uLT27XQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] mmc: renesas_sdhi: internal_dmac: updates after refactoring
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 20 Mar 2022 at 13:30, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Shimoda-san's much appreciated refactoring of the quirk handling allows
> for further cleanups which you can find in this series plus some other
> improvements found on the way. Finally, 'soc_dma_quirks' can be removed
> in favor of regular quirks.
>
> The series is based on mmc/next as of today and was tested on Salvator-X
> (H3 ES1.0), Salvator XS (H3 ES2.0 as well as M3-N).
>
> Looking forward for tests and comments.
>
> All the best,
>
>    Wolfram
>
> Wolfram Sang (6):
>   mmc: renesas_sdhi: remove outdated headers
>   mmc: renesas_sdhi: R-Car D3 also has no HS400
>   mmc: renesas_sdhi: make setup selection more understandable
>   mmc: renesas_sdhi: remove a stale comment
>   mmc: renesas_sdhi: make 'fixed_addr_mode' a quirk
>   mmc: renesas_sdhi: make 'dmac_only_one_rx' a quirk
>
>  drivers/mmc/host/renesas_sdhi.h               |  2 +
>  drivers/mmc/host/renesas_sdhi_core.c          |  2 -
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 70 ++++++++-----------
>  3 files changed, 33 insertions(+), 41 deletions(-)
>

Queued up on the "devel" branch for v5.19, thanks!

Kind regards
Uffe
