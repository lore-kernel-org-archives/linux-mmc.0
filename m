Return-Path: <SRS0=5iJr=5M=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F1DC43331
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Mar 2020 12:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2122082D
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Mar 2020 12:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V92IBXwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgC0M1t (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 27 Mar 2020 08:27:49 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39190 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgC0M1s (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Mar 2020 08:27:48 -0400
Received: by mail-ua1-f67.google.com with SMTP id o16so3414133uap.6
        for <linux-mmc@vger.kernel.org>; Fri, 27 Mar 2020 05:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yDbXsSaJLox3BEV/lGpLVToJP0inNIMb6h0DXnz5vRM=;
        b=V92IBXwmXN28A4jtMZdCWpv4Sv+iUOWOsJZSKw1vOK/qmoikLnv/lKYofQ5/9pVobO
         cTFxVWR9O34csQY6icAq2qd7sPEyLQs/loQiOdhm8goyYgpPN6QuhBL6fGEZ0Z6vLRLE
         dJ3yo0aKZqQK457sdAMrob7wUpHIhG8eLt/OGfDRy5FLAs6MXQ6PaPgHi7JKja+HVuUG
         mJfNanekq0IUpLncKOsLTRZOA/PqlkdfOxfiX22ghJRN0DZOwx7ZcsSHYqtQ9T6MV6eq
         jWJlQPkwqBy3NbC4dbUjQGIsOSX3XPuKgUNfKaCLMBR8DaWaRlQOa0kwnKiS+09po1Cb
         g6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDbXsSaJLox3BEV/lGpLVToJP0inNIMb6h0DXnz5vRM=;
        b=PQkxiSeLZY366WTMOoyufkHwOcW7/9Jo70C+RumwhNXtfFb1vgnO2F2Pp3divFOJng
         NxQv8mf6aVkWNdcaSDIniTAHzwOp1LjtQW9mYifFtlURx11otOt81TnnbMMEysFdQEF+
         1ldsLyj2r2P9XE/exHjbPdxPHA0DMmghdr5Uy2wbBKSz+fCUSVsu/scJSGD5gVVlUaB9
         FyDXeH5zWFDRPcqpedMMzjipuViuRvDaXw925x1EewDJJIkE8SsAnaPx2JbIPdXtPbPL
         3iNSlJOH70LKAONPlEMt5pXNjTFdYpnEyQaR/nPXulmTZ1jDc5fcwzBi/c1xp3DJ37LX
         lwmg==
X-Gm-Message-State: ANhLgQ0KX5iWpfQipHg/ld9lTBwR2xRMWt+54LonplDajgFBrr/7+gKx
        BRyUiGmNKfDzXMaslIQ/jpjrOsfObRJIc1RZbwltMQ==
X-Google-Smtp-Source: ADFU+vtKncJRqT4v3CpcXsHUWeMGn4VsoJj5VSwNTesK4hWsMiUrYYid02dt45zjVf50VayDFa8pUjpgDB7ygFBbcF8=
X-Received: by 2002:ab0:718b:: with SMTP id l11mr11488731uao.100.1585312067388;
 Fri, 27 Mar 2020 05:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <1585299097-6897-1-git-send-email-yong.mao@mediatek.com> <1585299097-6897-2-git-send-email-yong.mao@mediatek.com>
In-Reply-To: <1585299097-6897-2-git-send-email-yong.mao@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 27 Mar 2020 13:27:11 +0100
Message-ID: <CAPDyKFqpEAooQ3f=YC5uVxrbVc2o1U-kC297rTOm_-LvDsRp0g@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mediatek: fix SDIO irq issue
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

On Fri, 27 Mar 2020 at 09:51, Yong Mao <yong.mao@mediatek.com> wrote:
>
> From: yong mao <yong.mao@mediatek.com>
>
> SDIO irq is not triggered by low level, but by falling edge in our
> previous IC. This mechanism only have one chance to catch the SDIO irq
> if a SDIO irq comes within the multiple block transmission. This SDIO
> irq may be easily lost, because falling edge appears only once within 2
> clock after data transmission is completed.
>
> SDIO irq recheck mechanism will make sure all irqs can be
> processed correctly.
>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 7726dcf..b221c02 100644
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
> @@ -591,6 +601,7 @@ static void msdc_reset_hw(struct msdc_host *host)
>
>  static void msdc_cmd_next(struct msdc_host *host,
>                 struct mmc_request *mrq, struct mmc_command *cmd);
> +static void __msdc_enable_sdio_irq(struct msdc_host *host, int enb);
>
>  static const u32 cmd_ints_mask = MSDC_INTEN_CMDRDY | MSDC_INTEN_RSPCRCERR |
>                         MSDC_INTEN_CMDTMO | MSDC_INTEN_ACMDRDY |
> @@ -1007,6 +1018,32 @@ static int msdc_auto_cmd_done(struct msdc_host *host, int events,
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
> +       if (host->mmc->caps & MMC_CAP_SDIO_IRQ) {
> +               reg_inten = readl(host->base + MSDC_INTEN);
> +               if (reg_inten & MSDC_INTEN_SDIOIRQ) {
> +                       reg_int = readl(host->base + MSDC_INT);
> +                       reg_ps = readl(host->base + MSDC_PS);
> +                       if (!(reg_int & MSDC_INT_SDIOIRQ ||
> +                             reg_ps & MSDC_PS_DATA1)) {
> +                               __msdc_enable_sdio_irq(host, 0);
> +                               sdio_signal_irq(host->mmc);
> +                       }
> +               }
> +       }
> +}
> +
>  static void msdc_track_cmd_data(struct msdc_host *host,
>                                 struct mmc_command *cmd, struct mmc_data *data)
>  {
> @@ -1035,6 +1072,8 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
>         if (host->error)
>                 msdc_reset_hw(host);
>         mmc_request_done(host->mmc, mrq);
> +       if (host->dev_comp->recheck_sdio_irq)
> +               msdc_recheck_sdio_irq(host);
>  }
>
>  /* returns true if command is fully handled; returns false otherwise */
> @@ -1393,6 +1432,8 @@ static void __msdc_enable_sdio_irq(struct msdc_host *host, int enb)
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
