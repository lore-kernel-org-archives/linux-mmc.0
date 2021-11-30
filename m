Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEEDC433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Nov 2021 15:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbhK3Ppp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 30 Nov 2021 10:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241817AbhK3Ppn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Nov 2021 10:45:43 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45A1C061748
        for <linux-mmc@vger.kernel.org>; Tue, 30 Nov 2021 07:42:23 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id z8so41940357ljz.9
        for <linux-mmc@vger.kernel.org>; Tue, 30 Nov 2021 07:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VLnNhnEYNV8q9lKuRUq33ECpv8wxGYpMJDT++q2LbNg=;
        b=GUCw8SAvbdrpTPp3CmZJCCecx5b5Mz7v0kScyycARv/UwEAWNyPJSod20Otjms26ks
         N1CHkqEiNRAAaWfJAAA3PFTYqZT47cH6vFKbYXnuvUz9yNIvq3MyTcKIGGId0vnkh/3T
         UO/RV4HfhG3CRkQ56NEaRsm+3xNWmK8pLuDVnIQZabC+4yAYBPBaqqIgfNG3SaofLRYM
         nmJQZaFQPTpPCnsbN1MTu6f2gdzOmEZb5rAv2DtsI4FCmCfVb2yxFxsZLtw6oh6fCmAm
         3TmSvfqCzgv/5zDjpLwv/JfiVy42IU45MxUBglEptCjr26LR4rO94Rnk+NFamX0C6Gsx
         dwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VLnNhnEYNV8q9lKuRUq33ECpv8wxGYpMJDT++q2LbNg=;
        b=25lNtYkGncZasDXH/q0fFpaOtFjflQzxUI05zRyl5V1R6PilWXuWSMjwPkoVTV0nAh
         tYeXu0REmUpWyDCQlJSIWWORXOLagk5AcDDDj2AmeAwR9oj/0MG+LrqowhR5+9AHlpLe
         dMeaRUR3Sp0CJUJMMknnRqZU7p0TR4Hb88s97xdpc5qbMQ1tnH52xzfZZTqosxcINNm2
         xd8qejjKANqfpI8omn8maJyI53R+Ql1Pg/NQBEAO7i6qfGSIeygJ1a5evtlOEsXRhcjl
         +uji74+A9rZxVtycpjNFs1k3IIzQJNaP+9WmyPLhorn/X5HF6fM5wO9Mtkm76BGRHMKc
         7h+g==
X-Gm-Message-State: AOAM533BxHPyT2rR84AM8K5z9PFezw0AOfZF/6HOkCASa6caoIimUqDy
        o30RAM4iLOwwOTuiMuVKxo451Ho+lyDFFax5HdFggwhknng=
X-Google-Smtp-Source: ABdhPJzZ1pUCvQmKX4wa5/rUgkVndDTXO7AiAxnLty7lZELaRPzfbzDL6/DpdoE6FBRmjHqqQydcTYKSt4yK5jW1ToE=
X-Received: by 2002:a2e:a22a:: with SMTP id i10mr56747034ljm.16.1638286941938;
 Tue, 30 Nov 2021 07:42:21 -0800 (PST)
MIME-Version: 1.0
References: <20211130132309.18246-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20211130132309.18246-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 30 Nov 2021 16:41:45 +0100
Message-ID: <CAPDyKFrW51fsQ_3bULiSqnJdnok37xcYkvWsxKLm0=vXdCG-8A@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: initialize variable properly when tuning
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 30 Nov 2021 at 14:23, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> 'cmd_error' is not necessarily initialized on some error paths in
> mmc_send_tuning(). Initialize it.
>
> Fixes: 2c9017d0b5d3 ("mmc: renesas_sdhi: abort tuning when timeout detected")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>
> Tested on a Salvator-XS (R-Car M3N), tuning still works.
>
> Ulf, this is a bugfix, can you take it via your tree for this cycle
> please?
>
>  drivers/mmc/host/renesas_sdhi_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index a4407f391f66..f5b2684ad805 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -673,7 +673,7 @@ static int renesas_sdhi_execute_tuning(struct mmc_host *mmc, u32 opcode)
>
>         /* Issue CMD19 twice for each tap */
>         for (i = 0; i < 2 * priv->tap_num; i++) {
> -               int cmd_error;
> +               int cmd_error = 0;
>
>                 /* Set sampling clock position */
>                 sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TAPSET, i % priv->tap_num);
> --
> 2.30.2
>
