Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBF848A2C9
	for <linux-mmc@vger.kernel.org>; Wed, 21 Jan 2026 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999486; cv=pass; b=bvHf9e/PjoscVD7t2omvu/hhKGEXqKS3r3N/8+NpgU6VF7wctBeuvFQ1DQfr0nsytpO8dp0o8yypR11X8XyuXMeOJh+qmlNyUU83uucZNc9gdwNZI/TvTg4PaoHy+Y0DHbTVZeRYYGe94JDcjo9T2dlxShN+UFP5JF1Ybw64oco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999486; c=relaxed/simple;
	bh=xc3mKastqq6iX8EeUiMcKk8mfGYIQiSwqYYU5vEapgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3UW3flG3rr65PzNJdrYzkm7ylG1RiQ1+qAma5db+/WoGPx62SESM8h3nCcA2fabM8inD2R+brvEPfFqnBZCELrVw16NsECFHxexCM906zqDpN08sSKWRimdvgPx/sQzOGzFEmccPqWStRYTb7/geyN46SlL92U+sCYuwv19Bnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N4W2dnj0; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N4W2dnj0"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-598f8136a24so7517932e87.3
        for <linux-mmc@vger.kernel.org>; Wed, 21 Jan 2026 04:44:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768999480; cv=none;
        d=google.com; s=arc-20240605;
        b=JljaiBUTjMW48Pnhlnpzj7HX0kr04GGakZ3idzXu0YVYAqs5WPduFQ6vM0V8ZSOSI9
         BoJrGQ+EqSRm1Sq5qWOJmemmjunzA6zSynjocULLkq4M2+G2T+xf+gTPq/MEAPqVRBDs
         5BGA3E4GXCwZSIisfnguTS5nINlygj/3Ygpd83jN4TEMuB0FDQpSeG/lMDjozNxpc0m/
         qGDiCd1fK6id2NxlVa+nOkAnv/+BgkS6L7L+gcTpaKhP9YQNdmIaHHMUUuBi5Tj46Wja
         njHN8rsmmYRTuelWAVnEs/Jr1uLzC/KhKmZkHLdJ7s9j8yVW2/nkrLurU+pCtKXb03/c
         jQWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KX/gQRH8XWSQA+kVLrNMJ+xSKGOn45C/xodo0TsBA5M=;
        fh=6AqHbDwDp4WMyagr/lLdoVFmwFSdGDvVpkCMhekLenI=;
        b=l0VJ8Z/MBYNjJCklQ4pC/tzIaPXdd9A2BpFqJCtEmPBz2xvC9jvlVeIiOoA4m7H9SF
         JAvGoahiSj6enxXojZfU7Q3pBG5KJqP+dmXFpl3yvLXIwYV8jMWQXtHqWrJ+sLdQBh/M
         yPbhLJQrW9Nm4at82h6W6B623HlkZaeAj+qMzhX9mXF3/EsWmfKbtn64+9J3lk/OtYWe
         itBt1t9H3OZi0Y6wbnnTkd6npZtGwiaRw0pUWZhIob1srwhtuLmi+jNA32XszX9qbVgM
         r+EacI/+yTzya2qQPER+oqndZHfXJ1BZCBubt4JEzYMESpHcHR+uJsolBL58AE0C0LX1
         ND+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768999480; x=1769604280; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KX/gQRH8XWSQA+kVLrNMJ+xSKGOn45C/xodo0TsBA5M=;
        b=N4W2dnj0qEFHLVyJpX/zrmb/MJnWsxq6Qy/56NWn98C3AXk/HxDoAC2WPmzltDRw+z
         Xt2licdUFs/+cMfmWelQGvJ+E7L6Xdq/5pymIALDm6zmkAbDLL52iFuQUhPGWkoG4W4l
         HaiwIG+wnbsVbJVv9ciJjguOx1M5wf2BYVnY27umHO5rlhkeqz5/ib9mjY9Kt5+1GXmH
         FjrnU0MkGP8flJi23sXo0RLUEoUBl0kmEc98RNhzlAqHA0TVwrgh4EE9EuYd6A9PXyQ7
         H0glIliHKlr1qNnSu3+GPkQgY6QoBfnEzRaBRM5yc6ngDcJPvUyppoApBjD9+PIYU7J3
         C7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768999480; x=1769604280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KX/gQRH8XWSQA+kVLrNMJ+xSKGOn45C/xodo0TsBA5M=;
        b=QAbzQYsEnDxangONtsqSkYNuwiR34ujzo8VA2g2VnzrDessXo27HeYxCwNOcZ9KvE1
         PMLjEshoHrSJwajkMo784ir5SyQzou/xPraTADLO9lDg5BfI1kGn5T7Lvy60qWObyfMs
         EJCmX0eBA1F0tSAE7MH7gJ8hf6C47mNiDqe9L1OB0C5iOjZ7zxS8ypuW4NAlF59UGmfA
         Fd+pk5R0tLVwlrlpakj/6GeimMj4rC91zdea7hDhUhWgU2Y8hQkOXAQtV4xu4Ydhut6c
         ZsNbwht+8TVUeJD81xaizXdb/49ycYY2fBx95NDRufly7CkLs6EbihdXEOs+ISd8yhqP
         N+/g==
X-Forwarded-Encrypted: i=1; AJvYcCVgaUab5uft9/4UadZiKozqYhkCb80WieuXS3dQ/P/O2ZJ3GgN9B6QHTxEXWkBTOJWvQOYJ3um5CUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzko+wtRooVxzwVINzxb+l2k9E4pV7aHzJV0trOhKF+ISs6rSK/
	NSouIuqaltUAPTpnRLuTRx66aFPm9kQWDZ/NFYi+8T5ybla3w173VnOY70v80MMThYhnAFsAuU+
	hy+Me6whocEGvM9C8Tk/KVSn5htJPJIidwKa8vJW9rQ==
X-Gm-Gg: AZuq6aIiVC5gugFyJ4ieKdQ9ykmia5tTPVEHMWGVO8xldjfwyEDYpqDpQg03aedZVlQ
	+tVvxhk8tHu1t2h9S1NuGJn/grYIEt4uBLysGyKw2bLVlfCGbE3Bip/bNBK74WNh6TxmBUczuHU
	AQzjrVXIXxVCvvLeSn7xbbAra8vCT1AbeBz9H4IikO6uOycbfNObjT20iGCVX4toCr1N1aWKD4i
	vOSrLw8Ak4ulUlZRJ9pG7oL+jyKBU0xL29uASNk6UILzvGg3ZqIZAOndYkXGAisYvyE2yvu
X-Received: by 2002:a05:6512:3a94:b0:595:91dc:72a5 with SMTP id
 2adb3069b0e04-59baffcb9d7mr5264864e87.40.1768999479872; Wed, 21 Jan 2026
 04:44:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126064251.1928529-1-quic_mdalam@quicinc.com>
In-Reply-To: <20251126064251.1928529-1-quic_mdalam@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 21 Jan 2026 13:44:04 +0100
X-Gm-Features: AZwV_Qg1yN2uwKr4_1VyyUheg-q9reeNrvQ_fOzzUfFGEjx4fYB9jzMsn5Vxrv0
Message-ID: <CAPDyKFppNgYvHJDqfvyQ0DTYCwgcSR12D+-=04NGEDtbM8FmTA@mail.gmail.com>
Subject: Re: [PATCH v6] mmc: sdhci-msm: Enable ICE for CQE-capable controllers
 with non-CQE cards
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: adrian.hunter@intel.com, linux-arm-msm@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, abel.vesa@linaro.org, 
	ebiggers@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Nov 2025 at 07:43, Md Sadre Alam <quic_mdalam@quicinc.com> wrote:
>
> Enable Inline Crypto Engine (ICE) support for CQE-capable sdhci-msm
> controllers when used with eMMC cards that do not support CQE.
>
> This addresses the scenario where:
> - The host controller supports CQE (and has CQHCI crypto infrastructure)
> - The eMMC card does not support CQE
> - Standard (non-CMDQ) requests need crypto support
>
> This allows hardware-accelerated encryption and decryption for standard
> requests on CQE-capable hardware by utilizing the existing CQHCI crypto
> register space even when CQE functionality is not available due to card
> limitations.
>
> The implementation:
> - Adds ICE register definitions for non-CQE crypto configuration
> - Implements per-request crypto setup via sdhci_msm_ice_cfg()
> - Hooks into the request path via mmc_host_ops.request for non-CQE requests
> - Uses CQHCI register space (NONCQ_CRYPTO_PARM/DUN) for crypto configuration
>
> With this, CQE-capable controllers can benefit from inline encryption
> when paired with non-CQE cards, improving performance for encrypted I/O
> while maintaining compatibility with existing CQE crypto support.
>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

This has been applied for next since a few weeks, but I have a
question. See more below.

[...]

>
>  drivers/mmc/host/sdhci-msm.c | 77 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 3b85233131b3..da356627d9de 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -157,6 +157,17 @@
>  #define CQHCI_VENDOR_CFG1      0xA00
>  #define CQHCI_VENDOR_DIS_RST_ON_CQ_EN  (0x3 << 13)
>
> +/* non command queue crypto enable register*/
> +#define NONCQ_CRYPTO_PARM              0x70
> +#define NONCQ_CRYPTO_DUN               0x74
> +
> +#define DISABLE_CRYPTO                 BIT(15)
> +#define CRYPTO_GENERAL_ENABLE          BIT(1)
> +#define HC_VENDOR_SPECIFIC_FUNC4       0x260
> +
> +#define ICE_HCI_PARAM_CCI      GENMASK(7, 0)
> +#define ICE_HCI_PARAM_CE       GENMASK(8, 8)
> +
>  struct sdhci_msm_offset {
>         u32 core_hc_mode;
>         u32 core_mci_data_cnt;
> @@ -300,6 +311,7 @@ struct sdhci_msm_host {
>         u32 dll_config;
>         u32 ddr_config;
>         bool vqmmc_enabled;
> +       bool non_cqe_ice_init_done;
>  };
>
>  static const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
> @@ -2012,6 +2024,68 @@ static int sdhci_msm_ice_keyslot_evict(struct blk_crypto_profile *profile,
>         return qcom_ice_evict_key(msm_host->ice, slot);
>  }
>
> +static void sdhci_msm_non_cqe_ice_init(struct sdhci_host *host)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +       struct mmc_host *mmc = msm_host->mmc;
> +       struct cqhci_host *cq_host = mmc->cqe_private;
> +       u32 config;
> +
> +       config = sdhci_readl(host, HC_VENDOR_SPECIFIC_FUNC4);
> +       config &= ~DISABLE_CRYPTO;
> +       sdhci_writel(host, config, HC_VENDOR_SPECIFIC_FUNC4);
> +       config = cqhci_readl(cq_host, CQHCI_CFG);
> +       config |= CRYPTO_GENERAL_ENABLE;
> +       cqhci_writel(cq_host, config, CQHCI_CFG);
> +}
> +
> +static void sdhci_msm_ice_cfg(struct sdhci_host *host, struct mmc_request *mrq)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +       struct mmc_host *mmc = msm_host->mmc;
> +       struct cqhci_host *cq_host = mmc->cqe_private;
> +       unsigned int crypto_params = 0;
> +       int key_index;
> +
> +       if (mrq->crypto_ctx) {
> +               if (!msm_host->non_cqe_ice_init_done) {
> +                       sdhci_msm_non_cqe_ice_init(host);
> +                       msm_host->non_cqe_ice_init_done = true;
> +               }
> +
> +               key_index = mrq->crypto_key_slot;
> +               crypto_params = FIELD_PREP(ICE_HCI_PARAM_CE, 1) |
> +                               FIELD_PREP(ICE_HCI_PARAM_CCI, key_index);
> +
> +               cqhci_writel(cq_host, crypto_params, NONCQ_CRYPTO_PARM);
> +               cqhci_writel(cq_host, lower_32_bits(mrq->crypto_ctx->bc_dun[0]),
> +                            NONCQ_CRYPTO_DUN);
> +       } else {
> +               cqhci_writel(cq_host, crypto_params, NONCQ_CRYPTO_PARM);

Should we really call cqhci_writel() here, even if
sdhci_msm_non_cqe_ice_init() has not been called yet?

> +       }
> +
> +       /* Ensure crypto configuration is written before proceeding */
> +       wmb();
> +}
> +
> +/*
> + * Handle non-CQE MMC requests with ICE crypto support.
> + * Configures ICE registers before passing the request to
> + * the standard SDHCI handler.
> + */
> +static void sdhci_msm_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +
> +       /* Only need to handle non-CQE crypto requests in this path */
> +       if (mmc->caps2 & MMC_CAP2_CRYPTO)
> +               sdhci_msm_ice_cfg(host, mrq);
> +
> +       sdhci_request(mmc, mrq);
> +}
> +
>  static const struct blk_crypto_ll_ops sdhci_msm_crypto_ops = {
>         .keyslot_program        = sdhci_msm_ice_keyslot_program,
>         .keyslot_evict          = sdhci_msm_ice_keyslot_evict,
> @@ -2762,6 +2836,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>
>         msm_host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
>
> +#ifdef CONFIG_MMC_CRYPTO
> +       host->mmc_host_ops.request = sdhci_msm_request;
> +#endif
>         /* Set the timeout value to max possible */
>         host->max_timeout_count = 0xF;
>
> --
> 2.34.1
>

Kind regards
Uffe
