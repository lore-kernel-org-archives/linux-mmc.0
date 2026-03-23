Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A4B3B47DB
	for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279192; cv=pass; b=Zffw723tKRK49nJkxT9Ce3GfC9TZglf6MkIHpLpBS0u/zIQztn7IlV+iBBmFoi1YZX37/tcuTYoV8U9zGHCHwS8lQWdoPwvYR/ga109sf43RoSENOFalns36UWWI7Gd+o9KxS98ahBQQX2nOv0eiQciKct1Ik6A327faeQER6xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279192; c=relaxed/simple;
	bh=tgu/M7O1nOMEON1H+IpryrZnkOPrCgyKpyi37gYQC8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tPH5+2I/3jJGU3Dc2/0DDla7iXZ6FG3wrpZ/bw7bWZdoBuuPF40K6n4j6dj9mXXboLk3QgLGc+hVV4b0tyD4owWK3RiusZipxwa6kzGAR7lIXElBQ88PEJ6J/rBprfFjhqgGbdv+wZqKxdDWOvm1Rt67SM3MLfGcFSGs2PzujcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tvwqGls7; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tvwqGls7"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a27bfadca9so5245541e87.3
        for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 08:19:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774279189; cv=none;
        d=google.com; s=arc-20240605;
        b=jT+FLnbSMtxpHhrwoRXZ1Q7p/WhgsSf8m+wmYBtuD8Hs/5M4PL4dcvAkCZ17RurwMQ
         wTF3GsJZiguXaAUyUsHe83IDAY5TyoLG4uwV+hkX20jZ9N7sfqRZNseeAkager9IU1Le
         Wb249EajA+1CW2KjWPDJH5Gm9+acljTLJfjUAPzkBzNlk9f1UfdoILympNSbXNpCyD12
         Ho1LDmICZtj7F81TU/FUxsivS7eMeCd+3D0E6u5wX2DeG8mYGAVnEEYg308HlCDtgZQI
         8jkroi8W2uGyfDJG4yfzuw1rc3Y0OVCrKl0/7WnCXNCz6Pu51hbOfZrJB+3iQ+z64djr
         2BHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XFch42FbhwwFdZVr6Uym9f4ktf0sE9Nb8AZvP/Q1Bv4=;
        fh=e7a82Ygn2Dr3kTF5mQ04c/qcazpsvU137DtWthSb0rY=;
        b=WVlfHlOaAMwP27jjSNVJPuuxnVflIhlWvJFJoJetwQaFFxW0khQcEHGZS45qxXiN66
         dUmQ2n6K2R9b/Z9oYjrro0zbn58UiHVrgUetSoxzY4yBvPTjsfgVP27sG1SuptTZauDH
         jXB0Cwn5UzmHaz8OTf3p28HdvcsSRR6ztZxwcYmRIVy0khrbTgRVfGSkuy/4adO7yl7U
         efynsnpQ8GKuMhniPjTCPyYuXpi3b5p7ojdO4HoHZ6Niy75RPg3a6Hht5chXRAKEJRYm
         wi5D82KNnoGqjXT4FxBH7jd4MDrRViv/7lfyR1kdg5ynOGqy1pOzZM354p2Ny2bISA/k
         i7ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774279189; x=1774883989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XFch42FbhwwFdZVr6Uym9f4ktf0sE9Nb8AZvP/Q1Bv4=;
        b=tvwqGls7eH2fUHbCVx3Kvc5iyN5s93UbG7Q60xwnSqYPxJX35yodqj1vSij3/NHTs5
         7tPi4Jj6WBbJZOZqIuwhqc0Po2rvkMGodSjdTCkijs5ONC4eBWuYwnxThQeE/sFTZaFC
         +btXGjrhTz11vq9gN5gipKKRHlPJd1X9SoN/TGwxDAzbBt08JgEEweCVPFe7ZGqtdK0n
         MWeNueHDT63Hmr2qSWbOo3X6JyvaHHlDp7sIKgpqj9KeXssk7QjRbJTDBHAMAyN6B1k6
         NPJvaJYEMIJqwqGaUdYjDS3M8aljGTAI4vNwnecdYrJ09lHPeX3B/ZTmCjdtWr4LUM9K
         J0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279189; x=1774883989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFch42FbhwwFdZVr6Uym9f4ktf0sE9Nb8AZvP/Q1Bv4=;
        b=khsQIbyGEYx+pfgQxuqpIQbKgwuqheKi2Px8keC2vuGmKU4znoNdb/AFxM6J5tFFK2
         s+AFjRx0PoBsEEiqBbxhjY2a+gal94cMT1NGjw5SuojX6ErWt9CImOr3jNwapINZ4UYh
         udxa/59nRXSmOW64t7ME1RqXfXdT2SdA49YNln3spplvBVzeL9Us6NaN+MdUuNlf7kIj
         lWfat3ky4oxjQV53qWmfjymnkFDiPHnAGzRUwuG6UGchpLZ7/Lg+HsqeVASdmL1MvX2J
         FBlH6qnBPEDxZvLmy/m3qaJUupTy5u/xRV1sMrqBnu6vfJRT5/gxYIKfdu7H0yLCY1i2
         iNfw==
X-Forwarded-Encrypted: i=1; AJvYcCVXX6TBCYHz1CBVnlU5aNxyXXqDa/hKW5PghqhyuUvh34it5s8BR3EwMYdObGQ+rMFVTlR77hydUUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwftFaAQn0qv44b///ZMLV0eLNKEiroLv3UZy9Hk9/SL8QeT3Jt
	f1lJPSdnHbWlmzoYYsFBqz4GS+FBH5VNuUgGoQeZGpVXMs8YH3IT9Kc9Tu2CpFXzLrol5bFwFSu
	QGSl8qa6Sh5n0UM8LtPvnPU/akftI+lQlJByz65b4BQ==
X-Gm-Gg: ATEYQzxHsxsHA2wXy0gxdDlHkJRS61LHiMjmFlVBoVXqy8YfN8s4cgm8/HB9R41AFPF
	gSq4kbuNtFo8V51+f5h895bx4cvPNClCKdD4p2xN5bxyoH2IscU8oBX5Kflpgqz4KDo39D7Jfew
	UZj0eQD+HZpDJBuVslejA4Fm/s4ebyR0m5sA3SCmx1zbKHVQFCouvlzrDhTAAzSadSldwDFtx0i
	JZpqanws5gbi4/14i/999bJDnYZRBB2q8NpR3yny3OfSadHC9/9brOfVurkVrJcPOl6PUjwbo1n
	GGGPmmL9
X-Received: by 2002:a05:6512:10cc:b0:5a1:2c0b:bd7 with SMTP id
 2adb3069b0e04-5a285b5a663mr4593198e87.35.1774279189376; Mon, 23 Mar 2026
 08:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1773713692-117311-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1773713692-117311-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Mar 2026 16:19:12 +0100
X-Gm-Features: AQROBzC8_l1bTIZkGh6ivSp_mZ9dDFd8gqNWhLg2deGs6COk4J4Y5KSwHptOT7I
Message-ID: <CAPDyKFoHu7xZEwnvrgXDS2D9AOU29RZ4hZ5NsWaVaK5n4dYk9w@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc-pltfm: Use phase_map for SoCFPGA clock phase configuration
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Mar 2026 at 03:15, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> This change aligns the SoCFPGA driver with the current dw_mmc core,
> which now manages clock phases through host->phase_map. The phase values
> are still scaled by SOCFPGA_DW_MMC_CLK_PHASE_STEP before being written
> to the system manager registers.
>
> No functional changes intended.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied for next, thanks!

Kind regards
Uffe



> ---
>
>  drivers/mmc/host/dw_mmc-pltfm.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index 68770aa..cf38bb1 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -59,12 +59,13 @@ EXPORT_SYMBOL_GPL(dw_mci_pltfm_register);
>  static int dw_mci_socfpga_priv_init(struct dw_mci *host)
>  {
>         struct device_node *np = host->dev->of_node;
> +       struct mmc_clk_phase phase;
>         struct regmap *sys_mgr_base_addr;
> -       u32 clk_phase[2] = {0}, reg_offset, reg_shift;
> -       int i, rc, hs_timing;
> +       u32 reg_offset, reg_shift;
> +       int hs_timing;
>
> -       rc = of_property_read_variable_u32_array(np, "clk-phase-sd-hs", &clk_phase[0], 2, 0);
> -       if (rc < 0)
> +       phase = host->phase_map.phase[MMC_TIMING_SD_HS];
> +       if (!phase.valid)
>                 return 0;
>
>         sys_mgr_base_addr = altr_sysmgr_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
> @@ -76,10 +77,10 @@ static int dw_mci_socfpga_priv_init(struct dw_mci *host)
>         of_property_read_u32_index(np, "altr,sysmgr-syscon", 1, &reg_offset);
>         of_property_read_u32_index(np, "altr,sysmgr-syscon", 2, &reg_shift);
>
> -       for (i = 0; i < ARRAY_SIZE(clk_phase); i++)
> -               clk_phase[i] /= SOCFPGA_DW_MMC_CLK_PHASE_STEP;
> +       phase.in_deg /= SOCFPGA_DW_MMC_CLK_PHASE_STEP;
> +       phase.out_deg /= SOCFPGA_DW_MMC_CLK_PHASE_STEP;
>
> -       hs_timing = SYSMGR_SDMMC_CTRL_SET(clk_phase[0], clk_phase[1], reg_shift);
> +       hs_timing = SYSMGR_SDMMC_CTRL_SET(phase.in_deg, phase.out_deg, reg_shift);
>         regmap_write(sys_mgr_base_addr, reg_offset, hs_timing);
>
>         return 0;
> --
> 2.7.4
>
>
