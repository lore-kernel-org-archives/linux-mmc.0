Return-Path: <SRS0=IgIp=CG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDD9C433E6
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 12:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 594CA2086A
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 12:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I0l4bjtz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgH1Mgf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbgH1Mga (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Aug 2020 08:36:30 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1910FC061264
        for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2020 05:36:30 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id e41so312106uad.6
        for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2020 05:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j5YD1NhadThMEK/C58Ql2j7EiHiOLv18owkkqxsxprk=;
        b=I0l4bjtz2pqqTvOpwh0kcA0wzAQZtkTsI87wPl+MpXbnaZvHM4yItqDMxzyiE43QZC
         fX3wSvf1+5/DeMh/5KaikfCP5UL1aBInji5fWmUdl66/bzl87Q6ZfcYZVHBWueepxWIx
         QzMwur4eybknYd4TWA8uxY42WdErSOXMxXeQ2rmyr5T8JnQ9xZKhnws0Hb9yHwvguqxZ
         9S8CaeRqTL/hZoNwJvoEdk58lfefk+iO7jA4tKLimbep6Wc7z9tOMC/5nj5WIIHutkc+
         LbDCDgBeutXBLqFpC7UIRQaJPtcW25RuAM6v84XAE2M/JRyB6x62tve7RKHOI0LThxL8
         s8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j5YD1NhadThMEK/C58Ql2j7EiHiOLv18owkkqxsxprk=;
        b=lKOyv1uiBUZue1muJao8E+7BA21JS2XC3+o3yZRq3HDZJ56Djnd9JfcEwwI6oGE2Sc
         ekezF/zXXiKRDKc7AUSVlvdbTAiqgVxWz9yUJGG4TnWda73KdB2i4LxxwRpJg2I6f6KV
         cV6mkEAZpf2cnZlFron+a0L3BP6YZzIC4GHjSri8knE0U3GZZHrYizEoKa6OJLE5Yg3y
         waNELfPII3UIXecSAT87x2NgcJznY5n3fw4k3Y8FRcnYXIaCwLTbOKGFPFhwPATta7Ny
         qvqPzVCHonDriP1LvQNTWWoGuZZnzE17BJaxxttRz0GiGQpX0x4Oamnlks/WgtTq8txn
         k+Ow==
X-Gm-Message-State: AOAM533PAvibkyo4RrTAItpJY5Gd5oSw5EdftnR3cpUxvlzOrqA6aqtS
        5Y2UeigKf/P+UXEyqgp/ZxAx4e9ErkA9Z2yIsgAIEg==
X-Google-Smtp-Source: ABdhPJyrCiydOq5Bfcq6X+UyK8k8QCM/q6A1XKWpguUBZGQ1ZqLebjNwOplmZEyhJ+m2jgieDoQY0I5F4bsal9O4wlM=
X-Received: by 2002:ab0:2848:: with SMTP id c8mr712838uaq.15.1598618189189;
 Fri, 28 Aug 2020 05:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200821081654.28280-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20200821081654.28280-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 28 Aug 2020 14:35:52 +0200
Message-ID: <CAPDyKFp7rsHDY2vREakrR+PFJLs0n8JBR+URV1vCu5bydEhHuA@mail.gmail.com>
Subject: Re: [RFT] mmc: tmio: reset device on timeout, too
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 21 Aug 2020 at 10:17, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> When a command response times out, the TMIO driver has been resetting
> the controller ever since. However, this means some initialization like
> bus width or tuning settings will be forgotten. To ensure proper working
> in all code paths, we will enforce a reset of the remote device, too.
> Many thanks to the Renesas BSP team for the detailed description of the
> problem.
>
> Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> This patch depends on the TMIO reset refactorization:
>
> [RFT 0/6] mmc: refactor reset callbacks
>
> Looking also for tests here. Thanks!
>
>  drivers/mmc/host/tmio_mmc_core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index ab910043808f..0d64308c619f 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -220,6 +220,7 @@ static void tmio_mmc_reset_work(struct work_struct *work)
>         spin_unlock_irqrestore(&host->lock, flags);
>
>         tmio_mmc_reset(host);
> +       mmc_hw_reset(host->mmc);

This isn't how mmc_hw_reset() is intended to be used. Instead, the
idea is that it should be called by upper layer code, when some error
path is triggered for an I/O request.

However, let me think a bit about this.

>
>         /* Ready for new calls */
>         host->mrq = NULL;
> --
> 2.20.1
>

Kind regards
Uffe
