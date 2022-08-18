Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58FBC00140
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Aug 2022 10:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243901AbiHRKMk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 18 Aug 2022 06:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbiHRKMj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Aug 2022 06:12:39 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93648A0311
        for <linux-mmc@vger.kernel.org>; Thu, 18 Aug 2022 03:12:38 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x19so1504364lfq.7
        for <linux-mmc@vger.kernel.org>; Thu, 18 Aug 2022 03:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=aSqfyo1hjDQ/mL8gzg+CsbVFofxrq8E+jgC4tCXbs7U=;
        b=eCCH3OPo221NsZ7yRTe6jqXsgATPXRhQjWlp5KDhKQlDZTmgXxumsQI1w7N+Ux/SOk
         rbDTxY1wIL0w7ojseSaa0yEg6MILHr6yMt1k7oADrTz/lsS3kbhQaJn7lVmcOmydeBrI
         8ifoKEBhKQVC/XFZhNjZZ3kM0v7AP5CaeqE1FhWEF7uuwgy+IAWlzlEfMqEN7KTI4iIl
         lBq7ttLJl2ZGMLSZSJ2Fay18gnvuITrCDLXBsNNWy0hpRuEwCeIxX6buNB+irPiTP7Mg
         j7Gs+93juwnqrfu6TZZN3JwVJN9HvF2hfythqJcCFubEZfYYQrzqqxsBOfNLhVtVh0Kx
         bWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=aSqfyo1hjDQ/mL8gzg+CsbVFofxrq8E+jgC4tCXbs7U=;
        b=NJalgvVViSkglcQ0T141kOR6bAkORdzFRzV8dHDVttHJFeX27+Xc1dHHVZmj0mP+8r
         mY1g80vBOMcbg8yNRdK9lj7IzP2mfP4UyAf9NyPEnVt8MYd5E+WbhcTc3XFXbv9o7He1
         UKCtHAdL53CKY/7czRHQlru4sDm/+5CO23NW/2fC9SuqZFZlAXXZMV93ZAUa+T1Szl1n
         KIj5XGmil9W35aFiPeDE6H5NreBtajGQ2JvYEhsUJiWx5SJC+yfDyp0WFgpD08giHVhR
         auahJ+Xh9WMxVGCUBSxmloNhv6IdvgUm7fRqSWqcm74wq2vSH72o0Ir1oivD+kXV5xi8
         cqYw==
X-Gm-Message-State: ACgBeo3BSp+EmAwOoD8BpEAiiC+Ji7G5US6ns6E1AM5CDVY+aZQihx4u
        4QW/dXOMDoemN9ptAKVUY4Bzcv7doAd/XIiLa8QeNA==
X-Google-Smtp-Source: AA6agR7r8NwHcsgeAND4tQl4Cw25fRjUOUvdygbzJo6uOUi743+9TiDCWA3iNC/eGlYfTZsbxdWVa80ByX5BL2auSwQ=
X-Received: by 2002:a05:6512:2306:b0:48b:2905:21a8 with SMTP id
 o6-20020a056512230600b0048b290521a8mr817218lfu.167.1660817556914; Thu, 18 Aug
 2022 03:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <ecc229ad-c15a-2092-6568-f92e4507553e@gmail.com>
 <CAPDyKFoi70K9SBJbdvLZbseNpO2J4s-gZt-zpHMf-40wEyecYA@mail.gmail.com> <af405e40-ea58-075a-e364-b3c1c4b1cc1a@gmail.com>
In-Reply-To: <af405e40-ea58-075a-e364-b3c1c4b1cc1a@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 18 Aug 2022 12:11:59 +0200
Message-ID: <CAPDyKFoJDhjLkajBHgW3zHasvYYri77NQoDpiW-BpKgkdjtOyg@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: add SDIO interrupt support
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 18 Aug 2022 at 08:20, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 15.08.2022 20:20, Ulf Hansson wrote:
> > On Sun, 14 Aug 2022 at 23:44, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >>
> >> This adds SDIO interrupt support.
> >> Successfully tested on a S905X4-based system with a BRCM4334
> >> SDIO wifi module (brcmfmac driver).
> >>
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> ---
> >>  drivers/mmc/host/meson-gx-mmc.c | 45 +++++++++++++++++++++++++--------
> >>  1 file changed, 34 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> >> index 2f08d442e..e8d53fcdd 100644
> >> --- a/drivers/mmc/host/meson-gx-mmc.c
> >> +++ b/drivers/mmc/host/meson-gx-mmc.c
> >> @@ -41,14 +41,17 @@
> >>  #define   CLK_V2_TX_DELAY_MASK GENMASK(19, 16)
> >>  #define   CLK_V2_RX_DELAY_MASK GENMASK(23, 20)
> >>  #define   CLK_V2_ALWAYS_ON BIT(24)
> >> +#define   CLK_V2_IRQ_SDIO_SLEEP BIT(29)
> >>
> >>  #define   CLK_V3_TX_DELAY_MASK GENMASK(21, 16)
> >>  #define   CLK_V3_RX_DELAY_MASK GENMASK(27, 22)
> >>  #define   CLK_V3_ALWAYS_ON BIT(28)
> >> +#define   CLK_V3_IRQ_SDIO_SLEEP BIT(29)
> >>
> >>  #define   CLK_TX_DELAY_MASK(h)         (h->data->tx_delay_mask)
> >>  #define   CLK_RX_DELAY_MASK(h)         (h->data->rx_delay_mask)
> >>  #define   CLK_ALWAYS_ON(h)             (h->data->always_on)
> >> +#define   CLK_IRQ_SDIO_SLEEP(h)                (h->data->irq_sdio_sleep)
> >>
> >>  #define SD_EMMC_DELAY 0x4
> >>  #define SD_EMMC_ADJUST 0x8
> >> @@ -100,9 +103,6 @@
> >>  #define   IRQ_END_OF_CHAIN BIT(13)
> >>  #define   IRQ_RESP_STATUS BIT(14)
> >>  #define   IRQ_SDIO BIT(15)
> >> -#define   IRQ_EN_MASK \
> >> -       (IRQ_CRC_ERR | IRQ_TIMEOUTS | IRQ_END_OF_CHAIN | IRQ_RESP_STATUS |\
> >> -        IRQ_SDIO)
> >>
> >>  #define SD_EMMC_CMD_CFG 0x50
> >>  #define SD_EMMC_CMD_ARG 0x54
> >> @@ -136,6 +136,7 @@ struct meson_mmc_data {
> >>         unsigned int rx_delay_mask;
> >>         unsigned int always_on;
> >>         unsigned int adjust;
> >> +       unsigned int irq_sdio_sleep;
> >>  };
> >>
> >>  struct sd_emmc_desc {
> >> @@ -431,6 +432,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
> >>         clk_reg |= FIELD_PREP(CLK_CORE_PHASE_MASK, CLK_PHASE_180);
> >>         clk_reg |= FIELD_PREP(CLK_TX_PHASE_MASK, CLK_PHASE_0);
> >>         clk_reg |= FIELD_PREP(CLK_RX_PHASE_MASK, CLK_PHASE_0);
> >> +       clk_reg |= CLK_IRQ_SDIO_SLEEP(host);
> >>         writel(clk_reg, host->regs + SD_EMMC_CLOCK);
> >>
> >>         /* get the mux parents */
> >> @@ -933,7 +935,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
> >>  {
> >>         struct meson_host *host = dev_id;
> >>         struct mmc_command *cmd;
> >> -       struct mmc_data *data;
> >>         u32 irq_en, status, raw_status;
> >>         irqreturn_t ret = IRQ_NONE;
> >>
> >> @@ -948,14 +949,24 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
> >>                 return IRQ_NONE;
> >>         }
> >>
> >> -       if (WARN_ON(!host) || WARN_ON(!host->cmd))
> >> +       if (WARN_ON(!host))
> >>                 return IRQ_NONE;
> >>
> >>         /* ack all raised interrupts */
> >>         writel(status, host->regs + SD_EMMC_STATUS);
> >>
> >>         cmd = host->cmd;
> >> -       data = cmd->data;
> >> +
> >> +       if (status & IRQ_SDIO) {
> >> +               mmc_signal_sdio_irq(host->mmc);
> >
> > This is the legacy interface for supporting SDIO irqs. I am planning
> > to remove it, sooner or later.
> >
> > Please convert into using sdio_signal_irq() instead. Note that, using
> > sdio_signal_irq() means you need to implement support for
> > MMC_CAP2_SDIO_IRQ_NOTHREAD, which also includes to implement the
> > ->ack_sdio_irq() callback.
> >
> > There are other host drivers to be inspired from, but don't hesitate
> > to ask if there is something unclear.
> >
>
> One more question came to my mind:
>
> Typically host drivers disable the SDIO interrupt source before calling
> sdio_signal_irq(), and re-enable it in ->ack_sdio_irq().
>
> In sdio_run_irqs() we have the following:
>
> if (!host->sdio_irq_pending)
>         host->ops->ack_sdio_irq(host);
>
> In the middle of this code the host can't actively trigger a SDIO interrupt
> because the interrupt source is still disabled. But some other host interrupt
> could fire with also the SDIO interrupt source bit set.

It's the responsibility of the host driver to deal with this situation.

> Then the hard irq handler would disable the SDIO interrupt source, and directly
> after this ->ack_sdio_irq() would re-enable it.

The host driver shouldn't signal a new irq, before it has acked the
previous one via ->ack_sdio_irq().

> This looks racy to me and we may need some protection.
> Do you share this view or do I miss something?

The protection the mmc core provides around this, includes the general
host protection (mmc_claim|release_host()) in sdio_run_irqs() and by
using the workqueue of course.

Did that make sense?

Kind regards
Uffe
