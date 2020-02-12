Return-Path: <SRS0=ptsr=4A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59032C352A4
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Feb 2020 15:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267C62082F
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Feb 2020 15:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I9DMVVFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgBLPaH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:30:07 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44059 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgBLPaG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Feb 2020 10:30:06 -0500
Received: by mail-ua1-f65.google.com with SMTP id a33so993177uad.11
        for <linux-mmc@vger.kernel.org>; Wed, 12 Feb 2020 07:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YdB4m3YVt1/fgLUY06qzQkSNebhsTU31mLLemG8LZmc=;
        b=I9DMVVFjBIe+z3v1QY+Sc58CdPkSiZPh7ko0p+3zm8ZuigBNkLq/4VEWRbVVmRD26d
         4QpsBOP8CSBylfyv9T9cE/7yc698GtUaseXwihqvSg92Zmwn36g5pEnGaH7x148lW3MW
         qOxUdB21C35LOWLWtojRGSzwSTlE4rwL9cTVHF2MfEMMUzSL/C9DrZTsmez5SZVt2jTH
         yZwCVtPhpy6YB6HZwUlWwQup94bl4rwKW3rGDWVO+omdx9APi9AKvY7b49TMOjfGrazx
         DkV/PkO841l46AB27n1JqHa5fQ6z+cR+sYeqcEEvIHLIpq2DUCgRdjydoulLz95mov3C
         qTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YdB4m3YVt1/fgLUY06qzQkSNebhsTU31mLLemG8LZmc=;
        b=SJCJ5jBaZlONL0+O33Zmtz8TvGFOjdOLTL6mDnyyNjIetkrszdIJ+uI7WX6ab338/I
         DZ2idfywEdmRM94WzsReDu4EsNvstAJSO6Z+kE4r2UqvgFvHtLyLPkXAG71Ndx58mE4+
         L/9QxHlalOlXM+ZTT7L1T7IZJipRdsWZXn7XC9POqq2RCbYu9c+T1/OP6MsuEh2yYYVn
         CFZ0t6A/kD1bXdxNnDdSC5SbTz56wcv/SAUVzVEbwFuWBhvCarXIXai4ICu6IA8tYDWD
         0PRik4QztIr5U4UVuS7Vqsq9++Wx/AbrhGLGL/jtjv87+qNoqG2xXZKXfuAL/is6o+Rc
         9OcA==
X-Gm-Message-State: APjAAAW+08GpjmXCq9gfIOO0Ma5CuPc+jj6yB7kAMvXrQtmOX89G8rxR
        0N8AkjuBwMyNGC9OnQ6tjIlvI1dVWL6A39Rm6MAZCA==
X-Google-Smtp-Source: APXvYqziFyeB60oVPm+ZwS4K8wVf+b/AOYtF0dmdo9RMhOEDdweGI8FdVnSG2tXn5RFSmjr7TEc5nAfAwV2+nde15lA=
X-Received: by 2002:ab0:e16:: with SMTP id g22mr4862219uak.129.1581521404938;
 Wed, 12 Feb 2020 07:30:04 -0800 (PST)
MIME-Version: 1.0
References: <1579591258-30940-1-git-send-email-yong.mao@mediatek.com> <1579591258-30940-2-git-send-email-yong.mao@mediatek.com>
In-Reply-To: <1579591258-30940-2-git-send-email-yong.mao@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 12 Feb 2020 16:29:28 +0100
Message-ID: <CAPDyKFqh17yRi2wQcu-UxdskRHKwXWhirn8gjCH5qx3i2n=EbQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: fix SDIO irq issue
To:     Yong Mao <yong.mao@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 21 Jan 2020 at 08:21, Yong Mao <yong.mao@mediatek.com> wrote:
>
> From: yong mao <yong.mao@mediatek.com>
>
> Host controller may lost interrupt in some specail case.

Please explain a bit more about the special cases. When and how often
does it happen?

> Add SDIO irq recheck mechanism to make sure all interrupts
> can be processed immediately.
>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 7726dcf..18a1b86 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -128,6 +128,7 @@
>  #define MSDC_PS_CDSTS           (0x1 << 1)     /* R  */
>  #define MSDC_PS_CDDEBOUNCE      (0xf << 12)    /* RW */
>  #define MSDC_PS_DAT             (0xff << 16)   /* R  */
> +#define MSDC_PS_DATA1           (0x1 << 17)    /* R  */
>  #define MSDC_PS_CMD             (0x1 << 24)    /* R  */
>  #define MSDC_PS_WP              (0x1 << 31)    /* R  */
>
> @@ -361,6 +362,7 @@ struct msdc_save_para {
>
>  struct mtk_mmc_compatible {
>         u8 clk_div_bits;
> +       bool recheck_sdio_irq;
>         bool hs400_tune; /* only used for MT8173 */
>         u32 pad_tune_reg;
>         bool async_fifo;
> @@ -436,6 +438,7 @@ struct msdc_host {
>
>  static const struct mtk_mmc_compatible mt8135_compat = {
>         .clk_div_bits = 8,
> +       .recheck_sdio_irq = false,
>         .hs400_tune = false,
>         .pad_tune_reg = MSDC_PAD_TUNE,
>         .async_fifo = false,
> @@ -448,6 +451,7 @@ struct msdc_host {
>
>  static const struct mtk_mmc_compatible mt8173_compat = {
>         .clk_div_bits = 8,
> +       .recheck_sdio_irq = true,
>         .hs400_tune = true,
>         .pad_tune_reg = MSDC_PAD_TUNE,
>         .async_fifo = false,
> @@ -460,6 +464,7 @@ struct msdc_host {
>
>  static const struct mtk_mmc_compatible mt8183_compat = {
>         .clk_div_bits = 12,
> +       .recheck_sdio_irq = false,
>         .hs400_tune = false,
>         .pad_tune_reg = MSDC_PAD_TUNE0,
>         .async_fifo = true,
> @@ -472,6 +477,7 @@ struct msdc_host {
>
>  static const struct mtk_mmc_compatible mt2701_compat = {
>         .clk_div_bits = 12,
> +       .recheck_sdio_irq = false,
>         .hs400_tune = false,
>         .pad_tune_reg = MSDC_PAD_TUNE0,
>         .async_fifo = true,
> @@ -484,6 +490,7 @@ struct msdc_host {
>
>  static const struct mtk_mmc_compatible mt2712_compat = {
>         .clk_div_bits = 12,
> +       .recheck_sdio_irq = false,
>         .hs400_tune = false,
>         .pad_tune_reg = MSDC_PAD_TUNE0,
>         .async_fifo = true,
> @@ -496,6 +503,7 @@ struct msdc_host {
>
>  static const struct mtk_mmc_compatible mt7622_compat = {
>         .clk_div_bits = 12,
> +       .recheck_sdio_irq = false,
>         .hs400_tune = false,
>         .pad_tune_reg = MSDC_PAD_TUNE0,
>         .async_fifo = true,
> @@ -508,6 +516,7 @@ struct msdc_host {
>
>  static const struct mtk_mmc_compatible mt8516_compat = {
>         .clk_div_bits = 12,
> +       .recheck_sdio_irq = false,
>         .hs400_tune = false,
>         .pad_tune_reg = MSDC_PAD_TUNE0,
>         .async_fifo = true,
> @@ -518,6 +527,7 @@ struct msdc_host {
>
>  static const struct mtk_mmc_compatible mt7620_compat = {
>         .clk_div_bits = 8,
> +       .recheck_sdio_irq = false,
>         .hs400_tune = false,
>         .pad_tune_reg = MSDC_PAD_TUNE,
>         .async_fifo = false,
> @@ -1007,6 +1017,30 @@ static int msdc_auto_cmd_done(struct msdc_host *host, int events,
>         return cmd->error;
>  }
>
> +/**
> + * msdc_recheck_sdio_irq - recheck whether the SDIO irq is lost
> + *
> + * Host controller may lost interrupt in some special case.
> + * Add SDIO irq recheck mechanism to make sure all interrupts
> + * can be processed immediately
> + *
> + */
> +static void msdc_recheck_sdio_irq(struct msdc_host *host)
> +{
> +       u32 reg_int, reg_inten, reg_ps;
> +
> +       if ((host->mmc->caps & MMC_CAP_SDIO_IRQ)) {
> +               reg_inten = readl(host->base + MSDC_INTEN);
> +               if (reg_inten & MSDC_INTEN_SDIOIRQ) {
> +                       reg_int = readl(host->base + MSDC_INT);
> +                       reg_ps = readl(host->base + MSDC_PS);
> +                       if (!((reg_int & MSDC_INT_SDIOIRQ) ||
> +                             (reg_ps & MSDC_PS_DATA1)))

This looks a bit unnecessary complicated and there are more
parentheses than needed.

I am also wondering about the logic. This looks like you want to
signal an SDIO IRQ when both MSDC_INT_SDIOIRQ and MSDC_PS_DATA1 are
cleared. Is that really correct?

Moreover, this means that you will be polling the registers for each
every request you complete. This sounds quite inefficient and I wonder
if it can be done more seldom, perhaps via a timer event instead. And,
what if there is no request for a while, then this means the re-check
doesn't gets to run. Could that be a problem?

> +                               sdio_signal_irq(host->mmc);

Before calling sdio_signal_irq(), the SDIO IRQ needs to be temporarily
disabled. In other words, looks like you should be calling
__msdc_enable_sdio_irq(0) from here as well.

> +               }
> +       }
> +}
> +
>  static void msdc_track_cmd_data(struct msdc_host *host,
>                                 struct mmc_command *cmd, struct mmc_data *data)
>  {
> @@ -1035,6 +1069,8 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
>         if (host->error)
>                 msdc_reset_hw(host);
>         mmc_request_done(host->mmc, mrq);
> +       if (host->dev_comp->recheck_sdio_irq)
> +               msdc_recheck_sdio_irq(host);
>  }
>
>  /* returns true if command is fully handled; returns false otherwise */
> @@ -1393,6 +1429,8 @@ static void __msdc_enable_sdio_irq(struct msdc_host *host, int enb)
>         if (enb) {
>                 sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
>                 sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> +               if (host->dev_comp->recheck_sdio_irq)
> +                       msdc_recheck_sdio_irq(host);
>         } else {
>                 sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
>                 sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> --
> 1.9.1

Kind regards
Uffe
