Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41052C77B73
	for <linux-mmc@archiver.kernel.org>; Wed, 24 May 2023 15:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjEXPQ3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 May 2023 11:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjEXPQ2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 May 2023 11:16:28 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9249C123
        for <linux-mmc@vger.kernel.org>; Wed, 24 May 2023 08:16:27 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-ba8151a744fso1567869276.2
        for <linux-mmc@vger.kernel.org>; Wed, 24 May 2023 08:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684941387; x=1687533387;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7h+Ll+LPkmGPw5vwhzF/24POwXmi/564eOEcPaAnuow=;
        b=hRfptld6IybLYaxv479gsf1MEnubjhJt46UXrWAOzm14mnfk0yaKt1Kan+VzAFtb3k
         Hpi7MB6jLSaEZksiBhk5cYg3YWNiG+7jz0GkSbCMuYTeSSJen7vpRkCwjseevqbvJnKA
         T6dAKRyX9Gy3SM2t98tmPUXRKq3poyJI/SHt/u/oHtsJR1h3bPJzTqz6VqH2qLPzEr9l
         E6+BPIBsCz4u1ZICqdxxGil8bibIzcCkn8u3/qI5OG5RyhdVVJpmjFN8tpuiVq9vbnJr
         jtJSvS9wqcnMkFYjsQROWQgQ9xVcJ42pat2eUgRby9YMPkqYbqn317/7gOGTaNCdsA0+
         QruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684941387; x=1687533387;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7h+Ll+LPkmGPw5vwhzF/24POwXmi/564eOEcPaAnuow=;
        b=DwNTVFUh8mZcMKeuHPXutR49JolhUZfxgy8ymLYXbcI/GRs3FVhQwc4btIa1qcpaEr
         WLXVKaR50FxGgkess3MQjk+HmwRIGM7b8MTwtoM6xIKmDYJa5nYhhZhMr72doLVnBm5d
         yIp6ILXIg/9BPINYGnBCGHzGS2a5UCxbEZ5LsNVYZGZHcIr+fPzVUZ6MGxHscC+buYdE
         rUtMdkBg3/jdh2AYDzBnIaSKCrapr4/ZnB5zV/4tY7czlS/ysJekmCoQ4fSfOvmB0/OH
         xzPS7IKDa3DA7k/2ZYJRfn8qgrCtaJnWxjzSp996Z0jAQFatWgDTIbCyXN6pIROM5nVE
         CxvA==
X-Gm-Message-State: AC+VfDxE7/0ejb0QXYZCjO0TekrHoTmZSRymK7NiiUGI0+cPptfU01FM
        41kL+RlUGw/7Yoo8jtg0q6klF3TWiJUwyx4/Nk2ipA==
X-Google-Smtp-Source: ACHHUZ6chY/MRv9Kls5bnU5WCxXpU+BOYJMFfWlnQiTt3JiiSuWa/bkAfHzlW3c5BHgMmfW7eqUl/HKCPWnztNkwoZo=
X-Received: by 2002:a25:f625:0:b0:b9d:e253:d25 with SMTP id
 t37-20020a25f625000000b00b9de2530d25mr198528ybd.11.1684941386850; Wed, 24 May
 2023 08:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230522214818.2038252-1-ejo@pengutronix.de> <20230522214818.2038252-3-ejo@pengutronix.de>
In-Reply-To: <20230522214818.2038252-3-ejo@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 May 2023 17:15:51 +0200
Message-ID: <CAPDyKFoKYO867PDW+DmFaZZs2ecdx4zYJXa_CGvoRKWvcsMsew@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc-utils: do not hide CID manufacturer information
To:     Enrico Jorns <ejo@pengutronix.de>
Cc:     linux-mmc@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 22 May 2023 at 23:49, Enrico Jorns <ejo@pengutronix.de> wrote:
>
> Reading the MID just to convert it to 'Unlisted' is quite unhelpful for
> an info command.
> Due to the (constantly increasing) amount of valid MIDs it is quite
> unlikely to we have it in the database already anyway.
>
> Thus simply always print the manufacturer ID as 0xNN and understand the
> manufacturer name as an additional information held in parenthesis.
>
> Signed-off-by: Enrico Jorns <ejo@pengutronix.de>

Applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe


> ---
>  lsmmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lsmmc.c b/lsmmc.c
> index cea43af..54c3167 100644
> --- a/lsmmc.c
> +++ b/lsmmc.c
> @@ -636,10 +636,10 @@ void print_mmc_cid(struct config *config, char *cid)
>                 printf("\tCRC: 0x%02x\n", crc);
>         } else {
>                 if (config->mmc_ids[mid])
> -                       printf("manufacturer: '%s' 0x%01x\n",
> -                              config->mmc_ids[mid], oid);
> +                       printf("manufacturer: 0x%02x (%s) oid: 0x%01x\n",
> +                              mid, config->mmc_ids[mid], oid);
>                 else
> -                       printf("manufacturer: 'Unlisted' 0x%01x\n", oid);
> +                       printf("manufacturer: 0x%02x (Unlisted) oid: 0x%01x\n", mid, oid);
>
>                 printf("product: '%s' %u.%u\n", pnm, prv_major, prv_minor);
>                 printf("serial: 0x%08x\n", psn);
> --
> 2.39.2
>
