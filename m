Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A716C77B70
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Apr 2023 08:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjDQIar (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Apr 2023 04:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjDQIaq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Apr 2023 04:30:46 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD6A172C
        for <linux-mmc@vger.kernel.org>; Mon, 17 Apr 2023 01:30:42 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-54fb615ac3dso196275177b3.2
        for <linux-mmc@vger.kernel.org>; Mon, 17 Apr 2023 01:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681720242; x=1684312242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dB61uBZ/szhozbFNgrcOqtBKFc3f/HhJaKfbQUHWQ9s=;
        b=zRr3+/o74WKCpY9o+ifeZD2/hNy4GMPpICpulNJwJYWJP3H5EsHOvWr9GHeabcMSlJ
         wdWeyJBRWf6O+bo4ktYaoz28EbNU81vpxk2pj4A2DkVatkmhfI5sMdnkXo30ycNLGR37
         LCrj781vt7UncBYlpGJOZ4fmLrX6gaU3JgbSPE63gkx8NHEZ2NOciqv/pCdQ0GERSRug
         V+it14C37WwtYaAaNReKWXIB6+m0D6N1VWkaZ31cl4GqqxOPZqn0+84dz+B6IOCsoljU
         Uy6wQseLTsejSP1ekJ5I9/uHTpcyLpLzbs63zBtitwR9Caj++mpwW4cALGWMqUDXwn3E
         nC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681720242; x=1684312242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dB61uBZ/szhozbFNgrcOqtBKFc3f/HhJaKfbQUHWQ9s=;
        b=OCUPvit6//CPkmvXDmtXVaTBZZ2keu8XnbHc0+xLhGerlYlL7FDz6LcBnx4bXvEXX/
         4FcWYWOokojZ8ySDwOfsbcloEOaW85O+iojngBGSj2pSTQ9wbcvp+UQUXmI9+qp9dmJ+
         8i3IS8zdXJrsteRQTE6QmaMw7Fi89yGWZtSVk38tlvJqgLaDDoDDKGpmZKQO0QHwJ/H1
         impdaOnOGAA/aD//cqcgggJhjwlo3GXLJNKXC1otW7KyBldfZ+xPxCKLURa6x9Noxrcw
         7UEkVB9vM1iVB554GekRXs7NWEyC1cd6DQK4cS1xaa1giiKmd0sEZajxC7skO7d1cuZH
         7Z4Q==
X-Gm-Message-State: AAQBX9f/CEmCDY8omuVsrQmRFI68+gyyYxNusY0tFfrg43ZRkuBj0ea5
        UJndCb/2IUWh0JF9hCPiRwO/vhMJU87wwRS8d210XrG910CN2C95rQw=
X-Google-Smtp-Source: AKy350bA9qMBsY0gOtJ+x2AvhaammGe6TQAgLfC2r9A6rzH5jcsMw1E9lUCqDbfGcN6pfJfZ9438d7n646+o+q6A5vw=
X-Received: by 2002:a81:b71b:0:b0:54f:97dd:633 with SMTP id
 v27-20020a81b71b000000b0054f97dd0633mr8905401ywh.4.1681720241989; Mon, 17 Apr
 2023 01:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <28623fa7390242e9b003a44016c0235f@hyperstone.com>
In-Reply-To: <28623fa7390242e9b003a44016c0235f@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Apr 2023 10:30:05 +0200
Message-ID: <CAPDyKFpBGwbukxzhkd9ckfQeibPW5hBEhf11YujscvQ9ZuZYNA@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: Change version string to git hash
To:     Christian Loehle <CLoehle@hyperstone.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 12 Apr 2023 at 17:04, Christian Loehle <CLoehle@hyperstone.com> wrote:
>
> Since mmc-utils versioning has always been 0.1 and changes are not
> made frequently and formal releases do not happen, packaged versions
> are just pulled from git anyway, using the git hash for version is
> probably the best idea for now.
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Seems reasonable to me, applied, thanks!

Kind regards
Uffe

> ---
>  Makefile | 3 ++-
>  mmc.c    | 6 ++----
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index aa27ff2..d8d59a4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,6 +1,7 @@
>  CC ?= gcc
> +GIT_VERSION := "$(shell git describe --abbrev=6 --always --tags)"
>  AM_CFLAGS = -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=2
> -CFLAGS ?= -g -O2
> +CFLAGS ?= -g -O2 -DVERSION=\"$(GIT_VERSION)\"
>  objects = \
>         mmc.o \
>         mmc_cmds.o \
> diff --git a/mmc.c b/mmc.c
> index b9aa478..795b4e3 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -26,8 +26,6 @@
>
>  #include "mmc_cmds.h"
>
> -#define MMC_VERSION    "0.1"
> -
>  #define BASIC_HELP 0
>  #define ADVANCED_HELP 1
>
> @@ -319,7 +317,7 @@ static void help(char *np)
>
>         printf("\n\t%s help|--help|-h\n\t\tShow the help.\n",np);
>         printf("\n\t%s <cmd> --help\n\t\tShow detailed help for a command or subset of commands.\n",np);
> -       printf("\n%s\n", MMC_VERSION);
> +       printf("\n%s\n", VERSION);
>  }
>
>  static int split_command(char *cmd, char ***commands)
> @@ -500,7 +498,7 @@ static int parse_args(int argc, char **argv,
>         }
>
>         if(helprequested){
> -               printf("\n%s\n", MMC_VERSION);
> +               printf("\n%s\n", VERSION);
>                 return 0;
>         }
>
> --
> 2.37.3
>
>
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
