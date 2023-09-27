Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B71AE810CC
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Sep 2023 10:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjI0K4S (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Sep 2023 06:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjI0K4Q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Sep 2023 06:56:16 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6529B139
        for <linux-mmc@vger.kernel.org>; Wed, 27 Sep 2023 03:56:15 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59f82ad1e09so72465337b3.0
        for <linux-mmc@vger.kernel.org>; Wed, 27 Sep 2023 03:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695812174; x=1696416974; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hm8+PdGFfUnYa/mWP3SQPPuVGC2hftcLzjir/H7ACq8=;
        b=D9MF++A5XccW4X368DGkSOLLAMn4NmvcOOwlIRYfzyLJPQpBMoa5Ig6JcI4rJyzGWv
         AyMD2qtffVoIcOFfM+OXjsO/zsybR83Jojd9Rftb+zgS9UFDgffgDnN8X/b/JqUV4X1o
         beFLe3HPW+KlvVYrzJWItoESmG7gmsuNR/HW9UvP1NfKMeTflrEKNLxrq4j2dResaXmr
         NDAervfm4u0sP9QtM8F9xvbR20PbnPQnr3mTpHRtNe2KTB76tsGui9vRayXX9HcLc6PH
         2Xe4Ka12qE2+LpMSs7r0IYkEsceLE3hJGGTHrdfRPZSnmxwhWq+IsmKtvJSODwY3asDr
         6tBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695812174; x=1696416974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hm8+PdGFfUnYa/mWP3SQPPuVGC2hftcLzjir/H7ACq8=;
        b=T5lOh6ITNsTAQ6RXBmnhIYrFy4Bb8ndaX/weycVQQ0L8/51v6nTneV+RrLz3k3ONko
         EyZRaITuJq28yi03G5TXuzAowVSJtjiCr3T2VQPddbmP9dvVhwnpTUfofRi6Mj4dK6+F
         ZjgwrSwzO5YiOMA1e+SYESKM9A2JyK1+JCGj5Aao3iQhrHOJGT+qZmirNLYPzvV+iTiA
         fuAQzMV77RT5URa6rHAy/ya1v9i+k0gMJfUiIHn/se5Ivp6hhj61OuR2rAhw1jpyzbRz
         LhPIUSIPnUsi+qPFZhfJn2/jVovLPZGak7JCzCPsnJY0CKXephpvqW6RwqM+XistMzGR
         6pnw==
X-Gm-Message-State: AOJu0YwBuXs92WwAxTHlFWi1wRGOxjNzu72cakIadS/w4EmTzTPPL6xv
        0jsT1+N01oguz1YFdzod9S5LqN8sa0AXzK/w+uqiOA==
X-Google-Smtp-Source: AGHT+IGNtkP2VBbRq7YDUrEZObXPN//NfYHgzr6kMlXyXWBjyS1Pid6kYauvVXjkRJWVlPPP0wYoIswtfNyq/q3zL5A=
X-Received: by 2002:a25:6b4e:0:b0:d86:a964:a47e with SMTP id
 o14-20020a256b4e000000b00d86a964a47emr1461843ybm.63.1695812174459; Wed, 27
 Sep 2023 03:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230926100006.1789276-1-avri.altman@wdc.com> <20230926100006.1789276-6-avri.altman@wdc.com>
In-Reply-To: <20230926100006.1789276-6-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Sep 2023 12:55:38 +0200
Message-ID: <CAPDyKFoiX0cUTCtE7_A3PGfdsYgCkZcEL7QDgkZNfckcSwW2iw@mail.gmail.com>
Subject: Re: [PATCH 5/5] mmc-utils: lsmmc: Fix emmc capacity calculation
To:     Avri Altman <avri.altman@wdc.com>,
        wanggang26 <wanggang26@xiaomi.com>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 26 Sept 2023 at 12:02, Avri Altman <avri.altman@wdc.com> wrote:
>
> From: wanggang26 <wanggang26@xiaomi.com>
>
> When the device capacity is larger than 2GB, it shouldn't use c_size but
> instead it follows a different calculation using the SEC_COUNT field of
> the ext-csd[215:212] - see eMMC spec JESD84-B51 paragraph 7.3.12.
>
> This bug was already in lsmmc when it got merged into mmc-utils, hence
> the fixes tag.
>
> Fixes: 4af1749d2350 (mmc-utils: Merge the lsmmc tool into mmc-utils)
> Signed-off-by: wanggang26 <wanggang26@xiaomi.com>

I didn't quite see Gang's "Signed-off-by" at the original patch that
was posted (maybe you discussed offlist). Anyway, just to be sure, I
think we need his confirmation that patch is okay, before I can apply
it.

Gang?

Kind regards
Uffe

> ---
>  lsmmc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lsmmc.c b/lsmmc.c
> index ef8fab1..b7d1c58 100644
> --- a/lsmmc.c
> +++ b/lsmmc.c
> @@ -1819,6 +1819,9 @@ static void print_mmc_csd_capacity(unsigned int c_size, unsigned int c_size_mult
>         int block_len = 1 << read_bl_len;
>         unsigned long long memory_capacity;
>
> +       if (c_size == 0xfff)
> +               return;
> +
>         printf("\tC_SIZE: 0x%03x\n", c_size);
>         printf("\tC_SIZE_MULT: 0x%01x\n", c_size_mult);
>
> --
> 2.42.0
>
