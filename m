Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D344EC2B9F7
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7C4E6108E
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbhEXOM7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 May 2021 10:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhEXOMw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 May 2021 10:12:52 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDD4C06138D
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:11:21 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id x1so8855305uau.1
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQjfeEw8bGFzEuzrklBfge8nfFaFNuAFn3ZK3HpPgxw=;
        b=rxKg+ApaaB6JtEve8oSPQEKOi7NDXv6i0doj86gRxxobDDHUQFoMKa32yyziBSOU8P
         c0T36wIiPhxWTRBBSITeKlwYyObzAYmZwhAcFo3kIfhmjd9OIQjLghJCMDDLy26AHkVE
         Hmpgd7Fl3fCWgn8RHO6iN1G/A7m0klnp7LAzBgncua9JYZdDne+C2YJuAHrYXxXSK+O7
         HqyTwM+6EpIGvkjrHBh6s9IBeNtIGsEt0b/nl8UqnNvAPJC7LOBURfwaQBhs67hi4qol
         m+YN4JmTzIDo5GngFh6nNqRWoFhpQfMpQxoRA38GrFicoJkGmDO/WUDkuKYdGSwBE4iB
         yfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQjfeEw8bGFzEuzrklBfge8nfFaFNuAFn3ZK3HpPgxw=;
        b=RABsPt1KJ4/ZNhE0ZBt9HkBbZrFJ3CQfr+36iRWJSreiDhwzJjw0EbAJHBIP3w/KEo
         RvzummJGg4jYvmhzgFRCGRjs1PaGTv+4jmIuRjSGIcwVFnRDnQQZerAT6fvc1yTOPrfO
         Ea43tMSBSmc/bSdbWxWAYoHZKeicFaSbhPfeLsmoGxXRDUhxorx4bUU+CJtpGL1CMYZt
         43WN/elAcYLSbTLlc0Kg+G6SiBynJtQncfqOVMlfAxRC50aESBFVqP04eEHgK5BfFk18
         EQ7QVvXrc883EFJgPK3d+uM2AfHnqOZZJ3B8fs99K8lFI4QBR3MFs21xZug5zuSaypLr
         4+fQ==
X-Gm-Message-State: AOAM531Ni1aC8kCIWa8hihkXCLnJArjMLE7rsYlCEmTsykrnyeq2HqCu
        AyqD2LqcjynuRL2xf8p8dp/G69KceafLIoeTl9YMkw==
X-Google-Smtp-Source: ABdhPJy/Xv1nxDQRV1veUOYH4c6SXp+zM77ffvPcG8/+Kbug0zamZtYxNek83b1FHuKJAC+4So3Zy0yfA85rpxm85lU=
X-Received: by 2002:ab0:3351:: with SMTP id h17mr22720936uap.15.1621865480578;
 Mon, 24 May 2021 07:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210520101330.2255-1-zbestahu@gmail.com>
In-Reply-To: <20210520101330.2255-1-zbestahu@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 May 2021 16:10:43 +0200
Message-ID: <CAPDyKFqLgAm02OY4NK-yCmpQYaePwY0HBUYKRyMRSY+8KAU_HQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: cqhci: fix typo
To:     Yue Hu <zbestahu@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yue Hu <huyue2@yulong.com>, zbestahu@163.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 20 May 2021 at 12:13, Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> 'descritors' -> 'descriptors'
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cqhci-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index e759e3b..c237b6e 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -146,7 +146,7 @@ static void cqhci_dumpregs(struct cqhci_host *cq_host)
>  }
>
>  /*
> - * The allocated descriptor table for task, link & transfer descritors
> + * The allocated descriptor table for task, link & transfer descriptors
>   * looks like:
>   * |----------|
>   * |task desc |  |->|----------|
> --
> 1.9.1
>
