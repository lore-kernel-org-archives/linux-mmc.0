Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACB8C43381
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 15:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B24802339E
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 15:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387528AbhATOvw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Jan 2021 09:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388965AbhATOLB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jan 2021 09:11:01 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FA8C0613ED
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jan 2021 06:08:29 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id p20so5816225vsq.7
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jan 2021 06:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=13b3vHVu39A33E0TnIXuY5Wj8JKntF5mua6ndCRhPkM=;
        b=NK601z15ygFsvMzTe0v8tkPP1FHMOmkdAgM+Fd/TUnhA+4pnY8PyQYS+cjqtXGbi+F
         d1OLdYfJZFXFmrBJKNaJtYWk3A8poM/AUyoIpe7inS+TWkojwbkVtOAG2jtR2LMWX/pt
         Hx+BSzudXbHqUNEHHMn7SW1uh/g0968lniti3qBTtsU3gdDWTVUeDC+0YMhUC6M9jGLj
         ItVKmLJZyadP9YsD4YVqpGCD3nzonxW44OawBufnUSBFxhuH4tgh6KFbITvAe9YcS9aa
         N/BN+6h9e+VBiCyVnETSSuPHYmGKFgpe6S2uCLbk6W5iPgIg4XGoGjBchUOG/kJoxTEu
         ATyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=13b3vHVu39A33E0TnIXuY5Wj8JKntF5mua6ndCRhPkM=;
        b=h/tVzk885zfNrfCuMi+aF5vn9IDPD5fcdwt2ci4HDNDjE7I+grqRLZiUESYWFRmaVk
         g+H1nsb7NtdB7waTuPKlbNILVmaqwPbgOKdlvyF8odM4MiVAn1pdEbZlt0an1xejH35e
         GdRgBG+ZJeelvFKxI3t9qo1sezNK8/JNxOxUFieU1w/Kva5oSfNWqG5mVXRwHVl4L0Ir
         sKBcF06hQWC5G1h43+JROjasxOqDhXeUmyNT485TleAlWgNx0mISap9Ei7u2Pnh39g+6
         e8bSnsF2TURJsyWBh1tFcL7IZUFOHW6jk7HuC1aQjCIWzw6lcmyrw2vv6oSReQPrauFB
         Lf+Q==
X-Gm-Message-State: AOAM533EBmkM4E0ljO4XM2Sr9WPF38mvDmtcHekP+PUw40IV0Ekrg2qd
        3XuKS7XGVVmUAMLBj8/smPGM0a8gBIZb4BlqhL5YZQ==
X-Google-Smtp-Source: ABdhPJy4LDyZYIAtppdXF0yWSCx3G22s//bf3YpgnSFitS4qEj2Wug0NMhlcWg/Hu8b5kx/LSb7fjKhy/XPer9WqcrA=
X-Received: by 2002:a67:c787:: with SMTP id t7mr7074704vsk.48.1611151708746;
 Wed, 20 Jan 2021 06:08:28 -0800 (PST)
MIME-Version: 1.0
References: <20210119073705.375-1-zbestahu@gmail.com>
In-Reply-To: <20210119073705.375-1-zbestahu@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 Jan 2021 15:07:52 +0100
Message-ID: <CAPDyKFpp2jeeqwzM9MPtQqB18txGbX=J5stym53gZ3Us_oNruw@mail.gmail.com>
Subject: Re: [PATCH] mmc: test: clean up mmc_test_cleanup()
To:     Yue Hu <zbestahu@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yue Hu <huyue2@yulong.com>, zbestahu@163.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 19 Jan 2021 at 08:37, Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> mmc_test_cleanup() has same body as __mmc_test_prepare() with write
> except the character to memset().
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/mmc_test.c | 24 +++++-------------------
>  1 file changed, 5 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index f999b48..39a4788 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -624,7 +624,7 @@ static unsigned int mmc_test_capacity(struct mmc_card *card)
>   * Fill the first couple of sectors of the card with known data
>   * so that bad reads/writes can be detected
>   */
> -static int __mmc_test_prepare(struct mmc_test_card *test, int write)
> +static int __mmc_test_prepare(struct mmc_test_card *test, int write, int val)
>  {
>         int ret, i;
>
> @@ -633,7 +633,7 @@ static int __mmc_test_prepare(struct mmc_test_card *test, int write)
>                 return ret;
>
>         if (write)
> -               memset(test->buffer, 0xDF, 512);
> +               memset(test->buffer, val, 512);
>         else {
>                 for (i = 0; i < 512; i++)
>                         test->buffer[i] = i;
> @@ -650,31 +650,17 @@ static int __mmc_test_prepare(struct mmc_test_card *test, int write)
>
>  static int mmc_test_prepare_write(struct mmc_test_card *test)
>  {
> -       return __mmc_test_prepare(test, 1);
> +       return __mmc_test_prepare(test, 1, 0xDF);
>  }
>
>  static int mmc_test_prepare_read(struct mmc_test_card *test)
>  {
> -       return __mmc_test_prepare(test, 0);
> +       return __mmc_test_prepare(test, 0, 0);
>  }
>
>  static int mmc_test_cleanup(struct mmc_test_card *test)
>  {
> -       int ret, i;
> -
> -       ret = mmc_test_set_blksize(test, 512);
> -       if (ret)
> -               return ret;
> -
> -       memset(test->buffer, 0, 512);
> -
> -       for (i = 0; i < BUFFER_SIZE / 512; i++) {
> -               ret = mmc_test_buffer_transfer(test, test->buffer, i, 512, 1);
> -               if (ret)
> -                       return ret;
> -       }
> -
> -       return 0;
> +       return __mmc_test_prepare(test, 1, 0);
>  }
>
>  /*******************************************************************/
> --
> 1.9.1
>
