Return-Path: <SRS0=lwnd=CM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0D9C433E7
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 08:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 484BA208B3
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 08:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F8cahaKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgICIKl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbgICIKk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Sep 2020 04:10:40 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF82C061247
        for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2020 01:10:40 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id s62so1236878vsc.7
        for <linux-mmc@vger.kernel.org>; Thu, 03 Sep 2020 01:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9LSujuKc0BRpFIUlAoG3t4WRDvr3ggsu3MS/qx+gqZg=;
        b=F8cahaKlXlYymZy1vM9/LjOB55QfYqrKFz+jtu996q05elSZiM4NT/N2FUhqENkdDS
         p/z6Naq+t4p4sOjc9rOWCu2u1NigD8yO+JXlMBuBZtyBCdEfDOOMwtk9YeAi0BiRMh37
         0cNizsSvb4/1gqjnVsWXsFsjVuFrCowgJeOMM9oaX3pnRyKPZ4Pw2wqwbzAEAQEBr3aZ
         YzFzqehpPSEHkPysCEhZXHec2zTgFZjTY7WcaPzMmME8TmM85odYmBTJfYnaQ0Y8Scg9
         2dCn4+yr0AdNuw9EU4HFZWjjYLsm5OwcnOMYXb2MfuQcwzW0b4yz0P2Hx8XlmGPD+8UG
         kp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9LSujuKc0BRpFIUlAoG3t4WRDvr3ggsu3MS/qx+gqZg=;
        b=WvGPAewmOuhhB6lXhAHDCW8fN8HZ3Yzu/OVmnutULASyC+1S5+5XNK/ry4eAhHmzvf
         5bEgQfUA50fRKZosmW/wg2HEJCnJG0Ht7bHz4fgEQz5EqCbBwQBSYdkQw/cl5+9DvUU6
         Is70+NvuZT1I0pVFvdgy0QKxdlfBqZckO4lmWqfM0/lnfn2sApGbHoFpD0JLeT4m88Iq
         P1glNR8hMBhMKvMvoWYRHlCO6PXHkUAceDZnaANLBrUA8Kqfe/w6DDjPw+xjzGWla9j4
         U/ZN5k0wZJUtizyaTaZnwGBWQ7aWOIDtJHVRYWSuI9zs/M9XBOCY4v7fKMvbY5GX8Yu8
         1dHw==
X-Gm-Message-State: AOAM530YJ2YwvANDURqzfJRTeC2ued956qb+HhvkotmZXuzPTnEPM9Q0
        Ifskx6B8lwuATg81t/bfhJqhtB5lX6Opu8pPHQLYug==
X-Google-Smtp-Source: ABdhPJyI6yM9cYgRxLstCkc5xLwEf5PvN5GPJ1sq3T0dsqBj666zrIWnBAGaIL6c1jHKd+VdnV6KQIQh4y5v/9ZPk8s=
X-Received: by 2002:a67:8b47:: with SMTP id n68mr837341vsd.50.1599120638807;
 Thu, 03 Sep 2020 01:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200902204847.2764-1-krzk@kernel.org> <20200902204847.2764-2-krzk@kernel.org>
In-Reply-To: <20200902204847.2764-2-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Sep 2020 10:10:02 +0200
Message-ID: <CAPDyKFpQxJ29Rhv=LNzJf8LkpV01EY2Z5-wLPs2fTsraUM=XWQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: s3cmci: Use proper printk format for iomem pointer
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ben Dooks <ben-linux@fluff.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2 Sep 2020 at 22:49, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> iomem pointers should be printed with pointer format to hide the
> actual value and fix warnings when compile testing for 64-bit
> architecture:
>
>   drivers/mmc/host/s3cmci.c:1355:46: warning:
>     cast from pointer to integer of different size [-Wpointer-to-int-cast]
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/s3cmci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index dcd458649338..3fb597095079 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -1352,7 +1352,7 @@ static int s3cmci_state_show(struct seq_file *seq, void *v)
>  {
>         struct s3cmci_host *host = seq->private;
>
> -       seq_printf(seq, "Register base = 0x%08x\n", (u32)host->base);
> +       seq_printf(seq, "Register base = 0x%p\n", host->base);
>         seq_printf(seq, "Clock rate = %ld\n", host->clk_rate);
>         seq_printf(seq, "Prescale = %d\n", host->prescaler);
>         seq_printf(seq, "is2440 = %d\n", host->is2440);
> --
> 2.17.1
>
