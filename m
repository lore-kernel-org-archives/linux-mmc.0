Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20031C64E7C
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 14:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB88C2083E
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 14:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g/xUqz/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388933AbgKXO0B (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Nov 2020 09:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388931AbgKXO0A (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Nov 2020 09:26:00 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D16C0617A6
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2020 06:26:00 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id e127so2316549vkb.5
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2020 06:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KG8e5alurpzWsF4jajWReOxdS4vWE5nC7cfgCJfHE7o=;
        b=g/xUqz/xefjW2ksNTDU8JYI1zBpoXrIpxp0AUyWvbQVQgjWYR5M9htWM+WmCbF66g0
         r8sKwpkIIuv4vuLR9UHv90nTBobtYw7qBiFQCxR3K3pEbqc9r3P7GP68MP2VDqh7FvwE
         wR6wQRL4GyVBLYIa+R15z+kPsOIg1dlwQnmi3dhpPvjQSbRyu3SAO3+lEPRcO9OhKB1q
         3GT9a/R5Z1DR+Lmedxts69H/GShmSqlM9kdTpGfFWO3+/j7lqUZuDhZl6Ql53qKllW48
         BImiXC46bb6uRitmmEWw1LdnygAkyDKlyaC4l9Bl5aErzdyL7GOTPXScYHs1XLbDifqf
         Izhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KG8e5alurpzWsF4jajWReOxdS4vWE5nC7cfgCJfHE7o=;
        b=RUcgAJWGuzLfXXnOaGKhdaMRO7tlvtZMB5uaOCTJLCpuLyHD0zwkqkNt8CD3+SDUux
         goYlHTlW2O5KjtY/A8GlRscr+5D+o1DX17qVOiEid68NK77BFxu+xpPur2e4mvQU3UwA
         9M4Fol/2C7JfVvuYScNeJFsKC1GV5e2VHiwpFi4vN3uuxP4c0nQ/U49OcZYG4zy6vM0P
         je/Y35/ONTx+SjnC3odmO6VnlyP4vLf8140NqUx9x1dR2M9UZl7bd/DTAEvSxzXqBaYb
         hQS2v7P7wq7iW8Vf4VfvG3yzpMJESG0nOVbkh38noPMofvAcoKkXPG+4nBsjSghLVsM9
         Yjeg==
X-Gm-Message-State: AOAM5331SMdEPfKTo1h7YjwYgFOT9MY5yddl7kSAkab/0QD9/ZL9+/FC
        d6UC2SXa9h7+Fsj5cdLRpjYzO06z3WL3K/2U+QSi1Q==
X-Google-Smtp-Source: ABdhPJy6HKalBTH6OZFShSJXcEikfluUqZ+puytamY9rxBoTg0WnLNWKjGH9RzcZNSULA1ntvmmWdHLw+M+BH/7yj0E=
X-Received: by 2002:a1f:8f48:: with SMTP id r69mr3987608vkd.6.1606227959664;
 Tue, 24 Nov 2020 06:25:59 -0800 (PST)
MIME-Version: 1.0
References: <20201121021431.3168506-1-chengzhihao1@huawei.com>
In-Reply-To: <20201121021431.3168506-1-chengzhihao1@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Nov 2020 15:25:22 +0100
Message-ID: <CAPDyKFq3S2cdL0pCOLU7rfxFmNrQOZvproKVQ=Af7=sXHrFKOQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: pxamci: Fix error return code in pxamci_probe
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 21 Nov 2020 at 03:11, Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>
> Fix to return the error code from devm_gpiod_get_optional() instaed
> of 0 in pxamci_probe().
>
> Fixes: f54005b508b9a9d9c ("mmc: pxa: Use GPIO descriptor for power")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/pxamci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 29f6180a0036..316393c694d7 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -731,6 +731,7 @@ static int pxamci_probe(struct platform_device *pdev)
>
>                 host->power = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
>                 if (IS_ERR(host->power)) {
> +                       ret = PTR_ERR(host->power);
>                         dev_err(dev, "Failed requesting gpio_power\n");
>                         goto out;
>                 }
> --
> 2.25.4
>
