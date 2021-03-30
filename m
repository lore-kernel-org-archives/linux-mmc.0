Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE70EC433DB
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Mar 2021 13:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3855619C6
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Mar 2021 13:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhC3NBa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbhC3NBB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Mar 2021 09:01:01 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B160C061574
        for <linux-mmc@vger.kernel.org>; Tue, 30 Mar 2021 06:01:01 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id h136so3532471vka.7
        for <linux-mmc@vger.kernel.org>; Tue, 30 Mar 2021 06:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfaBsJ79Ie680vfPHo67i4DQqmjgy4PnknaEauClLok=;
        b=jdLobIz/yanbImfUaJ9cEZAvJBFvgCbTYX+IoNwArIx47h2MC8h5iyySayrb8wPl5u
         hX1IjbkoKVhyyOvQpoGl698eun3lpjvD5zEqZErZkNt8Es76w30XXXxXtaFr2hpxFZtj
         vvyjpLZSKCt0GTa+ym1XK31AnVCOibXCdqN1kRi2sWIyANGZ+eWi5/0Kw/p2N4taO6ic
         a8Fr6hqz3bjxHH3ZAvUnL4RntmcwIU18KwL0/058LYioWi3zubwvI73Qu6fGk1GhkUpT
         28HOzmr6JxBsmc2ayK0hZfK5KvpETgyrKFScrw4ab9uPidf2mXuxbYLLNc7IWaFk33qa
         ZZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfaBsJ79Ie680vfPHo67i4DQqmjgy4PnknaEauClLok=;
        b=Y9xBAeGR4TodW0y3M62B/FWkIbTVNiiKFrJTnaPGZCmZsKzqSP9ASw+YXW+OGFxu/M
         Itvoi9jYk65CR+l0KaI0IqLl2lYd/dRrcz0xmPMpQNisk/cekYjwg0XBPlbxvPdldhtN
         8gby+NDniXKmBOKLqXHF3UaAhXjv7drHSXr6Nx0CptnaifTso66MS5xvC/Yoh4BzhiKA
         UXVgNRWK/j/JfPgPjLewW22qm1FbzVB8WhgwXgmI3ALXywdiVPHpzOL9bj4Gg61toaXp
         0hKWi24HEMat35dDD35BF0AIjN/jGablFqjX5MskySoaK/FRQ8j1OnCOOLrqMqrbi/lx
         j3dQ==
X-Gm-Message-State: AOAM531IUwQObtVnPl7390WBY3mgIV+SGFwacczq0mmg4gTlOFk/2k0+
        ciiV4AOg07C04+sdWChK+Zsq89GVINWUyCOfPEgqsA==
X-Google-Smtp-Source: ABdhPJwbAYIyGWJFRRpFFBrjdWuyroqA6UXdzOlzydbeBljHiaFcAQE5ZukYjo2mI4UDCvAEcKxelJFggZhSrf0vXFM=
X-Received: by 2002:a1f:5504:: with SMTP id j4mr17396740vkb.7.1617109254460;
 Tue, 30 Mar 2021 06:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210208022642.7823-1-wuxy20@gmail.com> <20210208022642.7823-2-wuxy20@gmail.com>
In-Reply-To: <20210208022642.7823-2-wuxy20@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 30 Mar 2021 15:00:16 +0200
Message-ID: <CAPDyKFq2AVb7tA3W73MeCyxxsqaGrw-3nMV9_V3xue=S7O+Ppg@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] mmc-utils: fix messy code printed
To:     Avri Altman <avri.altman@wdc.com>
Cc:     Xingyu Wu <wuxy20@gmail.com>, jwerner@chromium.org,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-mmc <linux-mmc@vger.kernel.org>, wuxy20@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Avri

On Mon, 8 Feb 2021 at 03:30, Xingyu Wu <wuxy20@gmail.com> wrote:
>
> Some vendors of eMMC use different format to define the
> Firmware name. If the Firmware name uses character and if
> it exceeds the printable range of ASCII (0x20~0x7e),
> mmc-utils will print messy code. This change can fix the
> messy code issue, if the firmware name is not printable,
> print it out as hexadecimal, this change was verified on
> chromium project.
>
> Signed-off-by: Xingyu Wu <wuxy20@gmail.com>

Avri, can you please have a look at this and provide comments or your ack?

Kind regards
Uffe

> ---
>  mmc_cmds.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index fb37189..d090a24 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -29,6 +29,7 @@
>  #include <stdint.h>
>  #include <assert.h>
>  #include <linux/fs.h> /* for BLKGETSIZE */
> +#include <ctype.h>
>
>  #include "mmc.h"
>  #include "mmc_cmds.h"
> @@ -1758,8 +1759,16 @@ int do_read_extcsd(int nargs, char **argv)
>         }
>
>         if (ext_csd_rev >= 7) {
> -               printf("eMMC Firmware Version: %s\n",
> -                       (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION]);
> +               printf("eMMC Firmware Version:");
> +               for (int i = 0; i < 8; i++) {
> +                       char c = ext_csd[EXT_CSD_FIRMWARE_VERSION + i];
> +
> +                       if (isprint(c))
> +                               printf("%c", c);
> +                       else if (c != 0)
> +                               printf("\\x%02x", c);
> +               }
> +               printf("\n");
>                 printf("eMMC Life Time Estimation A [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]: 0x%02x\n",
>                         ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]);
>                 printf("eMMC Life Time Estimation B [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]: 0x%02x\n",
> --
> 2.25.1
>
