Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7D819F473
	for <linux-mmc@vger.kernel.org>; Wed, 28 Aug 2024 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858643; cv=none; b=MDb9t8CwnTeMZvtC9A4GOIxWl80dAbDMDM325UtbThLtiocj8BXR2y3UpOefOFK0lVeMDMdX3dpIOcRCcsgvBvJDj7xXHlI5QZvcbtuUcyt8IkKVbnweoFNpzyRlQp4oHi3s8sPkPlO+49H/P3h9hhOhtIsj0g0sLP/76Z9Espk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858643; c=relaxed/simple;
	bh=BvSMw8yg2LkQSKywm9vpxy8LiwnELHUOuZT6XhNtUTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5FtzkIhItZDKihHpAsb6RMpb67dd+onaLcGKke9ye4BVmZAhzTXrS09dbhyh4/zIMkwReF95LkoikciiYaxbuaEnJywkZYDsWsnXhLYLrvFv/s9gL64FUBHrKsPHyz4AFTlBFk4DQ7MlgAj0Fklz4Vrtize0C5wt/3x/+pMIS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S0/EV+rw; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S0/EV+rw"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e0b7efa1c1bso6859032276.3
        for <linux-mmc@vger.kernel.org>; Wed, 28 Aug 2024 08:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724858641; x=1725463441; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4dyecj1atvVOzm4XdX1oXkqk42toDzs0yGLdIhqTNSc=;
        b=S0/EV+rwIyeUfUwWYCUIyZBIUivxeVUq2gPhhfPfXxlR9/TDY1bM+BqSoYLRsc4WKc
         wLGKQ8S/e//1Jujt+Md3ZGQ4cHhMWpMRlYHww4nU9CwX/S3lV+uushrnVSPi6H6HfNia
         YToChovOCJLS663BixUyEYy80sJpRYNpGpoXJIJ6FBgEllTXkVIfRI8hnwi1mBBbqDBQ
         FaocWSULENAi5B7yNYnlOoYt49DTppTqjfBFnuXuHFTHtg/tsN4+SoQ1HNOH/NFg7S8Z
         SUzmJgAoeCX6lyuP5tJa3spK9ynxd/tYuCAvnYQrTJkGekuliAokQqQN1MrGJ21dLQbv
         LOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724858641; x=1725463441;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4dyecj1atvVOzm4XdX1oXkqk42toDzs0yGLdIhqTNSc=;
        b=DfUUcb4EF90YsSP3noiGMeT9S20DdaiDIh2OHtgSw05wCz6SPdp4HDLmot/9ogiEV+
         oHabx8lom/Uv4AJ0d9q6gh1GDBmKVLFMuchZVMZT2oU+hZ1AoHFS0zvByPpoWlvTG7e6
         Jb6Pr6w/CEimjZIa4ypU9JmiJnaARjkjgLJemtX9sj/yeg+ONaFsEIvebRRh8bMZNpsk
         E2kSr1dNA7wOSaVe14TttEJxkWVihcjHBgoIJhLs+PQst79QbxqOtO0H3FqB+gSaD7VP
         2rK9Jf3yo6KPo/PktrUPCvkPUPWlHfgmMMPyLVngBMwaiLEw0oAqAmYPZ8XnUgppYPyH
         Z5pA==
X-Forwarded-Encrypted: i=1; AJvYcCW97nr30A2/yaEQYQCW1WADjfQ2hlPyohHXxE3wtO3uzoozFwOlbHizc2zNuTqrl8BcXa4zg7G5iaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxrYc3tUha+HLUCCEyxXCx3IhBn/oiumrlGLj/u/Gf+mWn4XuV
	Rp0DRzrWmcUSVxbKsSLnMYSWHNf0N5sCgxlTdt5F19oV2md+uGsX/2Am9qTygHz1dswMSyLBhyD
	CtgtAsPNMaBWfcRtqGUXg7rPTLOknz/Sp/R4L8A==
X-Google-Smtp-Source: AGHT+IEOy2MkQVBEysNvyZMAM2fTzxX+1tGLn7Vroz2+sN8rIgjVDzd6/CyoHDrg0kcF5TFkzOmjVMOmjASdfqlh6RI=
X-Received: by 2002:a05:6902:1026:b0:e13:c984:d7cf with SMTP id
 3f1490d57ef6-e17a8682365mr17694339276.50.1724858640776; Wed, 28 Aug 2024
 08:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <73703c853e36f3cd61114e4ac815926d94a1a802.1724695127.git.limings@nvidia.com>
 <20240827164016.237617-1-limings@nvidia.com>
In-Reply-To: <20240827164016.237617-1-limings@nvidia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Aug 2024 17:23:24 +0200
Message-ID: <CAPDyKFohKt0E7zjnq0c9MkOLEEKZPtonWeDfz4w4Pw23=+uNtQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-dwcmshc: Add hw_reset() support for
 BlueField-3 SoC
To: Liming Sun <limings@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, David Thompson <davthompson@nvidia.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Aug 2024 at 18:40, Liming Sun <limings@nvidia.com> wrote:
>
> The eMMC RST_N register is implemented as secure register on
> the BlueField-3 SoC and controlled by TF-A. This commit adds the
> hw_reset() support which sends an SMC call to TF-A for the eMMC
> HW reset.
>
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Signed-off-by: Liming Sun <limings@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v1->v2:
>     Fixed a typo reported by test robot.
> v1: Initial version.
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index ba8960d8b2d4..8999b97263af 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -8,6 +8,7 @@
>   */
>
>  #include <linux/acpi.h>
> +#include <linux/arm-smccc.h>
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
> @@ -201,6 +202,9 @@
>                                          SDHCI_TRNS_BLK_CNT_EN | \
>                                          SDHCI_TRNS_DMA)
>
> +/* SMC call for BlueField-3 eMMC RST_N */
> +#define BLUEFIELD_SMC_SET_EMMC_RST_N   0x82000007
> +
>  enum dwcmshc_rk_type {
>         DWCMSHC_RK3568,
>         DWCMSHC_RK3588,
> @@ -1111,6 +1115,29 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
>         .irq                    = dwcmshc_cqe_irq_handler,
>  };
>
> +#ifdef CONFIG_ACPI
> +static void dwcmshc_bf3_hw_reset(struct sdhci_host *host)
> +{
> +       struct arm_smccc_res res = { 0 };
> +
> +       arm_smccc_smc(BLUEFIELD_SMC_SET_EMMC_RST_N, 0, 0, 0, 0, 0, 0, 0, &res);
> +
> +       if (res.a0)
> +               pr_err("%s: RST_N failed.\n", mmc_hostname(host->mmc));
> +}
> +
> +static const struct sdhci_ops sdhci_dwcmshc_bf3_ops = {
> +       .set_clock              = sdhci_set_clock,
> +       .set_bus_width          = sdhci_set_bus_width,
> +       .set_uhs_signaling      = dwcmshc_set_uhs_signaling,
> +       .get_max_clock          = dwcmshc_get_max_clock,
> +       .reset                  = sdhci_reset,
> +       .adma_write_desc        = dwcmshc_adma_write_desc,
> +       .irq                    = dwcmshc_cqe_irq_handler,
> +       .hw_reset               = dwcmshc_bf3_hw_reset,
> +};
> +#endif
> +
>  static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
>         .set_clock              = dwcmshc_rk3568_set_clock,
>         .set_bus_width          = sdhci_set_bus_width,
> @@ -1163,7 +1190,7 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_pdata = {
>  #ifdef CONFIG_ACPI
>  static const struct dwcmshc_pltfm_data sdhci_dwcmshc_bf3_pdata = {
>         .pdata = {
> -               .ops = &sdhci_dwcmshc_ops,
> +               .ops = &sdhci_dwcmshc_bf3_ops,
>                 .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>                 .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>                            SDHCI_QUIRK2_ACMD23_BROKEN,
> --
> 2.30.1
>
