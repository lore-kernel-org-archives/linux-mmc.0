Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC80C00140
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Aug 2022 10:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbiHRKAt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 18 Aug 2022 06:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239083AbiHRKAp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Aug 2022 06:00:45 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F2E86B53
        for <linux-mmc@vger.kernel.org>; Thu, 18 Aug 2022 03:00:42 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id o2so1502363lfb.1
        for <linux-mmc@vger.kernel.org>; Thu, 18 Aug 2022 03:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=am4N2i8J0slfYNbP4Y5irNrFkp7f2vhbyyojc5oOkVc=;
        b=TPrDLt5KtyNy1pudUCCryCxIzvm07+yQhigqyWDz4pNxziJ4bI3XDV+1GyvnD+aImH
         NbHWXjQ7YzWONRC8fYSn06UnnxwpPOaDGuLZKsXhsXVJNiy9WddpHzFa+NDAnK+PtUVD
         WJks46hw71Y0FkTVmJRZHxP1q1+PC50BVW4SzPVgbBaAXzkZ09Lf3KKP3Ili8VEoElW5
         E6JBnN/Vrvo63iu10E03HCOLIake8cCHDXfVySoD63sAcRWFtTWJ69zMuYzbxYVyh5NY
         7Igb4P3OB1EnSOUh5NQrGNcGWiJXuDNCkY1/OznjhfXy5LNdczjicFZMfh4fwhCKHpYB
         fWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=am4N2i8J0slfYNbP4Y5irNrFkp7f2vhbyyojc5oOkVc=;
        b=zywdK0KeIc2auaS6LXsEh/PU1FF0ryGDiOJGAULmxCWU4DV3HG5FLgTHFv1i+IA5sb
         PGHxGBEBSmql9cachfr9PYnLn8OA55aDOnw+YxUjVmTCzLWXEr3ay10DgXH0pX9+HCS8
         MBjW/OQtb5eOgxkJLGL1l3ekINChJOn/XJvz2L3/4VbCMC/fOmQwvx4as4BjDwySsNJb
         JSclo7Qw8KwE0lRNTFX9H7MzbRcqA2bwP866viQfWK9pqfB3wOsAcgjP3kk/Oio12FpZ
         7Xy4/YM1mqb+XoSKFUx0AxI44w+JdbhM48W2ViHBjP9wsKNFkDfAapoVgNwUVOY5qSp1
         v3BQ==
X-Gm-Message-State: ACgBeo3Ctnjp674ru10B20Qpfv350+vUp7tgjI57V0shDoq+FkQc3iFX
        BlDyjVL9pcuz595recHrr813DxuEr28VKdOI/1SawQ==
X-Google-Smtp-Source: AA6agR7YRCgZymTmxcNOkeh9E+DKEKnw1L9b4lny4PIi2XqjBumJIDj+McCrb0+Vn39Fqxlpi4+oakhTqU45wl2z330=
X-Received: by 2002:ac2:5324:0:b0:48b:9643:3838 with SMTP id
 f4-20020ac25324000000b0048b96433838mr763887lfh.373.1660816840975; Thu, 18 Aug
 2022 03:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <ecc229ad-c15a-2092-6568-f92e4507553e@gmail.com>
 <CAPDyKFoi70K9SBJbdvLZbseNpO2J4s-gZt-zpHMf-40wEyecYA@mail.gmail.com> <5030c495-e027-e900-0f79-e5343aa5777c@gmail.com>
In-Reply-To: <5030c495-e027-e900-0f79-e5343aa5777c@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 18 Aug 2022 12:00:04 +0200
Message-ID: <CAPDyKFr-vyNBpwOZNp4MQXvR+G+Jt94F3rP=QXs91n0KGu2QHQ@mail.gmail.com>
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

On Thu, 18 Aug 2022 at 07:54, Heiner Kallweit <hkallweit1@gmail.com> wrote:
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
> I switched to the new API and it works for me, will submit a v2.
>
> Just one question regarding core code:
> The core defines sdio_irq_work as delayed work, but no caller sets a delay.
> Then why not use a simple workqueue and schedule_work() instead of
> queue_delayed_work()?

That should work, I think. I don't quite recall why that wasn't made
in the original solution, probably just a mistake.

One thing that I do recall, is that we may want to consider running
our own workqueue in the future, if it turns out that we are
overloading the system_wq. But so far, none have reported problems.

Kind regards
Uffe
