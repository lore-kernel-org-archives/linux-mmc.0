Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F86C07E96
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Jul 2021 12:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4792B61430
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Jul 2021 12:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhGHMpc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Jul 2021 08:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhGHMpc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jul 2021 08:45:32 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F03C061574
        for <linux-mmc@vger.kernel.org>; Thu,  8 Jul 2021 05:42:49 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id s13so2155732uao.1
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jul 2021 05:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w1gip1Uk8MQUVgAPkI0MwrFlp5H8jfx4T6GteoEJTIA=;
        b=qH/VnH0xBTjPFk8PQnW+sDSzsqwos+OYGsAMVpqeKDShAlh+QAToHVUUWGz1Kzdoux
         wbjp6HmZI1GYNDWGZfBxZy89G9hbB1k/qUyNLP5JjAHc/CiXo1ytXJ6qXz6icol4PFgM
         e4Amu6xGvNDEYVIKgst+F0xhMKzN7iQJP6wwdTO1F8eXMmXS904ztprkjdfkkL1/TKMu
         FPK6hiWhtNHSk4RLW0p69RrlT9rqza0UFkFd6Wp83hKLWcMbhYrc3w6tyM795t0Fu5Rb
         8nV1OpcWfx+9xuNo4gLXqGDP1UsabFOZ1p0pCgmuMktJEw77NnzrydbtdzdFKOglri9O
         TVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w1gip1Uk8MQUVgAPkI0MwrFlp5H8jfx4T6GteoEJTIA=;
        b=oYpYOWkxC1UyVfQwLiFsSS2SrPSis7ciF29yefUIH8Utqhe+/SE2BkhcVK4y4i4FSa
         X/puYFG5Ay0L6IQY0YNJlyjvRQ6Q1IW/Zz3rIsNVKiiFe7G1wRefuIroB8mhOsnIAIEp
         oU/xTGI4Rxi8vK+zhT0v+cRVSyrEgYipsiqdHCxBUVtGEWjsXMcdIRszxhZIIzg9MKkE
         /GFwcknYku7a93S7m556Z6/7YHkiE7ssY90Lglzwlorg1+ZzPU6d4is5bpTxJa1z8KoR
         z9R2FnbKALZxpOxyrTlorNLHL0L2lTkbISCeYrPB6O9X0rElLWdFWXo+WSozibH0CDz9
         pDEA==
X-Gm-Message-State: AOAM533AZSn3sgHH0Pk615k/GPYQfucMUwQlty3bjVodqStNL1HyR4FW
        482QayNVnyBZXhdlPWPmoFAhswtPQKzmREWI3aP+Lg==
X-Google-Smtp-Source: ABdhPJx8t84YJgzE+nVy5Qz7a41B0D30tlomNTg8eVzqqkEMEENnhVNMzyKmEeYu+kJIEUMMfaZu96BQU0y7jus2oYA=
X-Received: by 2002:ab0:12a:: with SMTP id 39mr29193957uak.19.1625748168546;
 Thu, 08 Jul 2021 05:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210630102408.3543024-1-linus.walleij@linaro.org>
In-Reply-To: <20210630102408.3543024-1-linus.walleij@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Jul 2021 14:42:12 +0200
Message-ID: <CAPDyKFr1225F+yq7OS5pDn0LZS0pcpVveuhko9amQcykYt_1hg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmci: De-assert reset on probe
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Yann Gautier <yann.gautier@foss.st.com>,
        Ludovic Barre <ludovic.barre@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 30 Jun 2021 at 12:26, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> If we find a reset handle when probing the MMCI block,
> make sure the reset is de-asserted. It could happen that
> a hardware has reset asserted at boot.
>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Yann Gautier <yann.gautier@foss.st.com>
> Cc: Ludovic Barre <ludovic.barre@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Queued for v5.15 on my devel branch, thanks!

Kind regards
Uffe


> ---
> ChangeLog v1->v2:
> - Drop the else {} clause: reset_control_deassert() handles
>   NULL just fine.
> ---
>  drivers/mmc/host/mmci.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 984d35055156..3765e2f4ad98 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -2126,6 +2126,9 @@ static int mmci_probe(struct amba_device *dev,
>                 ret = PTR_ERR(host->rst);
>                 goto clk_disable;
>         }
> +       ret = reset_control_deassert(host->rst);
> +       if (ret)
> +               dev_err(mmc_dev(mmc), "failed to de-assert reset\n");
>
>         /* Get regulators and the supported OCR mask */
>         ret = mmc_regulator_get_supply(mmc);
> --
> 2.31.1
>
