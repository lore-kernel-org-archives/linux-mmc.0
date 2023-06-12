Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E957C88CB4
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Jun 2023 14:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237635AbjFLOU6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Jun 2023 10:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239631AbjFLOUf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Jun 2023 10:20:35 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB0F1BF4
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jun 2023 07:18:09 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-bcc50a23645so814424276.2
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jun 2023 07:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686579424; x=1689171424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=thz1rU6TqUqhP4hqV/tPAC8YgYdbM3d8oNqdBfG0TWQ=;
        b=FGx93jm5DHcCzgbJrMTqyqyHC9ByolTmytgHxNDUmpvCli+E2RzMDi44n3dxKLCUFq
         4C1l/+nIZufZsQSrTKb5oUbQeytNLgjpXH2zXlTJPch+CBQwpX5n/kn9mlsbqjGefAnK
         4qvf9as7rESZKXHEKNZ/0tSc8Oqq5BNGK38aHMNNXn2K/hISubGTH3Vh7O7I1Q+k9GkO
         Cs5ixA+audCWEfpQf1hF/6pJlXe7vkakxSpMlTm6UoOL5hdGo5oJSh/+zOEinEoB+ECw
         e1WL+QIMgqWoiQeI6VYxYgKrYG5xS0z3yPFuWgqWPRIZTXgGc1xJnZA7QSZ11SiH4Ix+
         OyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579424; x=1689171424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thz1rU6TqUqhP4hqV/tPAC8YgYdbM3d8oNqdBfG0TWQ=;
        b=TE7gZuodq4TO1Yu5KwZ5Tm9IbS6//R6LPHNwE/0B/3BnTunqy/UnGFDbXJ4QgVsakh
         o0Bt/sAY4A5gi0fsk0VNAHX2x9ehI7t55MUv0Nrz3/EnMI/Hn3vlSU8tlNCnN0lab1mn
         CphzLilBsAsFZTTA6dOje2n964DGr4ij9xh4aTheQ5kY6L3Za1oQ02h58Q1P6zthcliv
         tPUDnYfo8c5Tfk3oqVb7xcf6O8jxPqK1jzLyAHRj8fnERhvAMeIfIn2JMTjbgYPx29vY
         aUS3ydpWniiXRv3O7cOMub+5kUR+sFIOOb1nHH1aYF85w6K4KizzPKTuuHG/+/unT+Rf
         2e0A==
X-Gm-Message-State: AC+VfDxW27WLDEkGJGbUZ7axo7YXhi5lmFHGIbbbgzo8J/c/67ueQ+nw
        lyZvgC3yNu83zRoyyXIxKbqrg6PCMJMBBuItISjR1MNXW3Z1TeBe
X-Google-Smtp-Source: ACHHUZ68HLDX2HorpUfXt3blRkWbGvexBKPyOy7XyHFyo1/vgq9/OZpwRZTCSuXG4Fu+Jo4tLUVDouLpmzkDB5rLyK8=
X-Received: by 2002:a25:69c8:0:b0:bc8:833d:c41e with SMTP id
 e191-20020a2569c8000000b00bc8833dc41emr4142099ybc.6.1686579424216; Mon, 12
 Jun 2023 07:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230609083425.765-1-avri.altman@wdc.com>
In-Reply-To: <20230609083425.765-1-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Jun 2023 16:16:28 +0200
Message-ID: <CAPDyKFpHNYmre7Y6Ut0MqpJAAngZZx9Ra6ofzsjrNzbdwZ_itA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc-utils: Assert MMC_IOC_MULTI_CMD in compile time
To:     Avri Altman <avri.altman@wdc.com>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 9 Jun 2023 at 10:34, Avri Altman <avri.altman@wdc.com> wrote:
>
> v1 -> v2: Address Ulf's suggestions

Next time, please put this as patch version information, below the "---".

>
> Notify of mult-ioctl violation during preprocessing instead of bailing
> out in runtime.  Would not even allow bogus copies of mmc-utils binaries
> wondering about out there.
>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe


> ---
>  mmc_cmds.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index df66986..26bdc38 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -34,6 +34,10 @@
>  #include "mmc_cmds.h"
>  #include "3rdparty/hmac_sha/hmac_sha2.h"
>
> +#ifndef MMC_IOC_MULTI_CMD
> +#error "mmc-utils needs MMC_IOC_MULTI_CMD support (added in kernel v4.4)"
> +#endif
> +
>  #ifndef offsetof
>  #define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
>  #endif
> @@ -2112,11 +2116,6 @@ static int do_rpmb_op(int fd,
>                                           struct rpmb_frame *frame_out,
>                                           unsigned int out_cnt)
>  {
> -#ifndef MMC_IOC_MULTI_CMD
> -       fprintf(stderr, "mmc-utils has been compiled without MMC_IOC_MULTI_CMD"
> -               " support, needed by RPMB operation.\n");
> -       exit(1);
> -#else
>         int err;
>         u_int16_t rpmb_type;
>         struct mmc_ioc_multi_cmd *mioc;
> @@ -2196,7 +2195,6 @@ static int do_rpmb_op(int fd,
>  out:
>         free(mioc);
>         return err;
> -#endif /* !MMC_IOC_MULTI_CMD */
>  }
>
>  int do_rpmb_write_key(int nargs, char **argv)
> @@ -2804,11 +2802,6 @@ out:
>
>  int do_ffu(int nargs, char **argv)
>  {
> -#ifndef MMC_IOC_MULTI_CMD
> -       fprintf(stderr, "mmc-utils has been compiled without MMC_IOC_MULTI_CMD"
> -                       " support, needed by FFU.\n");
> -       exit(1);
> -#else
>         int dev_fd, img_fd;
>         int sect_done = 0, retry = 3, ret = -EINVAL;
>         unsigned int sect_size;
> @@ -3034,7 +3027,6 @@ out:
>         close(img_fd);
>         close(dev_fd);
>         return ret;
> -#endif
>  }
>
>  int do_general_cmd_read(int nargs, char **argv)
> --
> 2.40.0
>
