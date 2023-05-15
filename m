Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C763C77B7D
	for <linux-mmc@archiver.kernel.org>; Mon, 15 May 2023 13:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242351AbjEON3s (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 May 2023 09:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241356AbjEON3j (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 May 2023 09:29:39 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C801FF6
        for <linux-mmc@vger.kernel.org>; Mon, 15 May 2023 06:29:37 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-55a00da4e53so222362657b3.0
        for <linux-mmc@vger.kernel.org>; Mon, 15 May 2023 06:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684157377; x=1686749377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBBnywFAp40cBSWQciTvgFzP/RU4Qu/PWS6WSvEJl9c=;
        b=ip6XM3IgqX6aF1OsyKVAsDHhju5FVnDewzxp1m2ht+T7GXgzjubGVaBiagihtkHtN0
         lPrUzIDL53/NCo9Jirc3lyKhJA9d8e+WG9zxApKdVnOPzc7cnMRD2d/jAXayy236jrBU
         oZlTxCOZxZLHUYjcm1eZ8SMnhBqOWAsSha6kKdR2DLr5PoxtXr/CuHo+aSk82mXl0h52
         Dh7LXKVUxq0KwFVgU72H2KjhjdaXHHZAUzDz2AAH80Jn35JutPj51OXAyKGeNY+cKFPz
         UNrH/vp9Qy2Y085oNZG39w4kRV0qKAyPd5Ig7+PfgDdUW/mA2dN6NbqkQWSK0f5rUyg7
         sgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684157377; x=1686749377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBBnywFAp40cBSWQciTvgFzP/RU4Qu/PWS6WSvEJl9c=;
        b=kTxkaHIFRqqLxMZzmbM39RfCA9EdTqKCEBQ59pm8TuJlZMQZk6o+f5EK8bgGb9JF46
         V3SAqhRHCpKXeQCpgquX4w71NXdnq37t/kLNiu5k7E1hEry2CMgn88kLbt8BFkzdTEW3
         Q736Wi5nyKwo70oYsSaRwM20JzpNtu35PP8JE4eOn0djW0+1jpDewSoGCttn5NXlMmbf
         kU22BCsFp0jPJdGM14TMw06HSfOUruhY/opr4EK5wguhc21Jy694F7B0AslqpjQQCauY
         BIKHtbTuEQlAxonCkzxvfhybCMi1rshuWoqKdmZ+nwLrmPowpNbtguIukpC/QqZb6b2W
         KxVQ==
X-Gm-Message-State: AC+VfDxaRutIWJ3LJtnGmwTT+CMHRliHYa0D/+wANPJ0kWtnC20RKVuD
        b2nlLsZR3F/KPKLPB1ZOSQQSfuYjl8Foh5CO/i15Dg==
X-Google-Smtp-Source: ACHHUZ6hdHYo8UmdXtzFqFwHULdMec8OmUgQ/85DnzRl+kMcyGNyIZ3sStmv0JaR5xvEn7KrHPDLuhB/GlX0ryghZk4=
X-Received: by 2002:a81:7d02:0:b0:55a:88f0:a49c with SMTP id
 y2-20020a817d02000000b0055a88f0a49cmr34355712ywc.33.1684157377002; Mon, 15
 May 2023 06:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <e41fbab65e164b3788818bae83f0061a@hyperstone.com>
In-Reply-To: <e41fbab65e164b3788818bae83f0061a@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 May 2023 15:29:01 +0200
Message-ID: <CAPDyKFo+05WHAVQqbrL4L-ugDjyCosTSY6yensE0J8SMQ1xGAw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: block: ioctl: define rpmb reliable flag
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 5 Apr 2023 at 13:57, Christian L=C3=B6hle <CLoehle@hyperstone.com> =
wrote:
>
> Give a proper name to BIT 31 which is used as reliable write
> for RPMB.
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/core/block.c       | 5 ++++-
>  include/uapi/linux/mmc/ioctl.h | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 672ab90c4b2d..16e262ddc954 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -49,6 +49,8 @@
>
>  #include <linux/uaccess.h>
>
> +#include <uapi/linux/mmc/ioctl.h>
> +
>  #include "queue.h"
>  #include "block.h"
>  #include "core.h"
> @@ -538,7 +540,8 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card,=
 struct mmc_blk_data *md,
>                  * may be increased by a future standard. We just copy th=
e
>                  * 'Reliable Write' bit here.
>                  */
> -               sbc.arg =3D data.blocks | (idata->ic.write_flag & BIT(31)=
);
> +               sbc.arg =3D data.blocks |
> +                       (idata->ic.write_flag & MMC_RPMB_RELIABLE_WRITE);
>                 sbc.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
>                 mrq.sbc =3D &sbc;
>         }
> diff --git a/include/uapi/linux/mmc/ioctl.h b/include/uapi/linux/mmc/ioct=
l.h
> index e7401ade6822..b2ff7f5be87b 100644
> --- a/include/uapi/linux/mmc/ioctl.h
> +++ b/include/uapi/linux/mmc/ioctl.h
> @@ -11,6 +11,7 @@ struct mmc_ioc_cmd {
>          * Bit 31 selects 'Reliable Write' for RPMB.
>          */
>         int write_flag;
> +#define MMC_RPMB_RELIABLE_WRITE (1 << 31)

I am not sure this is really worth it. Keeping kernel headers for user
space in sync is a bit messy.

The define as such seems reasonable, but isn't it better to have the
define at two places then? One that's part of the MMC subsystem in the
kernel and another that's specific to the mmc-utils userspace tool?

[...]

Kind regards
Uffe
