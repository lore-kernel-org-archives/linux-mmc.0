Return-Path: <SRS0=vd7C=2A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70246C2D0D1
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 09:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442BE2077B
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 09:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zgHuWeY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfLJJwH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:52:07 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34687 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbfLJJwH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 04:52:07 -0500
Received: by mail-vs1-f68.google.com with SMTP id g15so12581938vsf.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2019 01:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ybsluu38MO5eh/YLSNECYiElz7Q4IKjXe1U2m0DW3pA=;
        b=zgHuWeY7/innDowtWMwI8fnAseVFKB5h8yAU+F+pXXolVXl7IT59cgR3WjvfyHEKhW
         1oJBc8pX9KCvwqjcnkqaBTwxHysQW3v4BP42qGr1GA89dxSewio7bUk2jlVDFdS5MNsw
         tjDpH+kEBA/0avN4I6DtRqv+G+GPp6XyI5rU4VS3cqkpH8P5Ax40K+EH8WfYDK1ACA82
         L58BwWWTVb46EJwVANNVbkh7gvhikAPoTnL8+pRWF5Q8nR+DrIsPFDhUGp/FtVn49yZp
         PoI1VeaPwpSrsxY8/BKDruPtuxroFhcqfnCqDCZo/EXdaU8DGyIlqX9ltATOWRYuD+IT
         aFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ybsluu38MO5eh/YLSNECYiElz7Q4IKjXe1U2m0DW3pA=;
        b=SXGhPua/4LDCJ1ffr+cD3Lj8436zI/pYgwqqHofH0OqveRWOWKP4MnXlDtTzBDDFV4
         xLyi3Y6iQhitAy2r8LOkqMwpJJwqzKkqMq+g3vAhW62psK0LMejBx7zL0lCsYICNGRzt
         JVovfKEvFDCn61+BQ3fDnA9yH3KUyTqniG2uqn/lbFK6Hk/O0t3Wdyrkw/jhXzwLmDm2
         j+FNsPDOm+lwJSI4E7sKON99MfjNuYUJN49GQc3F2sYw1sktJZP7FpsHI8/5Jg20YVY8
         YzDqinT+7P7E6oMycYOZhpu0iJBYNdRBHp19T2V/z+M51RRjAuvMbYcUKKR6al0O6bSb
         8fCg==
X-Gm-Message-State: APjAAAVW9qw17nYz3cGQZED9mho9iDlKQgBKxS+QWpx36nMwOQJPd1hH
        PKE3tzv0PoNi3wCQOZTceUvndb9YSEuWaQw7CZ1gdg==
X-Google-Smtp-Source: APXvYqwWNMYBAQkevXVNBP8cKIcAOSNAKJn6/eATEcFnzDvyeoLn5MqjM1Lw9GooaMA+WqRtf1+QrA4tXx8wiDf2JfA=
X-Received: by 2002:a67:b649:: with SMTP id e9mr24229005vsm.34.1575971526021;
 Tue, 10 Dec 2019 01:52:06 -0800 (PST)
MIME-Version: 1.0
References: <20191204085447.27491-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20191204085447.27491-1-linux@rasmusvillemoes.dk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Dec 2019 10:51:30 +0100
Message-ID: <CAPDyKFqyU1nyVUsuAPC8ZDCm88JOq45aywDM7AqR9vfr0k90jw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: Revert "mmc: sdhci-of-esdhc: add
 erratum A-009204 support"
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Yinbo Zhu <yinbo.zhu@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 4 Dec 2019 at 09:54, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
>
> This reverts commit 5dd195522562542bc6ebe6e7bd47890d8b7ca93c.
>
> First, the fix seems to be plain wrong, since the erratum suggests
> waiting 5ms before setting setting SYSCTL[RSTD], but this msleep()
> happens after the call of sdhci_reset() which is where that bit gets
> set (if SDHCI_RESET_DATA is in mask).
>
> Second, walking the whole device tree to figure out if some node has a
> "fsl,p2020-esdhc" compatible string is hugely expensive - about 70 to
> 100 us on our mpc8309 board. Walking the device tree is done under a
> raw_spin_lock, so this is obviously really bad on an -rt system, and a
> waste of time on all.
>
> In fact, since esdhc_reset() seems to get called around 100 times per
> second, that mpc8309 now spends 0.8% of its time determining that
> it is not a p2020. Whether those 100 calls/s are normal or due to some
> other bug or misconfiguration, regularly hitting a 100 us
> non-preemptible window is unacceptable.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>
> The errata sheet for mpc8309 also mentions A-009204, so I'm not at all
> opposed to having a fix for that. But it needs to be done properly
> without causing a huge performance or latency impact. We should
> probably just add a bit to struct sdhci_esdhc which gets initialized
> in esdhc_init.
>
>  drivers/mmc/host/sdhci-of-esdhc.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 5cca3fa4610b..7f87a90bf56a 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -764,9 +764,6 @@ static void esdhc_reset(struct sdhci_host *host, u8 mask)
>         sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
>         sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
>
> -       if (of_find_compatible_node(NULL, NULL, "fsl,p2020-esdhc"))
> -               mdelay(5);
> -
>         if (mask & SDHCI_RESET_ALL) {
>                 val = sdhci_readl(host, ESDHC_TBCTL);
>                 val &= ~ESDHC_TB_EN;
> --
> 2.23.0
>
