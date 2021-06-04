Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C746C07E94
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Jun 2021 16:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CBA46140B
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Jun 2021 16:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhFDQQ5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Jun 2021 12:16:57 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:46977 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhFDQQ4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Jun 2021 12:16:56 -0400
Received: by mail-lf1-f48.google.com with SMTP id i9so14836898lfe.13
        for <linux-mmc@vger.kernel.org>; Fri, 04 Jun 2021 09:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LvA0Er8AskDavuezV8RiKUwzdr6yicLLRj9IkJ+LjuY=;
        b=t09snEHxZfS0dvM4kwlDaIMrXgVcoYhGT6KvyuPjHpYlwB4OzhqbQOwOdsNVtz1IbB
         468+uOAoZZqCg3QOBf2krkDM+09v5DFNx9jc9m7c5cTBkvdQ1y8Ww51wC75jyhQMbNjy
         eLSbpREsKT4UhVnDbZkItDZNZObwFsPE/ec4LAMt9ivkV+odqMoLn18Y8P1FxYzQK5m+
         U1Nfag5qLBYVmMQhPWfKGCgsUrWtN8dUf1AZqzKMftTOVWse0nh9bIxvNEFOkOUjFOBq
         7M3npJumkxNrHQDrwu3wD00MofxHFOULsiy5dcitYonncL5wW6Qgejly5BoxOQDDSxsv
         muiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LvA0Er8AskDavuezV8RiKUwzdr6yicLLRj9IkJ+LjuY=;
        b=m6VjAJEDW1k7V2rpkNsWcp3caaLlMVapdkkRRdfW06L0gT+vniORPJ1b5kaDKozvvl
         MaF1rJyRkTkx8qVXwRJLVufbiKAde+I+Uv89raI6xorD2dNMX3nfVd+HvY9dnAOPGyLM
         0YPE2wGVB4YT7ZISrrVBXiLLlhHk5uqyFBw0JSN8knlZIGW52MaCweFQnxQvG8vKkIxH
         irpGYC2M5Om9kqaUQwsnCDcbhAhppfsSlvvIgcHvsSLIjQP3Q5zXiTJ/AAuinha4GwdY
         JQz16/ek7RKWf+e6uO7DUjANBQ6TT4/8Er+Hc7uh6zZtwx06VLPeb4ixfzPQW52ywhMD
         qWTg==
X-Gm-Message-State: AOAM532p+i7UZ4DYpEBKKSMwKL8QG44CUyUWi1sp83MoMDLQdqQGbIPg
        sXp91vGQwM0AI386NAAGhewD/w==
X-Google-Smtp-Source: ABdhPJwylHQ8+iVbW/SeT4vHq++HTlmIOEXyZLUdhZb+SKK07ZvBq9l9qfeVUU2bkJ8LNmhOI91HEQ==
X-Received: by 2002:ac2:515d:: with SMTP id q29mr3338076lfd.535.1622823241964;
        Fri, 04 Jun 2021 09:14:01 -0700 (PDT)
Received: from localhost (h-62-63-236-217.A463.priv.bahnhof.se. [62.63.236.217])
        by smtp.gmail.com with ESMTPSA id l22sm519659ljh.64.2021.06.04.09.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 09:14:00 -0700 (PDT)
Date:   Fri, 4 Jun 2021 18:13:59 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Takeshi Saito <takeshi.saito.xv@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: renesas_sdhi: Fix HS400 on R-Car M3-W+
Message-ID: <YLpRR7f/T88G8VRv@oden.dyn.berto.se>
References: <ee8af5d631f5331139ffea714539030d97352e93.1622811525.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee8af5d631f5331139ffea714539030d97352e93.1622811525.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Geert,

Thanks for your work.

On 2021-06-04 14:59:43 +0200, Geert Uytterhoeven wrote:
> R-Car M3-W ES3.0 is marketed as R-Car M3-W+ (R8A77961), and has its own
> compatible value "renesas,r8a77961".
> 
> Hence using soc_device_match() with soc_id = "r8a7796" and revision =
> "ES3.*" does not actually match running on an R-Car M3-W+ SoC.
> 
> Fix this by matching with soc_id = "r8a77961" instead.
> 
> Fixes: a38c078fea0b1393 ("mmc: renesas_sdhi: Avoid bad TAP in HS400")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> Boot-tested on Salvator-XS with R-Car M3-W+ ES3.0.
> No difference seen in eMMC/SHHC detection:
> 
>     mmc0: new HS400 MMC card at address 0001
>     mmcblk0: mmc0:0001 BGSD4R 29.1 GiB
>     mmcblk0boot0: mmc0:0001 BGSD4R 31.9 MiB
>     mmcblk0boot1: mmc0:0001 BGSD4R 31.9 MiB
>     mmcblk0rpmb: mmc0:0001 BGSD4R 4.00 MiB, chardev (247:0)
>      mmcblk0: p1
>     mmc1: new ultra high speed SDR104 SDHC card at address aaaa
>     mmcblk1: mmc1:aaaa SL16G 14.8 GiB
>      mmcblk1: p1
>     mmc2: new ultra high speed SDR104 SDHC card at address aaaa
>     mmcblk2: mmc2:aaaa SL32G 29.7 GiB
>      mmcblk2: p1
> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 635bf31a67359f10..b719eda6b8619453 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -939,7 +939,7 @@ static const struct soc_device_attribute sdhi_quirks_match[]  = {
>  	{ .soc_id = "r8a7795", .revision = "ES3.*", .data = &sdhi_quirks_bad_taps2367 },
>  	{ .soc_id = "r8a7796", .revision = "ES1.[012]", .data = &sdhi_quirks_4tap_nohs400 },
>  	{ .soc_id = "r8a7796", .revision = "ES1.*", .data = &sdhi_quirks_r8a7796_es13 },
> -	{ .soc_id = "r8a7796", .revision = "ES3.*", .data = &sdhi_quirks_bad_taps1357 },
> +	{ .soc_id = "r8a77961", .data = &sdhi_quirks_bad_taps1357 },
>  	{ .soc_id = "r8a77965", .data = &sdhi_quirks_r8a77965 },
>  	{ .soc_id = "r8a77980", .data = &sdhi_quirks_nohs400 },
>  	{ .soc_id = "r8a77990", .data = &sdhi_quirks_r8a77990 },
> -- 
> 2.25.1
> 

-- 
Regards,
Niklas Söderlund
