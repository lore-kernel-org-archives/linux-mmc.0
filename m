Return-Path: <SRS0=5iJr=5M=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6E0C43331
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Mar 2020 12:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85062208E0
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Mar 2020 12:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jcKrGM7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgC0M1w (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 27 Mar 2020 08:27:52 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:40526 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgC0M1v (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Mar 2020 08:27:51 -0400
Received: by mail-vk1-f193.google.com with SMTP id k63so2608093vka.7
        for <linux-mmc@vger.kernel.org>; Fri, 27 Mar 2020 05:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=In6AkM11gvqmdb/KispfzpmD2iRwwXtrg0CmmoI1bFo=;
        b=jcKrGM7exGuQiO1LjlslrdOoUNSre0tVMGa8X1rUwAJMoElMCXNRubZF5PwRCB95d6
         aNcuWamXRntJBVslsOEVoKLAKW80FJyIIcBeL2f8cJ7R68fekIllxvdDUoAqQFvJymCx
         XdCelLEQAo310iLDkU60a8lsWlVz2So8fqiQ9pqXZtANOavod0KBr5/IWIpeG7zlbFYv
         zZNIGA51vu8GtL2Vkj0OwFJZD9VZR3UtFspqf32K3AE8zb7NWhQZWlYNwoK59k4R6ZDr
         r82rokEhVSpUVN9wgvJdiPFRIUvHfjTd6XHGXxlAWbhBDiDpWOoZmKoWqdr8f14rRSk0
         3HoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=In6AkM11gvqmdb/KispfzpmD2iRwwXtrg0CmmoI1bFo=;
        b=QG5iZKtOKLZ9+h50We7/5safj0Q2r14XcMvOKh58COD55Sq1xRjxjsbyTTlJ6q7jb3
         2nbnMjY1IhtYQrbEHNoA23jG4Z3SNsdb90dPwgHik5mB6w0ql3AMqMhduFQXXF1o8OXR
         ROuyrcEXppY0x1n4q7FOIifXTHyXzezgCBG3vaqwKzYqj9jaeX+WcFZxNL7vPjThCS+d
         XrtrTnB/ANfx6WmF5A9UKkMawI9Y/OCjnCSaxD3trm43crJwvFC3+ESA3x+jLg4ze3vn
         KEZFeEVv9zxs6oInjeP7TxqPx00LQlWvOVBweWsax/Den7Ie5xBp41ZL3839S6gktkkg
         6IAw==
X-Gm-Message-State: ANhLgQ3EC+VxUootUn4ACJdczjMmsiVsDDWEjI6yR9flQU74m/fnSFwu
        8oiDvItg4q3I8m1319llEl4oxFPK9oqu0ts/Djt8Gw==
X-Google-Smtp-Source: ADFU+vsj3gMKz6JTZIh07Yw64OuO/tMYwReAjM54epn6GbmNlPQc0JWJA4fDl48NwW284gLnlQsKXcRQ9cQhHYiWP+Q=
X-Received: by 2002:a1f:d084:: with SMTP id h126mr10768426vkg.25.1585312070406;
 Fri, 27 Mar 2020 05:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200327043639.6564-1-tangbin@cmss.chinamobile.com>
In-Reply-To: <20200327043639.6564-1-tangbin@cmss.chinamobile.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 27 Mar 2020 13:27:14 +0100
Message-ID: <CAPDyKFpwJq5j0CwDN152bZkdPj4_xrL1p6raMPkHuBwWTXTTwQ@mail.gmail.com>
Subject: Re: [PATCH] mmc:cavium-octeon: remove nonsense variable coercion
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     rrichter@marvell.com,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 27 Mar 2020 at 05:36, Tang Bin <tangbin@cmss.chinamobile.com> wrote:
>
> In this function, the variable 'base' is already 'void __iomem *base',
> and the return function 'devm_platform_ioremap_resource()' also returns
> this type, so the mandatory definition here is redundant.
>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cavium-octeon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
> index 916746c6c..e299cdd1e 100644
> --- a/drivers/mmc/host/cavium-octeon.c
> +++ b/drivers/mmc/host/cavium-octeon.c
> @@ -207,13 +207,13 @@ static int octeon_mmc_probe(struct platform_device *pdev)
>         base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(base))
>                 return PTR_ERR(base);
> -       host->base = (void __iomem *)base;
> +       host->base = base;
>         host->reg_off = 0;
>
>         base = devm_platform_ioremap_resource(pdev, 1);
>         if (IS_ERR(base))
>                 return PTR_ERR(base);
> -       host->dma_base = (void __iomem *)base;
> +       host->dma_base = base;
>         /*
>          * To keep the register addresses shared we intentionaly use
>          * a negative offset here, first register used on Octeon therefore
> --
> 2.20.1.windows.1
>
>
>
