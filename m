Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0F73A1CF4
	for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882612; cv=none; b=Wkfk6bnMyj/7MP8fuGg1NqfSi8xGM8d0C302WlVYpxVnBQ32kczLcg/WUy+6Wrx6vPX8gLITYrBaJWmU7re7LuS41rKKLhRbRC0PqFFbymWOY2PnL4dAKvWbbHD8iARl0+TLbM8kBxsJU7AoWkO9mrQNS93SCSYGAosmJox3RDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882612; c=relaxed/simple;
	bh=5v98/KIRRqOkI5DHUHGIr4CzCrx/rkUzbyeiX0zIhrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4pDNKJMhEC/t0HVh5jfNnak8l3my2ReLdCVdZJdS5O8jUtzpqHU01p2FQe76yuD60dpRETPdHUXE/rA3ifmNK8rEtGqXiEuDxpEtkAZEzKFwHhUj9VSg6ufT1mTQbYfOka2InUxa8Y8ViKj8EHJSHAudwBadWxaPSNbS+lBhJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O8WXY7aZ; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O8WXY7aZ"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-787e35ab178so31459337b3.2
        for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 09:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762882609; x=1763487409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WFQ20n8MUe7z+UIRt0kQX0npYkqJ5XKUTrl9Nsf4IBc=;
        b=O8WXY7aZlVF4IzfV4CLlIrjo+d0fPmajvf0EhbrI0FpSPeXvxx/225jRKZL+RnZZCL
         /5Za+VkGFcPPWBEZoGv1HkkodBxKue/O6C7HZ2myelH1WDAw8+5kNGSQxe3bF8Swdpoo
         80zgarDeY6osqXNBmS6gSRkihpf1pQqc3VKqBq4Fz1o+SegXp08fzErQxX8QemsbzT12
         AbDsfM4Dgc+Q4K8SKLFQ+UqNG97iLMhrz9PL1fHCCYlYS/Co7KEjp81oQHW+IVFYCZmz
         EwL3FhnzfHsgfBxINxMAwj0lMXKZY5UF/soNwtmHoyocUs5FU1ZfJczSxzAn+/hFeKdO
         wMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762882609; x=1763487409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFQ20n8MUe7z+UIRt0kQX0npYkqJ5XKUTrl9Nsf4IBc=;
        b=UJw3rtvkEy1Uewqb3yUaVOFWh2FkQp/XyKpd3ZSY9QaQHljT7kFFX/5y8sj0YW5rdz
         sHJUSvgb0yA8FBSIJgqlcmEZvQLnk+a5iCSt5DW4FX2GEdUdUUQ84gcc1SK7uBQ7s98+
         TjulqdnuHB6WOZ4ouY+nlwmN9qPNsGgWubNJbjoWxSo+uXViK+7if22ShLRh/KhZiJAm
         EGQq77A4JAsyaijo29y1RtwJRtcf3RaNCNEBsTfQ49k5HOKIpgdNbKEy6Pp/lI5OFn3C
         1/EPC0Pwqb4te7sjMadMs1KHnxirlq/Ak1xz9pOPW2iyYqyvzkqTPfDq7jFqEJcJqWrx
         11+g==
X-Forwarded-Encrypted: i=1; AJvYcCWoOeoIFGgXDK2UVa3hdGPX1FbhFQXxw0IgPGSX0MwXlAXkwHShp9WZqFUo0xVHIR82ugwE0qKx+ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLGZVrKNEBvTeekvsjE5bwktVIeeauHpXTV17+oQFt7HrUtmZC
	jJ92gra7FUmV0pqQzMP5sCPZb4aQkShWlodtySTs0CLrMC95D9LSMAqY+qlkTWnOle8h0lC4lI2
	v16tQsvGjoffNtnIHd/DQyLp7GE2lzYIJThaJA411pA==
X-Gm-Gg: ASbGncsxN7gvtchR7T2dPoPqCAZqHlFxL70J8pFH7kK1golkYIjwig6fhajddOXE0/3
	Am03TDKUd3tS6xxlkbipq1+fCbWI0tgyeN7PfsVE7Y19FXLvsbYiDyHbf8gtOUGdMxuht+rU99t
	fYWuaOrPs3cz7HcLBenBFbsi0BbcRGe/qU++e0qytbBKqBgzXo9SEc5dii7pU8qFzRNiFxozsVi
	9Q+5p8cpcFJjsLJ38e3InjLSq62MMvmepR9uszXffa53W4y0ySwSb0ANPNsjIFIeXa5qEW3
X-Google-Smtp-Source: AGHT+IGkLjbupIggpKEGlGinb8AMEUbias2I/v844U6ezgd8B+66n8eOO1BOWZtdPF59rYp587WKM3GZCmUzRLlqfOs=
X-Received: by 2002:a05:690c:7482:b0:787:db85:571f with SMTP id
 00721157ae682-787db8560c7mr97817577b3.23.1762882609264; Tue, 11 Nov 2025
 09:36:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031-rockchip-emmc-cqe-support-v2-0-958171f5edad@collabora.com>
 <20251031-rockchip-emmc-cqe-support-v2-1-958171f5edad@collabora.com>
In-Reply-To: <20251031-rockchip-emmc-cqe-support-v2-1-958171f5edad@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Nov 2025 18:36:13 +0100
X-Gm-Features: AWmQ_bmtw_g6L83g-QmV7eXlxmHJ54F2yVH0-AUDdEGWeutpdAqoayrFvOW0EtU
Message-ID: <CAPDyKFrSKDE4BNLGge0qk2A3m+MfNjfRsqc0VJ-NMekBRFPNSw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: sdhci-of-dwcmshc: Add command queue support
 for rockchip SOCs
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	kernel@collabora.com, Yifeng Zhao <yifeng.zhao@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 16:58, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> This adds CQE support for the Rockchip RK3588 and RK3576 platform. To
> be functional, the eMMC device-tree node must have a 'supports-cqe;'
> flag property.
>
> As the RK3576 device-tree has been upstreamed with the 'supports-cqe;'
> property set by default, the kernel already tried to use CQE, which
> results in system hang during suspend. This fixes the issue.
>
> Co-developed-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 93 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 90 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index eebd45389956..47509435254b 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -24,6 +24,7 @@
>
>  #include "sdhci-pltfm.h"
>  #include "cqhci.h"
> +#include "sdhci-cqhci.h"
>
>  #define SDHCI_DWCMSHC_ARG2_STUFF       GENMASK(31, 16)
>
> @@ -82,6 +83,8 @@
>  #define DWCMSHC_EMMC_DLL_TXCLK         0x808
>  #define DWCMSHC_EMMC_DLL_STRBIN                0x80c
>  #define DECMSHC_EMMC_DLL_CMDOUT                0x810
> +#define DECMSHC_EMMC_MISC_CON          0x81C
> +#define MISC_INTCLK_EN                 BIT(1)
>  #define DWCMSHC_EMMC_DLL_STATUS0       0x840
>  #define DWCMSHC_EMMC_DLL_START         BIT(0)
>  #define DWCMSHC_EMMC_DLL_LOCKED                BIT(8)
> @@ -234,6 +237,7 @@ struct dwcmshc_priv {
>
>  struct dwcmshc_pltfm_data {
>         const struct sdhci_pltfm_data pdata;
> +       const struct cqhci_host_ops *cqhci_host_ops;
>         int (*init)(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
>         void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
>  };
> @@ -561,6 +565,68 @@ static void dwcmshc_cqhci_dumpregs(struct mmc_host *mmc)
>         sdhci_dumpregs(mmc_priv(mmc));
>  }
>
> +static void rk35xx_sdhci_cqe_pre_enable(struct mmc_host *mmc)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +       u32 reg;
> +
> +       reg = sdhci_readl(host, dwc_priv->vendor_specific_area2 + CQHCI_CFG);
> +       reg |= CQHCI_ENABLE;
> +       sdhci_writel(host, reg, dwc_priv->vendor_specific_area2 + CQHCI_CFG);
> +}
> +
> +static void rk35xx_sdhci_cqe_enable(struct mmc_host *mmc)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       u32 reg;
> +
> +       reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
> +       while (reg & SDHCI_DATA_AVAILABLE) {
> +               sdhci_readl(host, SDHCI_BUFFER);
> +               reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
> +       }
> +
> +       sdhci_writew(host, DWCMSHC_SDHCI_CQE_TRNS_MODE, SDHCI_TRANSFER_MODE);
> +
> +       sdhci_cqe_enable(mmc);
> +}
> +
> +static void rk35xx_sdhci_cqe_disable(struct mmc_host *mmc, bool recovery)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       unsigned long flags;
> +       u32 ctrl;
> +
> +       /*
> +        * During CQE command transfers, command complete bit gets latched.
> +        * So s/w should clear command complete interrupt status when CQE is
> +        * either halted or disabled. Otherwise unexpected SDCHI legacy
> +        * interrupt gets triggered when CQE is halted/disabled.
> +        */
> +       spin_lock_irqsave(&host->lock, flags);
> +       ctrl = sdhci_readl(host, SDHCI_INT_ENABLE);
> +       ctrl |= SDHCI_INT_RESPONSE;
> +       sdhci_writel(host,  ctrl, SDHCI_INT_ENABLE);
> +       sdhci_writel(host, SDHCI_INT_RESPONSE, SDHCI_INT_STATUS);
> +       spin_unlock_irqrestore(&host->lock, flags);
> +
> +       sdhci_cqe_disable(mmc, recovery);
> +}
> +
> +static void rk35xx_sdhci_cqe_post_disable(struct mmc_host *mmc)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +       u32 ctrl;
> +
> +       ctrl = sdhci_readl(host, dwc_priv->vendor_specific_area2 + CQHCI_CFG);
> +       ctrl &= ~CQHCI_ENABLE;
> +       sdhci_writel(host, ctrl, dwc_priv->vendor_specific_area2 + CQHCI_CFG);
> +}
> +
>  static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -679,6 +745,10 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
>         struct rk35xx_priv *priv = dwc_priv->priv;
> +       u32 extra = sdhci_readl(host, DECMSHC_EMMC_MISC_CON);
> +
> +       if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL))
> +               cqhci_deactivate(host->mmc);
>
>         if (mask & SDHCI_RESET_ALL && priv->reset) {
>                 reset_control_assert(priv->reset);
> @@ -687,6 +757,9 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
>         }
>
>         sdhci_reset(host, mask);
> +
> +       /* Enable INTERNAL CLOCK */
> +       sdhci_writel(host, MISC_INTCLK_EN | extra, DECMSHC_EMMC_MISC_CON);
>  }
>
>  static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
> @@ -1188,6 +1261,15 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_bf3_pdata = {
>  };
>  #endif
>
> +static const struct cqhci_host_ops rk35xx_cqhci_ops = {
> +       .pre_enable     = rk35xx_sdhci_cqe_pre_enable,
> +       .enable         = rk35xx_sdhci_cqe_enable,
> +       .disable        = rk35xx_sdhci_cqe_disable,
> +       .post_disable   = rk35xx_sdhci_cqe_post_disable,
> +       .dumpregs       = dwcmshc_cqhci_dumpregs,
> +       .set_tran_desc  = dwcmshc_set_tran_desc,
> +};
> +
>  static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
>         .pdata = {
>                 .ops = &sdhci_dwcmshc_rk35xx_ops,
> @@ -1196,6 +1278,7 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
>                 .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>                            SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>         },
> +       .cqhci_host_ops = &rk35xx_cqhci_ops,
>         .init = dwcmshc_rk35xx_init,
>         .postinit = dwcmshc_rk35xx_postinit,
>  };
> @@ -1245,7 +1328,8 @@ static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
>         .set_tran_desc  = dwcmshc_set_tran_desc,
>  };
>
> -static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *pdev)
> +static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *pdev,
> +                              const struct dwcmshc_pltfm_data *pltfm_data)
>  {
>         struct cqhci_host *cq_host;
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -1275,7 +1359,10 @@ static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *
>         }
>
>         cq_host->mmio = host->ioaddr + priv->vendor_specific_area2;
> -       cq_host->ops = &dwcmshc_cqhci_ops;
> +       if (pltfm_data->cqhci_host_ops)
> +               cq_host->ops = pltfm_data->cqhci_host_ops;
> +       else
> +               cq_host->ops = &dwcmshc_cqhci_ops;
>
>         /* Enable using of 128-bit task descriptors */
>         dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
> @@ -1443,7 +1530,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>                 priv->vendor_specific_area2 =
>                         sdhci_readw(host, DWCMSHC_P_VENDOR_AREA2);
>
> -               dwcmshc_cqhci_init(host, pdev);
> +               dwcmshc_cqhci_init(host, pdev, pltfm_data);
>         }
>
>         if (pltfm_data->postinit)
>
> --
> 2.51.0
>
