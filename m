Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6512C433B4
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Apr 2021 17:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9678561456
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Apr 2021 17:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244599AbhDURRq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Apr 2021 13:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241845AbhDURRq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Apr 2021 13:17:46 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3741FC06138A
        for <linux-mmc@vger.kernel.org>; Wed, 21 Apr 2021 10:17:11 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 12so67738529lfq.13
        for <linux-mmc@vger.kernel.org>; Wed, 21 Apr 2021 10:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=43DYgV+tGi3uz6vhioZmI3U81q1qHyxbq4uVPUHsfyU=;
        b=AR3/oRNQSPVYA2pY6BU9wrRI9xS5PUnAzVRKz6HYe0O732krReHkvYGW15ekzTEgHp
         GgMABGXqEVMGTibj+qxS3EfaemN5IkCCIsdSYwejleSElo+pHn2acnw4PuMQjzyHb04C
         /KLI91lfAzPyKc2ILg532Curi/5o6gIQ7zPTKMNcek0kgwL7/VB1U4V5raWxFj6GquGM
         YDr8KOXu2kIrikYXNuz45thQ8JmDEYZhfdagjoP2XDi9Y6O9XPFRtP6dnFjzxRD/TRs/
         wDfVor0seMOF0X6lGIFJ4TOoYeAAd68W6OAwDCWx5x7I8V/w1wflAa7wht/5pHFdweYI
         oUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=43DYgV+tGi3uz6vhioZmI3U81q1qHyxbq4uVPUHsfyU=;
        b=KUit3cpuaBZ3jDZ41MmwFnakLFcFQ0q5zw8aOmaNUhG1tFDT0Zc9z6lYw04dCYCCCY
         AbneU2olWHk88XOMVfGv58EEJok3U1z6p83CpYoQBdhpRMr5DPnXIXPsroM/lfnXJz8Q
         4xAbOGpsflKH6GetmX1TQkvYlOY8Q7pdx75m23AgnOUEgdHqr6tJRX1ZGFbVVc6Q4hkg
         EAie8eXVdClKWATlNDa5Wll+Y6f8FXS6SEu85iWRTTXFoFf0BWxEl1Qsc2opsE7EVWr5
         XP9KyJUYAiYcC+8NkLpq0S8HOQtUzcXT/MKqBAvBQLOhG96w8msI16+q5Zpj4zBGDwSt
         85+Q==
X-Gm-Message-State: AOAM532aV6MMpBAe4/bVK0uXoGXIKO0c/Ml3eEFsLQsCidlIos3DKFyQ
        5palthDHPa5iEU9dJSYJckRMOoAM0u+LE9lh/IBjpw==
X-Google-Smtp-Source: ABdhPJybU9H+tLJtOGevTx1w60ZOSPFsWMP4Oi3hRGsgFGVAPXCG5++l5UHc3Nif8YjQqL2oOuS/Li4qFENwVCAMQYM=
X-Received: by 2002:a05:6512:150:: with SMTP id m16mr21006546lfo.374.1619025429467;
 Wed, 21 Apr 2021 10:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210421135215.3414589-1-arnd@kernel.org>
In-Reply-To: <20210421135215.3414589-1-arnd@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 21 Apr 2021 10:16:58 -0700
Message-ID: <CAKwvOdk21V0qW_xQrWqQYnrw8nEr_+KTJnVZgL0gJsJiUf2Scw@mail.gmail.com>
Subject: Re: [PATCH] memstick: r592: ignore kfifo_out() return code again
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Apr 21, 2021 at 6:52 AM Arnd Bergmann <arnd@kernel.org> wrote:
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

Should r592_flush_fifo_write be made to return an int, then callers of
r592_flush_fifo_write percolate up their return code?
r592_transfer_fifo_pio() seems to only return 0, but its callers are
doing return code checking.

>
> Fixes: 4b00ed3c5072 ("memstick: r592: remove unused variable")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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


-- 
Thanks,
~Nick Desaulniers
