Return-Path: <SRS0=t5qd=3K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C6FC33CB6
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jan 2020 07:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A172E24125
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jan 2020 07:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OmZPzAo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgAUHio (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Jan 2020 02:38:44 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:39637 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgAUHin (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jan 2020 02:38:43 -0500
Received: by mail-il1-f194.google.com with SMTP id x5so1600979ila.6
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jan 2020 23:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PHqnHa0qnPxUWaLgWExp5NqTljru+b9BNhLxZoAb/74=;
        b=OmZPzAo9u4wNIjBaj5by2YVmcHi3W3kGgYCDYkOeX/sRuk/d6Ip2urxBgwBs+p4qXb
         e8Zs7A0p6K0Wk8LFpArEMZB0HpoKt8ZEe5W/8dqx6NDkhpINCAsFqIFoK90zejSFnGDE
         aBHqhA3HVcybPa8j6B/zbVNuB+bYrd1EieCoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PHqnHa0qnPxUWaLgWExp5NqTljru+b9BNhLxZoAb/74=;
        b=mZqBRhXlTE0HT4evLNe/5pRrEnGfAdOc6/JAdyN8v00s2R/UVkVd0hUz99D3r5q6YA
         0/yX2+eTBqsMcL+Zhdy01f2Kr937i+BOLl5dfANCcGHtFQRV5F653bwrVUmz3jk90l82
         1XJROI1D84eNCCgbzxX2evQj9pnNxQVsWLy29KtPHD4WYKWI0r6ywVawIv8WU8WBeRlj
         gIrtKRI1enIp7Plm57qvEDIEYTN67FOsHlLCdXqKgx2EW4NN730RsDlNcks5ulp5oTXk
         99/30OVNjILesjaf6jakIdGrUiwY7QQiCnBQxyWpEdCvru7jd12Q5MPPbno5bjyLRCFh
         uZ5g==
X-Gm-Message-State: APjAAAUB678x7j2c5wScXlVbLWwz283s8Q29sT5K71GlBYkF6sFojZoq
        l9t/BRKNNR7gpreHQt3YS4gb3msXx5BFISQ1/Nkmnw==
X-Google-Smtp-Source: APXvYqxEVd7Ck/bfZE7f0wlCDxyO/nhb3EbNs4Jfex0sGWrSKDd8Cp4Mi2akPZAanOm7rhHv5BOnETqZi6iUQknYyWM=
X-Received: by 2002:a92:af8e:: with SMTP id v14mr2485544ill.150.1579592322841;
 Mon, 20 Jan 2020 23:38:42 -0800 (PST)
MIME-Version: 1.0
References: <1579591258-30940-1-git-send-email-yong.mao@mediatek.com> <1579591258-30940-2-git-send-email-yong.mao@mediatek.com>
In-Reply-To: <1579591258-30940-2-git-send-email-yong.mao@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 21 Jan 2020 15:38:16 +0800
Message-ID: <CAJMQK-gZcvpQTSqM4kNsnNOXpcOfJw9u-X9uedQDM6W2soF_4w@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: fix SDIO irq issue
To:     Yong Mao <yong.mao@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>, srv_heupstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jan 21, 2020 at 7:20 AM Yong Mao <yong.mao@mediatek.com> wrote:
>
> From: yong mao <yong.mao@mediatek.com>
>
> Host controller may lost interrupt in some specail case.
> Add SDIO irq recheck mechanism to make sure all interrupts
> can be processed immediately.
>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> ---

Thanks, mt8173 need this patch for cap-sdio-irq to work.

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>


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
> +                               sdio_signal_irq(host->mmc);
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
