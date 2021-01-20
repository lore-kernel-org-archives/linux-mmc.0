Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C9BC43381
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 15:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 185B123358
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 15:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbhATPb5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Jan 2021 10:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390936AbhATPaB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jan 2021 10:30:01 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F544C061575
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jan 2021 07:29:16 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id o19so13257640vsn.3
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jan 2021 07:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zLmHjLoKfrJ/VBSSx0rkewFsbPHiVymRHs4Dil2S1qw=;
        b=D5DtkxVlUQUJtSIXXbF9T1C9/CYmrRxf6Dy1p+I7wDwynL+M0KgcqOkYPCeVO8JIZo
         RjKnI3es1ltCI2ykobw7XlFqe9g2hRWF4ctZGIw1g5vnXR7Ht+1/aitHi8M+NmKWbru+
         /0Z+DM+HC5fZMaLHy9lW2ythfM9YYQwl8QQiFTnbRW0uHdFquIr4xp2rN88klDN4jktf
         AGhBJNuPo4F//LtvstMhBORfPYNKGnIXDtWVd0hMHsAVlL8YKU+ZOAb5wAxjjYXuxHar
         pM0HvrunL2pU7a8u0Eu0I4UD+2D2s9Tllp4RcabkUUr6B22bm13U1Ma8iwEAaDN1en41
         /jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zLmHjLoKfrJ/VBSSx0rkewFsbPHiVymRHs4Dil2S1qw=;
        b=ApW3iYuSJ37NsTgl2mNtYujNLylA+5oJT5M02wV3rI636sR3mkEUVAmObYj5X4biEt
         00f40la1iigrI9Xiu0K6PlVsZz3/qvC+DYHVD6MpWlbnWBGTSSNJjHOJ5WkHfAQunnly
         XNmQ21tCYa34LJTGssapLCTIoYHdkxmpoRmlrqBcW+Vre85XxIo4VTFIyX+ISqiXOQen
         Inm27/uW/FaB356cbYGD4Tjx5Btl6d0celxQtV/ztjE5yLA2mtuKbP+zZermSWK3EzJm
         OTDqD7A4iC2HBAKdiM3K0k7xSj051Uu6uoOD2niW5QtpHqvSc1dV/bdho872OEaMK/RV
         F2Hw==
X-Gm-Message-State: AOAM532Z7y1kK3seHmFtRL6u3UKNb2kZdarAZ+zlH1k2Qbfb/YOoEQrE
        ywzVFWPGbyov0oudWPoLCKG0D5r9iqA2uW4fiC8vK2yigV9YNbN6
X-Google-Smtp-Source: ABdhPJykIJvgJNTjwtICR72Ml0lxuEuM/YumO2tX9boFGXE1ENmsNtFReuuUKbIyJ4x7SULzY/15lb6UgY+am40NDa8=
X-Received: by 2002:a67:c787:: with SMTP id t7mr7524554vsk.48.1611156555321;
 Wed, 20 Jan 2021 07:29:15 -0800 (PST)
MIME-Version: 1.0
References: <20210120144550.697303-1-fengnanchang@gmail.com>
In-Reply-To: <20210120144550.697303-1-fengnanchang@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 Jan 2021 16:28:39 +0100
Message-ID: <CAPDyKFqQ1C4vuyzwTV82q7ty=s5w6-4HX06gFqhhfjtzDbFA-A@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: limit the time of retries when analyse tuples failed
To:     Fengnan Chang <fengnanchang@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 20 Jan 2021 at 15:47, Fengnan Chang <fengnanchang@gmail.com> wrote:
>
> when analyse tuples failed, may enter an endless loop=EF=BC=8Cso limit th=
e time of retries.

Since this is fixing a real bug for you, it looks like we should tag
this for stable kernels as well, right?

>
> Signed-off-by: Fengnan Chang <fengnanchang@gmail.com>
> ---
>  drivers/mmc/core/sdio_cis.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
> index dcb3dee59fa5..47423a6d13fb 100644
> --- a/drivers/mmc/core/sdio_cis.c
> +++ b/drivers/mmc/core/sdio_cis.c
> @@ -266,6 +266,7 @@ static int sdio_read_cis(struct mmc_card *card, struc=
t sdio_func *func)
>
>         do {
>                 unsigned char tpl_code, tpl_link;
> +               u64 timeout =3D get_jiffies_64() + 10 * HZ;

To be consistent with how we do time based polling (see
__mmc_poll_for_busy() in mmc_ops.c for example) I would prefer if you
use a define for the timeout, rather than a magic value as here.

#define SDIO_READ_CIS_TIMEOUT_MS  (10 * 1000) /* 10s */

Additionally, regular jiffies should be sufficient I think. Thus I
prefer if you could specify the timeout along the lines like the
below:
timeout =3D jiffies + msecs_to_jiffies(SDIO_READ_CIS_TIMEOUT_MS);

>
>                 ret =3D mmc_io_rw_direct(card, 0, 0, ptr++, 0, &tpl_code)=
;
>                 if (ret)
> @@ -318,6 +319,8 @@ static int sdio_read_cis(struct mmc_card *card, struc=
t sdio_func *func)
>                         prev =3D &this->next;
>
>                         if (ret =3D=3D -ENOENT) {
> +                               if (time_after64(get_jiffies_64(), timeou=
t))
> +                                       break;
>                                 /* warn about unknown tuples */
>                                 pr_warn_ratelimited("%s: queuing unknown"
>                                        " CIS tuple 0x%02x (%u bytes)\n",
> --
> 2.25.1
>

Other than that, this looks okay to me.

Kind regards
Uffe
