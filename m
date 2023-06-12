Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2EFC88CB8
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Jun 2023 14:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbjFLOU5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Jun 2023 10:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239415AbjFLOU1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Jun 2023 10:20:27 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE4F3A9B
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jun 2023 07:18:02 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-56cfce8862aso22216567b3.1
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jun 2023 07:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686579419; x=1689171419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xd4ej52fz5tHOz0Tu2r6rHvX83QZvuCMy5qicdFt3g8=;
        b=bXpzU59KX9yyYF3IpRFIYUvXOQDT0Rtn4HQ0A1fSe0m79+Vi0O/iefWiMhhiUokGBN
         TX8BGksnigSHrpU6Xk7YZSPp4ipKDTCt6pgjyfz3+9ck1VX2rqezNk6fE0NSS9T0sVPu
         VRy6ubSSFxSdbqDSDwc/DFtY40BhcQH3QBYHmdXS0gl3eMKAoLMr9ubOKvApSluZBPRX
         iZdrjy6m59Yw6ZNvZVHONfeu2AZqdbS8U75+aLTuteru3tuNdZA0cHJy6JWu1aRgGyD6
         wbfJxHiHoJn4ayqjpxblqdosCesJB/I3m8g+tw8Z45mn5fNGXBAqP+FVeY9VOVgEi21F
         FrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579419; x=1689171419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xd4ej52fz5tHOz0Tu2r6rHvX83QZvuCMy5qicdFt3g8=;
        b=W4EHq7Mxv8pMEMwXVtcjPlORUuOdc6L5csXdmbSpM9GiCiCOPd+IIzE7kWZgl9PI6T
         Qpih+FJeDnUsY1cIUzeJRenviKL1qcsS+bE7C3RZnzMyeuAncD9/99RSJ7OsP2Tn01Wg
         bRsZGKeoVXF1JjXGwdpEr49sKipVFc5k3g+qPPQV7Exe8bvUAtvToiG+xhhtvUGjxgnN
         0fjhzW/uDqDIKPSBXKU5g6LnCtquSt3eVVlJNRiVrl7v2qveyhH1JBpTRJzOm515/gEE
         LeVOC+2Fvt9uZ0ay/BKRI4XwHz4cD1qcBhoUcILiKPdvCzqMbiPVcVBy/mp8xmupz9dD
         m1mg==
X-Gm-Message-State: AC+VfDx02SpEEHmJKsKhOyhwKaokJeO1bLD1AezBao751+AhZSho+lm2
        O5TjWrQ5mZqzBgmD//mZXX46my8+h76FKFE+AvijRaHN2IemHRJB
X-Google-Smtp-Source: ACHHUZ4AqsS9LkY9waaI57crFjubk8bELBxu1KgZO9jdfcj2HPyWE4lRx3uFSH3LRqfYMB5hgr4N4bUMgjKIFZ58/CQ=
X-Received: by 2002:a25:160a:0:b0:ba7:c03c:518d with SMTP id
 10-20020a25160a000000b00ba7c03c518dmr7618205ybw.63.1686579419253; Mon, 12 Jun
 2023 07:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230608194519.10665-1-s.shtylyov@omp.ru>
In-Reply-To: <20230608194519.10665-1-s.shtylyov@omp.ru>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Jun 2023 16:16:23 +0200
Message-ID: <CAPDyKFqHXqs7rcJQgBzGh_k-9023vopjcxowMLaHsFd7TykS5w@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] Fix deferred probing in the MMC/SD drivers
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 8 Jun 2023 at 21:45, Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>
> Here are 12 patches against the 'fixes' branch of Ulf Hansson's 'mmc.git' repo.
> The affected MMC/SD drivers call platform_get_irq[_byname]() but override its
> result in case of error which prevents the deferred probing from working. Some
> of these patches logically depend on commit ce753ad1549c ("platform: finally
> disallow IRQ0 in platform_get_irq() and its ilk")...

The above patch is available in v5.19. If someone wants any of the
patches in $subject series to be backported to an older kernel
version, the commit above needs backporting too.

Therefore I am adding the tag below for the series and leaving
anything that older to be managed separately.

Cc: stable@vger.kernel.org # v5.19+

>
> Sergey Shtylyov (12):
>   mmc: bcm2835: fix deferred probing
>   mmc: meson-gx: fix deferred probing
>   mmc: mtk-sd: fix deferred probing
>   mmc: mvsdio: fix deferred probing
>   mmc: omap: fix deferred probing
>   mmc: omap_hsmmc: fix deferred probing
>   mmc: owl: fix deferred probing
>   mmc: sdhci-acpi: fix deferred probing
>   mmc: sdhci-spear: fix deferred probing
>   mmc: sh_mmcif: fix deferred probing
>   mmc: sunxi: fix deferred probing
>   mmc: usdhi60rol0: fix deferred probing
>
>  drivers/mmc/host/bcm2835.c      | 4 ++--
>  drivers/mmc/host/meson-gx-mmc.c | 4 ++--
>  drivers/mmc/host/mtk-sd.c       | 2 +-
>  drivers/mmc/host/mvsdio.c       | 2 +-
>  drivers/mmc/host/omap.c         | 2 +-
>  drivers/mmc/host/omap_hsmmc.c   | 6 ++++--
>  drivers/mmc/host/owl-mmc.c      | 2 +-
>  drivers/mmc/host/sdhci-acpi.c   | 2 +-
>  drivers/mmc/host/sdhci-spear.c  | 4 ++--
>  drivers/mmc/host/sh_mmcif.c     | 2 +-
>  drivers/mmc/host/sunxi-mmc.c    | 4 ++--
>  drivers/mmc/host/usdhi6rol0.c   | 6 ++++--
>  12 files changed, 22 insertions(+), 18 deletions(-)
>

Applied for fixes, thanks!

Kind regards
Uffe
