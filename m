Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CFDEE0205
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Sep 2023 13:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbjINNDj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Sep 2023 09:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238585AbjINNDh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Sep 2023 09:03:37 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E801FDF
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 06:03:33 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d77ad095f13so965066276.2
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 06:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694696612; x=1695301412; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OGBNv/WCy7mlfSU/rquHrfUjucCsufeS4fxpOpJpRLo=;
        b=Fm5n8fCEQoCvtP/ZiYEwftfaaRFRcsT1NGihjTABbR0yJareDaZkWKN6WwdbBFHDld
         mY/zwWAf7Lu/Cfa+q6+zFjinzDKHNpEvzjG2Bqc+qdBBLIOxABJiFShj+ZB3VC+wjqkY
         njFAeq7MYc4AmDaRz3s+SPx9kV5+Y7mU+WjvcCwVA5iZSe+66l+NSegMK5lfRktFcc/9
         KbmQnX4aMD25AWv1NtwOq6S8v4+F6bb7Zfcdis3FH8x46+mQdvYLZbUn59wVRc4xsM8l
         YMVYyWJkTbN+1pFJAZq3+CMZ0IJYcdPM+TkQv88QR1Evh01uz+YWoB32Fp+rc7x4eMt9
         DkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694696612; x=1695301412;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGBNv/WCy7mlfSU/rquHrfUjucCsufeS4fxpOpJpRLo=;
        b=OdBCrUsCF7vX1hhC4cADNFvvXWYE9VrprIgb/X/uKjm1qPjwkMteVLTlEHLuU4lrvg
         mCBxk6rb7ecDOZOhgCPrL74UtgnX2mXSlzJRtYE3iGoZsYtIwGgJisTxCFmfXwD4HFYF
         P/7//eR5UHdGu5Zjw6zOywWvFwZz46lKBZSpOzRlwBGSov83swzwJXpZZyta8TnDICrO
         YKMeixhspgdh2mvsX4/7DBIDRryvpsWbTgNmH8gYgXymrX4e7lQ+MNcllTYxyIs2m7Li
         yahlVfyjARpLZ5CBOjzpqzchRt6zYhetDZ3pp0HeRhdR5jBIfB6VcfskhSrH1CqbWo9l
         m5mg==
X-Gm-Message-State: AOJu0Yw3CKo2WJ5aUG2X8cr9X7o5PG/p4XTRREgtSS85Btyi1RV5+ixh
        27vO/QR3tLpcg9Y/5skLwQPU6hhiax9A5coGkyQ7zA==
X-Google-Smtp-Source: AGHT+IHPMzUI/ot3DCoZ/iT1g4muQjpo9ZWKdRV8KZQpwQK3nU4X4TeTU3Js/qM/a3ER6+dKUgmedezyGL+8aAKDGC4=
X-Received: by 2002:a25:1545:0:b0:d81:6116:ac2d with SMTP id
 66-20020a251545000000b00d816116ac2dmr4087422ybv.59.1694696612626; Thu, 14 Sep
 2023 06:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230901122701.318082-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230901122701.318082-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Sep 2023 15:02:56 +0200
Message-ID: <CAPDyKFrmQs76oDbDrza=CKsp0VLHj8xTn9smUwvpXFbKaCZpAA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: host: Kconfig: Make MMC_SDHI_INTERNAL_DMAC config
 option dependant on ARCH_RENESAS
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 1 Sept 2023 at 14:27, Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> MMC_SDHI_INTERNAL_DMAC config option has dependency on ARM64 and
> R7S9210/R8A77470 this dependency will keep growing for future SoCs for
> varying architectures. So to simplify this configuration make
> MMC_SDHI_INTERNAL_DMAC solely depend on ARCH_RENESAS, as all Renesas
> SoCs inherently depend on the ARCH_RENESAS config option.
>
> This allows selecting MMC_SDHI_INTERNAL_DMAC config option for RZ/Five SoC
> which is based on RISC-V architecture.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v1-v2
> * Add dependency on ARCH_RENESAS instead of RISCV
>
> v1:
> https://lore.kernel.org/linux-renesas-soc/20230901113703.314667-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> ---
>  drivers/mmc/host/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 554e67103c1a..2e8476db2381 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -677,9 +677,9 @@ config MMC_SDHI_SYS_DMAC
>
>  config MMC_SDHI_INTERNAL_DMAC
>         tristate "DMA for SDHI SD/SDIO controllers using on-chip bus mastering"
> -       depends on ARM64 || ARCH_R7S9210 || ARCH_R8A77470 || COMPILE_TEST
> +       depends on ARCH_RENESAS || COMPILE_TEST
>         depends on MMC_SDHI
> -       default MMC_SDHI if (ARM64 || ARCH_R7S9210 || ARCH_R8A77470)
> +       default MMC_SDHI if ARCH_RENESAS
>         help
>           This provides DMA support for SDHI SD/SDIO controllers
>           using on-chip bus mastering. This supports the controllers
> --
> 2.34.1
>
