Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EEAC4332F
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Nov 2022 16:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbiKPQNu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Nov 2022 11:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbiKPQNt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2022 11:13:49 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1282263AF
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 08:13:49 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id f3so10686576pgc.2
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 08:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z1rUWutKviuABCXhXY06evbTP8Qb/JN/vOssJGqNTh0=;
        b=LoCqcxBb/0A4en6YJPudBTBwAugncPJfF4IIlmuptJxlJ3fqpW6s+jVYF7QTFC/tpz
         MgbIKcER8u/5z0q3veC4zk5Ucxe4fY0jOdf3ukThvDpy7ZrNkn1y0zk6CxNLh/h8NWQw
         cb5fhTthKZP5VLvgSjrnkYYCmMQM15HBDbfi+PqXrpr5E+kBIph24rd+iZ8AmHHR0c2p
         Ir31S94fzoErmJVIr794nJtoXRNSTG0rLvKNPL9mOb3qiaF/LPoEPDKezCt5myXTS0bm
         BmDC9yr6HbGAt1JLqg++DlYgGuepc4iGIbbHiA1t29PN8a+DvALjHVeLclVByZBAN/4S
         WmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1rUWutKviuABCXhXY06evbTP8Qb/JN/vOssJGqNTh0=;
        b=G62fQ84GxGQ07Paii86mvQwJU93L/e4Ndo6wevn3QBLfr07rrPXZ66LHKBof+sNKF1
         J9wSsB5rHUSWzIz9N0TkrueX2TgRjvH9p62+NQTOxmpJKW2rc6MMg0nqJmnDwCLorCPD
         lumedQKh/oQVye0hMOlyTnV3QmDEFBhlbsNh05n7pOK5kOFBrDL1NpvghMK7jhidFuYc
         28VJug4Rx+9aVqYdyDqDFGh/MSlGCjMb85qNQ2MDEBhgtAngIMXU4DW2lRTphzth8/TI
         i+SOmFOT7rMkem/Ms8UYxp2akA9FviNpmko0EmdJIaJkdNyRdaZTlePLYTbXUaWwQCCT
         UhTw==
X-Gm-Message-State: ANoB5plv6xWd5sRtI94nwfNyA+Mu3b1pk6dfLtyeyLDsOUwMKQh4hIQU
        dAFu/GNxNOiUsuF5r64Kr2yUw3hC0eKFoAZHrXDGZw==
X-Google-Smtp-Source: AA0mqf4KePcqF8TL0F8T8aM/T0G+4+eIDf4h7ns0C0M7LyQfmaH5u4OKNFGZsyldv/vno2rUNzTGP/NdiKCTjKDJDZw=
X-Received: by 2002:a63:121f:0:b0:442:ee11:4894 with SMTP id
 h31-20020a63121f000000b00442ee114894mr21639035pgl.595.1668615228512; Wed, 16
 Nov 2022 08:13:48 -0800 (PST)
MIME-Version: 1.0
References: <20221114093857.491695-1-peter.suti@streamunlimited.com>
In-Reply-To: <20221114093857.491695-1-peter.suti@streamunlimited.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Nov 2022 17:13:11 +0100
Message-ID: <CAPDyKFqrCCtY_A072WswEFa3Bnz7EfMp40MRYtr3G7Jbq_hbTw@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: fix SDIO interrupt handling
To:     Peter Suti <peter.suti@streamunlimited.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 14 Nov 2022 at 10:40, Peter Suti <peter.suti@streamunlimited.com> wrote:
>
> With the interrupt support introduced in commit 066ecde sometimes the
> Marvell-8987 wifi chip entered a deadlock using the marvell-sd-uapsta-8987
> vendor driver. The cause seems to be that sometimes the interrupt handler
> handles 2 IRQs and one of them disables the interrupts which are not reenabled
> when all interrupts are finished. To work around this, disable all interrupts
> when we are in the IRQ context and reenable them when the current IRQ is handled.
>
> Fixes: 066ecde ("mmc: meson-gx: add SDIO interrupt support")
>
> Signed-off-by: Peter Suti <peter.suti@streamunlimited.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 6e5ea0213b47..972024d57d1c 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -950,6 +950,10 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>         struct mmc_command *cmd;
>         u32 status, raw_status;
>         irqreturn_t ret = IRQ_NONE;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +       __meson_mmc_enable_sdio_irq(host->mmc, 0);
>
>         raw_status = readl(host->regs + SD_EMMC_STATUS);
>         status = raw_status & (IRQ_EN_MASK | IRQ_SDIO);
> @@ -958,11 +962,11 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>                 dev_dbg(host->dev,
>                         "Unexpected IRQ! irq_en 0x%08lx - status 0x%08x\n",
>                          IRQ_EN_MASK | IRQ_SDIO, raw_status);
> -               return IRQ_NONE;
> +               goto out_unlock;

This may end up re-enabling the sdio irqs, even if it was not enabled
to start with. This is probably not what we want.

>         }
>
>         if (WARN_ON(!host))
> -               return IRQ_NONE;
> +               goto out_unlock;
>
>         /* ack all raised interrupts */
>         writel(status, host->regs + SD_EMMC_STATUS);
> @@ -970,17 +974,16 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>         cmd = host->cmd;
>
>         if (status & IRQ_SDIO) {
> -               spin_lock(&host->lock);
> -               __meson_mmc_enable_sdio_irq(host->mmc, 0);
>                 sdio_signal_irq(host->mmc);
> -               spin_unlock(&host->lock);
>                 status &= ~IRQ_SDIO;
> -               if (!status)
> +               if (!status) {
> +                       spin_unlock_irqrestore(&host->lock, flags);
>                         return IRQ_HANDLED;
> +               }
>         }
>
>         if (WARN_ON(!cmd))
> -               return IRQ_NONE;
> +               goto out_unlock;
>
>         cmd->error = 0;
>         if (status & IRQ_CRC_ERR) {
> @@ -1023,6 +1026,10 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>         if (ret == IRQ_HANDLED)
>                 meson_mmc_request_done(host->mmc, cmd->mrq);
>
> +out_unlock:
> +       __meson_mmc_enable_sdio_irq(host->mmc, 1);
> +       spin_unlock_irqrestore(&host->lock, flags);
> +
>         return ret;
>  }
>

Kind regards
Uffe
