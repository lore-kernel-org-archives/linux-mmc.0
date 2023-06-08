Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FC2C7EE25
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Jun 2023 21:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjFHVon (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Jun 2023 17:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjFHVom (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2023 17:44:42 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45CC2D6A
        for <linux-mmc@vger.kernel.org>; Thu,  8 Jun 2023 14:44:41 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-565a63087e9so10193897b3.2
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jun 2023 14:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686260681; x=1688852681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0N+ws3L/I8Uw2LmFDBYFl9uHizGsXYhSf0gn+qAJxSE=;
        b=KCbwaYBlrV5jWARhyzftKjYlzY83EzBBHkAjV75dI8k4Z2XMe7/Iv7lSrgnfo3qh5r
         hddOvCGpLUGdtmbVzXxDj4XguKoz90qFDJkrHR2WxyqBu5q2q/1b54yE6/U9piH5DFgZ
         qtoNBs6YPm1b+PRyklwVyiIA/tgF7xPZxzemViz5UQQLGPZ7F34hh34ljn5PFY41Fdzb
         gkREbfxX90JZwqmQuYzH/VFIuxdYBy4W4hLrq/nS2oWIHEBCDmSmuF05IZnC/d5TZJzw
         x2gHefMajQhpsgin3YzXm7wqM9zSvBhlm7W9kp0cZ+iF7JZB+GfGM+Z8WCV3iIVEY2Sd
         DAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686260681; x=1688852681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0N+ws3L/I8Uw2LmFDBYFl9uHizGsXYhSf0gn+qAJxSE=;
        b=CKDY7fG5QW96hZqz7NlibFoj0jw2WauaT1C3atr/NYw2XxDOovRaBXY/fRmD83oCes
         2IJaHF3hqJXDup7Q+/bReF5G6/0zEAucgWS9FgxDkL4cUE/M8Pvltf2OfiO8GyeF7TGM
         pdPS3AZQnWWBa1PQ0vqDQb2P/DRU33i5gibGqRc3PZ86g3754uuXBFFw/IM5VmSKkk3B
         KjXOGHSS0lV1sBbyvF86ybBw1n/4NRI4VKw+CvqLQKq601ZaNmjZvqGb8UHJlPN6VvWu
         0v1/nKi0/8hoXMsThKE/G39yKY2frtFL6/FoRftSmQaaYDlGYA4AabiuT9T9VWXt38ST
         srsA==
X-Gm-Message-State: AC+VfDxplaKXxzzDy/vgxKALMFbqbGBR7mPOlP8w5nawXIC9/Q00NWwt
        cprnepl6tZbFyErLAalSnkhpc+FD4ktPSHTsCqTsGxUZ9Wx51nvVOs4=
X-Google-Smtp-Source: ACHHUZ5fpFhhxaKjPM3wqbDX+He1ZC/50sykaPvmckoM5u1nWR7nEh6vUTZsxUoNnGVN9b0BcIpabaOFK08kpWnal84=
X-Received: by 2002:a81:a190:0:b0:561:90b3:e712 with SMTP id
 y138-20020a81a190000000b0056190b3e712mr1012485ywg.28.1686260680958; Thu, 08
 Jun 2023 14:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230524084224.558-1-avri.altman@wdc.com>
In-Reply-To: <20230524084224.558-1-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Jun 2023 23:44:04 +0200
Message-ID: <CAPDyKFpHin4yj=bGO6bQBmTZPTPyR8jh7FUSh22zL0J-igTbEw@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: Assert MMC_IOC_MULTI_CMD in compile time
To:     Avri Altman <avri.altman@wdc.com>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 24 May 2023 at 10:42, Avri Altman <avri.altman@wdc.com> wrote:
>
> Notify of mult-ioctl violation during preprocessing instead of bailing
> out in runtime.  Would not even allow bogus copies of mmc-utils binaries
> wondering about out there.
>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  mmc_cmds.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index df66986..a4819ab 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2113,9 +2113,7 @@ static int do_rpmb_op(int fd,
>                                           unsigned int out_cnt)
>  {
>  #ifndef MMC_IOC_MULTI_CMD
> -       fprintf(stderr, "mmc-utils has been compiled without MMC_IOC_MULTI_CMD"
> -               " support, needed by RPMB operation.\n");
> -       exit(1);
> +#error "mmc-utils needs MMC_IOC_MULTI_CMD support"
>  #else
>         int err;
>         u_int16_t rpmb_type;
> @@ -2805,9 +2803,7 @@ out:
>  int do_ffu(int nargs, char **argv)
>  {
>  #ifndef MMC_IOC_MULTI_CMD
> -       fprintf(stderr, "mmc-utils has been compiled without MMC_IOC_MULTI_CMD"
> -                       " support, needed by FFU.\n");
> -       exit(1);
> +#error "mmc-utils needs MMC_IOC_MULTI_CMD support"

May I suggest that we have one place in the file to deal with this.
Perhaps put it in the top of the file, immediately after #include"
section.

Moreover, the MMC_IOC_MULTI_CMD support was added in v4.4, so adding
that information as part of the error message would be good too I
think.

>  #else
>         int dev_fd, img_fd;
>         int sect_done = 0, retry = 3, ret = -EINVAL;

Kind regards
Uffe
