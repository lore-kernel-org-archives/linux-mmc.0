Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03C525DAEA
	for <linux-mmc@vger.kernel.org>; Mon,  9 Jun 2025 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749479156; cv=none; b=BfTqP5g5+f35thyex3rzwiOeNZ+deOAos0wmyM2xywCP+1eooP/uf3LcWj3u16QNyOPEE8OWc+hepXC1zMsrumAsazDEKGsFlCs5zvNsFSqfSKy5pbXLVtSJsbdrBEhgGDOpLKK/A3RQHM/BAZabCawblOiKyIP3qcm/J5gJFrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749479156; c=relaxed/simple;
	bh=nOOhR9HE52z4cwyThZqBSTh6VLk7nUpLILw22jbwwPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocplhW/9tMCFYpX64LjhE5STaQqDRQlvGlN08UDE8zCd0ydiajOeEIaxxApdxeNmc7ddBAhEoK7FymsJ5eWavk/Kw6LUmITgMN+5Nrc3O15gFCnJISUroObyCeRA3ihDccakoM/jlaQ0M6zh71ZCKv0xbkGkv+BZLLRUvUUZFTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pH9ku1Tc; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pH9ku1Tc"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso3864360276.2
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jun 2025 07:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749479153; x=1750083953; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fSlVOn8zYHT3nmqgFx/RCqI+UplNCizYjqKZhNGavjc=;
        b=pH9ku1TctaA2YkQz7N4Wd54CbalwZhWWO0cUclBG5TXzmJeuZR3vTqA+dhn4BmEte+
         oGQXjETmMnbuLorfJvbF0AYKZWVV+JMD7zS+5v2XtqtHyuf1XZM2yg6Jx+y4T9D6Sy4Z
         HSJ+7uKVW/Q6NZV7K5tKQpMQIYQ99J4zmcmAR+7fGBB9StSRrDnqfIy/AyeZM/88piml
         yPCTJ8oJ4ffZkD8ugG7rTerwZTIfbqYBA7PMt+tSUepnTOd6sSKjNBg6qaI9Kp98uwiD
         xwcNzkqgaSsy3iwNnOW3ig2qbf7Xz0yBiY7qjLe/VqJ5hIxsa3QeawSD1ztGDFNoElTP
         +nGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749479153; x=1750083953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSlVOn8zYHT3nmqgFx/RCqI+UplNCizYjqKZhNGavjc=;
        b=M5+Lk3WqHCq0AIuR9GiBGKX4rKiRAGR/TjyNYYd1axuNKtXtVOZ1+9QnhLQMP5GQKO
         Cta8BlOMfVRxYutzoQd/8YHO2wiIIUsdxokYsByymdGe5SrKbjql+fELZTDuz6dl7321
         ksS7D91TO5ZkOQILJgwgbeBTu1ds1/pHWDjb4ChGCKTE4ys0NyWOrh+vFGsfJP7qCF4I
         tuOrVS/PUoHA1aON3NTpFGEEUFWkEy6H2KY0XOJuAU+SHTh7HIXFzItTSEq3IdvywcdT
         ANTHCB5XLJoH8rmfK1isyQx8Uj6D+yciPpGmqbyg2FYnCtKhRPqKouWJO/WPrQRgOLlr
         ysng==
X-Forwarded-Encrypted: i=1; AJvYcCWmUm6GVDuWcxT2T5JqWp2JSGdfyc+CeBE4iA5PB9jpf47U8cqFNbfb3+XIlfRKuLN+nfxgKOB1TKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlz+a/xdwORJ6kj7B6t6mwD/X+vo+AOtQ58shIWD2yUhShs3IB
	8w5o7yfrsN4g5CZtDgql2BpmfqK/Jci+yTijwgBLt15gOkNjLZdZYkefbazt2B9iSDkyctDEPhs
	fCjkLL8Pjw6xDvk0ZO+5LQLdeOezSe7SAy1udIICA3Q==
X-Gm-Gg: ASbGncsJ95F5A0+w+I+GgCnECSRBMNDQmg+ixb9iCmI5AjcqU+5JzwB5i1Ko0X2vRhZ
	KJ9fmKNMrWOD+A2tRIakb2MKwq4jLPmYo4fksLop8iy1xAfUI2IqRSENu4KpqLfy7c4rsKWbOBN
	t1/yxOF+7n42ktnFOCBAmu04zdazxvXsw8NRrxmc8ixjzN
X-Google-Smtp-Source: AGHT+IFYD9dDGCazZ3bzfDcCqhOCCus+7kFgIdLjwma2iAxhkhkBV8EHgGiSyMChjqXq22tiyygWsgmOIG4KMALEZHc=
X-Received: by 2002:a05:6902:2689:b0:e7b:9972:5cc with SMTP id
 3f1490d57ef6-e81a212affcmr17321994276.24.1749479153406; Mon, 09 Jun 2025
 07:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530165643.141295-1-adrian.hunter@intel.com>
In-Reply-To: <20250530165643.141295-1-adrian.hunter@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Jun 2025 16:25:17 +0200
X-Gm-Features: AX0GCFvd-VqGPt1-f5eKEptC6Fzu98KMPPekjjqxvi3BWfYgRe7LcMbM9z7lgOc
Message-ID: <CAPDyKFp_eJMBqYpVNgcfWW5achut3Tr8W6JH401WFNtzN8B2ng@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: sdhci: Return void from sdhci_runtime_suspend_host()
 and sdhci_runtime_resume_host()
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Haibo Chen <haibo.chen@nxp.com>, Aubin Constans <aubin.constans@microchip.com>, 
	Eugen Hristev <eugen.hristev@collabora.com>, Karel Balej <balejk@matfyz.cz>, 
	Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Hu Ziji <huziji@marvell.com>, Judith Mendez <jm@ti.com>, Andrew Davis <afd@ti.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 May 2025 at 18:57, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> It does not seem like these functions will ever need the return value,
> which is presently always zero.
>
> Simplify the usage by making the return type 'void' instead.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>
> Changes in V2:
>
>         Fix warning reported by kernel test robot:
>                 drivers/mmc/host/sdhci-esdhc-imx.c:2103:6:
>                 warning: variable 'ret' is used uninitialized
>                 whenever 'if' condition is false
>                 [-Wsometimes-uninitialized]
>
>
>  drivers/mmc/host/sdhci-acpi.c      |  8 +++-----
>  drivers/mmc/host/sdhci-esdhc-imx.c | 12 +++---------
>  drivers/mmc/host/sdhci-of-at91.c   |  8 ++++----
>  drivers/mmc/host/sdhci-pci-core.c  | 19 ++++---------------
>  drivers/mmc/host/sdhci-pxav3.c     |  8 +++-----
>  drivers/mmc/host/sdhci-s3c.c       | 10 ++++------
>  drivers/mmc/host/sdhci-xenon.c     |  9 ++-------
>  drivers/mmc/host/sdhci.c           |  8 ++------
>  drivers/mmc/host/sdhci.h           |  4 ++--
>  drivers/mmc/host/sdhci_am654.c     |  8 ++------
>  10 files changed, 29 insertions(+), 65 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index e6c5c82f64fa..d04c633f2b59 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -1028,14 +1028,11 @@ static int sdhci_acpi_runtime_suspend(struct device *dev)
>  {
>         struct sdhci_acpi_host *c = dev_get_drvdata(dev);
>         struct sdhci_host *host = c->host;
> -       int ret;
>
>         if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>                 mmc_retune_needed(host->mmc);
>
> -       ret = sdhci_runtime_suspend_host(host);
> -       if (ret)
> -               return ret;
> +       sdhci_runtime_suspend_host(host);
>
>         sdhci_acpi_reset_signal_voltage_if_needed(dev);
>         return 0;
> @@ -1047,7 +1044,8 @@ static int sdhci_acpi_runtime_resume(struct device *dev)
>
>         sdhci_acpi_byt_setting(&c->pdev->dev);
>
> -       return sdhci_runtime_resume_host(c->host, 0);
> +       sdhci_runtime_resume_host(c->host, 0);
> +       return 0;
>  }
>
>  #endif
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index ac187a8798b7..089ed0ccd9c4 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -2106,9 +2106,7 @@ static int sdhci_esdhc_runtime_suspend(struct device *dev)
>                         return ret;
>         }
>
> -       ret = sdhci_runtime_suspend_host(host);
> -       if (ret)
> -               return ret;
> +       sdhci_runtime_suspend_host(host);
>
>         if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>                 mmc_retune_needed(host->mmc);
> @@ -2122,7 +2120,7 @@ static int sdhci_esdhc_runtime_suspend(struct device *dev)
>         if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
>                 cpu_latency_qos_remove_request(&imx_data->pm_qos_req);
>
> -       return ret;
> +       return 0;
>  }
>
>  static int sdhci_esdhc_runtime_resume(struct device *dev)
> @@ -2152,17 +2150,13 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
>
>         esdhc_pltfm_set_clock(host, imx_data->actual_clock);
>
> -       err = sdhci_runtime_resume_host(host, 0);
> -       if (err)
> -               goto disable_ipg_clk;
> +       sdhci_runtime_resume_host(host, 0);
>
>         if (host->mmc->caps2 & MMC_CAP2_CQE)
>                 err = cqhci_resume(host->mmc);
>
>         return err;
>
> -disable_ipg_clk:
> -       clk_disable_unprepare(imx_data->clk_ipg);
>  disable_per_clk:
>         clk_disable_unprepare(imx_data->clk_per);
>  disable_ahb_clk:
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 97988ed37467..8f12ba6a4f90 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -251,9 +251,8 @@ static int sdhci_at91_runtime_suspend(struct device *dev)
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_at91_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -       int ret;
>
> -       ret = sdhci_runtime_suspend_host(host);
> +       sdhci_runtime_suspend_host(host);
>
>         if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>                 mmc_retune_needed(host->mmc);
> @@ -262,7 +261,7 @@ static int sdhci_at91_runtime_suspend(struct device *dev)
>         clk_disable_unprepare(priv->hclock);
>         clk_disable_unprepare(priv->mainck);
>
> -       return ret;
> +       return 0;
>  }
>
>  static int sdhci_at91_runtime_resume(struct device *dev)
> @@ -300,7 +299,8 @@ static int sdhci_at91_runtime_resume(struct device *dev)
>         }
>
>  out:
> -       return sdhci_runtime_resume_host(host, 0);
> +       sdhci_runtime_resume_host(host, 0);
> +       return 0;
>  }
>  #endif /* CONFIG_PM */
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 13a84b9309e0..7f66d426c3c2 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -152,18 +152,15 @@ static int sdhci_pci_runtime_suspend_host(struct sdhci_pci_chip *chip)
>  {
>         struct sdhci_pci_slot *slot;
>         struct sdhci_host *host;
> -       int i, ret;
>
> -       for (i = 0; i < chip->num_slots; i++) {
> +       for (int i = 0; i < chip->num_slots; i++) {
>                 slot = chip->slots[i];
>                 if (!slot)
>                         continue;
>
>                 host = slot->host;
>
> -               ret = sdhci_runtime_suspend_host(host);
> -               if (ret)
> -                       goto err_pci_runtime_suspend;
> +               sdhci_runtime_suspend_host(host);
>
>                 if (chip->rpm_retune &&
>                     host->tuning_mode != SDHCI_TUNING_MODE_3)
> @@ -171,26 +168,18 @@ static int sdhci_pci_runtime_suspend_host(struct sdhci_pci_chip *chip)
>         }
>
>         return 0;
> -
> -err_pci_runtime_suspend:
> -       while (--i >= 0)
> -               sdhci_runtime_resume_host(chip->slots[i]->host, 0);
> -       return ret;
>  }
>
>  static int sdhci_pci_runtime_resume_host(struct sdhci_pci_chip *chip)
>  {
>         struct sdhci_pci_slot *slot;
> -       int i, ret;
>
> -       for (i = 0; i < chip->num_slots; i++) {
> +       for (int i = 0; i < chip->num_slots; i++) {
>                 slot = chip->slots[i];
>                 if (!slot)
>                         continue;
>
> -               ret = sdhci_runtime_resume_host(slot->host, 0);
> -               if (ret)
> -                       return ret;
> +               sdhci_runtime_resume_host(slot->host, 0);
>         }
>
>         return 0;
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 3fb56face3d8..450d2d0e0c39 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -525,11 +525,8 @@ static int sdhci_pxav3_runtime_suspend(struct device *dev)
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_pxa *pxa = sdhci_pltfm_priv(pltfm_host);
> -       int ret;
>
> -       ret = sdhci_runtime_suspend_host(host);
> -       if (ret)
> -               return ret;
> +       sdhci_runtime_suspend_host(host);
>
>         if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>                 mmc_retune_needed(host->mmc);
> @@ -551,7 +548,8 @@ static int sdhci_pxav3_runtime_resume(struct device *dev)
>         if (!IS_ERR(pxa->clk_core))
>                 clk_prepare_enable(pxa->clk_core);
>
> -       return sdhci_runtime_resume_host(host, 0);
> +       sdhci_runtime_resume_host(host, 0);
> +       return 0;
>  }
>  #endif
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index bdf4dc0d6b77..dedc4e3a217e 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -714,9 +714,8 @@ static int sdhci_s3c_runtime_suspend(struct device *dev)
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_s3c *ourhost = to_s3c(host);
>         struct clk *busclk = ourhost->clk_io;
> -       int ret;
>
> -       ret = sdhci_runtime_suspend_host(host);
> +       sdhci_runtime_suspend_host(host);
>
>         if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>                 mmc_retune_needed(host->mmc);
> @@ -724,7 +723,7 @@ static int sdhci_s3c_runtime_suspend(struct device *dev)
>         if (ourhost->cur_clk >= 0)
>                 clk_disable_unprepare(ourhost->clk_bus[ourhost->cur_clk]);
>         clk_disable_unprepare(busclk);
> -       return ret;
> +       return 0;
>  }
>
>  static int sdhci_s3c_runtime_resume(struct device *dev)
> @@ -732,13 +731,12 @@ static int sdhci_s3c_runtime_resume(struct device *dev)
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_s3c *ourhost = to_s3c(host);
>         struct clk *busclk = ourhost->clk_io;
> -       int ret;
>
>         clk_prepare_enable(busclk);
>         if (ourhost->cur_clk >= 0)
>                 clk_prepare_enable(ourhost->clk_bus[ourhost->cur_clk]);
> -       ret = sdhci_runtime_resume_host(host, 0);
> -       return ret;
> +       sdhci_runtime_resume_host(host, 0);
> +       return 0;
>  }
>  #endif
>
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 098f0ea45cbe..15a76f8accea 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -648,11 +648,8 @@ static int xenon_runtime_suspend(struct device *dev)
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -       int ret;
>
> -       ret = sdhci_runtime_suspend_host(host);
> -       if (ret)
> -               return ret;
> +       sdhci_runtime_suspend_host(host);
>
>         if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>                 mmc_retune_needed(host->mmc);
> @@ -687,9 +684,7 @@ static int xenon_runtime_resume(struct device *dev)
>                 priv->restore_needed = false;
>         }
>
> -       ret = sdhci_runtime_resume_host(host, 0);
> -       if (ret)
> -               goto out;
> +       sdhci_runtime_resume_host(host, 0);
>         return 0;
>  out:
>         clk_disable_unprepare(pltfm_host->clk);
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 32fa0b2bb912..9e0941f5023a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3863,7 +3863,7 @@ int sdhci_resume_host(struct sdhci_host *host)
>
>  EXPORT_SYMBOL_GPL(sdhci_resume_host);
>
> -int sdhci_runtime_suspend_host(struct sdhci_host *host)
> +void sdhci_runtime_suspend_host(struct sdhci_host *host)
>  {
>         unsigned long flags;
>
> @@ -3880,12 +3880,10 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
>         spin_lock_irqsave(&host->lock, flags);
>         host->runtime_suspended = true;
>         spin_unlock_irqrestore(&host->lock, flags);
> -
> -       return 0;
>  }
>  EXPORT_SYMBOL_GPL(sdhci_runtime_suspend_host);
>
> -int sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset)
> +void sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset)
>  {
>         struct mmc_host *mmc = host->mmc;
>         unsigned long flags;
> @@ -3931,8 +3929,6 @@ int sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset)
>         sdhci_enable_card_detection(host);
>
>         spin_unlock_irqrestore(&host->lock, flags);
> -
> -       return 0;
>  }
>  EXPORT_SYMBOL_GPL(sdhci_runtime_resume_host);
>
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index f9d65dd0f2b2..6ccb21e50ee4 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -879,8 +879,8 @@ bool sdhci_enable_irq_wakeups(struct sdhci_host *host);
>  void sdhci_disable_irq_wakeups(struct sdhci_host *host);
>  int sdhci_suspend_host(struct sdhci_host *host);
>  int sdhci_resume_host(struct sdhci_host *host);
> -int sdhci_runtime_suspend_host(struct sdhci_host *host);
> -int sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset);
> +void sdhci_runtime_suspend_host(struct sdhci_host *host);
> +void sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset);
>  #endif
>
>  void sdhci_cqe_enable(struct mmc_host *mmc);
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 73385ff4c0f3..e4d9faa05e11 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -1082,9 +1082,7 @@ static int sdhci_am654_runtime_suspend(struct device *dev)
>         if (ret)
>                 return ret;
>
> -       ret = sdhci_runtime_suspend_host(host);
> -       if (ret)
> -               return ret;
> +       sdhci_runtime_suspend_host(host);
>
>         /* disable the clock */
>         clk_disable_unprepare(pltfm_host->clk);
> @@ -1106,9 +1104,7 @@ static int sdhci_am654_runtime_resume(struct device *dev)
>         if (ret)
>                 return ret;
>
> -       ret = sdhci_runtime_resume_host(host, 0);
> -       if (ret)
> -               return ret;
> +       sdhci_runtime_resume_host(host, 0);
>
>         ret = cqhci_resume(host->mmc);
>         if (ret)
> --
> 2.48.1
>
