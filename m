Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598DDE810CB
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Sep 2023 11:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjI0LGJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Sep 2023 07:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjI0LGI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Sep 2023 07:06:08 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7517A19E
        for <linux-mmc@vger.kernel.org>; Wed, 27 Sep 2023 04:06:07 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d7ecdb99b7aso12226303276.3
        for <linux-mmc@vger.kernel.org>; Wed, 27 Sep 2023 04:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695812766; x=1696417566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4fSNT6V7WDjIDyax18p7dhjCId4H1zHdkSGQb6xdmo=;
        b=fhVjNLcOIA9kGNQQN6A9+1jucgHVYzrhtOslfgyjfHrFrf6soPLEcOcglqcgqGAcb6
         X+/dLEhVzojXuZmmlstCgriBzZNRppIrPIiVHF+rgo94gggsaZzllONQbkdWoky5LF5P
         o7PDnSMwp18rdrAP8E6g8UIMKu3ndgONVZ7XOYWCIEIP5JWe+mRoYQ0rZQ6XsxWe2Pr2
         nYmrja+EZ5cpiKkpE8kWTCDidnoEmXfGMyPcl4IOYtvV+mDXQV8OJNPs3ndgMpueI6Im
         Gw9Cny/sKRSOQj8/0eI7L98kpRyfEUo6o/nCfeO93NU355KWvjU70FZgnKrtTfogrHO7
         p49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695812766; x=1696417566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4fSNT6V7WDjIDyax18p7dhjCId4H1zHdkSGQb6xdmo=;
        b=J5bSekGepANTu3OWCMlquC12XzuwnL7TWs1DUavBPr7AymTeRmTN8xW/yhktew4fsq
         PLx8/R5Zu4E+RnQbiFxV8SepIePvDs8NFUCnDhbt8T9SZemLoKDv3UmeFxzo2Mj0EhX/
         Rlr5jBaCfBBwIHvRnVLiRdWfX52UESzuaCX6Q53ODNfLC3aSNfpsqcv5wYtmpWn5mNpM
         88hU6eK7q6HoK3GtGTFyofg+6k3PDPDZZ30DP/O3yDJwR84+TmTg7JtWo1OyQ9uD91QS
         B4dRLc4gZJhJ6/VGxP6vk4RzSPOUxVnRupHuRXvKbcp+LoB0/HL2cMy87VrseMalVZIc
         z90g==
X-Gm-Message-State: AOJu0YzK9Riv0nvkbZd94bqhA05NBNm+UY8qeuh1ILeWoF2MkVcCZq29
        diqFJBsWHrWw8LcNSFGr6XNU7ot2wXyd7F+5aGXpmQ==
X-Google-Smtp-Source: AGHT+IFvROM00N3Az71+WGdQkigw1cIS1Fu8F5sCEZ40hIO1fEFuZMrpdEuiFcV836sMQBE8CuBFJ2IRljjFRtZHVaI=
X-Received: by 2002:a25:ae4c:0:b0:d88:a049:e902 with SMTP id
 g12-20020a25ae4c000000b00d88a049e902mr1549689ybe.53.1695812766501; Wed, 27
 Sep 2023 04:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230926131128.3771508-1-giulio.benetti@benettiengineering.com>
In-Reply-To: <20230926131128.3771508-1-giulio.benetti@benettiengineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Sep 2023 13:05:30 +0200
Message-ID: <CAPDyKFrxKrHXDvaOKJpkSGo6oiv9LwhHKAkfOZfbmYtcD+RBVg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc-utils: fix potential overflow
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Avri Altman <Avri.Altman@wdc.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 26 Sept 2023 at 15:11, Giulio Benetti
<giulio.benetti@benettiengineering.com> wrote:
>
> Building with _FORTIFY_SOURCE=3D3 results in:
>                  from mmc_cmds.c:20:
> In function =E2=80=98read=E2=80=99,
>     inlined from =E2=80=98do_rpmb_write_key=E2=80=99 at mmc_cmds.c:2233:8=
:
> /home/giuliobenetti/br_reproduce/a53922c5db3e605a5e81e53c034f45017ebb7db7=
/output/host/mipsel-buildroot-linux-gnu/sysroot/usr/include/bits/unistd.h:3=
8:10: error: =E2=80=98__read_alias=E2=80=99 writing 228 or more bytes into =
a region of size 32 overflows the destination [-Werror=3Dstringop-overflow=
=3D]
>    38 |   return __glibc_fortify (read, __nbytes, sizeof (char),
>       |          ^~~~~~~~~~~~~~~
> mmc_cmds.c: In function =E2=80=98do_rpmb_write_key=E2=80=99:
> mmc_cmds.c:2087:19: note: destination object =E2=80=98key_mac=E2=80=99 of=
 size 32
>  2087 |         u_int8_t  key_mac[32];
>       |                   ^~~~~~~
> /home/giuliobenetti/br_reproduce/a53922c5db3e605a5e81e53c034f45017ebb7db7=
/output/host/mipsel-buildroot-linux-gnu/sysroot/usr/include/bits/unistd.h:2=
6:16: note: in a call to function =E2=80=98__read_alias=E2=80=99 declared w=
ith attribute =E2=80=98access (write_only, 2, 3)=E2=80=99
>    26 | extern ssize_t __REDIRECT (__read_alias, (int __fd, void *__buf,
>       |                ^~~~~~~~~~
>
> To work around this let's check if the return of read() is lower than
> the nbyte requested instead of not equal.
>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>

Applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe


> ---
> V1->V2:
> * corrected commit log
> ---
>  mmc_cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 10d063d..ae7b876 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2065,7 +2065,7 @@ int do_sanitize(int nargs, char **argv)
>                         }                                                =
                               \
>                         else if (r > 0)                                  =
               \
>                                 ret +=3D r;                              =
                         \
> -               } while (r !=3D 0 && (size_t)ret !=3D nbyte);       \
> +               } while (r !=3D 0 && (size_t)ret < nbyte);        \
>                                                                          =
                               \
>                 ret;                                                     =
                       \
>         })
> --
> 2.34.1
>
