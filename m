Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859AEC433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28644233A1
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbhAML0M (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 06:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbhAML0M (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 06:26:12 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55CFC061786
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:25:31 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id z16so910959vsp.5
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UTamP/ArLqqwGoTYLNMH/RB+OzgOFY7u6lXmJEovIaE=;
        b=UgMjABl95Zcya/xwewD5TR75NWKt5G5GgXaDqG3SLnkwisVB45A4u+L3Ua4kqyacvy
         Bn0yCJVY1CiYWxoqtkyrfRZxztRfJa2aCwS6COtCEMmtJq7FwDpBuEGa+JTivpDDaBJj
         NRR3JPJeRibrwoQNcXKrErfCgTX2GaW0OugPvl4weCufgH2OdmH4BRCXdcY9LPOY1tqB
         NfNmJP+hVexHo1qYOKc0Tef1W/RrKqs+oVGpctpXjtXjpYT/8g1/YwwXEEw5AQX4qC0n
         u7ZR0YL9iEI6PS/a0ycfeo352VhDvgf5V8Nc3FgmEi/4OegCloz+pD5v1thJXv+oJnEv
         HdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UTamP/ArLqqwGoTYLNMH/RB+OzgOFY7u6lXmJEovIaE=;
        b=D6hOZE//zVq7ZEvuJTbL7SYQ4NP1LDrUWVbjam1aax7WYwUU+PSiYvR8IVdlSjoNJc
         pBwUIWEDJqyABI7ongco8HZVqM6FyRXry0w840Zcunp0RjbHHhAgLqySP5bpBAfnd8+v
         J9CHjWDVu6slCTADX4mlnm3qom54fExdLFZMZMq1L4e/PmuMZ95R3umg+IS1w8GbYMCs
         A9ZNcNvw+nbFIGwDWlRgFQyjE57O1BDQgx3ItB0tzgQecjqLVcpKleWAeDIh3K0BaVk7
         7GvrgJQhePQJGpUAt9UEDVSYZKOc4kWYGNfm4joEtjOAEM9Wfe4fCFGHGmNtRoU3iNyx
         tm/g==
X-Gm-Message-State: AOAM531M0k3dFU0lpgB/qTrKUMWHZn7rAXXEoaTdN+KjVnvASNPR2MHH
        0l9iuGnGQFu/bevNRRpHh8Kj7Cp2EGiZQnykt3Lnjk6r0DV4cA==
X-Google-Smtp-Source: ABdhPJwBwHyie480O2xGlwJHrHs3ZflMifx52QfOELTUo6npGeUwrPtutxWDy4YxE8zNu13H6+PTxLqsROPnmyDevQY=
X-Received: by 2002:a67:e286:: with SMTP id g6mr1628197vsf.42.1610537130904;
 Wed, 13 Jan 2021 03:25:30 -0800 (PST)
MIME-Version: 1.0
References: <1608114572-1892-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1608114572-1892-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 12:24:53 +0100
Message-ID: <CAPDyKFrE0udk+GY2MnNB7h7GPrdrbLnCwT-U=KunwxUBbdM4qQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mmc: renesas_internal_dmac: add pre_req and
 post_req support
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 16 Dec 2020 at 11:29, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>
> To improve performance, add pre_req and post_req support into
> renesas_internal_dmac. Note that the patch [1/2] is a bug fix patch.
>
> Changes from v1:
>  - Add a bug fix patch for hardware limitation in patch 1.
>  - Remove a redundant argument in the unmap function in patch 2.
>  - Describe the reason why we should not use host->sg_ptr in patch 2.
>  - Rename argument of struct mmc_request from req to mrq in patch 2.
>
> Takeshi Saito (1):
>   mmc: renesas_sdhi_internal_dmac: Fix DMA buffer alignment from 8 to
>     128-bytes
>
> Yoshihiro Shimoda (1):
>   mmc: renesas_internal_dmac: add pre_req and post_req support
>
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 91 ++++++++++++++++++++++++---
>  1 file changed, 83 insertions(+), 8 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
