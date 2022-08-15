Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B26CC00140
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Aug 2022 18:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243475AbiHOScf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Aug 2022 14:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243068AbiHOSby (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Aug 2022 14:31:54 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FD83335E
        for <linux-mmc@vger.kernel.org>; Mon, 15 Aug 2022 11:21:22 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id w15so8427174ljw.1
        for <linux-mmc@vger.kernel.org>; Mon, 15 Aug 2022 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=by5rsD4ddIanVxCeTskMSrVNwwWSHEvtLbsCUNXbgG8=;
        b=rJ4tqNwlRj/1Mj/KkAa8NUDNkZF24E/qoJezRgv4qDHrgwlZTjT/rtIpzrVwXMlJrU
         CUq8S7KjQVBhX54m6MBPFFC1Vx16jT6SulhoF51sluxjaq+aYS7nl5wGksK7R7hBalBL
         sswCqzISPmibGaOAU6OPlHsr/WtFkcFrLF6x6tlOw5rQGxngvruAK9brZBQPlB2NQ3yD
         UMVwxFI+eEnSllRik7+vxaQpZctobH6/E0+Mv/K5fRWFDtYpCKTD3ufzRgABlNz80pAz
         Ly6/S0J9FziHi0MacHL6iOqy7fjJs85t47Jarb1DGLOeuEnAuM9s2McCIGA9t/CrG8gJ
         0y4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=by5rsD4ddIanVxCeTskMSrVNwwWSHEvtLbsCUNXbgG8=;
        b=AgbdaOz9EJCFtyvJgHjaMAp1rxm0oQTXUfjBc93YuFklectuvfATjeJC1ssKHtK8cw
         t25LvefJemKEVcfa0CHjfjVkbPwRntNPKdlBJMJHtd575wSFB50L3R2gHLWNL+eShEt/
         mub4pgbLX6Y/dMAjXWkibY/h65Tr8DaB9D11lOXyJFVAtXe6gKe0qp0bghUFUQ9U81hX
         l4JYwXLHKdlLqZsJHlLhjBisUzMH8f0bNnLD22tLMC73ZzRmPVgXJpgCQGdY8onhFC6q
         s01m0zM6ELW9olHlW6ofqAEb0lFY+sBUMnco+SqTd8ppFUXfCaSEoKkWNzNoG6To6I6U
         mAOQ==
X-Gm-Message-State: ACgBeo3BhaBVHbKM69hkI306dNCnebH/26w4zYvxhI4Y77r7K7bCMB27
        +jtIdGFr1G+ae9AxVWkFRGbm8I8c3oroUXE7Xzn7AA==
X-Google-Smtp-Source: AA6agR6Y7iExKqYVImImJJST7yO+G5pQQPjq2z4/oRqjIqp2qjOw9UD+MCsnCj3+R/JeS5uPU+Y4s73DggAn8uUZ2Tc=
X-Received: by 2002:a2e:5455:0:b0:25e:4b87:9714 with SMTP id
 y21-20020a2e5455000000b0025e4b879714mr4968855ljd.463.1660587680728; Mon, 15
 Aug 2022 11:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <ecc229ad-c15a-2092-6568-f92e4507553e@gmail.com>
In-Reply-To: <ecc229ad-c15a-2092-6568-f92e4507553e@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Aug 2022 20:20:44 +0200
Message-ID: <CAPDyKFoi70K9SBJbdvLZbseNpO2J4s-gZt-zpHMf-40wEyecYA@mail.gmail.com>
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

On Sun, 14 Aug 2022 at 23:44, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> This adds SDIO interrupt support.
> Successfully tested on a S905X4-based system with a BRCM4334
> SDIO wifi module (brcmfmac driver).
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 45 +++++++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 2f08d442e..e8d53fcdd 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -41,14 +41,17 @@
>  #define   CLK_V2_TX_DELAY_MASK GENMASK(19, 16)
>  #define   CLK_V2_RX_DELAY_MASK GENMASK(23, 20)
>  #define   CLK_V2_ALWAYS_ON BIT(24)
> +#define   CLK_V2_IRQ_SDIO_SLEEP BIT(29)
>
>  #define   CLK_V3_TX_DELAY_MASK GENMASK(21, 16)
>  #define   CLK_V3_RX_DELAY_MASK GENMASK(27, 22)
>  #define   CLK_V3_ALWAYS_ON BIT(28)
> +#define   CLK_V3_IRQ_SDIO_SLEEP BIT(29)
>
>  #define   CLK_TX_DELAY_MASK(h)         (h->data->tx_delay_mask)
>  #define   CLK_RX_DELAY_MASK(h)         (h->data->rx_delay_mask)
>  #define   CLK_ALWAYS_ON(h)             (h->data->always_on)
> +#define   CLK_IRQ_SDIO_SLEEP(h)                (h->data->irq_sdio_sleep)
>
>  #define SD_EMMC_DELAY 0x4
>  #define SD_EMMC_ADJUST 0x8
> @@ -100,9 +103,6 @@
>  #define   IRQ_END_OF_CHAIN BIT(13)
>  #define   IRQ_RESP_STATUS BIT(14)
>  #define   IRQ_SDIO BIT(15)
> -#define   IRQ_EN_MASK \
> -       (IRQ_CRC_ERR | IRQ_TIMEOUTS | IRQ_END_OF_CHAIN | IRQ_RESP_STATUS |\
> -        IRQ_SDIO)
>
>  #define SD_EMMC_CMD_CFG 0x50
>  #define SD_EMMC_CMD_ARG 0x54
> @@ -136,6 +136,7 @@ struct meson_mmc_data {
>         unsigned int rx_delay_mask;
>         unsigned int always_on;
>         unsigned int adjust;
> +       unsigned int irq_sdio_sleep;
>  };
>
>  struct sd_emmc_desc {
> @@ -431,6 +432,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
>         clk_reg |= FIELD_PREP(CLK_CORE_PHASE_MASK, CLK_PHASE_180);
>         clk_reg |= FIELD_PREP(CLK_TX_PHASE_MASK, CLK_PHASE_0);
>         clk_reg |= FIELD_PREP(CLK_RX_PHASE_MASK, CLK_PHASE_0);
> +       clk_reg |= CLK_IRQ_SDIO_SLEEP(host);
>         writel(clk_reg, host->regs + SD_EMMC_CLOCK);
>
>         /* get the mux parents */
> @@ -933,7 +935,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>  {
>         struct meson_host *host = dev_id;
>         struct mmc_command *cmd;
> -       struct mmc_data *data;
>         u32 irq_en, status, raw_status;
>         irqreturn_t ret = IRQ_NONE;
>
> @@ -948,14 +949,24 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>                 return IRQ_NONE;
>         }
>
> -       if (WARN_ON(!host) || WARN_ON(!host->cmd))
> +       if (WARN_ON(!host))
>                 return IRQ_NONE;
>
>         /* ack all raised interrupts */
>         writel(status, host->regs + SD_EMMC_STATUS);
>
>         cmd = host->cmd;
> -       data = cmd->data;
> +
> +       if (status & IRQ_SDIO) {
> +               mmc_signal_sdio_irq(host->mmc);

This is the legacy interface for supporting SDIO irqs. I am planning
to remove it, sooner or later.

Please convert into using sdio_signal_irq() instead. Note that, using
sdio_signal_irq() means you need to implement support for
MMC_CAP2_SDIO_IRQ_NOTHREAD, which also includes to implement the
->ack_sdio_irq() callback.

There are other host drivers to be inspired from, but don't hesitate
to ask if there is something unclear.

[...]

Kind regards
Uffe
