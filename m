Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E399A3115B4
	for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 10:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514541; cv=none; b=ZCBEm117sWRDqEk4hwBoaAdpGnxkZiOIRQyyEGphNbhh63ct0yfgvzgc2GwA0qeGDL6OdxVACXSP3jhFYxHATGrw08qMqrhL/Vz6ZWpd8fp4/sqXGdmr/7q6mR1g4zru8fiN8B/22E7oCBHdo7tW4/0oPQle+9nFu/eUKeWIj2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514541; c=relaxed/simple;
	bh=6hKYpty+qx2naJXVS4dhHCkbWyVy9m+3Fk7HNYLM6Oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FcH4sYLlOoNY7IqIYYMw+7A5lZYcroDNzR6v6xxdFeNB+8zvFT2fE7YSR+zIsKThfg7UQ25bOzspqNpSUU0FAFbWOQefyBUEOwh4oKWGXw1JGDGgHI/k7bpUzibIqPq8yBU7IqWTu+PKqb+4Lfm4dhy8tYcKIDR5w0aFx62Xx28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uOaOe4co; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uOaOe4co"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e9455cfb9d1so706182276.0
        for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 03:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755514539; x=1756119339; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FeRqiOPLopz5KVnC68acZ5B+PxJ3Dx5XQd6rUO1DhDU=;
        b=uOaOe4co57giMDOyAEHNLxxyTxTugi/U999sU/I0FikCkhD4uwvj25yGF4rQcC2uyM
         aEFskhvkR3IDQygCVqJXS1MjM64HSFTCam0+uFUn4ra8QsrQaAubE9zwY58hX+8Qjo60
         jPbzx3qqzb0qQdAlduXVdfdvX0ISYPbNrkJ+gVunOf/383LN+4yH32BCwr+kX10NomCj
         0g0zFZq12mVt5v1C92Fi204jqmPCRAuRl0jl9+tthaKQL3fjmzM+rgYRW8A5NGODUm6B
         SNmSzVIvsAvnKGAiFc2O/eAbxDkkOS1YNrBWXDv1JsJbzQaBjGEMrJDGo7V8RKX6h2gg
         Bv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755514539; x=1756119339;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FeRqiOPLopz5KVnC68acZ5B+PxJ3Dx5XQd6rUO1DhDU=;
        b=lBUWCr7BdICOhatSMHSkW7z/f+Egq2Q6kTtBFOKZQpUZuPDByyx/gDdkT02JDofHW4
         uBeH5D84Y2OJgUu3KJFagype/u+3uSvz0iEhzRs7+utMd0l/tytE02g+QtLr3QRiCSTu
         Hd4803Y8F4a+HhLiX1m65wrEuMZoWThB61Rzq5eKiwhF1DK/WZgpkQeTgPtIKWS1ixCb
         gJuZ2KCHkg+VgEKB+1p6/EiYDqYtY0INDw2ZVUYnOz7XdaG5GN7AlUQy2Zyr/KMLvz7s
         TuUVUjZ/zLG2vkvnvteLL60MPeN5huK6NwH6Tynpd4p62rtAUWyb/jFqQeNPKeDt0Sht
         WtDw==
X-Forwarded-Encrypted: i=1; AJvYcCVkaBUHOLHivwLhczMdTq8zwLSk7QrNlzfps5ErCZymwkiH++gpXEH59q7JFgcMisUmUQWgJP/SfK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YznsH93BWWemfRUebZ89WZ23QzBNCPiMSj5ioFMOlnNbs/taqD6
	0szpfYKgA3QrdPpQP8Z9vqnQJgZVSe9WllC6vdvT3NeoZJke5LuwJmhQos69nFc4vvHFDeqMUS3
	fhM2kfi4TrQl0EzSzLomh6ZSHPAUs4yu9XapT8lbZqg==
X-Gm-Gg: ASbGncsmj5qwiMyqltCmj1brHpbqmq3fRejeG/DHNrzLPQK2VUZze2mQKMSaG9HO0JH
	J07ENaGiAF78L+4BNDOpCSdkBrdajxgYdsPeHuM70SXUXUTFqSuXHPHwHHWiamaEpM6CfvHpxCu
	nr+bv2Tz+UPvM3B13uZN/+4tphIaB2Q4R5YGdvpL4aDUU2GTkV7xIimreTdC8B5Sd98nLLoCrOA
	Tlt/JLO
X-Google-Smtp-Source: AGHT+IF46ecL1xUjdrsluGaAMVIK/JazDBA1JIpYrAjgHNI9HWRequ3E121ddAsqZMq/3qbwEzgmgBnN6SAjLVVuP9k=
X-Received: by 2002:a05:6902:c02:b0:e93:49e4:296 with SMTP id
 3f1490d57ef6-e9349e4262cmr5734998276.15.1755514538545; Mon, 18 Aug 2025
 03:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730060543.1735971-1-sai.krishna.potthuri@amd.com>
In-Reply-To: <20250730060543.1735971-1-sai.krishna.potthuri@amd.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 18 Aug 2025 12:55:02 +0200
X-Gm-Features: Ac12FXzR0M0mFy6ZPqWaS6vLojYGCwrlmKHrnZEElZA3PnZ6Uz4ev6cpqb4ddLI
Message-ID: <CAPDyKFpjtLjgRZ-q2VJWtqw5f=jZ7VpvSO3pCd0PUM5b-0p=0g@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sdhci-of-arasan: Ensure CD logic stabilization
 before power-up
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@amd.com>, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, git@amd.com, saikrishna12468@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 08:05, Sai Krishna Potthuri
<sai.krishna.potthuri@amd.com> wrote:
>
> During SD suspend/resume without a full card rescan (when using
> non-removable SD cards for rootfs), the SD card initialization may fail
> after resume. This occurs because, after a host controller reset, the
> card detect logic may take time to stabilize due to debounce logic.
> Without waiting for stabilization, the host may attempt powering up the
> card prematurely, leading to command timeouts during resume flow.
> Add sdhci_arasan_set_power_and_bus_voltage() to wait for the card detect
> stable bit before power up the card. Since the stabilization time
> is not fixed, a maximum timeout of one second is used to ensure
> sufficient wait time for the card detect signal to stabilize.
>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>

Applied for fixes and by adding a stable-tag, thanks!

Kind regards
Uffe


> ---
> Changes in v3:
> - Add quirk to sdhci_arasan_of_data and assigned them to
> sdhci_arasan->quirks in probe instead of using of_device_is_compatible().
> Changes in v2:
> - Use read_poll_timeout() instead of readl_poll_timeout().
> - Enable the CD stable check using platform specific quirk.
> - Define the quirk for Xilinx/AMD ZynqMP, Versal and Versal NET platforms.
>
>  drivers/mmc/host/sdhci-of-arasan.c | 33 ++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 42878474e56e..60dbc815e501 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -99,6 +99,9 @@
>  #define HIWORD_UPDATE(val, mask, shift) \
>                 ((val) << (shift) | (mask) << ((shift) + 16))
>
> +#define CD_STABLE_TIMEOUT_US           1000000
> +#define CD_STABLE_MAX_SLEEP_US         10
> +
>  /**
>   * struct sdhci_arasan_soc_ctl_field - Field used in sdhci_arasan_soc_ctl_map
>   *
> @@ -206,12 +209,15 @@ struct sdhci_arasan_data {
>   * 19MHz instead
>   */
>  #define SDHCI_ARASAN_QUIRK_CLOCK_25_BROKEN BIT(2)
> +/* Enable CD stable check before power-up */
> +#define SDHCI_ARASAN_QUIRK_ENSURE_CD_STABLE    BIT(3)
>  };
>
>  struct sdhci_arasan_of_data {
>         const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
>         const struct sdhci_pltfm_data *pdata;
>         const struct sdhci_arasan_clk_ops *clk_ops;
> +       u32 quirks;
>  };
>
>  static const struct sdhci_arasan_soc_ctl_map rk3399_soc_ctl_map = {
> @@ -514,6 +520,24 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
>         return -EINVAL;
>  }
>
> +static void sdhci_arasan_set_power_and_bus_voltage(struct sdhci_host *host, unsigned char mode,
> +                                                  unsigned short vdd)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +       u32 reg;
> +
> +       /*
> +        * Ensure that the card detect logic has stabilized before powering up, this is
> +        * necessary after a host controller reset.
> +        */
> +       if (mode == MMC_POWER_UP && sdhci_arasan->quirks & SDHCI_ARASAN_QUIRK_ENSURE_CD_STABLE)
> +               read_poll_timeout(sdhci_readl, reg, reg & SDHCI_CD_STABLE, CD_STABLE_MAX_SLEEP_US,
> +                                 CD_STABLE_TIMEOUT_US, false, host, SDHCI_PRESENT_STATE);
> +
> +       sdhci_set_power_and_bus_voltage(host, mode, vdd);
> +}
> +
>  static const struct sdhci_ops sdhci_arasan_ops = {
>         .set_clock = sdhci_arasan_set_clock,
>         .get_max_clock = sdhci_pltfm_clk_get_max_clock,
> @@ -521,7 +545,7 @@ static const struct sdhci_ops sdhci_arasan_ops = {
>         .set_bus_width = sdhci_set_bus_width,
>         .reset = sdhci_arasan_reset,
>         .set_uhs_signaling = sdhci_set_uhs_signaling,
> -       .set_power = sdhci_set_power_and_bus_voltage,
> +       .set_power = sdhci_arasan_set_power_and_bus_voltage,
>         .hw_reset = sdhci_arasan_hw_reset,
>  };
>
> @@ -570,7 +594,7 @@ static const struct sdhci_ops sdhci_arasan_cqe_ops = {
>         .set_bus_width = sdhci_set_bus_width,
>         .reset = sdhci_arasan_reset,
>         .set_uhs_signaling = sdhci_set_uhs_signaling,
> -       .set_power = sdhci_set_power_and_bus_voltage,
> +       .set_power = sdhci_arasan_set_power_and_bus_voltage,
>         .irq = sdhci_arasan_cqhci_irq,
>  };
>
> @@ -1447,6 +1471,7 @@ static const struct sdhci_arasan_clk_ops zynqmp_clk_ops = {
>  static struct sdhci_arasan_of_data sdhci_arasan_zynqmp_data = {
>         .pdata = &sdhci_arasan_zynqmp_pdata,
>         .clk_ops = &zynqmp_clk_ops,
> +       .quirks = SDHCI_ARASAN_QUIRK_ENSURE_CD_STABLE,
>  };
>
>  static const struct sdhci_arasan_clk_ops versal_clk_ops = {
> @@ -1457,6 +1482,7 @@ static const struct sdhci_arasan_clk_ops versal_clk_ops = {
>  static struct sdhci_arasan_of_data sdhci_arasan_versal_data = {
>         .pdata = &sdhci_arasan_zynqmp_pdata,
>         .clk_ops = &versal_clk_ops,
> +       .quirks = SDHCI_ARASAN_QUIRK_ENSURE_CD_STABLE,
>  };
>
>  static const struct sdhci_arasan_clk_ops versal_net_clk_ops = {
> @@ -1467,6 +1493,7 @@ static const struct sdhci_arasan_clk_ops versal_net_clk_ops = {
>  static struct sdhci_arasan_of_data sdhci_arasan_versal_net_data = {
>         .pdata = &sdhci_arasan_versal_net_pdata,
>         .clk_ops = &versal_net_clk_ops,
> +       .quirks = SDHCI_ARASAN_QUIRK_ENSURE_CD_STABLE,
>  };
>
>  static struct sdhci_arasan_of_data intel_keembay_emmc_data = {
> @@ -1937,6 +1964,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>         if (of_device_is_compatible(np, "rockchip,rk3399-sdhci-5.1"))
>                 sdhci_arasan_update_clockmultiplier(host, 0x0);
>
> +       sdhci_arasan->quirks |= data->quirks;
> +
>         if (of_device_is_compatible(np, "intel,keembay-sdhci-5.1-emmc") ||
>             of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sd") ||
>             of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sdio")) {
> --
> 2.25.1
>
