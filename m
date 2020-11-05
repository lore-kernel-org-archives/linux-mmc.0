Return-Path: <SRS0=4qKy=EL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BDDC4742C
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Nov 2020 13:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A647D206DB
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Nov 2020 13:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SraoIp6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbgKEM7x (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 07:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730940AbgKEM7x (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 07:59:53 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A755C0613D4
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 04:59:52 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id q20so479631uar.7
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 04:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WT1MvSlztZlc1FZ5Asxkhe1NYZezAK9LnhK1vwgJmXo=;
        b=SraoIp6GVcQVkv/M8F+b5/a1obllwuyTigrdn6SG8CQ4oTWM2I3D4/w1z1XoKddci4
         Mj8+kvwiLLFykFKvzijWne63PuKBXEVHEV2dQirGZeDWNKUvAgYdG8GeKEVFzDI5xGOJ
         lE+WkS0HVDlLyyt4ybARSfIuMoBZJvZIyoK74/GNeYLjQo3KEMHWoHUU53XptSRhP7Us
         EYG5C3AXS6ncwALJF7yGYpeZozD9WPSPCunnttAtiiv6xJ9eUNK6uEkvfrWvqnjNFtK7
         kdB+BylGReXaV6UsK0XguHSE7tIsnM7HZlejUmbhxTcgizc/StgRSSWjn/ZuVL0e29Or
         i0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WT1MvSlztZlc1FZ5Asxkhe1NYZezAK9LnhK1vwgJmXo=;
        b=TjhNfKV8g4VxxOQ/HjXOvllTFFOgz1Jzk/Fnaztpr9uvWTd0tyJmTffq9I+xzs5E7a
         ES264XhGvSQUK/+FrYPIaMehYMU2dHUeZUc4432jrvmRMMJZNmprZmwZioZJv8b5VdpD
         LbAm52P5tfs3sPYsyvxOcHEl2UCoyzYz7pTCDWj3W/F/X4zPp8KNqR53hm5BOy+ZckFp
         xDtZSvKoypkd1wXnpu2/EM3zR4TgLAYm38dv0BoRsOEG4hVr0/lF8EOjK9y0CQYF8zJt
         pRxQsFXjs0+XKUrAB+bgocFYnTmNxQH3ofQb/fa70/gSwiAdP3kajO9c7WYq8YFy+BrQ
         BERg==
X-Gm-Message-State: AOAM532oT0tWw19+IC0moZ9/H3b5IDGT7V4mH03vz60684Ey9q6A70LS
        LQKDqRrbxJDT86y1nb9aepeuvPZHzU1eGJ5qRXAX4g==
X-Google-Smtp-Source: ABdhPJw0Ws5JxTx6vxeo66/SjiEPxXO12VwIiiEbeCglmyTuCgwCugyFQ5EdHVJLN7WAkJdswMXD1NoWU6xFViluqAo=
X-Received: by 2002:ab0:23d5:: with SMTP id c21mr816639uan.129.1604581191469;
 Thu, 05 Nov 2020 04:59:51 -0800 (PST)
MIME-Version: 1.0
References: <20201102092822.5301-1-wenbin.mei@mediatek.com> <20201102092822.5301-2-wenbin.mei@mediatek.com>
In-Reply-To: <20201102092822.5301-2-wenbin.mei@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Nov 2020 13:59:15 +0100
Message-ID: <CAPDyKFpej4T=-kaEMz6nzJxeYUfJVXzHckVr-LhwvZhuU68Y4w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: mediatek: add HS400 enhanced strobe support
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 2 Nov 2020 at 10:29, Wenbin Mei <wenbin.mei@mediatek.com> wrote:
>
> Add support for HS400ES mode to MediaTek MMC Card Driver.
>
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 40 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index f7f68623fefc..fc5ee5df91ad 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -78,9 +78,12 @@
>  #define MSDC_PAD_TUNE0   0xf0
>  #define PAD_DS_TUNE      0x188
>  #define PAD_CMD_TUNE     0x18c
> +#define EMMC51_CFG0     0x204
>  #define EMMC50_CFG0      0x208
> +#define EMMC50_CFG1      0x20c
>  #define EMMC50_CFG3      0x220
>  #define SDC_FIFO_CFG     0x228
> +#define CQHCI_SETTING   0x7fc
>
>  /*--------------------------------------------------------------------------*/
>  /* Top Pad Register Offset                                                  */
> @@ -261,15 +264,26 @@
>
>  #define PAD_CMD_TUNE_RX_DLY3     (0x1f << 1)  /* RW */
>
> +/* EMMC51_CFG0 mask */
> +#define CMDQ_RDAT_CNT            (0x3ff << 12) /* RW */
> +
>  #define EMMC50_CFG_PADCMD_LATCHCK (0x1 << 0)   /* RW */
>  #define EMMC50_CFG_CRCSTS_EDGE    (0x1 << 3)   /* RW */
>  #define EMMC50_CFG_CFCSTS_SEL     (0x1 << 4)   /* RW */
> +#define EMMC50_CFG_CMD_RESP_SEL   (0x1 << 9)   /* RW */
> +
> +/* EMMC50_CFG1 mask */
> +#define EMMC50_CFG1_DS_CFG        (0x1 << 28)  /* RW */
>
>  #define EMMC50_CFG3_OUTS_WR       (0x1f << 0)  /* RW */
>
>  #define SDC_FIFO_CFG_WRVALIDSEL   (0x1 << 24)  /* RW */
>  #define SDC_FIFO_CFG_RDVALIDSEL   (0x1 << 25)  /* RW */
>
> +/* CQHCI_SETTING */
> +#define CQHCI_RD_CMD_WND_SEL     (0x1 << 14) /* RW */
> +#define CQHCI_WR_CMD_WND_SEL     (0x1 << 15) /* RW */
> +
>  /* EMMC_TOP_CONTROL mask */
>  #define PAD_RXDLY_SEL           (0x1 << 0)      /* RW */
>  #define DELAY_EN                (0x1 << 1)      /* RW */
> @@ -2276,6 +2290,31 @@ static int msdc_get_cd(struct mmc_host *mmc)
>                 return !val;
>  }
>
> +static void msdc_hs400_enhanced_strobe(struct mmc_host *mmc,
> +                                      struct mmc_ios *ios)
> +{
> +       struct msdc_host *host = mmc_priv(mmc);
> +
> +       if (ios->enhanced_strobe) {
> +               msdc_prepare_hs400_tuning(mmc, ios);
> +               sdr_set_field(host->base + EMMC50_CFG0, EMMC50_CFG_PADCMD_LATCHCK, 1);
> +               sdr_set_field(host->base + EMMC50_CFG0, EMMC50_CFG_CMD_RESP_SEL, 1);
> +               sdr_set_field(host->base + EMMC50_CFG1, EMMC50_CFG1_DS_CFG, 1);
> +
> +               sdr_clr_bits(host->base + CQHCI_SETTING, CQHCI_RD_CMD_WND_SEL);
> +               sdr_clr_bits(host->base + CQHCI_SETTING, CQHCI_WR_CMD_WND_SEL);
> +               sdr_clr_bits(host->base + EMMC51_CFG0, CMDQ_RDAT_CNT);
> +       } else {
> +               sdr_set_field(host->base + EMMC50_CFG0, EMMC50_CFG_PADCMD_LATCHCK, 0);
> +               sdr_set_field(host->base + EMMC50_CFG0, EMMC50_CFG_CMD_RESP_SEL, 0);
> +               sdr_set_field(host->base + EMMC50_CFG1, EMMC50_CFG1_DS_CFG, 0);
> +
> +               sdr_set_bits(host->base + CQHCI_SETTING, CQHCI_RD_CMD_WND_SEL);
> +               sdr_set_bits(host->base + CQHCI_SETTING, CQHCI_WR_CMD_WND_SEL);
> +               sdr_set_field(host->base + EMMC51_CFG0, CMDQ_RDAT_CNT, 0xb4);
> +       }
> +}
> +
>  static void msdc_cqe_enable(struct mmc_host *mmc)
>  {
>         struct msdc_host *host = mmc_priv(mmc);
> @@ -2333,6 +2372,7 @@ static const struct mmc_host_ops mt_msdc_ops = {
>         .set_ios = msdc_ops_set_ios,
>         .get_ro = mmc_gpio_get_ro,
>         .get_cd = msdc_get_cd,
> +       .hs400_enhanced_strobe = msdc_hs400_enhanced_strobe,
>         .enable_sdio_irq = msdc_enable_sdio_irq,
>         .ack_sdio_irq = msdc_ack_sdio_irq,
>         .start_signal_voltage_switch = msdc_ops_switch_volt,
> --
> 2.18.0
