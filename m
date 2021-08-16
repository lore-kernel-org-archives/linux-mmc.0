Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58960C4320E
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 13:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42A1A632CC
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 13:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhHPNyY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Aug 2021 09:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhHPNyU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2021 09:54:20 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70F5C0613C1
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 06:53:48 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 1so2489106vkk.1
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 06:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y7hOpa/welNvCt12D36323fD2CJdjdocllm6RzIrhyQ=;
        b=BVHobZpr97GepNREkk5+26c5OaF2pTjp71JDn1jMijK2N9URLGhW/WMCorTiPV82ir
         MhMBWc6D7KqmKVpJdWr/rt7dL+KJvIb+sqGLqx+lprMSn4iM3QG02hmGMj2UR9DT7A2P
         ZA1LL+CoOINrKbG23Q7NdggC1KlJYKVHA3muM5oFAEuhBPKQg5qV9oGQ+KEZZNBuoim/
         yhs7bFh8c0J0PH5ki4yxL7Zn7BxTXq00qwpmxH5TBQACCJwt8KwBZnRN6wJJYXf45TD3
         EVMCYKUTgseEMoxu+ZWDApP29C7b0eXMzKTZGx6QPFzP5roEQRJGhQfNSeMakV3YV2eF
         m2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y7hOpa/welNvCt12D36323fD2CJdjdocllm6RzIrhyQ=;
        b=W6IVgGapXZlUGixi1RjDdemThH/iYrdHLCU4neuISdo2e9pHjI6OfPIQiGGgL7+GCI
         yKe+kLSZYguG+ixgBkbY+LzWgnKK9p9IKM/+mF4yPM05XkSztC2OhOoUjNaDXsF4SgDs
         0Wi+8r9a+BFdVZNZXQh5VWjHi610xr2NKrGq0uLUSshDclbsyffEXP/Ox2STMspbwBYi
         ufby7S20inRA19I4wREJy66fzY7LOVnzwr2AUqVqxC+UHERMxXzHIETcM06/ihKenYsa
         lNZ6/lAYhgS4Xlg4Cl2ufB9DC/sm/2YBixL10+VHk4U9b0uew8Mjt7gzmwwTnRV9FjMk
         f1aw==
X-Gm-Message-State: AOAM530LFZgpmQEhioVA64BNUk/HwMa2vbE2cQJ2MUCdn9NbklhwBnoT
        iruTT2Btj7UXIBtoh8NZz9bSKa+7iOlxFMnQWZbqUw==
X-Google-Smtp-Source: ABdhPJyPsXdd1FXnlQGYjydEpTa9/Tliu/93SI4a3CP+xaqYiqnDEBqRj+AlY8cS5Z7S5K4frFq0qT9EOKiC+nn/xwI=
X-Received: by 2002:a1f:1d94:: with SMTP id d142mr9064370vkd.6.1629122028012;
 Mon, 16 Aug 2021 06:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <1629117508-4886-1-git-send-email-haibo.chen@nxp.com> <1629117508-4886-4-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1629117508-4886-4-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Aug 2021 15:53:11 +0200
Message-ID: <CAPDyKFpqTdKxFytQWo+TLJf+D=JYJo6B2aZDqOQc4+9_mbH40Q@mail.gmail.com>
Subject: Re: [PATCH 4/6] mmc: host: sdhci-esdhc-imx.c: correct the auto-tuning
 setting for sdio device
To:     Haibo Chen <haibo.chen@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 16 Aug 2021 at 15:00, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> USDHC contain auto tuning circuit, this circuit will work automatically after
> the tuning procedurae, it can increase/decrease the delay cell according to
> the outside environment change (like temperature).
>
> Unfortunately, this auto tuning circuit can not handle the async sdio device
> interrupt correctly. When sdio device use 4 data line, async sdio interrupt
> will use DAT[1], if we enable auto tuning circuit check 4 data lines, include
> the DAT[1], this circuit will detect this interrupt, take this as a data on
> DAT[1], and adjust the delay cell wrongly.
>
> This is the hardware design limitation, to avoid this, when sdio device enable
> async interrupt, auto tuning circuit only check DAT[0] and CMD lines.

SDIO irqs are being enabled/disabled dynamically in runtime by the mmc
core via the host ops ->enable_sdio_irq().

Rather than forcing the autotuning circuit to stay unused statically,
perhaps an option would be to disable it when the SDIO irqs becomes
enabled? Or maybe that becomes too complicated?

>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index f18d169bc8ff..ab84c29777e5 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -226,6 +226,7 @@ struct esdhc_platform_data {
>         unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
>         unsigned int tuning_start_tap;  /* The start delay cell point in tuning procedure */
>         unsigned int strobe_dll_delay_target;   /* The delay cell for strobe pad (read clock) */
> +       bool sdio_async_interrupt_enabled;      /* sdio device enable the async interrupt */
>  };
>
>  struct esdhc_soc_data {
> @@ -416,6 +417,8 @@ static inline void esdhc_wait_for_card_clock_gate_off(struct sdhci_host *host)
>  /* Enable the auto tuning circuit to check the CMD line and BUS line */
>  static inline void usdhc_auto_tuning_mode_sel(struct sdhci_host *host)
>  {
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>         u32 buswidth, auto_tune_buswidth;
>
>         buswidth = USDHC_GET_BUSWIDTH(readl(host->ioaddr + SDHCI_HOST_CONTROL));
> @@ -432,6 +435,18 @@ static inline void usdhc_auto_tuning_mode_sel(struct sdhci_host *host)
>                 break;
>         }
>
> +       /*
> +        * If sdio device use async interrupt, it will use DAT[1] to signal
> +        * the device's interrupt asynchronous when use 4 data lines.
> +        * Then hardware auto tuning circuit MUST NOT check the DAT[1] line,
> +        * otherwise auto tuning will be impacted by this async interrupt,
> +        * and change the delay cell incorrectly, which then cause data/cmd
> +        * errors.
> +        * This is the hardware auto tuning circuit limitation.
> +        */
> +       if (imx_data->boarddata.sdio_async_interrupt_enabled)
> +               auto_tune_buswidth = ESDHC_VEND_SPEC2_AUTO_TUNE_1BIT_EN;
> +
>         esdhc_clrset_le(host, ESDHC_VEND_SPEC2_AUTO_TUNE_MODE_MASK,
>                         auto_tune_buswidth | ESDHC_VEND_SPEC2_AUTO_TUNE_CMD_EN,
>                         ESDHC_VEND_SPEC2);
> @@ -1531,6 +1546,9 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>         if (of_property_read_u32(np, "fsl,delay-line", &boarddata->delay_line))
>                 boarddata->delay_line = 0;
>
> +       if (of_property_read_bool(np, "fsl,sdio-async-interrupt-enabled"))

As stated on the DT patch, I think you can use the "cap-sdio-irq" instead.

> +               boarddata->sdio_async_interrupt_enabled = true;
> +
>         mmc_of_parse_voltage(host->mmc, &host->ocr_mask);
>
>         if (esdhc_is_usdhc(imx_data) && !IS_ERR(imx_data->pinctrl)) {
> --
> 2.17.1
>

Kind regards
Uffe
