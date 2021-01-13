Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FD7C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E764C2333F
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbhAMLPu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 06:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbhAMLPt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 06:15:49 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470EFC061794
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:15:09 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id x26so906441vsq.1
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5F3Y1+dvzqZPxeJEhWq1oJzPV10LGp3WuH2PQnvIrno=;
        b=Bs01E+yS0to9O9W6rRtGlBZGNxNfce2hx/qfzQjInfwMBqnjKV7ikGKq2HirAXZm3o
         kuorTChMOhCfYcF8vb/UhcdtDNbF8bx9FEutmtT8sdqjr97uwj7bJ8f7oKb8rNoFUhtC
         A+nujCQ/rC7JenrVVGj6YTEpgADCf1ouOHlcbdOw729VwFEjNSja5b0wVCLb1zQQnIWH
         +CpwzE7WRWgnKoLo2hBbQq94rxnrUkmpxj7G6aED/rxX55/aZ/9brjm0W2lMDuEXlOfV
         q2g6o5lmjgcdImsSUx4FBC36NSvsBYAmygP54VAAarv4teMw+mOpyRVKvc/kwxpLFm6D
         OQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5F3Y1+dvzqZPxeJEhWq1oJzPV10LGp3WuH2PQnvIrno=;
        b=kbLhR1H04eD6HiBQYthzTifzeK7OMco84TNdMwMfd1zT7AwUzGLSl8oG/a/JdIix8y
         rJLrvr2HXZmF7PZpRcwr4efov7HQm+6rIurlZBrfXFJuxbKZQw5/yzwh9ByP8kxLwiwY
         MhagD5iiBfNfjd3ttS5NQ5aI72g7nauPxc59hwfvgQAlGhMjDvk+KSZnqwhdfUTcnDmY
         9KQ2e2herxxp7gzHKNmLmeBbz0zZlTtnN8C7SJm2PRecU2kd7E1PILGOl+imX7XZYRix
         YltFG9j7rnEVPR7RRP63sM7Gdqx4MCzTRW12uMo/zAyJ/IGRf/azYqycevwXzw6MPW5u
         Wn2Q==
X-Gm-Message-State: AOAM531OLWpDa0heJ2xca1+E37msyuj6CUvsjAwIk8k056dIt9/484k/
        FUl7+oeNyR1gyvsHzzUwuCLJlLgZLPCKPUz/4EfMPg==
X-Google-Smtp-Source: ABdhPJymuNBcf7MceK1EWHcETSqNc+BDRBBcDPE8Si1HQfHJU2a2qnvqWQqXTbUq8gjU0N3YVjt0paoikQI9Ehnk13A=
X-Received: by 2002:a67:fe85:: with SMTP id b5mr1167502vsr.19.1610536508532;
 Wed, 13 Jan 2021 03:15:08 -0800 (PST)
MIME-Version: 1.0
References: <1610358374-81002-1-git-send-email-abaci-bugfix@linux.alibaba.com>
In-Reply-To: <1610358374-81002-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 12:14:32 +0100
Message-ID: <CAPDyKFpV55EErFRXQO=W=yvu-W7R1Q3GAouCYZAr=-59kuouzg@mail.gmail.com>
Subject: Re: [PATCH] host: omap_hsmmc: style: Simplify bool comparison
To:     YANG LI <abaci-bugfix@linux.alibaba.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 11 Jan 2021 at 10:46, YANG LI <abaci-bugfix@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warning:
> ./drivers/mmc/host/omap_hsmmc.c:297:6-25: WARNING: Comparison of 0/1 to
> bool variable

If you really want this change, I prefer if you can clean up all use
of "pbias_enabled" - and at the same time, do the same clean up for
"vqmmc_enabled".

Kind regards
Uffe

>
> Signed-off-by: YANG LI <abaci-bugfix@linux.alibaba.com>
> Reported-by: Abaci Robot<abaci@linux.alibaba.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index aa9cc49..91a0760 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -294,7 +294,7 @@ static int omap_hsmmc_set_pbias(struct omap_hsmmc_host *host, bool power_on)
>                         host->pbias_enabled = 1;
>                 }
>         } else {
> -               if (host->pbias_enabled == 1) {
> +               if (host->pbias_enabled) {
>                         ret = regulator_disable(host->pbias);
>                         if (ret) {
>                                 dev_err(host->dev, "pbias reg disable fail\n");
> --
> 1.8.3.1
>
