Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5E8257423
	for <linux-mmc@vger.kernel.org>; Thu,  5 Mar 2026 11:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772711350; cv=pass; b=mtH8wfRl+3DKCncV2PusbjNDljRL/2+nZlLKJF8j8bd2CvE9fC/EgpEQBO6qpCxhrokxqJU+ZuphbioGiV4gOScxivn2G16NRVgmOtuNybF0qF64584uwv39MorFEJMGn5V4BWpEKKH9gEea5DCB5nL4MUuLFxWhsptSCtaPCoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772711350; c=relaxed/simple;
	bh=7vyD8zqzHVdsFOSYMdD9Syx+8kthZrIRiMT1pjzzXK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F4+X4JzK9eLA3KdvJQmdGZzbPYFbRWQDf8meVyLxODOQ8hDOncN/lo52aTbnnnJYUZUbB1n1UCeVxvuMF4K/ybelvbnsKMLyuL2x4eN0OWsjDR93Gf3xiIXun526stTtl/uYi2j+5YCAtzd27Yg/GNnMcwi2FY57HWxQeZMjxa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gTbO9+K1; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gTbO9+K1"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59e5ea93a1aso1835272e87.1
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2026 03:49:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772711347; cv=none;
        d=google.com; s=arc-20240605;
        b=CIESw5uBR4RdIPCtZBsR2Y1nOFpzqdJWX/FtH/vc954PSxqVfoTrIzqmSZ7nONpDJT
         CnZd4sRm0RZa0u8hyPUDh1JWXTzWlz4G/x/nUSnaw/0FgISvTBuoLVTb6AhQfEHJd5Vy
         3VzaH3CYwtkAhJJwovm4b+T1EYERmSlydlhZrDWqCKU99crZ5aiPp+jFcEH3rtq4ekr1
         Zwnkt/Wp1BWq8fM8Aau3bDz0ULNZdyXBnrKsYLxJIGdG+qn/fFqmFm1sI+GdrtoljJzN
         MucWEDERakSgFajhOrB6BSsk+eAte54Gtoazxsv2ribh2b7wZXs0C5O6rWPzV0s7eqP6
         VkFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JsfgSj6xXDBTyorRizxHsuWjgHE8jzwVestTRCsOkXE=;
        fh=mFxx+1RE66ftik+N4UOxSb+9AV8ccf/bVZluFA0ROl8=;
        b=EGB+cF4F4n86/pcupO6iYF0BCCmD0aJaE9i9WXxr2qUfNEdgVJxGiYxv7pS1AJbR6I
         mTbrChqQg3yPNJ2CChWQuuI5duDBrG7MjbP50BRkfQfddlTK6G4X7/CTROrtJuVxIwSe
         1HeexbtQRHQSBCNdnmyH56oIFCCBnKc1PlDBJzrmg5QIxPN6DdOqZi/843VG+EjFUDPA
         lwSMiPgGk62AcZLOsKrdZqdRyAsRBuRpWPvenDEacO3kbu97IS+rQK+4SOkRD4s1kCL6
         Vbq130v/jHI6PchQFHg8CxkJoMd6zu2g2rOtt79dAfupPFa0I6uWdrZOR4KqcK37irq1
         UC4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772711347; x=1773316147; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JsfgSj6xXDBTyorRizxHsuWjgHE8jzwVestTRCsOkXE=;
        b=gTbO9+K1sj4BhsJnFX13ZPBGjEOTy0KbH2oA4Wq+QTy8DrXRIYzLLolAfcCH+lIbn4
         3P1Hln8gQjYWE14k1mfCd5Coi6mg8aMKar1SHW/6NJnP7R1XUaHuDtg3jcRY+5AvfEeY
         rGBN3nEd96CRQ4Evo/3FD+prCUjtLFz07H2biRwUMpaSlDmUYaAXT0vi3WGRS3EAtd/L
         42xBmsKfpjYm8LYjJG8spoUSKD5Lg56k+O5MQMOOnA55fZZnDnDwhCkEv+a1K9rgqNAW
         d90j34Pqpr4tPWlKBhS1J3VeyluJK9hMRPvyGLo9wDYiRzIbYKI4bGz2qwJxDy75Bc/j
         G3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772711347; x=1773316147;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsfgSj6xXDBTyorRizxHsuWjgHE8jzwVestTRCsOkXE=;
        b=VBAopgtKoAxmB9d4APRqS7wOVs/xsYf0ClrVENkK0pNPL1V3HkUd0Gf0gG+jiXcZpn
         AmqJHGsJOaNSbR4DchVYoi3YXiF7bERFNaSU080MmOymF7fgAyMXN3ZroH+FS6S3c+YA
         DW24u+kyP9Lo8YX1hAUfSikAE0j9LdQbnoseV2S7ccViuKP1o/dy0a2Jf+nXBcMybpZA
         C1P6ohppjaBYIP3pFjsLQt5/1ljOJzwBQJLqX0ydu2GCmD/9h1qKiia2COdxAyU4HiaQ
         w4BiH1E7rEh1QEVPfLdhlhe/Dwdr/IM82SfhLd5WPtUO2QuOQ2tsIHoYVJCFOTpCNt34
         wiGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDKVm3JVu2SMa00spgFjsyKr/ReUwF8RIErKAXuWW4GwsvxM0jvLLBbHQ8suSkJWeAdzWvhqmUBVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSQHP5ngcGCXUcEzj2+gJh9umJh8w2sfrdcpg/UwOkpcX65XVy
	lqJUIRq9x/1xaBi0r24rWNneQKazMiiBb2YUSNKo/BQiy1XKOwZasOCOwT7if7+h4Ek8v2a64v/
	L1C+HBlrc24Sg3Tw9TDyjZ6lz9J8bfPcY7cIYLcIUZw==
X-Gm-Gg: ATEYQzyu9ejKCcKQbpe+g/rysQ+rRi03d9wWG35ffu1KlQl5mGu524eSZuoES/IIs2a
	5KkUai+krhTLfrpVCdSPu9sPnohuXzDbFTVME7JZjUuxi/pF/cFKTrOCYt55hVvu7krY7DBBK/s
	yDpLaTj9DucPdgJZEDM6EAOS617R2RMIOJVHqZe+AnUjmLiu28bMn5uM4sH2EHSp+yrVyvgzMPA
	9pfBOeK8xGM6QWdIPC3FvLE6A46QRNqRgCyr5cSLW/fpmPjt6sUspjEO2uVZbGtdK9s+J2EYgE3
	Fd4QG889
X-Received: by 2002:a05:6512:3093:b0:5a1:3134:923f with SMTP id
 2adb3069b0e04-5a131349301mr720263e87.40.1772711346715; Thu, 05 Mar 2026
 03:49:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226115923.75670-1-jiayu.riscv@isrc.iscas.ac.cn> <20260226115923.75670-3-jiayu.riscv@isrc.iscas.ac.cn>
In-Reply-To: <20260226115923.75670-3-jiayu.riscv@isrc.iscas.ac.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Mar 2026 12:48:29 +0100
X-Gm-Features: AaiRm53AjyJYNQijXY6q6y4X_v_yONuMKKSX6WNloZ4c1DB_5kt_3SxJ_g0U8Uc
Message-ID: <CAPDyKFrxJ0oWuMWoUEYGO0t-WOYU+G7p5eFw8cUY7xyPaREB5Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: sdhci-dwcmshc: Add Canaan K230 DWCMSHC
 controller support
To: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
Cc: krzk@kernel.org, adrian.hunter@intel.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	gaohan@iscas.ac.cn, me@ziyao.cc
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Feb 2026 at 12:59, Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn> wrote:
>
> Add SDHCI controller driver for Canaan k230 SoC. Implement custom
> sdhci_ops for set_clock, phy init, init and reset.
>
> Signed-off-by: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 288 ++++++++++++++++++++++++++++
>  1 file changed, 288 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 2b75a36c096b..21c77e908d77 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -128,9 +128,11 @@
>  #define PHY_CNFG_PHY_PWRGOOD_MASK      BIT_MASK(1) /* bit [1] */
>  #define PHY_CNFG_PAD_SP_MASK           GENMASK(19, 16) /* bits [19:16] */
>  #define PHY_CNFG_PAD_SP                        0x0c /* PMOS TX drive strength */
> +#define PHY_CNFG_PAD_SP_k230           0x09 /* PMOS TX drive strength for k230 */
>  #define PHY_CNFG_PAD_SP_SG2042         0x09 /* PMOS TX drive strength for SG2042 */
>  #define PHY_CNFG_PAD_SN_MASK           GENMASK(23, 20) /* bits [23:20] */
>  #define PHY_CNFG_PAD_SN                        0x0c /* NMOS TX drive strength */
> +#define PHY_CNFG_PAD_SN_k230           0x08 /* NMOS TX drive strength for k230 */
>  #define PHY_CNFG_PAD_SN_SG2042         0x08 /* NMOS TX drive strength for SG2042 */
>
>  /* PHY command/response pad settings */
> @@ -153,14 +155,22 @@
>  #define PHY_PAD_RXSEL_3V3              0x2 /* Receiver type select for 3.3V */
>
>  #define PHY_PAD_WEAKPULL_MASK          GENMASK(4, 3) /* bits [4:3] */
> +#define PHY_PAD_WEAKPULL_DISABLED      0x0 /* Weak pull up and pull down disabled */
>  #define PHY_PAD_WEAKPULL_PULLUP                0x1 /* Weak pull up enabled */
>  #define PHY_PAD_WEAKPULL_PULLDOWN      0x2 /* Weak pull down enabled */
>
>  #define PHY_PAD_TXSLEW_CTRL_P_MASK     GENMASK(8, 5) /* bits [8:5] */
>  #define PHY_PAD_TXSLEW_CTRL_P          0x3 /* Slew control for P-Type pad TX */
> +#define PHY_PAD_TXSLEW_CTRL_P_k230_VAL2        0x2 /* Slew control for P-Type pad TX for k230 */
>  #define PHY_PAD_TXSLEW_CTRL_N_MASK     GENMASK(12, 9) /* bits [12:9] */
>  #define PHY_PAD_TXSLEW_CTRL_N          0x3 /* Slew control for N-Type pad TX */
>  #define PHY_PAD_TXSLEW_CTRL_N_SG2042   0x2 /* Slew control for N-Type pad TX for SG2042 */
> +#define PHY_PAD_TXSLEW_CTRL_N_k230_VAL2        0x2 /* Slew control for N-Type pad TX for k230 */
> +#define PHY_PAD_TXSLEW_CTRL_N_k230_VAL1        0x1 /* Slew control for N-Type pad TX for k230 */
> +
> +/* PHY Common DelayLine config settings */
> +#define PHY_COMMDL_CNFG                        (DWC_MSHC_PTR_PHY_R + 0x1c)
> +#define PHY_COMMDL_CNFG_DLSTEP_SEL     BIT(0) /* DelayLine outputs on PAD enabled */
>
>  /* PHY CLK delay line settings */
>  #define PHY_SDCLKDL_CNFG_R             (DWC_MSHC_PTR_PHY_R + 0x1d)
> @@ -174,7 +184,10 @@
>  #define PHY_SDCLKDL_DC_HS400           0x18 /* delay code for HS400 mode */
>
>  #define PHY_SMPLDL_CNFG_R              (DWC_MSHC_PTR_PHY_R + 0x20)
> +#define PHY_SMPLDL_CNFG_EXTDLY_EN      BIT(0)
>  #define PHY_SMPLDL_CNFG_BYPASS_EN      BIT(1)
> +#define PHY_SMPLDL_CNFG_INPSEL_MASK    GENMASK(3, 2) /* bits [3:2] */
> +#define PHY_SMPLDL_CNFG_INPSEL         0x3 /* delay line input source */
>
>  /* PHY drift_cclk_rx delay line configuration setting */
>  #define PHY_ATDL_CNFG_R                        (DWC_MSHC_PTR_PHY_R + 0x21)
> @@ -227,6 +240,14 @@
>  /* SMC call for BlueField-3 eMMC RST_N */
>  #define BLUEFIELD_SMC_SET_EMMC_RST_N   0x82000007
>
> +/* Canaan specific Registers */
> +#define SD0_CTRL                       0x00
> +#define SD0_HOST_REG_VOL_STABLE                BIT(4)
> +#define SD0_CARD_WRITE_PROT            BIT(6)
> +#define SD1_CTRL                       0x08
> +#define SD1_HOST_REG_VOL_STABLE                BIT(0)
> +#define SD1_CARD_WRITE_PROT            BIT(2)
> +
>  /* Eswin specific Registers */
>  #define EIC7700_CARD_CLK_STABLE                BIT(28)
>  #define EIC7700_INT_BCLK_STABLE                BIT(16)
> @@ -268,6 +289,12 @@ struct eic7700_priv {
>         unsigned int drive_impedance;
>  };
>
> +struct k230_priv  {
> +       /* Kendryte k230 specific */
> +       struct regmap *hi_sys_regmap;
> +       const struct dwcmshc_k230_match_data *match_data;
> +};
> +
>  #define DWCMSHC_MAX_OTHER_CLKS 3
>
>  struct dwcmshc_priv {
> @@ -284,12 +311,34 @@ struct dwcmshc_priv {
>  };
>
>  struct dwcmshc_pltfm_data {
> +       const void *match_data;

This makes sense to me!

Although, I realized that dwcmshc_rk35xx_init() could also move its
assignment of "devtype" into this match_data.

Can you please create a follow-up patch to fixup this and to avoid
storing this type of data in two different ways?

>         const struct sdhci_pltfm_data pdata;
>         const struct cqhci_host_ops *cqhci_host_ops;
>         int (*init)(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
>         void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
>  };
>
> +struct dwcmshc_k230_match_data {
> +       bool is_emmc;
> +       u32 ctrl_reg;
> +       u32 vol_stable_bit;
> +       u32 write_prot_bit;
> +};
> +
> +static const struct dwcmshc_k230_match_data k230_emmc_match_data = {
> +       .is_emmc = true,
> +       .ctrl_reg = SD0_CTRL,
> +       .vol_stable_bit = SD0_HOST_REG_VOL_STABLE,
> +       .write_prot_bit = SD0_CARD_WRITE_PROT,
> +};
> +
> +static const struct dwcmshc_k230_match_data k230_sdio_match_data = {
> +       .is_emmc = false,
> +       .ctrl_reg = SD1_CTRL,
> +       .vol_stable_bit = SD1_HOST_REG_VOL_STABLE,
> +       .write_prot_bit = SD1_CARD_WRITE_PROT,
> +};

[...]

> +
> +static int dwcmshc_k230_init(struct device *dev, struct sdhci_host *host,
> +                            struct dwcmshc_priv *dwc_priv)
> +{
> +       static const char * const clk_ids[] = {"block", "timer", "axi"};
> +       const struct dwcmshc_k230_match_data *match_data;
> +       const struct dwcmshc_pltfm_data *pltfm_data;
> +       struct device_node *usb_phy_node;
> +       struct k230_priv *k230_priv;
> +       u32 data;
> +       int ret;
> +
> +       pltfm_data = device_get_match_data(dev);
> +
> +       if (!pltfm_data || !pltfm_data->match_data) {
> +               dev_err(dev, "No vendor data found for K230\n");
> +               return -EINVAL;
> +       }
> +       match_data = pltfm_data->match_data;

I don't think this should be specific to dwcmshc_k230_init().

Instead I suggest adding a "const void *match_data" to the "struct
dwcmshc_priv" - and copy the pointer in the common dwcmshc_probe()
instead. In this way, all variants will be able to use it.

> +
> +       k230_priv = devm_kzalloc(dev, sizeof(struct k230_priv), GFP_KERNEL);
> +       if (!k230_priv)
> +               return -ENOMEM;
> +
> +       k230_priv->match_data = match_data;
> +       dwc_priv->priv = k230_priv;
> +
> +       usb_phy_node = of_parse_phandle(dev->of_node, "canaan,usb-phy", 0);
> +       if (!usb_phy_node)
> +               return dev_err_probe(dev, -ENODEV,
> +                                    "Failed to find canaan,usb-phy phandle\n");
> +
> +       k230_priv->hi_sys_regmap = device_node_to_regmap(usb_phy_node);
> +       of_node_put(usb_phy_node);
> +
> +       if (IS_ERR(k230_priv->hi_sys_regmap))
> +               return dev_err_probe(dev, PTR_ERR(k230_priv->hi_sys_regmap),
> +                                    "Failed to get k230-usb-phy regmap\n");
> +
> +       ret = dwcmshc_get_enable_other_clks(mmc_dev(host->mmc), dwc_priv,
> +                                           ARRAY_SIZE(clk_ids), clk_ids);
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                                    "Failed to get/enable k230 mmc other clocks\n");
> +
> +       if (match_data->is_emmc) {
> +               host->flags &= ~SDHCI_SIGNALING_330;
> +               dwc_priv->flags |= FLAG_IO_FIXED_1V8;
> +       } else {
> +               host->mmc->caps |= MMC_CAP_SD_HIGHSPEED;
> +               host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
> +       }
> +
> +       ret = regmap_read(k230_priv->hi_sys_regmap, match_data->ctrl_reg, &data);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to read control reg 0x%x\n",
> +                                    match_data->ctrl_reg);
> +
> +       data |= match_data->write_prot_bit | match_data->vol_stable_bit;
> +       ret = regmap_write(k230_priv->hi_sys_regmap, match_data->ctrl_reg, data);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to write control reg 0x%x\n",
> +                                    match_data->ctrl_reg);
> +
> +       return 0;
> +}

[...]

Kind regards
Uffe
