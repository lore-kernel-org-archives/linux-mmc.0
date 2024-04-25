Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B9B14E2D5
	for <linux-mmc@vger.kernel.org>; Thu, 25 Apr 2024 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062154; cv=none; b=Q9zGQa29aElUKq8qYtVmh4q+LXS79K+jii6DBbEHRdiPST467J1rucrdeJm5BNd02+4Ahr31TepPkLZn5J00eaPpPIxfI9vdqu1xQZoAFcd480iOQaXf8pM8SGaekbA0/+JPLy94FjvFO1q9KsDzT+EE/mTMnpiFfHKi5PmKKbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062154; c=relaxed/simple;
	bh=ZL8HHYvCq0ak38rqDJmiytamD3EVrDPvUPTuEJqpEhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tf8EqIFGM0cr9Oc7KDiQx5WxP7gNetZAKMFXw1Hn4jhq1NsYCM5h7I4aJJ/PbsUygibGgKrBW1IO+AYdXqSEmTh0/wvAdqrVC31XrFHCoSOde9ALf86lNZteMsY9p8HWJSPTDaws//1tqxjwDbFnECcvhRBvO6O3CZpx+Zp30JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LEbxTe29; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LEbxTe29"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-de469a634fbso1494542276.2
        for <linux-mmc@vger.kernel.org>; Thu, 25 Apr 2024 09:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714062151; x=1714666951; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QuQKIElXV0SROcK8jcZmdA0uu9zMqYotio4ffi8Z6+c=;
        b=LEbxTe29jVmoBHkq4AdkUuHbo+RvXlq5q2OWVuSs+KIe7np2AeDPx0DGBg8ON0Ic33
         xGuDnjbcNmQyIzwm5S6r3jMoYgyihfcAPjd5N2UIy1RoCf1F61IArzDYdeIX5LI4VGaY
         WP/zCdsVLuP1Fb3PCfG3LGIhUOl6YXHL7Tbiha5PZHWzA/8mhLlqcIwHmb4eiN5tT7rJ
         AGvdpg9MhNpNbT2gHt3tXaT1bFqyR0o6YONBUwWdZZr8iGhx3vlWAQlC8owuq7kLHGFL
         YNA1IQK9Qdvn37+Kt2qjvK8PAHy+tqzmqkOYVh7n1giGgmGqRZe979ygoavnmJoZ249W
         Jqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714062151; x=1714666951;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QuQKIElXV0SROcK8jcZmdA0uu9zMqYotio4ffi8Z6+c=;
        b=fz2IFv2jbgMpdV3JZDApmb3Jm9LlS8BFVgYtLKRpN16ECVyLrMs9juKaHsgK0NiF/w
         cVchBGe7nOvhIRr1zpaZ3SuOZMgUdtJLoUZ7jXhCQHY/Dd0gpoBtYLffAH4hA0c58X7M
         EEneOkm7VK0qODUK61nT+Ft4sZzxwuQ2wgwP/UbNnYJQso/kzPlnmjWrC6OxyNIcq7sN
         SbnKQ7tiWicTahqU9gofFYSr83JLqnnlsM27ygS5pdlVUA9ngSCMIUTp4wX62CS64il4
         mz3rvwwQx+mxLAcJIc03dO5nZHk3PH1dZFSeMeiLM/Wx0y4J+R1uPgWCp4VGqxpYzG6d
         trkw==
X-Forwarded-Encrypted: i=1; AJvYcCVvE++iuK7YjyNDMxJBCumlAWZXRfU7LNrAciGRcdDlGeoCG8PpInWRWViJyPFPMIwLTnqEYAMrZbsIaIzgYfjJ9YVlGjmVTyF6
X-Gm-Message-State: AOJu0YyA/yGcLhEnORnTfYeNDP12cgil16xgkZ8ghhUaKH/228xADWyq
	7/20941qeRKPlI3HSZl6V23CkpkOyrDThV4uiSmNXCtplkvlKFpULFqairOuNqfKV+B6iQcRgix
	u3oNt5V//CHla6M52gJ4l+/AegWfbbDXtvXldVg==
X-Google-Smtp-Source: AGHT+IF5TaRHu5ItnLprFQocrPIpCid1nu3FlhjNGqHAmBNXTDnP5h3zw+WrUOGh1XiiPqUPXLenvuW0xtyAakEgjck=
X-Received: by 2002:a25:26cd:0:b0:de4:5d4a:aa93 with SMTP id
 m196-20020a2526cd000000b00de45d4aaa93mr110721ybm.23.1714062151678; Thu, 25
 Apr 2024 09:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420021429.454-1-jszhang@kernel.org>
In-Reply-To: <20240420021429.454-1-jszhang@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 25 Apr 2024 18:21:56 +0200
Message-ID: <CAPDyKFrmhCN5bW31JuBA7QPXuCnSbCnkXyCFwAss3SfFUWEeWQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-dwcmshc: Add tuning support for Sophgo
 CV1800B and SG200X
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Apr 2024 at 04:28, Jisheng Zhang <jszhang@kernel.org> wrote:
>
> Implement the .platform_execute_tuning for Sophgo CV1800B and SG200X.
> Some code is borrowed from sdhci-esdhc-imx.c. The tuning result is
> similar as the one of SoC vendor's SDK.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Since v1:
>  - use usleep_range() instead of mdelay() as suggested by Adrian
>
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 112 ++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index ab4b964d4058..7b55acd9830c 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -66,6 +66,10 @@
>  #define CV18XX_SDHCI_PHY_CONFIG                        0x4c
>  #define  CV18XX_PHY_TX_BPS                     BIT(0)
>
> +#define CV18XX_TUNE_MAX                                128
> +#define CV18XX_TUNE_STEP                       1
> +#define CV18XX_RETRY_TUNING_MAX                        50
> +
>  /* Rockchip specific Registers */
>  #define DWCMSHC_EMMC_DLL_CTRL          0x800
>  #define DWCMSHC_EMMC_DLL_RXCLK         0x804
> @@ -685,6 +689,113 @@ static void cv18xx_sdhci_reset(struct sdhci_host *host, u8 mask)
>         sdhci_writel(host, val, priv->vendor_specific_area1 + CV18XX_SDHCI_PHY_TX_RX_DLY);
>  }
>
> +static void cv18xx_sdhci_set_tap(struct sdhci_host *host, int tap)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +       u16 clk;
> +       u32 val;
> +
> +       clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +       clk &= ~SDHCI_CLOCK_CARD_EN;
> +       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +       val = sdhci_readl(host, priv->vendor_specific_area1 + CV18XX_SDHCI_MSHC_CTRL);
> +       val &= ~CV18XX_LATANCY_1T;
> +       sdhci_writel(host, val, priv->vendor_specific_area1 + CV18XX_SDHCI_MSHC_CTRL);
> +
> +       val =  (FIELD_PREP(CV18XX_PHY_TX_DLY_MSK, 0) |
> +               FIELD_PREP(CV18XX_PHY_TX_SRC_MSK, CV18XX_PHY_TX_SRC_INVERT_CLK_TX) |
> +               FIELD_PREP(CV18XX_PHY_RX_DLY_MSK, tap));
> +       sdhci_writel(host, val, priv->vendor_specific_area1 + CV18XX_SDHCI_PHY_TX_RX_DLY);
> +
> +       sdhci_writel(host, 0, priv->vendor_specific_area1 + CV18XX_SDHCI_PHY_CONFIG);
> +
> +       clk |= SDHCI_CLOCK_CARD_EN;
> +       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +       usleep_range(1000, 2000);
> +}
> +
> +static int cv18xx_retry_tuning(struct mmc_host *mmc, u32 opcode, int *cmd_error)
> +{
> +       int ret, retry = 0;
> +
> +       while (retry < CV18XX_RETRY_TUNING_MAX) {
> +               ret = mmc_send_tuning(mmc, opcode, NULL);
> +               if (ret)
> +                       return ret;
> +               retry++;
> +       }
> +
> +       return 0;
> +}
> +
> +static void cv18xx_sdhci_post_tuning(struct sdhci_host *host)
> +{
> +       u32 val;
> +
> +       val = sdhci_readl(host, SDHCI_INT_STATUS);
> +       val |= SDHCI_INT_DATA_AVAIL;
> +       sdhci_writel(host, val, SDHCI_INT_STATUS);
> +
> +       sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +}
> +
> +static int cv18xx_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +       int min, max, avg, ret;
> +       int win_length, target_min, target_max, target_win_length;
> +
> +       min = max = 0;
> +       target_win_length = 0;
> +
> +       sdhci_reset_tuning(host);
> +
> +       while (max < CV18XX_TUNE_MAX) {
> +               /* find the mininum delay first which can pass tuning */
> +               while (min < CV18XX_TUNE_MAX) {
> +                       cv18xx_sdhci_set_tap(host, min);
> +                       if (!cv18xx_retry_tuning(host->mmc, opcode, NULL))
> +                               break;
> +                       min += CV18XX_TUNE_STEP;
> +               }
> +
> +               /* find the maxinum delay which can not pass tuning */
> +               max = min + CV18XX_TUNE_STEP;
> +               while (max < CV18XX_TUNE_MAX) {
> +                       cv18xx_sdhci_set_tap(host, max);
> +                       if (cv18xx_retry_tuning(host->mmc, opcode, NULL)) {
> +                               max -= CV18XX_TUNE_STEP;
> +                               break;
> +                       }
> +                       max += CV18XX_TUNE_STEP;
> +               }
> +
> +               win_length = max - min + 1;
> +               /* get the largest pass window */
> +               if (win_length > target_win_length) {
> +                       target_win_length = win_length;
> +                       target_min = min;
> +                       target_max = max;
> +               }
> +
> +               /* continue to find the next pass window */
> +               min = max + CV18XX_TUNE_STEP;
> +       }
> +
> +       cv18xx_sdhci_post_tuning(host);
> +
> +       /* use average delay to get the best timing */
> +       avg = (target_min + target_max) / 2;
> +       cv18xx_sdhci_set_tap(host, avg);
> +       ret = mmc_send_tuning(host->mmc, opcode, NULL);
> +
> +       dev_dbg(mmc_dev(host->mmc), "tuning %s at 0x%x ret %d\n",
> +               ret ? "failed" : "passed", avg, ret);
> +
> +       return ret;
> +}
> +
>  static const struct sdhci_ops sdhci_dwcmshc_ops = {
>         .set_clock              = sdhci_set_clock,
>         .set_bus_width          = sdhci_set_bus_width,
> @@ -721,6 +832,7 @@ static const struct sdhci_ops sdhci_dwcmshc_cv18xx_ops = {
>         .get_max_clock          = dwcmshc_get_max_clock,
>         .reset                  = cv18xx_sdhci_reset,
>         .adma_write_desc        = dwcmshc_adma_write_desc,
> +       .platform_execute_tuning = cv18xx_sdhci_execute_tuning,
>  };
>
>  static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
> --
> 2.43.0
>
