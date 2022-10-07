Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29F2C433FE
	for <linux-mmc@archiver.kernel.org>; Fri,  7 Oct 2022 07:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiJGHpi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 Oct 2022 03:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJGHpf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Oct 2022 03:45:35 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAD2B3B23;
        Fri,  7 Oct 2022 00:45:32 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id e3so1583672qts.1;
        Fri, 07 Oct 2022 00:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sqHNNpkksAJS2cbN9CjD6/f2HC0IE1NfWoJ/qa7yGPw=;
        b=bO6UYMarJh3PmhloueHaeWmkxr1Mgi8RQL/kIVYZVxx99sS6EWEUrG+RV4bf95TYnX
         wWYUi8x4gbAcLCbI4WGxrfxYAhrdw/C0cNrwJhYmZul4nT3KSuFpv1ZxQ5368YuMKBHz
         HrhuOPbsGnWhGB52Qx2AwNtt1IiZ/Uj+tHf8JtLZ/u848R7px/qOZ1ocG/tWF/xhyuQr
         F3aJxzcjziM9za5lQi2o3859tBuijzopJKhV60ZPXx7S6xXdVkLSG2eAMX87h6BS9WmN
         KHaIYjkvqt1bkyrOno0rfSkWVJXpf6E46npYxdfTPiW+V3/f7ZA0JQyig+0mX7Dq+YBO
         pS2Q==
X-Gm-Message-State: ACrzQf0ylO34mBD2klISUx6//PC3C0Qop9bui0BbtFkbogV++B+y5tsI
        g5uJqmwyzmg+cmYA5E2Zxc8poTZujWhzuw==
X-Google-Smtp-Source: AMsMyM4JJgWeCsFOeJChl6W4oU0TV8oR8zehEpEmBcnINhyLGZ/A+khYukGtXC8IJcTjk/USC3V5xA==
X-Received: by 2002:a05:622a:16:b0:35d:4325:7a54 with SMTP id x22-20020a05622a001600b0035d43257a54mr3273400qtw.101.1665128731921;
        Fri, 07 Oct 2022 00:45:31 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id r20-20020ac87ef4000000b0034035e73be0sm1557985qtc.4.2022.10.07.00.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 00:45:31 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 126so4878016ybw.3;
        Fri, 07 Oct 2022 00:45:31 -0700 (PDT)
X-Received: by 2002:a25:2d49:0:b0:6bf:87:706f with SMTP id s9-20020a252d49000000b006bf0087706fmr2923419ybe.202.1665128731040;
 Fri, 07 Oct 2022 00:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221006190452.5316-1-wsa+renesas@sang-engineering.com> <20221006190452.5316-6-wsa+renesas@sang-engineering.com>
In-Reply-To: <20221006190452.5316-6-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 7 Oct 2022 09:45:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVAP4k=O1+e5n9puRCSCr3zsA0EecQrJ7FkqQiLP4C39g@mail.gmail.com>
Message-ID: <CAMuHMdVAP4k=O1+e5n9puRCSCr3zsA0EecQrJ7FkqQiLP4C39g@mail.gmail.com>
Subject: Re: [PATCH RFC 5/6] mmc: renesas_sdhi: take DMA end interrupts into account
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Wolfram,

On Thu, Oct 6, 2022 at 9:06 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> So far, we have been relying on access_end interrupts only to mark DMA
> transfers as done implying that DMA end interrupts have occurred by then
> anyhow. On some SoCs under some conditions, this turned out to be not
> enough. So, we enable DMA interrupts as well and make sure that both
> events, DMA irq and access_end irq, have happened before finishing the
> DMA transfer.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch!

> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c

> @@ -285,12 +284,14 @@ static void
>  renesas_sdhi_internal_dmac_enable_dma(struct tmio_mmc_host *host, bool enable)
>  {
>         struct renesas_sdhi *priv = host_to_priv(host);
> +       u32 dma_irqs = INFO1_DTRANEND0 |
> +                       (priv->quirks && priv->quirks->old_info1_layout ?
> +                       INFO1_DTRANEND1_OLD : INFO1_DTRANEND1);

Perhaps it makes sense to store the dma_irqs mask in priv->quirks,
or even in priv, to simplify this code (repeated below)?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
