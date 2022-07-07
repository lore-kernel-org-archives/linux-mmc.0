Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72053C43334
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Jul 2022 08:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiGGIs0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Jul 2022 04:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbiGGIsY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jul 2022 04:48:24 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355121EC
        for <linux-mmc@vger.kernel.org>; Thu,  7 Jul 2022 01:48:24 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id p129so1604900yba.7
        for <linux-mmc@vger.kernel.org>; Thu, 07 Jul 2022 01:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3DfoExFZmNTGC0O3yYbMqzldLz9nrmhwSG9ryY0dVz0=;
        b=BDgmlIy+RqVcpSiA7KHaPJ02JCM4O0LLPu4f3DXuKcSGGeBJxKdOfPukMlWjk9fQJR
         yGi1ihLdsjTyxd1oeNE1rL+WG8w/NgCiRdTt8BkGs7HKraYi0DYAztZGJE79pCT16Ynw
         7tomjYx6hNfFizRJLSbn7VhJj77uu3DS17ojACPSPDT4PuQ7P6tfBkpiu5gfgCB8hA2Y
         8i5qF4SsKIwh7r6SDSktYNl4PMG7l6HrI6hB5wo5KVMWUi02DRJiM1VAuvi7WWjCLiqk
         Mt+4WlofJLE52nRcOBbt0SqQLhQlXjleCFtTd4dF17U50NLQl9jFr+nrvd6eRp6fLYtH
         9gpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3DfoExFZmNTGC0O3yYbMqzldLz9nrmhwSG9ryY0dVz0=;
        b=x+ysLwna6H+mVvBebUFaW+8p7/GTfBWwLDN1J3IcgHX8C+Y9qtD+oSgbZLxpn6P0Kb
         Og9nCruRv/mnMnC5SWnyEzBb/1udOsbWQqstrDoRkRd7+aTsWEUamcE0j+tcKGh7d1V/
         nBlrwk9CmDvKAUSTES1IXuAR3ynsRQI9VREDsVAP95Ky++T8MghKhIx7dOzBrv8ckusC
         Im1YPOXG9QfzP4HKPiebO0S1+VtDhIuQPdye+vz4tGEv8I1O5FWZzLqRnzrtq2ErQ6Pb
         qEppT8sq+q5rvXnCy0s2BY7zAzslOZmO05qvxvMYGcAzeiseTKTx4bNVC8Qq8jhgRlzZ
         Os2Q==
X-Gm-Message-State: AJIora8x2cPqwU8i3W1SOEsGQ4iQ4/ooGNOH3K/iolf3YYl2XFztR7EZ
        9L0Hf7F+b9buLqKJ8Fln4UvUVX8pyTB1LY7/ev9vLQ==
X-Google-Smtp-Source: AGRyM1vA90z3W6lqHkPxXibfYzpXiWZCS6gabQQsQOgTyTEuu8uMRiVTh7ABrFuXfMlbKiMGtefgAUAwe/tJoe/ih/8=
X-Received: by 2002:a25:1f57:0:b0:669:b6fa:167e with SMTP id
 f84-20020a251f57000000b00669b6fa167emr50618854ybf.295.1657183703467; Thu, 07
 Jul 2022 01:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220706005238epcas1p110ad467f1406cb9270e449de998090a9@epcas1p1.samsung.com>
 <20220706004840.24812-1-cw9316.lee@samsung.com>
In-Reply-To: <20220706004840.24812-1-cw9316.lee@samsung.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Jul 2022 10:48:12 +0200
Message-ID: <CACRpkdYPxozy76jsrt3O-eC2PEW32WmRSMDGz7PrBu7Ee8whzw@mail.gmail.com>
Subject: Re: [PATCH] Replace with already defined values for readability
To:     Chanwoo Lee <cw9316.lee@samsung.com>
Cc:     ulf.hansson@linaro.org, s.shtylyov@omp.ru, huijin.park@samsung.com,
        andrej.skvortzov@gmail.com, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Jul 6, 2022 at 2:52 AM Chanwoo Lee <cw9316.lee@samsung.com> wrote:

> From: ChanWoo Lee <cw9316.lee@samsung.com>
>
> SD_ROCR_S18A is already defined
> and is used to check the rocr value as shown below.
>
> So, replace with already defined values for readability.
>
> --------------------------------------------------
> /sd.h
> .#define SD_OCR_S18R    (1 << 24)    /* 1.8V switching request */
> .#define SD_ROCR_S18A   SD_OCR_S18R  /* 1.8V switching accepted by card */
>
> /sd.c
> static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>         struct mmc_card *oldcard)
> {
> ...
>         if (rocr & SD_ROCR_S18A && mmc_host_uhs(host)) {
>                 err = mmc_sd_init_uhs_card(card);
> }
> -------------------------------------------------
>
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>

Excellent patch.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
