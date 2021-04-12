Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB30AC43600
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 07:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A382461360
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 07:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbhDLHxH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Apr 2021 03:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237173AbhDLHxG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Apr 2021 03:53:06 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44660C061574
        for <linux-mmc@vger.kernel.org>; Mon, 12 Apr 2021 00:52:49 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id g20so6190380vst.2
        for <linux-mmc@vger.kernel.org>; Mon, 12 Apr 2021 00:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hxbPBuINzsiyQdtXGnDJ0X7XxKPxqap5sLfwm2OcunM=;
        b=pRICCxPoeEQLl+usptIWO5MabXlg9nq0HNynWGBljJvbY1kqlGSbLIS9SLhIVkvHIP
         pnLCb9R9+A6737nO+kAFOn7zpHbzuGKn/xSA5BvH+P7OtMca+RIvEcO/xXkghMn2wa8F
         SNnlNmsXBRwHGLBHs54WsYoD7uhB5lzU44spyQzmplNcrVxyyDzI9VFuqFRS6WDecNZL
         zP62iYYLZH5MpqMX7U9CpkQnk22ZZAEQdD3JEc+yZvrE4TLennuVnrP109ADuhI4yZnu
         Ozzd7DHlubjlhcBYhhek66I1jqWniQHJ1+/+rAqBGS0mMpqV2pXtme0EUnhbsDInq4iR
         b9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hxbPBuINzsiyQdtXGnDJ0X7XxKPxqap5sLfwm2OcunM=;
        b=f2U3He6bzoYEVICCgwuiFOvYxslbWJONlyS4KhI6qkxycJe1dLLMV34PvKv9cXSyrp
         DCE91KXJtdI61jth613kY//50SqnV++OH6VXhnYlxRU5O0ZMxm+BNNg0eARVsbLOuIaQ
         EOVwNrKjFqqPX339Dr8qXCHFVugLaIkZ/4044bnR+0AJnvXwSgsBSrrph5Oy+XWOKFra
         WTzORLXHIC1K7sq8Pr2oKXNgUVnt9hzMcXR1tSpz/pxHCHfgJQc3zBWNtBskErm9b0O9
         FEbI5uTYgdLmY+JMU8zyhZHU639yqGUSJlPx/q0y578VDT4ZLMknJchxL5qQzLLSS8oI
         oQ3Q==
X-Gm-Message-State: AOAM530EdZB/Gi0iVjB8j2fE9yfW53IHoidpwkcXSfhlMd27rvYoRYHf
        yoICWbvD+6hyqgaJxuJIndMouo0JSpBoZduSvwCQww==
X-Google-Smtp-Source: ABdhPJwLG4Xhk65p1fnC2Z0IKOXF4S2MAN6Y1KYrnaZOVrhilo6KugfYX4yJhJJYnT8hSXIayThLik0kuU6hu9HxwGk=
X-Received: by 2002:a67:fe05:: with SMTP id l5mr18245050vsr.34.1618213968496;
 Mon, 12 Apr 2021 00:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210407094617.770495-1-jonathanh@nvidia.com>
In-Reply-To: <20210407094617.770495-1-jonathanh@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Apr 2021 09:52:12 +0200
Message-ID: <CAPDyKFo+HwkBaCkALaSuUiTFE_soptsECmGRQX873_WKAmN_Lw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-tegra: Add required callbacks to set/clear
 CQE_EN bit
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Kamal Mostafa <kamal@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 7 Apr 2021 at 11:46, Jon Hunter <jonathanh@nvidia.com> wrote:
>
> From: Aniruddha Tvs Rao <anrao@nvidia.com>
>
> CMD8 is not supported with Command Queue Enabled. Add required callback
> to clear CQE_EN and CQE_INTR fields in the host controller register
> before sending CMD8. Add corresponding callback in the CQHCI resume path
> to re-enable CQE_EN and CQE_INTR fields.
>
> Reported-by: Kamal Mostafa <kamal@canonical.com>
> Tested-by: Kamal Mostafa <kamal@canonical.com>
> Signed-off-by: Aniruddha Tvs Rao <anrao@nvidia.com>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Applied for next, thanks!

Please tell, if you think this needs to be tagged for stable kernels
as well (and if so, perhaps we can set a fixes tag as well?).

Kind regards
Uffe




> ---
>  drivers/mmc/host/sdhci-tegra.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index c61f797a853f..387ce9cdbd7c 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -119,6 +119,10 @@
>  /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
>  #define SDHCI_TEGRA_CQE_BASE_ADDR                      0xF000
>
> +#define SDHCI_TEGRA_CQE_TRNS_MODE      (SDHCI_TRNS_MULTI | \
> +                                        SDHCI_TRNS_BLK_CNT_EN | \
> +                                        SDHCI_TRNS_DMA)
> +
>  struct sdhci_tegra_soc_data {
>         const struct sdhci_pltfm_data *pdata;
>         u64 dma_mask;
> @@ -1156,6 +1160,7 @@ static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
>  static void tegra_cqhci_writel(struct cqhci_host *cq_host, u32 val, int reg)
>  {
>         struct mmc_host *mmc = cq_host->mmc;
> +       struct sdhci_host *host = mmc_priv(mmc);
>         u8 ctrl;
>         ktime_t timeout;
>         bool timed_out;
> @@ -1170,6 +1175,7 @@ static void tegra_cqhci_writel(struct cqhci_host *cq_host, u32 val, int reg)
>          */
>         if (reg == CQHCI_CTL && !(val & CQHCI_HALT) &&
>             cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT) {
> +               sdhci_writew(host, SDHCI_TEGRA_CQE_TRNS_MODE, SDHCI_TRANSFER_MODE);
>                 sdhci_cqe_enable(mmc);
>                 writel(val, cq_host->mmio + reg);
>                 timeout = ktime_add_us(ktime_get(), 50);
> @@ -1205,6 +1211,7 @@ static void sdhci_tegra_update_dcmd_desc(struct mmc_host *mmc,
>  static void sdhci_tegra_cqe_enable(struct mmc_host *mmc)
>  {
>         struct cqhci_host *cq_host = mmc->cqe_private;
> +       struct sdhci_host *host = mmc_priv(mmc);
>         u32 val;
>
>         /*
> @@ -1218,6 +1225,7 @@ static void sdhci_tegra_cqe_enable(struct mmc_host *mmc)
>                 if (val & CQHCI_ENABLE)
>                         cqhci_writel(cq_host, (val & ~CQHCI_ENABLE),
>                                      CQHCI_CFG);
> +               sdhci_writew(host, SDHCI_TEGRA_CQE_TRNS_MODE, SDHCI_TRANSFER_MODE);
>                 sdhci_cqe_enable(mmc);
>                 if (val & CQHCI_ENABLE)
>                         cqhci_writel(cq_host, val, CQHCI_CFG);
> @@ -1281,12 +1289,36 @@ static void tegra_sdhci_set_timeout(struct sdhci_host *host,
>         __sdhci_set_timeout(host, cmd);
>  }
>
> +static void sdhci_tegra_cqe_pre_enable(struct mmc_host *mmc)
> +{
> +       struct cqhci_host *cq_host = mmc->cqe_private;
> +       u32 reg;
> +
> +       reg = cqhci_readl(cq_host, CQHCI_CFG);
> +       reg |= CQHCI_ENABLE;
> +       cqhci_writel(cq_host, reg, CQHCI_CFG);
> +}
> +
> +static void sdhci_tegra_cqe_post_disable(struct mmc_host *mmc)
> +{
> +       struct cqhci_host *cq_host = mmc->cqe_private;
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       u32 reg;
> +
> +       reg = cqhci_readl(cq_host, CQHCI_CFG);
> +       reg &= ~CQHCI_ENABLE;
> +       cqhci_writel(cq_host, reg, CQHCI_CFG);
> +       sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
> +}
> +
>  static const struct cqhci_host_ops sdhci_tegra_cqhci_ops = {
>         .write_l    = tegra_cqhci_writel,
>         .enable = sdhci_tegra_cqe_enable,
>         .disable = sdhci_cqe_disable,
>         .dumpregs = sdhci_tegra_dumpregs,
>         .update_dcmd_desc = sdhci_tegra_update_dcmd_desc,
> +       .pre_enable = sdhci_tegra_cqe_pre_enable,
> +       .post_disable = sdhci_tegra_cqe_post_disable,
>  };
>
>  static int tegra_sdhci_set_dma_mask(struct sdhci_host *host)
> --
> 2.25.1
>
