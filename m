Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DEFC433ED
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Apr 2021 09:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2AFB61090
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Apr 2021 09:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhDZJpu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 26 Apr 2021 05:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbhDZJpt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Apr 2021 05:45:49 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A9AC061574
        for <linux-mmc@vger.kernel.org>; Mon, 26 Apr 2021 02:45:08 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id k124so27972895vsk.3
        for <linux-mmc@vger.kernel.org>; Mon, 26 Apr 2021 02:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jq6l+/zeiO0MmVuivxxJjucggcKTImzUuMZiYzS2/qU=;
        b=uFxMEaVU9TkO6pxkc1iLcaOb6Ih5f8NgBFT6HnB2JZGeDJlEE49k0fQZIfEVQB87Nl
         Y1Gtcu+HHXVxEgUr7ucvLNZ34WNK6jvx6rdPW+z+RGhoSJeIK5V4sqvWtSrbGjvGuhbS
         4mKqPOAXSvKEEWMEhmhpFdW46Zxu0Qn9vevaO/pbMTKqwvtjH1ycqHhMoz7qRpYoLGtf
         iKj2qWUeLCdDir3rAkNcnivBoz8NkiLac8xIaH2HoO4I0xUcKz7g6Rv7ZmZcMji/CXLW
         6m22bq7XztAydKZhJsAfLoveVqoihtqYAVVR2UyLoP1VCCJDFZ0VoPyYnwcK7BvzNN78
         z6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jq6l+/zeiO0MmVuivxxJjucggcKTImzUuMZiYzS2/qU=;
        b=VaO5nJA9wobsUIbuQDjOH8Gk2lnWwL0MGFomCmWLLz0ZLbdLkBhkzRLL1VcSE8q6Ja
         fIu1vmixN3pTJPHqBgMkLG6QvlLSNJHPTRQrZTcIqWG2+GtB/6yDfifGF/ZgRHTRtW30
         EH+AMqZU4zQTzbngFoMvRctWff5+uuu4Ul/lsLSeCwqxViT/F28PCnmVu7Tgp8QffFVM
         P13k4TWU0Xt9RDetYqTvngIKOgNJadBz0CPeFHZBRk407c4VHrvznexmC2pa/U1J0y0z
         UiGXVkeoitjEKWZqjjdu0Sqy7jrkxaU+UOGzFQwwff59SI/NfpR/8MblWtg+OdEGUQOW
         dsNQ==
X-Gm-Message-State: AOAM5316zLO/T1R6pE594BWcRJzEML8gkkmWMKToSrPIFALyNLSw7drN
        vZVBS6IxPBoItBN9KhgFHxNFxVALCQNigJF4/4m4hg==
X-Google-Smtp-Source: ABdhPJw1ndt6VhCvCQjjRbfsHP9lGuTGdSe4tjtznSAIvSPMXZtSIKott5n3vwWPwG9OPuREVPYm9gDHmfTyT9ori9I=
X-Received: by 2002:a67:e902:: with SMTP id c2mr10830509vso.42.1619430307798;
 Mon, 26 Apr 2021 02:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210421135215.3414589-1-arnd@kernel.org>
In-Reply-To: <20210421135215.3414589-1-arnd@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 26 Apr 2021 11:44:31 +0200
Message-ID: <CAPDyKFrUMaQM_aacYcKKnQeqeDz8cfabsFGrdNLYmotcFf3uew@mail.gmail.com>
Subject: Re: [PATCH] memstick: r592: ignore kfifo_out() return code again
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 21 Apr 2021 at 15:52, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> A minor cleanup to address a clang warning removed an assigned
> but unused local variable, but this now caused a gcc warning as
> kfifo_out() is annotated to require checking its return code:
>
> In file included from drivers/memstick/host/r592.h:13,
>                  from drivers/memstick/host/r592.c:21:
> drivers/memstick/host/r592.c: In function 'r592_flush_fifo_write':
> include/linux/kfifo.h:588:1: error: ignoring return value of '__kfifo_uint_must_check_helper' declared with attribute 'warn_unused_result' [-Werror=unused-result]
>   588 | __kfifo_uint_must_check_helper( \
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   589 | ({ \
>       | ~~~~
>   590 |         typeof((fifo) + 1) __tmp = (fifo); \
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   591 |         typeof(__tmp->ptr) __buf = (buf); \
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   592 |         unsigned long __n = (n); \
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~
>   593 |         const size_t __recsize = sizeof(*__tmp->rectype); \
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   594 |         struct __kfifo *__kfifo = &__tmp->kfifo; \
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   595 |         (__recsize) ?\
>       |         ~~~~~~~~~~~~~~
>   596 |         __kfifo_out_r(__kfifo, __buf, __n, __recsize) : \
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   597 |         __kfifo_out(__kfifo, __buf, __n); \
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   598 | }) \
>       | ~~~~
>   599 | )
>       | ~
> drivers/memstick/host/r592.c:367:9: note: in expansion of macro 'kfifo_out'
>   367 |         kfifo_out(&dev->pio_fifo, buffer, 4);
>       |         ^~~~~~~~~
>
> The value was never checked here, and the purpose of the function
> is only to flush the contents, so restore the old behavior but
> add a cast to void and a comment, which hopefully warns with neither
> gcc nor clang now.
>
> If anyone has an idea for how to fix it without ignoring the return
> code, that is probably better.
>
> Fixes: 4b00ed3c5072 ("memstick: r592: remove unused variable")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/memstick/host/r592.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
> index 026fadaa1d5d..615a83782e55 100644
> --- a/drivers/memstick/host/r592.c
> +++ b/drivers/memstick/host/r592.c
> @@ -359,12 +359,15 @@ static void r592_write_fifo_pio(struct r592_device *dev,
>  /* Flushes the temporary FIFO used to make aligned DWORD writes */
>  static void r592_flush_fifo_write(struct r592_device *dev)
>  {
> +       int ret;
>         u8 buffer[4] = { 0 };
>
>         if (kfifo_is_empty(&dev->pio_fifo))
>                 return;
>
> -       kfifo_out(&dev->pio_fifo, buffer, 4);
> +       ret = kfifo_out(&dev->pio_fifo, buffer, 4);
> +       /* intentionally ignore __must_check return code */
> +       (void)ret;
>         r592_write_reg_raw_be(dev, R592_FIFO_PIO, *(u32 *)buffer);
>  }
>
> --
> 2.29.2
>
