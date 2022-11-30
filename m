Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0719FC433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Nov 2022 14:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiK3Ooh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Nov 2022 09:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiK3Oog (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2022 09:44:36 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD5E183BD
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 06:44:35 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so2344274pjb.0
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 06:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYuSJquVwIjmwCCxFA89hvpczZS6iAqYsFgIeQbQyk4=;
        b=P6upJZHw3kEQqixVBF1l9xDXgWhHnFvJpaIkF91K7oFHU3IHlsrI87+u0LNjxkVsPD
         lt8jjxM8uscBVyemK5Pp5TDhtcX2z3kVNe3CxuynX+0DzHSYdqsWjWvXakgGcvQJPgdS
         hW5xC3C1C+wXWnVTWpfaynTevi5nLzjQOvD8kt0UIxki0elwTYOA1wL1XT1bM6RKZr0L
         tl0fP1lje1l2Htl/DjdqBpX79JiLdJqro7onW3CHpR0rSrSbXPzPyRNrGl4HxJQoZszJ
         wMnrdffqzR7yMeUGxyyrbZARMamR1qWAEeTPOl+aC2qiK+HT+86KWviq4tLncED6X/uq
         Si5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZYuSJquVwIjmwCCxFA89hvpczZS6iAqYsFgIeQbQyk4=;
        b=V+0kf2egZanCfIIJzpb5ADHQxM/Shfx1e7qJbxfCe1qh9BbXofc/iSTksGiQ+N/eZ2
         9/qJMnHQyZWpow5w7Ka84CdcrE/AT/GUYufB3HS41VWBqJCaNNVenT146jB94LuwazIv
         9h+jr2qbQoHn4YWR3kQZ8ZYkzJF3Hr/7H9f2CtH2CfvIKz6425BOZbfna8H/0/GvLzNP
         ax9xUbdQDFcPj52jfj67m3q8XAdLZdXNNOkWzEtc6j7xGgIMSQlzb+NSPDpqLaHo84io
         /bzAuuaOF0fY3WsDQSA/kLmqWRiFzFHYE3JwrbmRakJpxFwgyvNNrV1OGG7JGuLnA+Dr
         Ca6g==
X-Gm-Message-State: ANoB5plFg2ZFqaCyyeArE74n3akItDXHrX4liJn+vz97XPhJti2440Ac
        yk0Vg6dJ+6u+ne6RXDxC9v18zGfy4yXRdFwB2XnElw==
X-Google-Smtp-Source: AA0mqf4Fjnax4NQ1M1G8Yb/5mHMz2XBgnPQYbujS17h4jc8RF/kNSGd8x2Ve0ssQGzTrweZfOPpQBV5va67gO3iTNM4=
X-Received: by 2002:a17:902:d68b:b0:188:cca8:df29 with SMTP id
 v11-20020a170902d68b00b00188cca8df29mr49431583ply.148.1669819475327; Wed, 30
 Nov 2022 06:44:35 -0800 (PST)
MIME-Version: 1.0
References: <20221130134920.2109-1-thunder.leizhen@huawei.com>
In-Reply-To: <20221130134920.2109-1-thunder.leizhen@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Nov 2022 15:43:59 +0100
Message-ID: <CAPDyKFq+poiVobaaCAYx_AD9Z6M_+r89AE6pViPFZMzVSZc92A@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: Normalize the error handling branch in sd_read_ext_regs()
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 30 Nov 2022 at 14:49, Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> 1. Use pr_err() to output the error message.
> 2. Add the description of why success 0 is returned in case
>    "non-supported SD ext reg layout".
>
> Fixes: c784f92769ae ("mmc: core: Read the SD function extension registers for power management")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/sd.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 3662bf5320ce56d..93ee53f74427c38 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1259,7 +1259,7 @@ static int sd_read_ext_regs(struct mmc_card *card)
>          */
>         err = sd_read_ext_reg(card, 0, 0, 0, 512, gen_info_buf);
>         if (err) {
> -               pr_warn("%s: error %d reading general info of SD ext reg\n",
> +               pr_err("%s: error %d reading general info of SD ext reg\n",
>                         mmc_hostname(card->host), err);
>                 goto out;
>         }
> @@ -1273,7 +1273,12 @@ static int sd_read_ext_regs(struct mmc_card *card)
>         /* Number of extensions to be find. */
>         num_ext = gen_info_buf[4];
>
> -       /* We support revision 0, but limit it to 512 bytes for simplicity. */
> +       /*
> +        * We only support revision 0, and limit it to 512 bytes for simplicity.
> +        * In other cases, success 0 is returned, because the card remains
> +        * functional and all but the new features from the SD function
> +        * extensions registers can still be used.
> +        */
>         if (rev != 0 || len > 512) {
>                 pr_warn("%s: non-supported SD ext reg layout\n",
>                         mmc_hostname(card->host));
> @@ -1288,7 +1293,7 @@ static int sd_read_ext_regs(struct mmc_card *card)
>         for (i = 0; i < num_ext; i++) {
>                 err = sd_parse_ext_reg(card, gen_info_buf, &next_ext_addr);
>                 if (err) {
> -                       pr_warn("%s: error %d parsing SD ext reg\n",
> +                       pr_err("%s: error %d parsing SD ext reg\n",
>                                 mmc_hostname(card->host), err);
>                         goto out;
>                 }
> --
> 2.25.1
>
