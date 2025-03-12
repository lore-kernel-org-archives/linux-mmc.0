Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC1C22E412
	for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778685; cv=none; b=LaouRtHfX1S9fM50mlItnZJ8BxU0xHD9T9lP/Dq+JUaZivGfaw8leXDhDL9U6NslRx006okhbt9m3Nz6WnXouGa0z/iur0HVMBvKGulGVVmEDRrZJoNrlAuiQOSc6BO4Ryhgu/M/usAoIGpAK0ArDjVnMFwLLFiwGXPX0jvAEGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778685; c=relaxed/simple;
	bh=owmjtHJ1OL7QBkcWkfuFfnJ9VwoXOvpkdBPmshDSLCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFtk6vn+HCr1HkNFz2s/ggxkQ+oKbxvl/NDBi7d9s8in2iD+EDXhE9+DtgZA2Y0A6HFpslSkRVJRq50r7MD73ZosO+qyRL2w52fE8RBH9yjcYgRaW/PwEx8b1JVVS1HFSQiAdFrDaj2DBONHnhZhurartrtO9rJVaR8FgMPVXkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MNe34WPV; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MNe34WPV"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6fedefb1c9cso30669927b3.0
        for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 04:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741778683; x=1742383483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CrtcozoCbHBJRg4iL3YVu4uCUXqgrlqH7RyDHdI1VkM=;
        b=MNe34WPV0Vl5shRBSJrvZN0wX/2sUTHnTABn4nhBEfBh43MSLpVjkyhCw3ffKJOEOt
         uMB66qhK2rQoQHLALLLj9o6RtIKGcEu/uMRf5ii10W4uEJmQk6LAKi6RM9g2qNV8ykrs
         FSFQDjCyjTdNL9Y9Yo1yHd2sN2XIrFfeFl2Yo0YW7TaNyvV3HMoJbWWHR99lGtZXuqNW
         163Aiti4Pl8hEJfEnCKnEydnaruJounSXrkqibMCs1dr+flnbDwpz0QmylOYm+DaYadm
         AFVuYZPFwzFRNTFL5QCy7Y1DI29+Xm4iu1iFP9vHQkvdGG4Rdf8HdwAXO4dh2j0f7NTq
         TvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778683; x=1742383483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrtcozoCbHBJRg4iL3YVu4uCUXqgrlqH7RyDHdI1VkM=;
        b=lBTA9gcuKQQ7/71s8EERxmiUIGJ5oR6xIReiqDQbaaj7M5wD4R4y5h+Ro3OMMbxjLX
         YNpWgxHxaL2xpkF3iT/02C6LpiQxr3OQzfoALj2ODtVlFsLEHWRgBVXCPmrTCMQmUhuz
         lGmUWbJgb4aqNduy8BNo5hh342pgeewijWC/E+dR/rLKNC42ClfbASpsIIr6mQVHlmKx
         p34A5wkI9s1BLCH8RG2sdvAJqAIOo50TYRG3zOWIdMJNV7biyCgX3th+Fbw4p+khgKkm
         iSNz1CK6m+uMltjl1606LfBM+l/oQ3d475VxpuQu3Q1DQn7VMUfj3mHEZo57q+whIb9l
         mdVw==
X-Gm-Message-State: AOJu0YxADvgs4f7UMJc5z7NuTZXBycpvtrNPzJ/CS3qbQ5+4BOIjiscV
	lndMFMz5JnzA1j2If0WgzJ7arNwCw1UlyS0NPCofqmWkUw/7Cfr0az7BPUYUDGFqr4M0vqKgluy
	cy2OhVY2r0F1lD/E0vn8jnsSgIPAGMav/pDOtgw==
X-Gm-Gg: ASbGncuOaCsPvXtiNLASnwYpogGHN30cr7JL52jTp7FptMQ1zlZ6D78Y+VL/+Tv41tO
	yDVK3A01ICRHIrj3XCMImrbhKrSwAQ4FhBalMKA5k8rYvJ0G7/jjv2IjPP9B0LAq9ITOZc8oRR4
	en1epCN9t/W2YWzq1BRfJFe9jVMLg=
X-Google-Smtp-Source: AGHT+IGaN6Q0ttfkc5m0ykp+fyW2URIaRx7smcZ6q8z3v4Yg4TGj406BEhnK42qek6BpHrcfYHXGeI8hq4eaX8xiGe4=
X-Received: by 2002:a05:690c:7207:b0:6ef:4a1f:36d6 with SMTP id
 00721157ae682-6febf3ada0dmr274819757b3.23.1741778682935; Wed, 12 Mar 2025
 04:24:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250131025408epcas1p10fa298907557074b1d38b25a56b51f5e@epcas1p1.samsung.com>
 <20250131025406.1753513-1-jh80.chung@samsung.com>
In-Reply-To: <20250131025406.1753513-1-jh80.chung@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 12:24:07 +0100
X-Gm-Features: AQ5f1JoS_UJQHk6UPrRF-qnh7YHp4h71cJuoPx7NPgR58wxQCWqUzqzvQLjX_n4
Message-ID: <CAPDyKFpTPLAc4HKVEgwmBDyfJmik=Fs4h+nchtf_xZVWLnPsEQ@mail.gmail.com>
Subject: Re: [PATCH V3] mmc: sdhci-of_dwcmshc: Change to dwcmshc_phy_init for
 reusing codes
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, adrian.hunter@intel.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Jan 2025 at 03:54, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>
> dwcmshc_phy_1_8v_init and dwcmshc_phy_3_3v_init differ only by a few
> lines of code. This allow us to reuse code depending on voltage.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changelog V3:
> - Remove unnecessary condition
> - Check rxsel value instead of checking entire condition
> Changelog V2:
> - Add more conditions to clarify if it's MMC_SIGNAL_VOLTAGE_180
> - Order the local variable according to Adrian's comment
> - Use local variable to make more readable
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 72 ++++++-----------------------
>  1 file changed, 15 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 7ea3da45db32..09b9ab15e499 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -328,12 +328,17 @@ static void dwcmshc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>         sdhci_request(mmc, mrq);
>  }
>
> -static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
> +static void dwcmshc_phy_init(struct sdhci_host *host)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +       u32 rxsel = PHY_PAD_RXSEL_3V3;
>         u32 val;
>
> +       if (priv->flags & FLAG_IO_FIXED_1V8 ||
> +               host->mmc->ios.timing & MMC_SIGNAL_VOLTAGE_180)
> +               rxsel = PHY_PAD_RXSEL_1V8;
> +
>         /* deassert phy reset & set tx drive strength */
>         val = PHY_CNFG_RSTN_DEASSERT;
>         val |= FIELD_PREP(PHY_CNFG_PAD_SP_MASK, PHY_CNFG_PAD_SP);
> @@ -353,7 +358,7 @@ static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
>         sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
>
>         /* configure phy pads */
> -       val = PHY_PAD_RXSEL_1V8;
> +       val = rxsel;
>         val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
>         val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
>         val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> @@ -365,65 +370,22 @@ static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
>         val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
>         sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
>
> -       val = PHY_PAD_RXSEL_1V8;
> +       val = rxsel;
>         val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLDOWN);
>         val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
>         val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
>         sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
>
>         /* enable data strobe mode */
> -       sdhci_writeb(host, FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK, PHY_DLLDL_CNFG_SLV_INPSEL),
> -                    PHY_DLLDL_CNFG_R);
> -
> -       /* enable phy dll */
> -       sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
> -}
> -
> -static void dwcmshc_phy_3_3v_init(struct sdhci_host *host)
> -{
> -       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -       struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -       u32 val;
> -
> -       /* deassert phy reset & set tx drive strength */
> -       val = PHY_CNFG_RSTN_DEASSERT;
> -       val |= FIELD_PREP(PHY_CNFG_PAD_SP_MASK, PHY_CNFG_PAD_SP);
> -       val |= FIELD_PREP(PHY_CNFG_PAD_SN_MASK, PHY_CNFG_PAD_SN);
> -       sdhci_writel(host, val, PHY_CNFG_R);
> -
> -       /* disable delay line */
> -       sdhci_writeb(host, PHY_SDCLKDL_CNFG_UPDATE, PHY_SDCLKDL_CNFG_R);
> -
> -       /* set delay line */
> -       sdhci_writeb(host, priv->delay_line, PHY_SDCLKDL_DC_R);
> -       sdhci_writeb(host, PHY_DLL_CNFG2_JUMPSTEP, PHY_DLL_CNFG2_R);
> -
> -       /* enable delay lane */
> -       val = sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
> -       val &= ~(PHY_SDCLKDL_CNFG_UPDATE);
> -       sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
> +       if (rxsel == PHY_PAD_RXSEL_1V8) {
> +               u8 sel = FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK, PHY_DLLDL_CNFG_SLV_INPSEL);
>
> -       /* configure phy pads */
> -       val = PHY_PAD_RXSEL_3V3;
> -       val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
> -       val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
> -       val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> -       sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
> -       sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
> -       sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
> -
> -       val = FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
> -       val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> -       sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
> -
> -       val = PHY_PAD_RXSEL_3V3;
> -       val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLDOWN);
> -       val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
> -       val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> -       sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
> +               sdhci_writeb(host, sel, PHY_DLLDL_CNFG_R);
> +       }
>
>         /* enable phy dll */
>         sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
> +
>  }
>
>  static void th1520_sdhci_set_phy(struct sdhci_host *host)
> @@ -433,11 +395,7 @@ static void th1520_sdhci_set_phy(struct sdhci_host *host)
>         u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
>         u16 emmc_ctrl;
>
> -       /* Before power on, set PHY configs */
> -       if (priv->flags & FLAG_IO_FIXED_1V8)
> -               dwcmshc_phy_1_8v_init(host);
> -       else
> -               dwcmshc_phy_3_3v_init(host);
> +       dwcmshc_phy_init(host);
>
>         if ((host->mmc->caps2 & emmc_caps) == emmc_caps) {
>                 emmc_ctrl = sdhci_readw(host, priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
> @@ -1163,7 +1121,7 @@ static const struct sdhci_ops sdhci_dwcmshc_th1520_ops = {
>         .get_max_clock          = dwcmshc_get_max_clock,
>         .reset                  = th1520_sdhci_reset,
>         .adma_write_desc        = dwcmshc_adma_write_desc,
> -       .voltage_switch         = dwcmshc_phy_1_8v_init,
> +       .voltage_switch         = dwcmshc_phy_init,
>         .platform_execute_tuning = th1520_execute_tuning,
>  };
>
> --
> 2.25.1
>
