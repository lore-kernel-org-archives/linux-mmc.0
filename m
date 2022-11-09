Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D3BC433FE
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Nov 2022 12:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKIMeo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Nov 2022 07:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKIMen (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Nov 2022 07:34:43 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA211740E
        for <linux-mmc@vger.kernel.org>; Wed,  9 Nov 2022 04:34:43 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id o7so16602845pjj.1
        for <linux-mmc@vger.kernel.org>; Wed, 09 Nov 2022 04:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+vTr7OxuLdKpOUINi2XZxnuPJqnUXrvJgdjO2NhLpRw=;
        b=sLwZJE/xemd5S+1CdXKsb1KtEstqBjCEO2BQxelhbpSobnBi0NRITQFxqmuoRkB9zf
         8HwaQMSyUNCzEG2iDCxogqEgS64hiHgYvE+W/4zHmLMWRsbFWV//vfPCyiIqyjaD2195
         I1tUpJnS9pCFaeDAdpmKLIYfj3RIpNS689cXYVJNWrg6KSYqgyfrmfnH/FRDdjkMHvIH
         RKsHk38MWWYJR8YdIzRJNkAj6TtMd/79fP+eVZqOXaGRdtGMemhypURPMAHLcuIprNB3
         kwLdB3E+4RM6XIARemkjPj8LvSLq9kP2j/o+6gyuI3WF/HzUMkJm3XQQJ6SzH5d1/FLr
         3t5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vTr7OxuLdKpOUINi2XZxnuPJqnUXrvJgdjO2NhLpRw=;
        b=sQbsC91PLRfAxW5y7ve/xnfCe/S9xCW6ybbKjKvrAsOxCAxf0osuETWzVkH89UERyo
         82KpVihW8QcesXzWXxzgwtLW5YRCSMmEOGRVumwA1tAKuqXgdWPUnzZbUYbmOXDNzGVB
         hJ5356mXjje8Q9YCLtVJd2hdRq9gxTSmzQGLo5pnCn/BrAt8HV1aj9cK6phFPad0rIwu
         up8hC/7V3JQCG5Cp8S6uklJAnGWZKT76FNz+WxAuyQKWSDmeicwr9j6MfkA8zpauuKdL
         nwonaoDFMFzRZBfcm2hERA9VmkPpBH53WEDupJKWYIBw3VGzupDzYcY/deQ2b/E29LbO
         DLqA==
X-Gm-Message-State: ACrzQf0nPrMMKZ+pwV8sHESN1dApnQgtyQr1k2wCRs0K7ubBueSSFF1P
        Czuek6HlJLABRSEeMSlyG6QIbI+D7QwQZDOWoD5PIA==
X-Google-Smtp-Source: AMsMyM5ALov/r/ZakJeN3jfFfMSqoBqWZs5d/jt5YzgMsQgWBmWKD2si99B0ol7FjSzPFb1duICNzTgFtYH88EFZiOI=
X-Received: by 2002:a17:903:100c:b0:186:63a1:3b5d with SMTP id
 a12-20020a170903100c00b0018663a13b5dmr61928202plb.148.1667997282600; Wed, 09
 Nov 2022 04:34:42 -0800 (PST)
MIME-Version: 1.0
References: <20221107155516.2535912-1-gsomlo@gmail.com>
In-Reply-To: <20221107155516.2535912-1-gsomlo@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Nov 2022 13:34:05 +0100
Message-ID: <CAPDyKFpBHGzH2iuGJOr29by57azeUv_s1qmfpKdSriw2nDUQcw@mail.gmail.com>
Subject: Re: [PATCH] mmc: litex_mmc: ensure `host->irq == 0` if polling
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, joel@jms.id.au,
        andy.shevchenko@gmail.com, mdudek@internships.antmicro.com,
        paulus@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 7 Nov 2022 at 16:55, Gabriel Somlo <gsomlo@gmail.com> wrote:
>
> Ensure the flag is explicitly set to 0 if we determine that polling is
> needed during driver probe, to cover all possible cases.
>
> Fixes: 92e099104729 ("mmc: Add driver for LiteX's LiteSDCard interface")
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/litex_mmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
> index 6ba0d63b8c07..39c6707fdfdb 100644
> --- a/drivers/mmc/host/litex_mmc.c
> +++ b/drivers/mmc/host/litex_mmc.c
> @@ -502,6 +502,7 @@ static int litex_mmc_irq_init(struct platform_device *pdev,
>
>  use_polling:
>         host->mmc->caps |= MMC_CAP_NEEDS_POLL;
> +       host->irq = 0;
>         return 0;
>  }
>
> --
> 2.37.3
>
