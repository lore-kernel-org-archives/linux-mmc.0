Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC383C7EE25
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Jun 2023 22:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbjFHWTj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Jun 2023 18:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjFHWTj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2023 18:19:39 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66702113
        for <linux-mmc@vger.kernel.org>; Thu,  8 Jun 2023 15:19:36 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-ba8afcc82c0so1105713276.2
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jun 2023 15:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686262776; x=1688854776;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j/jRcCEptoZI15vQwyuL4KhtNKdIrJWJkuXvDmpbN+4=;
        b=EkfVCq9sJIsMknG6KTGNg+hUMS11bdJZBnewr8xWr8dtNkKPrFc7+hTVxpqDFDnhml
         6NhsvRxK+si1Iohm/LGBHilN7d2sZRAJWMKoEMGjlU0GAlYKfqNIIVlnUYw3hs6Xqo3X
         +BWi6y31JR09ZUKUV5Zs016hfM6rknmaRpkz+V+cyDUreIvrEVOtLEi8Qxcc0gYk3D2e
         50mQ8YUXJcOOVtFMyYnXiORGxaxNkS2YwL+2yEFYyrm1Fiyx2sN74J2IaA+M/vMeqqIe
         IhlNBz/uo7CE9w3kScX//0MTSmRhddj7TarLJ3bZ8qROdw/N9BDGxB9mqusR3Uu474VX
         YN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686262776; x=1688854776;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/jRcCEptoZI15vQwyuL4KhtNKdIrJWJkuXvDmpbN+4=;
        b=SZi/G1SZHtyRm/WPAv3L5EJ1l2QKDVYJGu+yKM23IIJZupE8T2JQyUzPOS2erdRco/
         xgPeL78Qfo4J8/e/FDG5Rpe5aP9hgOWuVp0yaCYMmxcAx4j52hYzyTMv4hIKSPHH+KFH
         RQn4yG9SsM/LDVeRO6NVv2in3WPaZJlIEtLhN2A28hHHk8UP0cSAEikpqJy5YikyytGf
         szMTM/cvRvi8LEqTZT7nTKkXtX/vgTDgpfkuhjT+meR47H20/24LBxGmkmrK9wDy3o5/
         81xBcuL93qrz/hlE4BZExTV0UVN8wiHEX0FzVt0BnM9GhQYSyCOuN3rr05GzcUXkA2Xa
         RhHA==
X-Gm-Message-State: AC+VfDw3VtUCqn6us/x5sF7ylaxT2gbHxBmuJZ4t2F3Vj0GCYdJPeVUH
        MFJSkcKWabhYqpDpPB5JgBT9Ejy6wr7pX9cE66OpIw==
X-Google-Smtp-Source: ACHHUZ62auTsiML+0ZiCG8qXdSraTRPV2M8+diFeDLEoFONXwLvluzI1lc2xcnrdHjAO2RNFkxsVMT6fvwms9Ppfqfg=
X-Received: by 2002:a0d:e607:0:b0:565:e87f:a78f with SMTP id
 p7-20020a0de607000000b00565e87fa78fmr1021175ywe.25.1686262775907; Thu, 08 Jun
 2023 15:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230530213259.1776512-1-robimarko@gmail.com>
In-Reply-To: <20230530213259.1776512-1-robimarko@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Jun 2023 00:18:59 +0200
Message-ID: <CAPDyKForsVQ_inZG9+8mWdWM6-_T6O23AiwndLg33Yh7rPYTpA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: disable TRIM on Micron MTFC4GACAJCN-1M
To:     Robert Marko <robimarko@gmail.com>,
        "Luca Porzio (lporzio)" <lporzio@micron.com>
Cc:     windhl@126.com, avri.altman@wdc.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Luca (Bean was added by Avri in another thread)

On Tue, 30 May 2023 at 23:33, Robert Marko <robimarko@gmail.com> wrote:
>
> It seems that Micron MTFC4GACAJCN-1M despite advertising TRIM support does
> not work when the core is trying to use REQ_OP_WRITE_ZEROES.
>
> We are seeing the following errors in OpenWrt under 6.1 on Qnap Qhora 301W
> that we did not previously have and tracked it down to REQ_OP_WRITE_ZEROES:
> [   18.085950] I/O error, dev loop0, sector 596 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 2
>
> Disabling TRIM makes the error go away, so lets add a quirk for this eMMC
> to disable TRIM.

Let's leave this another week or so, to allow Micron folkz to confirm
before applying.

>
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Kind regards
Uffe

> ---
>  drivers/mmc/core/quirks.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index 29b9497936df..77caa0c903f8 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -100,6 +100,13 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>         MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
>                   MMC_QUIRK_TRIM_BROKEN),
>
> +       /*
> +        * Micron MTFC4GACAJCN-1M advertises TRIM but it does not seems to
> +        * support being used to offload WRITE_ZEROES.
> +        */
> +       MMC_FIXUP("Q2J54A", CID_MANFID_MICRON, 0x014e, add_quirk_mmc,
> +                 MMC_QUIRK_TRIM_BROKEN),
> +
>         /*
>          * Some SD cards reports discard support while they don't
>          */
> --
> 2.40.1
>
