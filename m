Return-Path: <SRS0=mNiq=AR=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43411C433E1
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jul 2020 14:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2119C2070C
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jul 2020 14:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G4ob+a4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgGFOtq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbgGFOtq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jul 2020 10:49:46 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF817C061755
        for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2020 07:49:45 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id q15so11966568uap.4
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2020 07:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RlwlWb/UfP78qwcjII/qv8pEpVUy1fPzrWtMfafx0Oc=;
        b=G4ob+a4XNBO85mbUP20flf9o6X0dY1Lgei1+5vICDnCEiYp4WkIbFO4tO1Lr15O0b0
         Fl+iLUdh2sFSx/vTkDH9TsANNmTkkY7PKYtxP+K76YLdRRG79VxMyZ6SOVQXAsZjeyUK
         sony2dGSEBFL/Jxd42E957wY7ApgaHbXe8gkqJ0tybp0x6vttdIr4C8wIeEHHiawlgjf
         OteXblkFn1VwkGr681tiI41BLiSKP7wvtsn+pVAwQ9MktGtjy0OzS7KuQFqIGCgmKNhF
         BjpVna2Xylsck0mXM4F++QO9O0DpsIJab0eQVwVtXlD1CHEH/P/qnnGD60gQ3+UdK5B2
         J/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RlwlWb/UfP78qwcjII/qv8pEpVUy1fPzrWtMfafx0Oc=;
        b=NzP7zkZKRAlJVGazKHShbMw71tXRpMPC4rSNZ/Wap6x5OMnJpNi6y8yHksIJToKkTn
         15+G61AVZoc5Tuw02l8YLKIWMpsU4rGD9FF+WqwutYTfsu5wBmhJkvpsvVI+QL1ZaWHb
         oAUE3t/mjwDko2eExnZW0lrhP93x96kDvILZOeZrxJg6hhUMevgHOKBN6+k3DVHieYhD
         gWDr2wxoEiI6ihIekNOWuYFy2LmTAGOtYlrbpFD9nrZ64oNI1/64EWQoqn1rzYtBChnh
         ggsTk1aBInzsyvKKRAMvmFKX7JsdThXjMllxmjGLy6F+6TW9nMvKQbGSNDiFj2773s8P
         eU3g==
X-Gm-Message-State: AOAM530/HHbHjQELQ8Pnl7Zw1qLW0kSYAZB176Wdq16vhJghBHNAj8FJ
        kff1BSgHa8v6xA+buUnZFB8uTxzN3SxWX/zHGaQttw==
X-Google-Smtp-Source: ABdhPJwZ0BIW49aETEkPlOXU/Q3egJ4SaouR53jzPrWzw4D3JDugGK9LB5NI6aj2kYuY1HjrPyphXue8Ol/obQFzEOM=
X-Received: by 2002:ab0:6f0a:: with SMTP id r10mr41113467uah.100.1594046985173;
 Mon, 06 Jul 2020 07:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <1592985830-13038-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1592985830-13038-1-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Jul 2020 16:49:08 +0200
Message-ID: <CAPDyKFrO0Ddz+pFeu7bhn-j7Qg_rjgX0C_eAzbphP8qS8OAK+w@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: sdhci-esdhc-imx: dump internal IC debug status
 during error
To:     Haibo Chen <haibo.chen@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 24 Jun 2020 at 10:15, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> USDHC of i.MX has internal IC debug register, which record the IC
> logical status. So dump these logical status in error condition,
> this can help analyzing issue.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 39 ++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 1d7f84b23a22..a76b4513fbec 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -38,6 +38,16 @@
>  #define  ESDHC_VENDOR_SPEC_SDIO_QUIRK  (1 << 1)
>  #define  ESDHC_VENDOR_SPEC_VSELECT     (1 << 1)
>  #define  ESDHC_VENDOR_SPEC_FRC_SDCLK_ON        (1 << 8)
> +#define ESDHC_DEBUG_SEL_AND_STATUS_REG         0xc2
> +#define ESDHC_DEBUG_SEL_REG                    0xc3
> +#define ESDHC_DEBUG_SEL_MASK                   0xf
> +#define ESDHC_DEBUG_SEL_CMD_STATE              1
> +#define ESDHC_DEBUG_SEL_DATA_STATE             2
> +#define ESDHC_DEBUG_SEL_TRANS_STATE            3
> +#define ESDHC_DEBUG_SEL_DMA_STATE              4
> +#define ESDHC_DEBUG_SEL_ADMA_STATE             5
> +#define ESDHC_DEBUG_SEL_FIFO_STATE             6
> +#define ESDHC_DEBUG_SEL_ASYNC_FIFO_STATE       7
>  #define ESDHC_WTMK_LVL                 0x44
>  #define  ESDHC_WTMK_DEFAULT_VAL                0x10401040
>  #define  ESDHC_WTMK_LVL_RD_WML_MASK    0x000000FF
> @@ -348,6 +358,34 @@ static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, i
>         writel(((readl(base) & ~(mask << shift)) | (val << shift)), base);
>  }
>
> +#define DRIVER_NAME "sdhci-esdhc-imx"
> +#define ESDHC_IMX_DUMP(f, x...) \
> +       pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
> +static void esdhc_dump_debug_regs(struct sdhci_host *host)
> +{
> +       int i;
> +       char *debug_status[7] = {
> +                                "cmd debug status",
> +                                "data debug status",
> +                                "trans debug status",
> +                                "dma debug status",
> +                                "adma debug status",
> +                                "fifo debug status",
> +                                "async fifo debug status"
> +       };
> +
> +       ESDHC_IMX_DUMP("========= ESDHC IMX DEBUG STATUS DUMP =========\n");
> +       for (i = 0; i < 7; i++) {
> +               esdhc_clrset_le(host, ESDHC_DEBUG_SEL_MASK,
> +                       ESDHC_DEBUG_SEL_CMD_STATE + i, ESDHC_DEBUG_SEL_REG);
> +               ESDHC_IMX_DUMP("%s:  0x%04x\n", debug_status[i],
> +                       readw(host->ioaddr + ESDHC_DEBUG_SEL_AND_STATUS_REG));
> +       }
> +
> +       esdhc_clrset_le(host, ESDHC_DEBUG_SEL_MASK, 0, ESDHC_DEBUG_SEL_REG);
> +
> +}
> +
>  static inline void esdhc_wait_for_card_clock_gate_off(struct sdhci_host *host)
>  {
>         u32 present_state;
> @@ -1237,6 +1275,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
>         .set_uhs_signaling = esdhc_set_uhs_signaling,
>         .reset = esdhc_reset,
>         .irq = esdhc_cqhci_irq,
> +       .dump_vendor_regs = esdhc_dump_debug_regs,
>  };
>
>  static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
> --
> 2.17.1
>
