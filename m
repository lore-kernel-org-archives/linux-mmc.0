Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB61212189
	for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862607; cv=none; b=qQLPUicszl6q/iERa4D+JO/PKQj/zBc6PtqiWwsMT4VFNCsI91wdFOYnHhZo26A+q0yZyAytqO1nLtscjblmCzgalx18+9WCTPLIImr5OoU7uGGCiZXQ8C3ZeEySKCKEp/myaq4tEoa+aH9l9sJC98+zStVKYs5QdBoy1pGX87g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862607; c=relaxed/simple;
	bh=peqexeuw5wHJv6totkmML0VJIDG0DCMQ+5G4N1JjCyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwGnaj187jAzsRsKlV05Wh6vi3HBdMp76J8ycOaxZGAtaCcicrvJMPvYpRiEpnQ0Tvh7ADneHgc/yKSbZVhis+lHJ6Ak7/cbIrche2e33UMIodPnSoepQZZ+4YGPYzHdOZPFwupu7NTf/Va0heU0yj+OrA91lWvCjirrEP/+BGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RnP+Znk3; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RnP+Znk3"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e291cbbf05bso2310083276.2
        for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 06:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729862604; x=1730467404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RSi07GpJCTtbyn49PZY5VKqw+hphFmZmbrjr6WKqC9o=;
        b=RnP+Znk3kbUHkdVoBQ1sEe1sJ+KwwqNOUVuAO9iiizqOrQuWjjYJTsZhmQNGc88n5c
         1PbEMafMQdfVy4xKY36vvtN5mk1GwZqcg49EmoPVWom+ZAxXAe8EATAlpCCpxwgd08yS
         mIsxQiQwEVsnrrOenG0U7Nh6Z8gfTejPT4cLfDIo63kwyNcGEQtTFep5H4amTssdRm4J
         TmiAksbRylzIrKQD8O0HSqKMTy1tXzqor/wpzj+UeHhl4viQCvJ5o+x0LZNvjkQo7K5I
         YC5wbxdSgtczK8K48S/JOgOj99HbtYcqPreNQbCV8jzOK2i7O73E5CDoeRxJStPLXLaN
         po1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729862604; x=1730467404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RSi07GpJCTtbyn49PZY5VKqw+hphFmZmbrjr6WKqC9o=;
        b=hjV6+Upwexuqh9IUtdJn8HAACPXI21Bj5b3Iry2aSp9yZqFMOhrdOWZTlkjJ0TOZjo
         2g+GynN24RJOWZh4aK0EMCMLwAhXYFfjXHJXVuRTpDp0UItykXCLCe7zJ/hOf5pkNryp
         AT77Wh7H1MHEEmumoQszn6bM+omr1GCpmpFjBv3ddQ8KkyPByHUIDEoF30FFycpMRUKp
         +zrFpIcLeaNY95z0ShqVDdLPNPzJXuE3Oj5LnsS24QP5yEhfmkAdmaOQK9TgTggVIwDO
         7vrmUBgrT+1gUALpuS4bO8QkRbFFt/9oYyRzIVAEU5O0OxdWcihggC0QBdCQkflPmm0O
         4zqA==
X-Forwarded-Encrypted: i=1; AJvYcCWKT2Ih6BpniGNhyKKjAXfSdjOCt5Ige5kBBq6JGln0ZAdZ4kcjj27rQu9TtUqkn75LSTmW4KhLz90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3IkwRfg0uNvXdnt5ahEEIovrCGBXiq7Sdnx0VlMvVTvHlZBd2
	ShLuYoW9u+CBsO1lxHf3vSxP7GDowWnWJHpj4ZOD7Vq00O8CVXp63IiHkitcEJudUQbYG32zBIw
	q1u/kbrP09LfSpdKKgd+KEF1A+K74lAJjWvhzwQ==
X-Google-Smtp-Source: AGHT+IFnMJBu2OdHwDe03B0G8MXo39DHb96dxUSQUCPRpHdFteV2Ewfi7/O4fZ5SMm83m1s55hqH4aLeqgoc995xDHg=
X-Received: by 2002:a05:690c:660c:b0:6dd:cdd7:ce5a with SMTP id
 00721157ae682-6e7f0e14dc2mr102640547b3.18.1729862604209; Fri, 25 Oct 2024
 06:23:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025060017.1663697-1-benchuanggli@gmail.com>
In-Reply-To: <20241025060017.1663697-1-benchuanggli@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 25 Oct 2024 15:22:48 +0200
Message-ID: <CAPDyKFpb5ZePhXziLH3VbuKKywJZbo8UBF1NM1_dyOWq9oLDng@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-pci-gli: GL9767: Fix low power mode on the
 set clock function
To: Ben Chuang <benchuanggli@gmail.com>
Cc: adrian.hunter@intel.com, victor.shih@genesyslogic.com.tw, 
	greg.tu@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw, 
	HL.Liu@genesyslogic.com.tw, Lucas.Lai@genesyslogic.com.tw, 
	victorshihgli@gmail.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Georg Gottleuber <ggo@tuxedocomputers.com>
Content-Type: text/plain; charset="UTF-8"

+ Georg

On Fri, 25 Oct 2024 at 08:01, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> On sdhci_gl9767_set_clock(), the vendor header space(VHS) is read-only
> after calling gl9767_disable_ssc_pll() and gl9767_set_ssc_pll_205mhz().
> So the low power negotiation mode cannot be enabled again.
> Introduce gl9767_set_low_power_negotiation() function to fix it.
>
> The explanation process is as below.
>
> static void sdhci_gl9767_set_clock()
> {
>         ...
>         gl9767_vhs_write();
>         ...
>         value |= PCIE_GLI_9767_CFG_LOW_PWR_OFF;
>         pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value); <--- (a)
>
>         gl9767_disable_ssc_pll(); <--- (b)
>         sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
>
>         if (clock == 0)
>                 return;  <-- (I)
>
>         ...
>         if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
>                 ...
>                 gl9767_set_ssc_pll_205mhz(); <--- (c)
>         }
>         ...
>         value &= ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
>         pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value); <-- (II)
>         gl9767_vhs_read();
> }
>
> (a) disable low power negotiation mode. When return on (I), the low power
> mode is disabled.  After (b) and (c), VHS is read-only, the low power mode
> cannot be enabled on (II).
>
> Fixes: d2754355512e ("mmc: sdhci-pci-gli: Set SDR104's clock to 205MHz and enable SSC for GL9767")

Is this the same problem as being reported in
https://lore.kernel.org/all/41c1c88a-b2c9-4c05-863a-467785027f49@tuxedocomputers.com/

?

> Signed-off-by: Ben Chuang <benchuanggli@gmail.com>

Not sure the above SoB makes sense. The below is perfectly sufficient, right?

> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 35 +++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 0f81586a19df..22a927ce2c88 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -892,28 +892,40 @@ static void gl9767_disable_ssc_pll(struct pci_dev *pdev)
>         gl9767_vhs_read(pdev);
>  }
>
> +static void gl9767_set_low_power_negotiation(struct pci_dev *pdev, bool enable)
> +{
> +       u32 value;
> +
> +       gl9767_vhs_write(pdev);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
> +       if (enable)
> +               value &= ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> +       else
> +               value |= PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
> +
> +       gl9767_vhs_read(pdev);
> +}
> +
>  static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>         struct sdhci_pci_slot *slot = sdhci_priv(host);
>         struct mmc_ios *ios = &host->mmc->ios;
>         struct pci_dev *pdev;
> -       u32 value;
>         u16 clk;
>
>         pdev = slot->chip->pdev;
>         host->mmc->actual_clock = 0;
>
> -       gl9767_vhs_write(pdev);
> -
> -       pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
> -       value |= PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> -       pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
> -
> +       gl9767_set_low_power_negotiation(pdev, false);
>         gl9767_disable_ssc_pll(pdev);
>         sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
>
> -       if (clock == 0)
> +       if (clock == 0) {
> +               gl9767_set_low_power_negotiation(pdev, true);
>                 return;
> +       }
>
>         clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
>         if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
> @@ -922,12 +934,7 @@ static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned int clock)
>         }
>
>         sdhci_enable_clk(host, clk);
> -
> -       pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
> -       value &= ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> -       pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
> -
> -       gl9767_vhs_read(pdev);
> +       gl9767_set_low_power_negotiation(pdev, true);
>  }
>
>  static void gli_set_9767(struct sdhci_host *host)
> --
> 2.47.0
>
