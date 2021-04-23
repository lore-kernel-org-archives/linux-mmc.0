Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBE1C433B4
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Apr 2021 08:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1957611C2
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Apr 2021 08:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhDWIAi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 23 Apr 2021 04:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWIAh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Apr 2021 04:00:37 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C8FC061574
        for <linux-mmc@vger.kernel.org>; Fri, 23 Apr 2021 01:00:01 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id u22so13249104vsu.6
        for <linux-mmc@vger.kernel.org>; Fri, 23 Apr 2021 01:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pmtAlemk9SkQiMZDpYGCeEcDtc4HAQA190oHucpZ6SI=;
        b=GxfOAh/M/OMPoZSX6vx3Y/rchiyiDt/hPaZ5VKds+a9vdawKMk+Hmy5u/asG8VI3LO
         we3/vg/JR9S0cIilK4a4sOuOE6wjMP/nDaQJkB1m/icFjhCxVvOcUd5ch0mrAEIMbpZz
         vtoZdDvHo5JeD6bmQT03VXdw4A+iSH4q5BRQWzPEtSy79W2Sixw4baXFX/jHtnoGdrit
         G+y8ubozgRrzmU7v22jIkAqlNIVmnfXrWvQf+AkAEX/YjqjPtnhvaXQLK163f8NG8i1j
         50EqzRglaKnOArkqsYhHouaDe48OxH4koVEZadnoa7fPuGnOj1S3C6NUq8i4gy7I0x30
         SS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pmtAlemk9SkQiMZDpYGCeEcDtc4HAQA190oHucpZ6SI=;
        b=Fz70wNZX8aZh7aqjsZKTEyK4Y1geUab1nUW1AlLuMznTRulYGxAWt3QuimP4DX3Bxr
         5qG7MokD4qnM6vTHKIXSECHnQwN5GPjDLi0xy8wEHV8YAvPYN5fKUzJnMB/qUOOMBgkw
         vkGq1d9pk+p6w7p6cDdFTJMum2kNjyyl5gwhZ+4ZL9y/fsCb4LzBQvrRdrFGkMi9a0MJ
         F1W6zDFn+/MAKs2ycw1k3fDFD0U/wHMVBlSKB1AE7UKhApi5vzaK920KAtbZSC7mPsa6
         spjl2tLFFlzBMGDVD/OkjTmnYJhvfrEA+5ijyj6c2AD8N30VnTnG5zEbrf8umGjp1zFJ
         6eSw==
X-Gm-Message-State: AOAM531qdrJt59LplcBWm3DsCF13jaKCFQA7ukKhGZhFm91MOQd+o/PF
        LTPhMg08RhEibW8w33W9huV2XHiADnvWbcbfNfnh8g==
X-Google-Smtp-Source: ABdhPJw1eb9lAuquyTjGTAeDhOqfXxVOUgDPREXGno3kNAY+lV6q3CImbRpUTYs6UqoM7kV4bUn3Ho8EuYgbNwIiYy8=
X-Received: by 2002:a67:e902:: with SMTP id c2mr2022417vso.42.1619164800544;
 Fri, 23 Apr 2021 01:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210421135215.3414589-1-arnd@kernel.org>
In-Reply-To: <20210421135215.3414589-1-arnd@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 23 Apr 2021 09:59:24 +0200
Message-ID: <CAPDyKFqy_yqYNjBykv7L3Cbs_bRh78O4tQdf-8+W08yRzyFNOA@mail.gmail.com>
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

Perhaps, if you can't do anything with return value, why is kfifo_out
declared like this?

>
> Fixes: 4b00ed3c5072 ("memstick: r592: remove unused variable")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

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
