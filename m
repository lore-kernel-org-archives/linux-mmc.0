Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C31C77B73
	for <linux-mmc@archiver.kernel.org>; Wed, 24 May 2023 15:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjEXPQY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 May 2023 11:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjEXPQX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 May 2023 11:16:23 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0C010B
        for <linux-mmc@vger.kernel.org>; Wed, 24 May 2023 08:16:22 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-ba8afcc82c0so2117230276.2
        for <linux-mmc@vger.kernel.org>; Wed, 24 May 2023 08:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684941381; x=1687533381;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lQB3QyJ5RSXe5SUSf5FzNaoUeU6QuKFZXnOHLiB7n9k=;
        b=cyeJXrRsJ2NBOu62y2PskyFIayRnrptGf2lw2azjRCc0RGjf4wdGmb6mxPk/mMl03v
         ZHAZXfVug50XLcBHueRfp3FUa8OnDc+7haYE5JvXRGsx4IeBWA/LCxg7Yw6NhFV0z+xd
         LU+bATjUUl0hK+xzPsiP45C1UC5tb6BvfWwyiGCvQ5WFO2x0nx4E4DT/ns/9puBPxGSe
         +WVeW4fZYMOaqf4Xj+qukZPzk9zMkK2stvKePVGlUmIvO6d2rvTLz1pKj92MZm1E5m2j
         g9hUYjS4dQdmn9TGNIGD3083L8jGe+A2ZpxnfSijFLEvf8PB1iJwtnOmziJo4gcMFZaf
         IBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684941381; x=1687533381;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQB3QyJ5RSXe5SUSf5FzNaoUeU6QuKFZXnOHLiB7n9k=;
        b=EB5IqwSHjJB73TfjA974UZQnVmLMKJ3I3owmMRLWUhE/17cOAQ0/lFK73Sz6o3RQF5
         sI9O/1ckaPcyiOppZKOEt6vTS+KFwf9OSoFoF/wxU/Pwe9vVz26UoHWXVJRDdENcxn29
         uR16n0yTWRgzNouuAIFWUejwYC204gGGyYYwn2SyzVw6OKfg2WeBMcNURt0uOp7Hy54b
         QWPsMVU+qo7b+NkM9Pl8VmmznMA+pW6sycNjWwX7wB9DNNuSTEZNW/1hE7nkongSydTT
         ooMeg7JNPe0/adK7nzjMuD+PlhieHL1WcjOBp/Sr6zCCyMl3OWGLCgsnN8ElSZdsYP+i
         CNvw==
X-Gm-Message-State: AC+VfDy2z/8IBBYxx7pTroulIEdkKSNcjJk89i2UwDijDLM5ArUjFRGo
        fTMCLFc+OBudl0JkdK+fZogf9XrN/yVrEBXbmJs42g==
X-Google-Smtp-Source: ACHHUZ7SkFRCIYPv3E2hSGW5BXyQE2VyGzL4PESlgkBrAb67hcllUmjMyhf+92q6h+mujxGi7i3/eS8aWEjx+TSmPI0=
X-Received: by 2002:a25:2445:0:b0:bab:af52:7482 with SMTP id
 k66-20020a252445000000b00babaf527482mr108339ybk.34.1684941381657; Wed, 24 May
 2023 08:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230522214818.2038252-1-ejo@pengutronix.de> <20230522214818.2038252-2-ejo@pengutronix.de>
In-Reply-To: <20230522214818.2038252-2-ejo@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 May 2023 17:15:45 +0200
Message-ID: <CAPDyKFpa+8ShufeZaKYgLDqr2jtGOUvbN0moa5X=a++2nvpoKg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc-utils: fix printing OID for mmc in non-verbose mode
To:     Enrico Jorns <ejo@pengutronix.de>
Cc:     linux-mmc@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 22 May 2023 at 23:49, Enrico Jorns <ejo@pengutronix.de> wrote:
>
> It is parsed as an integer and printed as a char which does not really
> make sense.
> E.g. if OID is '0' (which does not seem to be uncommon), then this
> prints a '\0' character and makes output nearly unreadable/unparsable.
>
> Also, do not print it like it would be a string, instead use 0x<digit>
> format.
>
> Signed-off-by: Enrico Jorns <ejo@pengutronix.de>

Applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe


> ---
>  lsmmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lsmmc.c b/lsmmc.c
> index da9d69e..cea43af 100644
> --- a/lsmmc.c
> +++ b/lsmmc.c
> @@ -636,10 +636,10 @@ void print_mmc_cid(struct config *config, char *cid)
>                 printf("\tCRC: 0x%02x\n", crc);
>         } else {
>                 if (config->mmc_ids[mid])
> -                       printf("manufacturer: '%s' '%c'\n",
> +                       printf("manufacturer: '%s' 0x%01x\n",
>                                config->mmc_ids[mid], oid);
>                 else
> -                       printf("manufacturer: 'Unlisted' '%c'\n", oid);
> +                       printf("manufacturer: 'Unlisted' 0x%01x\n", oid);
>
>                 printf("product: '%s' %u.%u\n", pnm, prv_major, prv_minor);
>                 printf("serial: 0x%08x\n", psn);
> --
> 2.39.2
>
