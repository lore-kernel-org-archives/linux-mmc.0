Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7F2C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Oct 2022 14:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbiJZORT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbiJZORH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Oct 2022 10:17:07 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43221119D9
        for <linux-mmc@vger.kernel.org>; Wed, 26 Oct 2022 07:16:56 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b11so8011809pjp.2
        for <linux-mmc@vger.kernel.org>; Wed, 26 Oct 2022 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2aCkXJ3/E5kIsgcvjrlWJkcK9UIk/FwpFvw0TBvEhQs=;
        b=XXerNSUAAtAyO09OVK1S8loCnDU8Uq2DlLCcqb++RjYle9GSjcpTpOAxPQv0Fkb7rp
         EGNklaYucvSEecLhwRipKP5bxxrWR7ev2ZpZVJwXHjpo3uptunqLAJDc7Lnt3cCt2BNw
         dKMCuiQvf48kV5vAG+QVBFZ3P4rTXWpqGGiDwnfsREslwB0VVLOF0ljAOutIkvV1yBRl
         y0/4W7yduSlsTgfnLT4+h3j8u1f4ZIX7loTKYzxeYRGN9bT8U0Ub34MZT33C6jgo2UIs
         KvU/GxI/N2oZB6rBb1xMNjlRJ4fr4AlML5pWlePhDirogArHTgcbQv+9PGwvhkCSlvKZ
         qKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2aCkXJ3/E5kIsgcvjrlWJkcK9UIk/FwpFvw0TBvEhQs=;
        b=0V04mPJUxeb4KkDproDiCRoQiXIE1yzcmTmc68FpghXvfbAfZmmxjI0ZNCT9BOm8sR
         rWwisDGnF5tKEyXBuDNTriNzheweJ2kcZHFkoQ9MrDFTO0z+waIr+xei5mt3lnqtBJrq
         skXPhFBlv+gEw2B2l2lE3PBYXrCJxgV4c7EVZsZjCwcRzCA/01+UnHvFDSCgkcTywoLy
         iFKE5SfOXe4voIm1qHallhz9lcsMUcu3HySMLchR/cvQcL/yuooWuteYFgEJbcStHROO
         AtFTf8zAnyAE+EgGRNT+yAnHePpHL53zaEUsrC2gwBOXD9e8vio0lD6AXuvcL6NG3f9t
         QJBQ==
X-Gm-Message-State: ACrzQf0LwH63Z7VTKNv7wKHkkELvIP4IvCOG3FB2hTamW5/Fp/JGS/8T
        T04D3JL64AASPcfPtHuMzcU4nOOEZpLZat2WqTOX27uDz7DMsQ==
X-Google-Smtp-Source: AMsMyM6iyi+51XGotsLLwU0U4SEvki1VwmuQAFuE0VoGoDlO9tzGbzWyaKXocdQuaVR1HS5bA3243qXPQVZhqAUsnPQ=
X-Received: by 2002:a17:90b:70a:b0:211:f163:ddff with SMTP id
 s10-20020a17090b070a00b00211f163ddffmr4490569pjz.202.1666793816169; Wed, 26
 Oct 2022 07:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <972a1ea1-7431-21fe-c8af-027c4271f6a2@foss.st.com>
In-Reply-To: <972a1ea1-7431-21fe-c8af-027c4271f6a2@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 26 Oct 2022 16:16:19 +0200
Message-ID: <CAPDyKFqaJea9MA9KwkkuQt7YcUj5LCw46yeTKyomx1bCRnUzoA@mail.gmail.com>
Subject: Re: Issue with an SD-card switching to high speed
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     linux-mmc@vger.kernel.org, christophe.kerello@foss.st.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 19 Oct 2022 at 17:50, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> Hi Ulf (and mailing-list),
>
> I've an SD-card on a STM32MP157F-DK2 board that cannot switch to
> high-speed mode:
> "mmc0: Problem switching card into high-speed mode!"
>
> On this board, it is not possible to switch to UHS modes.
> And there is no power cycle done in kernel.
>
> When checking the differences when I add full-pwr-cycle in DT, I see
> that the OCR we ask the card is different:
> 0x300000 (MMC_VDD_32_33 | MMC_VDD_33_34) vs 0x200000 (MMC_VDD_33_34).
>
> If I add this missing MMC_VDD_32_33 voltage range (without power cycle),
> then the card can switch to high-speed.
>
> Checking where this is done in the framework, I've seen something that
> could correct my issue in mmc_select_voltage():
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 368f10405e13..bcd8fa81f78b 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1132,7 +1132,7 @@ u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
>                  mmc_power_cycle(host, ocr);
>          } else {
>                  bit = fls(ocr) - 1;
> -               ocr &= 3 << bit;
> +               ocr &= 3 << (bit - 1);

To me, this looks like you may be fixing a very old bug. Unless I am
wrong, it seems like the current code might as well have been:

ocr &= 1 << bit;

The upper bit that the '3' is trying to allow to be set, can in fact
never be set, because we have already done "ocr &= host->ocr_avail" a
few lines above.


>                  if (bit != host->ios.vdd)
>                          dev_warn(mmc_dev(host), "exceeding card's
> volts\n");
>          }
>
> The ocr given to mmc_select_voltage() is 0x300000.
> fls(ocr) = 22, bit = 21, 3 << bit = 0x600000.
> With the &= operator, we then have only 0x200000 and have removed
> MMC_VDD_32_33 mode.
> The architecture is an Armv7, I hope that the fls() has the same
> behavior on other architectures.
>
> But as this function is also used for eMMC and SDIO, this could have
> impacts I've not seen.
>
>
> Maybe the issue is just with this SD-card, that doesn't properly handle
> the range MMC_VDD_33_34 alone, and it could be out of spec.
>
> I then have 3 possibilities:
> - stop using this type of card if it is out-of-specs
> - add full-pwr-cycle in this board's DT, but I'll have issues with other
> boards that really cannot do power cycle
> - push the proposed patch in mmc_select_voltage()

Yes, please - so we can discuss it better.

Also, please try to add a relevant comment in the code too, so it
becomes a bit more obvious of what goes on.

Kind regards
Uffe
