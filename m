Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB0BC28D13
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Aug 2022 11:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiHVLeM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Aug 2022 07:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbiHVLeM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Aug 2022 07:34:12 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C080D2FFFC
        for <linux-mmc@vger.kernel.org>; Mon, 22 Aug 2022 04:34:10 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id m5so4172230lfj.4
        for <linux-mmc@vger.kernel.org>; Mon, 22 Aug 2022 04:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=nk17M2wugNLpqT/MyttSUPM+w2KNwJsYhkMcDYjfJ8A=;
        b=yJIJE8slplbDUI7vIremi8RTvmWfGLmHetDbz8iSr4Adpigp8j2eoZUtHQkorDDikP
         xxf3o0pYeRr4bUMCnXrzIpaeVyU9fDnjK1FlAz4yYjUPRRUHpyVNZexMRy9uZyHbVBIj
         g+pr1P4hFjYhgOmAWEu1aGa0EVxG5ttilwZWFuLi9IgpKw1zURj9LyWLT2yjgv1bvweW
         Amx6PaSmZvwMyTyJ7jUE97vvy5l11qM9Hnda8AUViPKos7Bjrs7nAzBFvPeo/1TKQE+q
         bCgMMaz9kYfl4eOLTd5/UAuflF798FA0QbSbS5xVXPt+LGDsMTHk74el7CYLDD2aCT0K
         Tplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nk17M2wugNLpqT/MyttSUPM+w2KNwJsYhkMcDYjfJ8A=;
        b=GJsrirXTCOSt1NrHcjlm6srBkK7HWggMj7ulbxrmWaYVXHoOCHhtkjc60uEnLt36mr
         OLmSJa+3XsxnUobSESHZxe0tIiEhlzJHKl8GuTyjGFOYureEQ0j4doqyknpk8jRRH4Md
         E5md8JaCEH3NgJaMnwVzJp99WuWDsC/coGG246Kpt0SnLvR0mKBZCt8LRmd53kbTRt9D
         8rtslnLW6W5tnSoH3dfLl3JQngKO76igMhPt+G3J8J+6HHXzRU5ERVPAlzsfwucbloRG
         GOoelvD8unMkPJdo/HRZSVHRFJrUbhasW3wmjuTUDjeV3lk0Bf3+WJ6WMhf8gijSquYU
         7zMg==
X-Gm-Message-State: ACgBeo0NBAtDVLRvsbBMkuKlxj5yT9KBjptFQfTR4GhoUDovkWe+C9jf
        HfsnvJeWBNy7v+cYCS6LuYneNQiustvl+F/WlN/m1A==
X-Google-Smtp-Source: AA6agR7HllNyJIOXcBtwvhf9DXEPo79K5zJP2HELbqKIXDNlQgPY+0YiZQM/TuBSv9VPozRNxgpPNd680f1OGdRIv9Y=
X-Received: by 2002:a05:6512:234e:b0:492:cfc4:c4f9 with SMTP id
 p14-20020a056512234e00b00492cfc4c4f9mr4863391lfu.358.1661168048868; Mon, 22
 Aug 2022 04:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <b94b7f5b-1095-33a5-b1a0-20a6e2281bce@gmail.com> <a185b4e9-f238-c2e6-0847-79cd8265844a@gmail.com>
In-Reply-To: <a185b4e9-f238-c2e6-0847-79cd8265844a@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 22 Aug 2022 13:33:31 +0200
Message-ID: <CAPDyKFopddPSU-cSdnfXGbg91zNWWEX5L9kvMmtVrvxumD0R3w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: meson-gx: add SDIO interrupt support
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

On Fri, 19 Aug 2022 at 23:14, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> Add SDIO interrupt support. Successfully tested on a S905X4-based
> system (V3 register layout) with a BRCM4334 SDIO wifi module
> (brcmfmac driver). The implementation also considers the potential
> race discussed in [0].
>
> [0] https://lore.kernel.org/linux-arm-kernel/CAPDyKFoJDhjLkajBHgW3zHasvYYri77NQoDpiW-BpKgkdjtOyg@mail.gmail.com/
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 76 ++++++++++++++++++++++++++++-----
>  1 file changed, 66 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 9a4da2544..58b7836a5 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -41,14 +41,17 @@
>  #define   CLK_V2_TX_DELAY_MASK GENMASK(19, 16)
>  #define   CLK_V2_RX_DELAY_MASK GENMASK(23, 20)
>  #define   CLK_V2_ALWAYS_ON BIT(24)
> +#define   CLK_V2_IRQ_SDIO_SLEEP BIT(25)
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
> @@ -135,6 +138,7 @@ struct meson_mmc_data {
>         unsigned int rx_delay_mask;
>         unsigned int always_on;
>         unsigned int adjust;
> +       unsigned int irq_sdio_sleep;
>  };
>
>  struct sd_emmc_desc {
> @@ -174,6 +178,7 @@ struct meson_host {
>         bool vqmmc_enabled;
>         bool needs_pre_post_req;
>
> +       spinlock_t lock;
>  };
>
>  #define CMD_CFG_LENGTH_MASK GENMASK(8, 0)
> @@ -430,6 +435,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
>         clk_reg |= FIELD_PREP(CLK_CORE_PHASE_MASK, CLK_PHASE_180);
>         clk_reg |= FIELD_PREP(CLK_TX_PHASE_MASK, CLK_PHASE_0);
>         clk_reg |= FIELD_PREP(CLK_RX_PHASE_MASK, CLK_PHASE_0);
> +       clk_reg |= CLK_IRQ_SDIO_SLEEP(host);
>         writel(clk_reg, host->regs + SD_EMMC_CLOCK);
>
>         /* get the mux parents */
> @@ -934,32 +940,54 @@ static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
>         }
>  }
>
> +static void __meson_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
> +{
> +       struct meson_host *host = mmc_priv(mmc);
> +       u32 reg_irqen = IRQ_EN_MASK;
> +
> +       if (enable)
> +               reg_irqen |= IRQ_SDIO;
> +       writel(reg_irqen, host->regs + SD_EMMC_IRQ_EN);
> +}
> +
>  static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>  {
>         struct meson_host *host = dev_id;
>         struct mmc_command *cmd;
> -       struct mmc_data *data;
>         u32 status, raw_status;
>         irqreturn_t ret = IRQ_NONE;
>
>         raw_status = readl(host->regs + SD_EMMC_STATUS);
> -       status = raw_status & IRQ_EN_MASK;
> +       status = raw_status & (IRQ_EN_MASK | IRQ_SDIO);
>
>         if (!status) {
>                 dev_dbg(host->dev,
>                         "Unexpected IRQ! irq_en 0x%08lx - status 0x%08x\n",
> -                        IRQ_EN_MASK, raw_status);
> +                        IRQ_EN_MASK | IRQ_SDIO, raw_status);
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
> +               spin_lock(&host->lock);
> +               __meson_mmc_enable_sdio_irq(host->mmc, 0);
> +               sdio_signal_irq(host->mmc);
> +               spin_unlock(&host->lock);
> +               status &= ~IRQ_SDIO;
> +               if (!status)
> +                       return IRQ_HANDLED;
> +       }
> +
> +       if (WARN_ON(!cmd))
> +               return IRQ_NONE;
> +
>         cmd->error = 0;
>         if (status & IRQ_CRC_ERR) {
>                 dev_dbg(host->dev, "CRC Error - status 0x%08x\n", status);
> @@ -977,12 +1005,9 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>
>         meson_mmc_read_resp(host->mmc, cmd);
>
> -       if (status & IRQ_SDIO) {
> -               dev_dbg(host->dev, "IRQ: SDIO TODO.\n");
> -               ret = IRQ_HANDLED;
> -       }
> -
>         if (status & (IRQ_END_OF_CHAIN | IRQ_RESP_STATUS)) {
> +               struct mmc_data *data = cmd->data;
> +
>                 if (data && !cmd->error)
>                         data->bytes_xfered = data->blksz * data->blocks;
>                 if (meson_mmc_bounce_buf_read(data) ||
> @@ -1125,6 +1150,27 @@ static int meson_mmc_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>         return -EINVAL;
>  }
>
> +static void meson_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
> +{
> +       struct meson_host *host = mmc_priv(mmc);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +       __meson_mmc_enable_sdio_irq(mmc, enable);
> +       spin_unlock_irqrestore(&host->lock, flags);
> +}
> +
> +static void meson_mmc_ack_sdio_irq(struct mmc_host *mmc)
> +{
> +       struct meson_host *host = mmc_priv(mmc);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +       if (!mmc->sdio_irq_pending)

I am not quite sure I understand why you need to check this flag here.

The point is, in meson_mmc_irq() you are doing things in the correct
order, which means disabling the SDIO irq by calling
__meson_mmc_enable_sdio_irq(host->mmc, 0) prior calling
sdio_signal_irq(host->mmc) (which sets the flag).

In this way, the host driver should be prevented from signaling
another new SDIO irq, until it has acked (which means re-enabling the
SDIO irqs) the current one to be processed.

Or did I miss something?

> +               __meson_mmc_enable_sdio_irq(mmc, 1);
> +       spin_unlock_irqrestore(&host->lock, flags);
> +}
>

[...]

Other than the comment above, the patch looks good to me!

Kind regards
Uffe
