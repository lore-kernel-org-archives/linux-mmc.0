Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AA6C41535
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Nov 2023 11:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346858AbjKCLRT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Nov 2023 07:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346671AbjKCLRP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Nov 2023 07:17:15 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8C4D68
        for <linux-mmc@vger.kernel.org>; Fri,  3 Nov 2023 04:17:01 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a81ab75f21so23327127b3.2
        for <linux-mmc@vger.kernel.org>; Fri, 03 Nov 2023 04:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699010220; x=1699615020; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oWqvGHOpDjXeJF4gaG5FvSChunLowe+31JAI0Z5rk34=;
        b=aTAeo++ufcpuOK6ygynGRX8GpEjrCX4iIsxGeSzbXaI/UKqI822QKIIZ7KYNfbZL6W
         q7ZuC/BGDP7M7RxUi84roEW10U/GV3F1+ITWIErXRQD7d0j86xRq3eztwsU6C+B3NVki
         SUgg4HVAQX2aBtJmbJosEktwRXGkmr4D/HuzOB5Sc7MOUXRz8HZRPnFfLfCbGlWsJysp
         XZlmDIEfk4O228DHLlYe1dGixLQAYCmwmbvNEzQn+j6KRRaUUTEJwWxVJeR8agxVBhnS
         dVbfe993pSvGL8axGrZTLwphROUuFWh/dULncYfyOZRy0xo/WE6tvlqIMpA0iG042yZ8
         7K6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699010220; x=1699615020;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWqvGHOpDjXeJF4gaG5FvSChunLowe+31JAI0Z5rk34=;
        b=pfJyTrPEiZIWwcvD9kqcDSUY8FZz8pjUC7hvqLEXF5QSwTB2uHLcdBJv6mRX87Vxtq
         UyjtLroYmuH+SboCPGvGV5jTiPWm20CiZJAuw2aCLKFshTtKSWrCDOT4wPRM9z7McdVB
         RRm7ux2+po6mLd2rnT8CPxH8NMRUBOfQ+yWEPX8prK5Wz29Kdh/iLIYknGGYL9meIYSK
         Z/M38M/4f+VBV1dYpE9YJGr/+6ya7Nz5kv//juWGMyJJJXXYGWGpCXjpO5Wqg7sUYpcH
         1fzY/xon34i43z53ZaQ5/uR1N1x9xlyVMpAvfRkyUYA/ykRRW9J2zCashh1Ybml17/sW
         tmdQ==
X-Gm-Message-State: AOJu0YwvVB8XmNDErx/CdW0JY91GF0cSryTPG2Lvip3I4KGwxs8X2wOu
        uxKIjG7TmhbbRqb1jx40WluvOBJRAAkF1NBWf9aWGg==
X-Google-Smtp-Source: AGHT+IFLVZi6pW8xuPrCXex8Mha8wM8l8BM1AAWvvxpzrUbGuBa0q1spsqLLCOnrl8AxOXZ62UTRQpiJM5P5rka57OE=
X-Received: by 2002:a81:4f04:0:b0:5a7:e5b8:997a with SMTP id
 d4-20020a814f04000000b005a7e5b8997amr2573913ywb.10.1699010220701; Fri, 03 Nov
 2023 04:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231103004220.1666641-1-asmadeus@codewreck.org>
In-Reply-To: <20231103004220.1666641-1-asmadeus@codewreck.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Nov 2023 12:16:25 +0100
Message-ID: <CAPDyKFrPaScaQE340g8cD_xR+KoX=JuSc9xtCW=B+HZKYjf1aQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "mmc: core: Capture correct oemid-bits for eMMC cards"
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dominique Martinet <dominique.martinet@atmark-techno.com>,
        stable@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Alex Fetters <Alex.Fetters@garmin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 3 Nov 2023 at 01:42, Dominique Martinet <asmadeus@codewreck.org> wrote:
>
> From: Dominique Martinet <dominique.martinet@atmark-techno.com>
>
> This reverts commit 84ee19bffc9306128cd0f1c650e89767079efeff.
>
> The commit above made quirks with an OEMID fail to be applied, as they
> were checking card->cid.oemid for the full 16 bits defined in MMC_FIXUP
> macros but the field would only contain the bottom 8 bits.
>
> eMMC v5.1A might have bogus values in OEMID's higher bits so another fix
> will be made, but it has been decided to revert this until that is ready.
>
> Fixes: 84ee19bffc93 ("mmc: core: Capture correct oemid-bits for eMMC cards")
> Link: https://lkml.kernel.org/r/ZToJsSLHr8RnuTHz@codewreck.org
> Link: https://lkml.kernel.org/r/CAPDyKFqkKibcXnwjnhc3+W1iJBHLeqQ9BpcZrSwhW2u9K2oUtg@mail.gmail.com
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> Cc: stable@vger.kernel.org
> Cc: Avri Altman <avri.altman@wdc.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Alex Fetters <Alex.Fetters@garmin.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> Here's the revert as discussed in "mmc: truncate quirks' oemid to 8
> bits"' patch thread.
> Feel free to ignore if you already have something, I just checked your
> -next branch quickly and might have missed it.
>
>  drivers/mmc/core/mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 4a4bab9aa726..89cd48fcec79 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -104,7 +104,7 @@ static int mmc_decode_cid(struct mmc_card *card)
>         case 3: /* MMC v3.1 - v3.3 */
>         case 4: /* MMC v4 */
>                 card->cid.manfid        = UNSTUFF_BITS(resp, 120, 8);
> -               card->cid.oemid         = UNSTUFF_BITS(resp, 104, 8);
> +               card->cid.oemid         = UNSTUFF_BITS(resp, 104, 16);
>                 card->cid.prod_name[0]  = UNSTUFF_BITS(resp, 96, 8);
>                 card->cid.prod_name[1]  = UNSTUFF_BITS(resp, 88, 8);
>                 card->cid.prod_name[2]  = UNSTUFF_BITS(resp, 80, 8);
> --
> 2.41.0
>
