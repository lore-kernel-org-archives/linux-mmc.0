Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA411C433FE
	for <linux-mmc@archiver.kernel.org>; Fri, 14 Oct 2022 14:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiJNOIW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 14 Oct 2022 10:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiJNOIM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Oct 2022 10:08:12 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA56189C18
        for <linux-mmc@vger.kernel.org>; Fri, 14 Oct 2022 07:08:07 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id p3-20020a17090a284300b0020a85fa3ffcso8029446pjf.2
        for <linux-mmc@vger.kernel.org>; Fri, 14 Oct 2022 07:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3R5dZLIo4FZkTYpLjxbbNDjYi6YbMj7MKY/V8/eX5Pc=;
        b=NGaWWewgPhLVumxT7+imkHQ1InfD7YmrIgHGQQHYZWx1cYcTiiHbRxVMeTO72p6ZcP
         KKYos0MEVpao57aY4Nw5FSh3aNbEMgEevHPsoa0+V+JYeqJDCAIUQbKVLKefeahdpfGX
         qvpYj9ynfczsC23c5utXVJJzvRjhyPfSyh1XZO1vN0weS4Wo0unRsirIaK1FnOIBqwny
         QNl/jWx1SpnQfn0yj/ndZzgiTIFezB5Psw2zr1h/Oo8ty/phx9ixF4BRuAeVS9F6ifso
         USANTEq30z48XLsr7dh4Bugjz6hOYMapWsqU/tUhdI7CZwLAt6HyYKcauS2t0O3tusf0
         YXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3R5dZLIo4FZkTYpLjxbbNDjYi6YbMj7MKY/V8/eX5Pc=;
        b=a6qXbUle3LrKJ0sA0PDW4XUBfIHWWR7DJSLEh6lT7z/tSfn/5Um5oYnLtwo4CYcGKs
         SSiRXvOxqEdDQv9HCRw0M+VCEYoQX8+SsdBkQhMm5tJ5jg23HPcjAVAfTHhKjQvveKa6
         /oP3EphYk1S++26dUHOS23bRya8oC4A+LemxnzPF5U6YDLnzDtlevcZWGQRchPYOdSmx
         WcVSbchJqyQQkUNKSPagWIW6+g3LVmAwXAzikjeI+WFso4ta4foWD8p7bHaltW6QDNXi
         CX2qWl2XznmYv8hTv+Nmu3DQVDb1RYelreyuA1OdpYFedFxfku1bc1OXmX9uNpfKB6sp
         P7jQ==
X-Gm-Message-State: ACrzQf25ldW6yuAhF0/CeRGwvZ48Wj15zBapgmOEOMSwaXQVstT97pqt
        xJzHHgZ4eIncodGex2o/joapVFuA6IofSxGempWLLQ==
X-Google-Smtp-Source: AMsMyM44/hdR/I8oru0k3pWfv4CbyDISykFuqObi2fS9Dsp6LPDkmBLNviItjwbMeOP+zDxkuH+WWz2Pul5jcOIK5cM=
X-Received: by 2002:a17:902:d714:b0:17f:5813:1df4 with SMTP id
 w20-20020a170902d71400b0017f58131df4mr5506815ply.148.1665756486078; Fri, 14
 Oct 2022 07:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221014034951.2300386-1-ouyangweizhao@zeku.com>
In-Reply-To: <20221014034951.2300386-1-ouyangweizhao@zeku.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 14 Oct 2022 16:07:28 +0200
Message-ID: <CAPDyKFrpCGzOcRpHANt4cjJuELn2EVStQM15a2=ofYus=Jn_oA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdio: fix kernel panic when remove non-standard
 SDIO card
To:     Weizhao Ouyang <ouyangweizhao@zeku.com>
Cc:     Weizhao Ouyang <o451686892@gmail.com>,
        Matthew Ma <mahongwei@zeku.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        John Wang <wangdayu@zeku.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Grazvydas Ignotas <notasas@gmail.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 14 Oct 2022 at 05:50, Weizhao Ouyang <ouyangweizhao@zeku.com> wrote:
>
> From: Weizhao Ouyang <o451686892@gmail.com>
>
> From: Matthew Ma <mahongwei@zeku.com>
>
> SDIO tuple is only allocated for standard SDIO card, especially it
> causes memory corruption issues when the non-standard SDIO card has
> removed since the card device's reference counter does not increase for
> it at sdio_init_func(), but all SDIO card device reference counter has
> decreased at sdio_release_func().
>
> Fixes: 6f51be3d37df ("sdio: allow non-standard SDIO cards")
> Signed-off-by: Matthew Ma <mahongwei@zeku.com>
> Reviewed-by: Weizhao Ouyang <ouyangweizhao@zeku.com>
> Reviewed-by: John Wang <wangdayu@zeku.com>

If I understand correctly, Matthew Ma <mahongwei@zeku.com> should be
the author of the patch?

Assuming I am correct, I have amended the patch and changed that,
please tell me if I should change that.

So, I applied this for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
> -- update Fixes tag
>
>  drivers/mmc/core/sdio_bus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index c6268c38c69e..babf21a0adeb 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -291,7 +291,8 @@ static void sdio_release_func(struct device *dev)
>  {
>         struct sdio_func *func = dev_to_sdio_func(dev);
>
> -       sdio_free_func_cis(func);
> +       if (!(func->card->quirks & MMC_QUIRK_NONSTD_SDIO))
> +               sdio_free_func_cis(func);
>
>         kfree(func->info);
>         kfree(func->tmpbuf);
> --
> 2.25.1
>
