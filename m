Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56763F7E94
	for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2026 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528423; cv=pass; b=fDP1ZQgKUU2nzejWBpynPhK9pAmRVqmU0EgJQZDHd3hLrSkOCeosMp9ADcTRbVTb2fpn6XDi+d54KOrSwwkQRm02R22KSf/0cpEGzj00dB9UTIEB4m2Vd4OULGdp4AtR2f5D4+q5jz+3LperzzNwTaFutbDEK7DM5gMsbXZLlHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528423; c=relaxed/simple;
	bh=oSoxboKQrYhosaSFhqO9CxSQZ5LAmgO/AIfzusUt4HY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFVVm1kownK0xS1Qsd4GovQhUEF/kicjohYkz2o9/etDhA5srO/kHz83Xrg6YMM8LLHhvLv6UC7vy5jj54sDTEiUsEv9VZCSiMcvi4Lgr6bjvROq01v/5dRwaaiUgvVhkwdTpIqLvdNY908QE3+0r/b3WiVxlJZi+jJEcujOKm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P0jVUCjm; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P0jVUCjm"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a298acb395so1245753e87.2
        for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2026 05:33:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774528417; cv=none;
        d=google.com; s=arc-20240605;
        b=EciAuSmYrddX1KgMc+m8l1q2nNS61MyXuAvW3+ohzoB73M7pm2rupZxxim1QczyEQP
         +3mB7boNkeOBXcE86nMOvYgLU8lOUgNPbsA3uyaqL2ekMJ2INu61oYb3NDTaWcFN5EUB
         zC5wJhtZl4VHbpPEmqZ1LR9YX1ArwLQZXHMqg/sbpjoroHo5/wgf8GK/CGjk+cCJe3qG
         z0RWGuHJhk2/cUTNaYfMWxq1T5S7SzmUei3aAA/4tiRS8qwapQFWTCLEiCfjODqT8HOG
         KT4Ef6hwevxQ3ayRDp7XnnD8xV4MONHqC7eYdeQFFae9S8v0UKCjuxfNfHg/w4yDhcJg
         eknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vETnFrNRg5XY0Iv+QhCnHxQYxNBO8zNBgxwQbZ/9KCE=;
        fh=c+s+pNIA13T8/2+McUVdu9bXlSOe/NvJwN3JDX2l8WE=;
        b=hUpu8HxuNxkSBFIPbns6vqMUje78+famrVhgylZCbANNZn+92SCqSTvsQshA6Rs57A
         2kXDlKzaF3B/+zaUX3gmzvq4D9LHwFyOVNxzKbQWfEyuSSeOWmaNXqBf8JB83iRMdUYC
         PDh9R+5ZgsqPHfsi/7p9jV1rFSbZboS81dI1PIVaTrK4PKX1O7e/woRsIgctvokWRQY0
         f42GVCCF0KNhH1P9XHBMvsQJPedHopLsdxEvwSoGkgtFF+dGjjq1NxmtjA0zGm2Rtv/+
         A38089KF+jIsVdftmiopmdjoW0KgVuhOuxDNKfD6Si1WOVeY8oIEgkto2vy/H9W+1Vkw
         FZ0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774528417; x=1775133217; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vETnFrNRg5XY0Iv+QhCnHxQYxNBO8zNBgxwQbZ/9KCE=;
        b=P0jVUCjm1v4NzREQQUMo95fgY/0V5OkzsLR8INYsKx47c38fdyRjMUScnUTqGpTnLA
         fWhPZ0ZgVCBZ1QYoxHgC+CYNcmLv8UClDf9YYbmi1VpwEQzzQj/4iQrNhfQINgKUIEn7
         khNtdvLtWF1GycJp8y/L6e/d9y0DFd6G4CueroDBST9nckbFG/kC7skDQWxcT6vaqolt
         xvC7R+M6yb7OCm++VUHRwWSKZ9PhFk4RMV/7JEI4V9QjkaIKmiJv1XFavXRw4CtgQJcn
         LmuT3t9gMT3DsZXk2GNPsqug78DIjZTurVqbrXH6yUqXUTW19XPjKhg+RK8qJs/A3yFL
         iR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774528417; x=1775133217;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vETnFrNRg5XY0Iv+QhCnHxQYxNBO8zNBgxwQbZ/9KCE=;
        b=m8sS6MoTvy4z/dSqERd2HOl7AYh53gHMVRyx1CT+Sb32NOYZpDePVimidpk4viFUBh
         UDgOK3vSm853XW7fcG8LgG6o/iOl+2T/PXgl9j0w168y8C91dx+LPBM8K3w/xRqaQQpo
         Z/C1QyO0IdHoTjkbL58fC7ZNkT3sPpDv5SCkpOF5sXa5SmabuG4o4VjvPOOXk9hRDtUF
         rNS4hUz7qtmK9XmfZOB5ykZkdM4p+8+Rf3w7bRa3bD0zl/qWi5yG97m1Jk3PhySPlut7
         mDZMkCBFA2+IMDFxFbAXAh234XGUbX4//XDWP0kNm8vLpw970CLdI3k/AZlF+2BwUCEJ
         S4zw==
X-Gm-Message-State: AOJu0YzQQ7nW550fSpTP52WXZFKEFaUUHEwtKr2jEpPuX+IEqJ7e5eYd
	//qAtyvNR3mC3cwPEixAAs34OLPpjga3EGBZWJnU+G5lGYmEWGkVMEKxcqW1t4cPJjYCK4vy2eS
	SYiaJq0x/0UcM6LCGC2A3NO7nhlicaVpsjxLfxEWPhw==
X-Gm-Gg: ATEYQzwhmCLZMp7tqzXv2nsCXP+kTktJxuxIdVNwTeWBNMQbsRJ+2NIbuqsH8xOA73R
	zlxYSvJWxMqDvOQ9/2MaapsgL9Go3JimriSkxDc+v1+sNEWaWxwSEv3i4S5eX7F7cWkbUHduV2x
	73Cu5MxHaQ9CO9xJLyP0+qX4hJOTt5/dzB44wXTwEFYGCIa08a9R9hmW32HWVT2bI4pLDWJ/aZY
	bqbP9TJ8aQ/yh27gpGKuVDxqgxyX/5wEsAxRYUG1XKwFl7TT9/r45ywOse3/EIxzsBy8Prw4scC
	we/3T4F8uDpUuB4mrA==
X-Received: by 2002:a05:6512:61d8:20b0:5a2:9bd8:838d with SMTP id
 2adb3069b0e04-5a29bd883a1mr1990089e87.6.1774528416262; Thu, 26 Mar 2026
 05:33:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1774341736-229127-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1774341736-229127-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 26 Mar 2026 13:33:00 +0100
X-Gm-Features: AQROBzAtPfb6kIvE3LP5V2Z2MJi0Dp0MsLU2uQVesMqhPs_-NZU-ttGiaCIkRko
Message-ID: <CAPDyKFrU8f=XL_SR+ws0d06NBBieYeRH99TDnc-A5EAUhW71sA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-arasan: Use standard mmc_clk_phase_map infrastructure
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org, 
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Mar 2026 at 09:42, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> Convert the Arasan SDHCI driver to use the mainline standard
> mmc_clk_phase_map infrastructure instead of custom clk_phase_in/out
> arrays as well as arasan_dt_read_clk_phase().
>
> The phase values for ZynqMP, Versal, and Versal-NET platforms are
> still initialized from the predefined tables.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Changes in v2:
> - remove check in sdhci_arasan_set_clk_delays() (Sai Krishna Potthuri)
>
>  drivers/mmc/host/sdhci-of-arasan.c | 73 +++++++-------------------------------
>  1 file changed, 12 insertions(+), 61 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index caf9723..785d3ac 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -152,8 +152,7 @@ struct sdhci_arasan_clk_ops {
>   * @sdcardclk:         Pointer to normal 'struct clock' for sdcardclk_hw.
>   * @sampleclk_hw:      Struct for the clock we might provide to a PHY.
>   * @sampleclk:         Pointer to normal 'struct clock' for sampleclk_hw.
> - * @clk_phase_in:      Array of Input Clock Phase Delays for all speed modes
> - * @clk_phase_out:     Array of Output Clock Phase Delays for all speed modes
> + * @phase_map:         Struct for mmc_clk_phase_map provided.
>   * @set_clk_delays:    Function pointer for setting Clock Delays
>   * @clk_of_data:       Platform specific runtime clock data storage pointer
>   */
> @@ -162,8 +161,7 @@ struct sdhci_arasan_clk_data {
>         struct clk      *sdcardclk;
>         struct clk_hw   sampleclk_hw;
>         struct clk      *sampleclk;
> -       int             clk_phase_in[MMC_TIMING_MMC_HS400 + 1];
> -       int             clk_phase_out[MMC_TIMING_MMC_HS400 + 1];
> +       struct mmc_clk_phase_map phase_map;
>         void            (*set_clk_delays)(struct sdhci_host *host);
>         void            *clk_of_data;
>  };
> @@ -1249,36 +1247,9 @@ static void sdhci_arasan_set_clk_delays(struct sdhci_host *host)
>         struct sdhci_arasan_clk_data *clk_data = &sdhci_arasan->clk_data;
>
>         clk_set_phase(clk_data->sampleclk,
> -                     clk_data->clk_phase_in[host->timing]);
> +                     clk_data->phase_map.phase[host->timing].in_deg);
>         clk_set_phase(clk_data->sdcardclk,
> -                     clk_data->clk_phase_out[host->timing]);
> -}
> -
> -static void arasan_dt_read_clk_phase(struct device *dev,
> -                                    struct sdhci_arasan_clk_data *clk_data,
> -                                    unsigned int timing, const char *prop)
> -{
> -       struct device_node *np = dev->of_node;
> -
> -       u32 clk_phase[2] = {0};
> -       int ret;
> -
> -       /*
> -        * Read Tap Delay values from DT, if the DT does not contain the
> -        * Tap Values then use the pre-defined values.
> -        */
> -       ret = of_property_read_variable_u32_array(np, prop, &clk_phase[0],
> -                                                 2, 0);
> -       if (ret < 0) {
> -               dev_dbg(dev, "Using predefined clock phase for %s = %d %d\n",
> -                       prop, clk_data->clk_phase_in[timing],
> -                       clk_data->clk_phase_out[timing]);
> -               return;
> -       }
> -
> -       /* The values read are Input and Output Clock Delays in order */
> -       clk_data->clk_phase_in[timing] = clk_phase[0];
> -       clk_data->clk_phase_out[timing] = clk_phase[1];
> +                     clk_data->phase_map.phase[host->timing].out_deg);
>  }
>
>  /**
> @@ -1315,8 +1286,8 @@ static void arasan_dt_parse_clk_phases(struct device *dev,
>                 }
>
>                 for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
> -                       clk_data->clk_phase_in[i] = zynqmp_iclk_phase[i];
> -                       clk_data->clk_phase_out[i] = zynqmp_oclk_phase[i];
> +                       clk_data->phase_map.phase[i].in_deg = zynqmp_iclk_phase[i];
> +                       clk_data->phase_map.phase[i].out_deg = zynqmp_oclk_phase[i];
>                 }
>         }
>
> @@ -1327,8 +1298,8 @@ static void arasan_dt_parse_clk_phases(struct device *dev,
>                         VERSAL_OCLK_PHASE;
>
>                 for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
> -                       clk_data->clk_phase_in[i] = versal_iclk_phase[i];
> -                       clk_data->clk_phase_out[i] = versal_oclk_phase[i];
> +                       clk_data->phase_map.phase[i].in_deg = versal_iclk_phase[i];
> +                       clk_data->phase_map.phase[i].out_deg = versal_oclk_phase[i];
>                 }
>         }
>         if (of_device_is_compatible(dev->of_node, "xlnx,versal-net-emmc")) {
> @@ -1338,32 +1309,12 @@ static void arasan_dt_parse_clk_phases(struct device *dev,
>                         VERSAL_NET_EMMC_OCLK_PHASE;
>
>                 for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
> -                       clk_data->clk_phase_in[i] = versal_net_iclk_phase[i];
> -                       clk_data->clk_phase_out[i] = versal_net_oclk_phase[i];
> +                       clk_data->phase_map.phase[i].in_deg = versal_net_iclk_phase[i];
> +                       clk_data->phase_map.phase[i].out_deg = versal_net_oclk_phase[i];
>                 }
>         }
> -       arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_LEGACY,
> -                                "clk-phase-legacy");
> -       arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_MMC_HS,
> -                                "clk-phase-mmc-hs");
> -       arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_SD_HS,
> -                                "clk-phase-sd-hs");
> -       arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_UHS_SDR12,
> -                                "clk-phase-uhs-sdr12");
> -       arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_UHS_SDR25,
> -                                "clk-phase-uhs-sdr25");
> -       arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_UHS_SDR50,
> -                                "clk-phase-uhs-sdr50");
> -       arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_UHS_SDR104,
> -                                "clk-phase-uhs-sdr104");
> -       arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_UHS_DDR50,
> -                                "clk-phase-uhs-ddr50");
> -       arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_MMC_DDR52,
> -                                "clk-phase-mmc-ddr52");
> -       arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_MMC_HS200,
> -                                "clk-phase-mmc-hs200");
> -       arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_MMC_HS400,
> -                                "clk-phase-mmc-hs400");
> +
> +       mmc_of_parse_clk_phase(dev, &clk_data->phase_map);
>  }
>
>  static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
> --
> 2.7.4
>
