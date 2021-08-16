Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3901C4320A
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 22:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 878DC60F55
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 22:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbhHPWib (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Aug 2021 18:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhHPWib (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2021 18:38:31 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ACBC0613CF
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 15:37:58 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id h11so29632498ljo.12
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 15:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=39HL+1BSTEP9McF8N5wJpHZqTmDxGof61S5w7T18t2c=;
        b=PIs+rFO4pY8Mv2zPiP7V6q/9YBvqlbSQNI7cVts9VvV0Hz3CkLMBnig1HrU7GnFYCE
         O0Q4VRNvYIVl119B7gJPknlTEUx+o0PWLDRPKeaE+JF0RKf6O01d+ztmYDR3LJ/5BZLK
         7aYlfzKganWO6Zz/nbb5QGdMwAmcFJ7YNW/EFtn8uVSguA0SKqkNu7u1yTFx760GaryM
         pJugUZKI8rd1dAmUwiCsf1Wm7L2TAcWTw/LSngxpoeua5nKPQoWX0dspsKulFQ0ntlCj
         QRhfsrxl6bi0Yqc0tXysl1ZoKWnjIEYeZMQHApP5C6ATdIyZ1qR+GBZy/BCrs8N5He8N
         H69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39HL+1BSTEP9McF8N5wJpHZqTmDxGof61S5w7T18t2c=;
        b=MYdiRtnnxljw/rarLOacbCf3P7Dc6xwhGzdRpbfFb6DPC2htsqrL6hVlRcREZDLdwl
         su+rV5thzRdLjEaSYEEMx/vGy/IGUYFVm2Nh1ojr4fqtNgOYR0MfdPviu4ia7LcENNX9
         vdtTnYEdHm1SixfpXQ576b5i8CGi4gUq8SNj5W+ERosps5ivZkcNUb42A+W80QV/nXSQ
         x1fJzLSSEMUfoL4OJg01kxoCwvz7amDcpIgZwHRSmH4nuDGLTyzWBHzejdZ0DLxOdcBV
         2o6sCVKw3ZCtPboHtlVqlpD9+wEMcboJaquaEcvjWf483HAw4W/l6kahNKPfqft3EKek
         zc6g==
X-Gm-Message-State: AOAM531Do8pXz9qYYckm6Qbu6l88UXmx0DvWpPhbr5ioMYPT3YllhlTD
        NwyHE1H7jVzURaXp1kT2LF8WivollLbPff+OZVknxA==
X-Google-Smtp-Source: ABdhPJxzmodtRFtigSTsXW3Hjcueq6Q1d1XD/3P7zoYrskkwNMcxgNm5kFyqkanm5Fu3lKOWWYYYiaLrR2KTWatt1+Q=
X-Received: by 2002:a05:651c:1507:: with SMTP id e7mr426852ljf.368.1629153476979;
 Mon, 16 Aug 2021 15:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210720144115.1525257-1-linus.walleij@linaro.org> <2f449f6e-bca0-3c70-4255-26619e957d44@foss.st.com>
In-Reply-To: <2f449f6e-bca0-3c70-4255-26619e957d44@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Aug 2021 00:37:46 +0200
Message-ID: <CACRpkdY2GnqNYqPPctqa_t5ax1SDo7nEc3a1jSncF8N-V-Da-g@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: core: Add a card quirk for non-hw busy detection
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        stable <stable@vger.kernel.org>, phone-devel@vger.kernel.org,
        Ludovic Barre <ludovic.barre@st.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Stefan Hansson <newbyte@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Aug 16, 2021 at 4:03 PM Yann Gautier <yann.gautier@foss.st.com> wrote:

> I was just testing your patch on top of mmc/next.
> Whereas mmc/next is fine, with your patch I fail to pass MMC test 5
> (Multi-block write).
> I've got this error on STM32MP157C-EV1 board:
> [  108.956218] mmc0: Starting tests of card mmc0:aaaa...
> [  108.959862] mmc0: Test case 5. Multi-block write...
> [  108.995615] mmc0: Warning: Host did not wait for busy state to end.
> [  109.000483] mmc0: Result: ERROR (-110)
> Then nothing more happens.
>
> The test was done on an SD-card Sandisk Extreme Pro SDXC UHS-I mark 3,
> in DDR50 mode.
>
> I'll try to add more traces to see what happens.

What I think happens is:
- You are using the MMCI driver (correct?)
- My patch augments the driver to not use busydetect until we have
  determined that the card can do it (after reading extcsd etc)
- Before this patch, the MMCI would unconditionally use HW
  busy detect on any card.

Either we have managed to wire the MMCI driver so that it doesn't
work without HW busy detect anymore, you can easily test this
by doing this:

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 3765e2f4ad98..3a35f65491c8 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -270,10 +270,10 @@ static struct variant_data variant_stm32_sdmmc = {
        .datactrl_any_blocksz   = true,
        .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
        .stm32_idmabsize_mask   = GENMASK(12, 5),
-       .busy_timeout           = true,
-       .busy_detect            = true,
-       .busy_detect_flag       = MCI_STM32_BUSYD0,
-       .busy_detect_mask       = MCI_STM32_BUSYD0ENDMASK,
+       //.busy_timeout         = true,
+       //.busy_detect          = true,
+       //.busy_detect_flag     = MCI_STM32_BUSYD0,
+       //.busy_detect_mask     = MCI_STM32_BUSYD0ENDMASK,
        .init                   = sdmmc_variant_init,
 };

@@ -297,10 +297,10 @@ static struct variant_data variant_stm32_sdmmcv2 = {
        .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
        .stm32_idmabsize_mask   = GENMASK(16, 5),
        .dma_lli                = true,
-       .busy_timeout           = true,
-       .busy_detect            = true,
-       .busy_detect_flag       = MCI_STM32_BUSYD0,
-       .busy_detect_mask       = MCI_STM32_BUSYD0ENDMASK,
+       //.busy_timeout         = true,
+       //.busy_detect          = true,
+       //.busy_detect_flag     = MCI_STM32_BUSYD0,
+       //.busy_detect_mask     = MCI_STM32_BUSYD0ENDMASK,
        .init                   = sdmmc_variant_init,

Or else there is a card that cannot work without busy detect which
I find unlikely.

Yours,
Linus Walleij
