Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F63E1F7577
	for <linux-mmc@vger.kernel.org>; Fri, 17 Jan 2025 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737113919; cv=none; b=PlQbHNYV2LPfEG+IRA78xUY38PhSya6HkA3aoRMkNCJ18mSKCl5j7kTzgYX639Cnug8sSup6vtRtc5yqESXshsVg/5W+3VZXJv7sq6zlr3qvlR2LCaq+jvHg0+oVuaEE6doD1rYYDU6CRzlGEhRuHozvWkeJ+ralyiOv6ODGCik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737113919; c=relaxed/simple;
	bh=xLSTVg8aF+qRLDZqDFcgXTIUheIrK52yydEphPsAHpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4PvepTuBNX69OvHQ4GX6d4Xk4i2bpeLemRUwg6JUO85hb38msYnJrXbASr4cxPdMEnbCylsC9bhBXbfkm77bcuqWtzzpuA5li6ZwsWZ8q4SoLaJ1xuztZk5SJTXcV7NbxsBNV3weyyiZz9lvVk6s70030TCXbHuyHFuWjCr8X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rh6GYKSR; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rh6GYKSR"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e39779a268bso3213539276.1
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jan 2025 03:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737113916; x=1737718716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0mJJOlz6uR5ZkcRAiOz6gDo5saPIYLvSvvuRIdHEdog=;
        b=Rh6GYKSRMXEZmOdsO7isruC9QZXPHY8wAu+gugwRgHjHz8rGyw3YRffuM6/fG1bV6Q
         +LFSzWRyjy8rfTvr2qOQvkL8ub7IDhz3DGSCBhpmM4dDrsuuMHzQtvialj2EoSRIkuY1
         4+2V2M+PH5PZbF3I6Ri/D8dJ/h7nNeNTCPweyWpokt0GfmR6G9krUDDIQN/0pvqKN61x
         hFwdfJD2F3PktExRLjs0nlj0houWnAPttE17ndbHkIx7wcm37GGJGKw8KBnGLSCg9Urm
         ZdBRWKkckRqm4GW8Ql5diQUH3mt3LaDsV2sIipceV1Y3sKwXCT3vnSQT5Qz5nk6ucfkH
         44Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737113916; x=1737718716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0mJJOlz6uR5ZkcRAiOz6gDo5saPIYLvSvvuRIdHEdog=;
        b=Vl6ae11hsgPZp4tlL0jWZd3W5g4yakwGpf0Fg06nkS/2HPEBhS+hLP0uOGQUVj28ag
         pGSvSBu7/0LWc8k96kXIwJs6o+CPfBSb48jwZQ9QzQlgnRwUmTOfCldHA+8meV10KvIo
         YOBsm2XkfxEVqB0p2OZO/LpH4KfabkMtJ/F+v5QXOb/EYq8jVjlzE+Qg356/Ap6cZNKu
         4GjmquXjvjS6zm1E08jHDRRYR7zT4gvv18kyNY+LQEHOOnH65FimW43seb4CUngiFkvx
         NMt6Jox6SfFOhB+p9wRNMGYQAcfIimc0X8iKqh0TJoOyleE0q2Wh/ZytxSxVi7bqPbhS
         sa8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1mJdM7syq6iAoeKbr4nvyJ2HNKOa/LO7jnylXq+h+yK2iL6vwvnywKff6akQXsANDGqmHvyubcTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWCdICb+zYnu3ihpOsH9wmeSbk5DH8jNsxtmYHn6JtzNpQ1kEB
	KpI+nrJ6AksMcLRYJgAga4l5/T0zc5fYTkVSbKQXkA6vkFUMz7bf9PB7Mn6bdEOGMH4PYTaZNgA
	0tDsjzLcSWhZa7Pe9vRAwGsaRS5Aicn+RQsgcMg==
X-Gm-Gg: ASbGncvkhpv8q/GrJiFhckaMg0glBFNgroxkUgJ3N0VtUOJ+uMEkGfYWKIEDqsZQUF1
	oMKzxMViqWBCA/A198g0NVMdTA0GgkEfuK3vy7a4=
X-Google-Smtp-Source: AGHT+IH6sbrHZpfPtB0gOqdesf2laUrdMqC8hmqfbSsr01XH8sLCKvLCLkKqZqEOXUkDJm6/EQUGWK7PpeDd0ls3Wq0=
X-Received: by 2002:a25:b309:0:b0:e57:87a6:1ccb with SMTP id
 3f1490d57ef6-e578a10f42bmr10077884276.4.1737113916359; Fri, 17 Jan 2025
 03:38:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114083514.258379-1-quic_yuanjiey@quicinc.com>
In-Reply-To: <20250114083514.258379-1-quic_yuanjiey@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 17 Jan 2025 12:38:00 +0100
X-Gm-Features: AbW1kvYDSuYT8nN46TY9M7sAhLbywcWar8Tg8FoAj_2a7CbnQQ-Fz-3pO9uzpN8
Message-ID: <CAPDyKFq_QDHaDOygMp8S+9+UURyJLhc1BoegYXHOX=xvddz3VQ@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: sdhci-msm: Correctly set the load for the regulator
To: Yuanjie Yang <quic_yuanjiey@quicinc.com>
Cc: adrian.hunter@intel.com, linux-arm-msm@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dmitry.baryshkov@linaro.org, andersson@kernel.org, quic_tingweiz@quicinc.com, 
	quic_zhgao@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Jan 2025 at 09:35, Yuanjie Yang <quic_yuanjiey@quicinc.com> wrote:
>
> Qualcomm regulator supports two power supply modes: HPM and LPM.
> Currently, the sdhci-msm.c driver does not set the load to adjust
> the current for eMMC and SD. If the regulator dont't set correct
> load in LPM state, it will lead to the inability to properly
> initialize eMMC and SD.
>
> Set the correct regulator current for eMMC and SD to ensure that the
> device can work normally even when the regulator is in LPM.
>
> Signed-off-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v4:
> - Optimize msm_config_vmmc_regulator and msm_config_vqmmc_regulator code logic
> - Delete redundant return in msm_config_vmmc_regulator and msm_config_vqmmc_regulator
> - Rebase on tag: next-20250114
> - Link to v3: https://lore.kernel.org/linux-arm-msm/20241226031845.2574669-1-quic_yuanjiey@quicinc.com/
>
> Changes in v3:
> - Optimize the code logic and separate code for regulator vmmc and vqmmc
> - Rebase on tag: next-20241217
> - Link to v2: https://lore.kernel.org/all/20241127095029.3918290-1-quic_yuanjiey@quicinc.com/
>
> Changes in v2:
> - Add enum msm_reg_type to optimize the code
> - Delete redundant emmc type judgment
> - Link to v1: https://lore.kernel.org/linux-arm-msm/20241122075048.2006894-1-quic_yuanjiey@quicinc.com/
>
> ---
>  drivers/mmc/host/sdhci-msm.c | 53 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 51 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 4610f067faca..e3d39311fdc7 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -134,9 +134,18 @@
>  /* Timeout value to avoid infinite waiting for pwr_irq */
>  #define MSM_PWR_IRQ_TIMEOUT_MS 5000
>
> +/* Max load for eMMC Vdd supply */
> +#define MMC_VMMC_MAX_LOAD_UA   570000
> +
>  /* Max load for eMMC Vdd-io supply */
>  #define MMC_VQMMC_MAX_LOAD_UA  325000
>
> +/* Max load for SD Vdd supply */
> +#define SD_VMMC_MAX_LOAD_UA    800000
> +
> +/* Max load for SD Vdd-io supply */
> +#define SD_VQMMC_MAX_LOAD_UA   22000
> +
>  #define msm_host_readl(msm_host, host, offset) \
>         msm_host->var_ops->msm_readl_relaxed(host, offset)
>
> @@ -1403,11 +1412,48 @@ static int sdhci_msm_set_pincfg(struct sdhci_msm_host *msm_host, bool level)
>         return ret;
>  }
>
> -static int sdhci_msm_set_vmmc(struct mmc_host *mmc)
> +static void msm_config_vmmc_regulator(struct mmc_host *mmc, bool hpm)
> +{
> +       int load;
> +
> +       if (!hpm)
> +               load = 0;
> +       else if (!mmc->card)
> +               load = max(MMC_VMMC_MAX_LOAD_UA, SD_VMMC_MAX_LOAD_UA);
> +       else if (mmc_card_mmc(mmc->card))
> +               load = MMC_VMMC_MAX_LOAD_UA;
> +       else if (mmc_card_sd(mmc->card))
> +               load = SD_VMMC_MAX_LOAD_UA;
> +       else
> +               return;
> +
> +       regulator_set_load(mmc->supply.vmmc, load);
> +}
> +
> +static void msm_config_vqmmc_regulator(struct mmc_host *mmc, bool hpm)
> +{
> +       int load;
> +
> +       if (!hpm)
> +               load = 0;
> +       else if (!mmc->card)
> +               load = max(MMC_VQMMC_MAX_LOAD_UA, SD_VQMMC_MAX_LOAD_UA);
> +       else if (mmc_card_sd(mmc->card))
> +               load = SD_VQMMC_MAX_LOAD_UA;
> +       else
> +               return;
> +
> +       regulator_set_load(mmc->supply.vqmmc, load);
> +}
> +
> +static int sdhci_msm_set_vmmc(struct sdhci_msm_host *msm_host,
> +                             struct mmc_host *mmc, bool hpm)
>  {
>         if (IS_ERR(mmc->supply.vmmc))
>                 return 0;
>
> +       msm_config_vmmc_regulator(mmc, hpm);
> +
>         return mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, mmc->ios.vdd);
>  }
>
> @@ -1420,6 +1466,8 @@ static int msm_toggle_vqmmc(struct sdhci_msm_host *msm_host,
>         if (msm_host->vqmmc_enabled == level)
>                 return 0;
>
> +       msm_config_vqmmc_regulator(mmc, level);
> +
>         if (level) {
>                 /* Set the IO voltage regulator to default voltage level */
>                 if (msm_host->caps_0 & CORE_3_0V_SUPPORT)
> @@ -1642,7 +1690,8 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
>         }
>
>         if (pwr_state) {
> -               ret = sdhci_msm_set_vmmc(mmc);
> +               ret = sdhci_msm_set_vmmc(msm_host, mmc,
> +                                        pwr_state & REQ_BUS_ON);
>                 if (!ret)
>                         ret = sdhci_msm_set_vqmmc(msm_host, mmc,
>                                         pwr_state & REQ_BUS_ON);
>
> base-commit: dab2734f8e9ecba609d66d1dd087a392a7774c04
> --
> 2.34.1
>
