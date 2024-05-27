Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA60717BD5
	for <linux-mmc@vger.kernel.org>; Mon, 27 May 2024 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716794857; cv=none; b=FCKZ78xZjYd8HjHNbZ0/bjhCHU866PNNT/Wviyz4rBqe55Tpz3q0ojqDmhNn1S7gPNb8uug+eWRykOxfugSIe2UfYTpAZuXO7g8To7w7WYv5o8u6dmUkXwWLkcwLATLJMayW4pYpBXKwYTWJMxw1ryRLyFp6Wbi7z9xkUg7Owv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716794857; c=relaxed/simple;
	bh=sc2dXMdM8I170FsVHX97DbIKM+TPkoHaIGmAf1Ax5QU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcE32DEqjAIBk46/ZVYhjvR2jxIpK2IiRviTzd0xKTQJNa8lnDmPR+rOJTGPFtB9BkQRuZhHjMmQZvOw2sOB5ONWMx37/oSgJf4qv0iZGy72ejHUiz9kN4RlyU3IzjgVAEmee0f95PHEGM088DWTjOl899b+hB3baCTt/zjbfG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N6npEU/s; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N6npEU/s"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57857e0f45eso2111901a12.0
        for <linux-mmc@vger.kernel.org>; Mon, 27 May 2024 00:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716794853; x=1717399653; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tq08Kk3nKg9qcVVrH+CQCgxy3zPqfMg+Tuq3n+0tlL4=;
        b=N6npEU/s3i+7twLzlkvo88IyK4KO07VkRx63bWrgBUEIuO+lhNWVoj0W394jdZDEgH
         nQ12Q1cjNmNia/KslqZW0a8K5AH84s0/98NX2vabx7FF6wlyTYLet6AyKqylhlA0x1SY
         W7t7FtjTIWBi7GlNTjvayLa2vmWwD3zaZkt2AxdpMWglP1vmTrLeX/okf9W3ZZFjgPlw
         R0syGBSCYl4Sf8FzqY2gnx9OQSZSY5rMVdAWLjQ2zNmR5S9r9EGMk06SXgF3zuy8W+IQ
         S+QCuF2T1cYzzumdK8OGub+wf0tDFFsE0zhT0+EftF+mZK8upioljHl6QOb0K0p/Lp4V
         T4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716794853; x=1717399653;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tq08Kk3nKg9qcVVrH+CQCgxy3zPqfMg+Tuq3n+0tlL4=;
        b=o75h81/fgjss4DrqWOh3qEfW7V1t15D+OCZ/LaZodZC3di6BOuph4PKuRZatodK2pz
         XIp/uQnj4RJfwMLvS5RAWxpo/lZPQxb85GFFxu3S2SzBp3qY2DuPt0F8AEeIvU5BMEVj
         3wFY4t4E7/C+MYUaY7a3dKIA2Dd9pPemQpEt30G1xSP/6wgyQuNHfw58A1Xc7sbCy/Uy
         2AbmnSfqU7U/WoV9qrR0QQWpOP5fvSi3q8E2xylrVXgC6a4nTfsyz4+trI/CMpS96h76
         hccF0ehjg02QQePiC3vyfcOu+nIr7NJMla3O6497L8fD9U2z3v3qPvTpKVReDQuP4ztC
         baSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUM8T2L0v7DYXbHGYFMKjQu/obi4RUeNcAMTQzSJogx4sneeEFJ+Kvcmv3BtpNWIdjQXylvdyYu0H0D9DNsbma8C5aXXJBJAma
X-Gm-Message-State: AOJu0YymGnkwgnZSugmqTaDu2Lc6NMR5QOF6ZLZ96LCq6uNcbOBJ5l+3
	ThxIA/p89GY3bu69i+9XMeloN44iCeYWIOTdaaQ+4Hg8pHKE0vcgalbfiu0Aemo=
X-Google-Smtp-Source: AGHT+IF/Ad/UrVqGCx4yFYh9J4k54L4ZIgvX2cg0dOunkhcbkkjAaaXiLkqInRLp/8vA3D0cOmTk6Q==
X-Received: by 2002:a50:9518:0:b0:578:6438:be99 with SMTP id 4fb4d7f45d1cf-5786438bed5mr5978574a12.7.1716794853077;
        Mon, 27 May 2024 00:27:33 -0700 (PDT)
Received: from localhost (host-87-18-209-253.retail.telecomitalia.it. [87.18.209.253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57852495de0sm5342116a12.61.2024.05.27.00.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 00:27:32 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 27 May 2024 09:27:45 +0200
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Marc Zyngier <maz@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH v3 3/4] mmc: sdhci-brcmstb: Add BCM2712 support
Message-ID: <ZlQ18byCTvj1kg_q@apocalypse>
Mail-Followup-To: Stefan Wahren <wahrenst@gmx.net>,
	Andrea della Porta <andrea.porta@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Marc Zyngier <maz@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
References: <cover.1716277695.git.andrea.porta@suse.com>
 <c413737f538d9bd403c30104a83a7fbb1ea7461d.1716277695.git.andrea.porta@suse.com>
 <f27aaf92-8109-4cad-94ba-6f72cd9bdabf@gmx.net>
 <ZlF5dQbNpZ921e66@apocalypse>
 <9ef2d8c2-621a-4e05-8afa-5d2b99a36caa@gmx.net>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ef2d8c2-621a-4e05-8afa-5d2b99a36caa@gmx.net>

Hi Stefan,

On 08:59 Sat 25 May     , Stefan Wahren wrote:
> Hi Andrea,
> 
> Am 25.05.24 um 07:39 schrieb Andrea della Porta:
> > On 14:26 Tue 21 May     , Stefan Wahren wrote:
> > > Hi Andrea,
> > > 
> > > Am 21.05.24 um 10:35 schrieb Andrea della Porta:
> > > > Broadcom BCM2712 SoC has an SDHCI card controller using the SDIO CFG
> > > > register block present on other STB chips. Add support for BCM2712
> > > > SD capabilities of this chipset.
> > > > The silicon is SD Express capable but this driver port does not currently
> > > > include that feature yet.
> > > > Based on downstream driver by raspberry foundation maintained kernel.
> > > > 
> > > > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > > > ---
> > > >    drivers/mmc/host/sdhci-brcmstb.c | 65 ++++++++++++++++++++++++++++++++
> > > >    1 file changed, 65 insertions(+)
> > > > 
> > > > diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> > > > index 9053526fa212..b349262da36e 100644
> > > > --- a/drivers/mmc/host/sdhci-brcmstb.c
> > > > +++ b/drivers/mmc/host/sdhci-brcmstb.c
> > > > @@ -30,6 +30,21 @@
> > > > 
> > > >    #define SDHCI_ARASAN_CQE_BASE_ADDR		0x200
> > > > 
> > > > +#define SDIO_CFG_CQ_CAPABILITY			0x4c
> > > > +#define SDIO_CFG_CQ_CAPABILITY_FMUL		GENMASK(13, 12)
> > > > +
> > > > +#define SDIO_CFG_CTRL				0x0
> > > > +#define SDIO_CFG_CTRL_SDCD_N_TEST_EN		BIT(31)
> > > > +#define SDIO_CFG_CTRL_SDCD_N_TEST_LEV		BIT(30)
> > > > +
> > > > +#define SDIO_CFG_MAX_50MHZ_MODE			0x1ac
> > > > +#define SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE	BIT(31)
> > > > +#define SDIO_CFG_MAX_50MHZ_MODE_ENABLE		BIT(0)
> > > > +
> > > > +#define MMC_CAP_HSE_MASK	(MMC_CAP2_HSX00_1_2V | MMC_CAP2_HSX00_1_8V)
> > > > +/* Select all SD UHS type I SDR speed above 50MB/s */
> > > > +#define MMC_CAP_UHS_I_SDR_MASK	(MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104)
> > > > +
> > > >    struct sdhci_brcmstb_priv {
> > > >    	void __iomem *cfg_regs;
> > > >    	unsigned int flags;
> > > > @@ -38,6 +53,7 @@ struct sdhci_brcmstb_priv {
> > > >    };
> > > > 
> > > >    struct brcmstb_match_priv {
> > > > +	void (*cfginit)(struct sdhci_host *host);
> > > >    	void (*hs400es)(struct mmc_host *mmc, struct mmc_ios *ios);
> > > >    	struct sdhci_ops *ops;
> > > >    	const unsigned int flags;
> > > > @@ -168,6 +184,38 @@ static void sdhci_brcmstb_set_uhs_signaling(struct sdhci_host *host,
> > > >    	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> > > >    }
> > > > 
> > > > +static void sdhci_brcmstb_cfginit_2712(struct sdhci_host *host)
> > > > +{
> > > > +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > > > +	struct sdhci_brcmstb_priv *brcmstb_priv = sdhci_pltfm_priv(pltfm_host);
> > > > +	u32 reg, base_clk_mhz;
> > > > +
> > > > +	/*
> > > > +	 * If we support a speed that requires tuning,
> > > > +	 * then select the delay line PHY as the clock source.
> > > > +	 */
> > > > +	if ((host->mmc->caps & MMC_CAP_UHS_I_SDR_MASK) || (host->mmc->caps2 & MMC_CAP_HSE_MASK)) {
> > > > +		reg = readl(brcmstb_priv->cfg_regs + SDIO_CFG_MAX_50MHZ_MODE);
> > > > +		reg &= ~SDIO_CFG_MAX_50MHZ_MODE_ENABLE;
> > > > +		reg |= SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE;
> > > > +		writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_MAX_50MHZ_MODE);
> > > > +	}
> > > > +
> > > > +	if ((host->mmc->caps & MMC_CAP_NONREMOVABLE) ||
> > > > +	    (host->mmc->caps & MMC_CAP_NEEDS_POLL)) {
> > > > +		/* Force presence */
> > > > +		reg = readl(brcmstb_priv->cfg_regs + SDIO_CFG_CTRL);
> > > > +		reg &= ~SDIO_CFG_CTRL_SDCD_N_TEST_LEV;
> > > > +		reg |= SDIO_CFG_CTRL_SDCD_N_TEST_EN;
> > > > +		writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_CTRL);
> > > > +	}
> > > > +
> > > > +	/* Guesstimate the timer frequency (controller base clock) */
> > > > +	base_clk_mhz = max_t(u32, clk_get_rate(pltfm_host->clk) / (1000 * 1000), 1);
> > > > +	reg = SDIO_CFG_CQ_CAPABILITY_FMUL | base_clk_mhz;
> > > > +	writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_CQ_CAPABILITY);
> > > This part assumes the clock isn't changed afterwards, see below ...
> > > > +}
> > > > +
> > > >    static void sdhci_brcmstb_dumpregs(struct mmc_host *mmc)
> > > >    {
> > > >    	sdhci_dumpregs(mmc_priv(mmc));
> > > > @@ -200,6 +248,14 @@ static struct sdhci_ops sdhci_brcmstb_ops = {
> > > >    	.set_uhs_signaling = sdhci_set_uhs_signaling,
> > > >    };
> > > > 
> > > > +static struct sdhci_ops sdhci_brcmstb_ops_2712 = {
> > > > +	.set_clock = sdhci_set_clock,
> > > > +	.set_power = sdhci_set_power_and_bus_voltage,
> > > > +	.set_bus_width = sdhci_set_bus_width,
> > > > +	.reset = sdhci_reset,
> > > > +	.set_uhs_signaling = sdhci_set_uhs_signaling,
> > > > +};
> > > > +
> > > >    static struct sdhci_ops sdhci_brcmstb_ops_7216 = {
> > > >    	.set_clock = sdhci_brcmstb_set_clock,
> > > >    	.set_bus_width = sdhci_set_bus_width,
> > > > @@ -214,6 +270,11 @@ static struct sdhci_ops sdhci_brcmstb_ops_74165b0 = {
> > > >    	.set_uhs_signaling = sdhci_brcmstb_set_uhs_signaling,
> > > >    };
> > > > 
> > > > +static const struct brcmstb_match_priv match_priv_2712 = {
> > > > +	.cfginit = sdhci_brcmstb_cfginit_2712,
> > > > +	.ops = &sdhci_brcmstb_ops_2712,
> > > > +};
> > > > +
> > > >    static struct brcmstb_match_priv match_priv_7425 = {
> > > >    	.flags = BRCMSTB_MATCH_FLAGS_NO_64BIT |
> > > >    	BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
> > > > @@ -238,6 +299,7 @@ static struct brcmstb_match_priv match_priv_74165b0 = {
> > > >    };
> > > > 
> > > >    static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] = {
> > > > +	{ .compatible = "brcm,bcm2712-sdhci", .data = &match_priv_2712 },
> > > >    	{ .compatible = "brcm,bcm7425-sdhci", .data = &match_priv_7425 },
> > > >    	{ .compatible = "brcm,bcm7445-sdhci", .data = &match_priv_7445 },
> > > >    	{ .compatible = "brcm,bcm7216-sdhci", .data = &match_priv_7216 },
> > > > @@ -370,6 +432,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
> > > >    	    (host->mmc->caps2 & MMC_CAP2_HS400_ES))
> > > >    		host->mmc_host_ops.hs400_enhanced_strobe = match_priv->hs400es;
> > > > 
> > > > +	if (match_priv->cfginit)
> > > > +		match_priv->cfginit(host);
> > > > +
> > > I'm not sure this is the right place to call cfginit.
> > > sdhci_brcmstb_cfginit_2712 retrives the current controller base clock,
> > > but at the end of  sdhci_brcmstb_probe this clock frequency could be
> > > adjusted by the device property "clock-frequency". So i'm not sure this
> > > is intended.
> > I've tried to interpret the meaning of those two clocks since unfortunately I don't
> > own the datasheet for any of the platforms involved, so please take the following
> > as the result of my own (possibly wrong) intuition and (mostly wild) guessing.
> > 
> > The main clock is 'sw_sdio' while 'sdio_freq' is optional and the latter seems to be
> > orthogonal to the former.
> > While sw_sdio is mostly used for SD storage card, sdio_freq seems more related to
> > SDIO family of cards (wifi, gps, camera, etc) for which you could specify a particular
> > (and higher) base frequency.
> > Unfortunately I wasn't able to find any reference to sdio_freq in current devicetree
> > so it's probably only specific to custom appliances: to be honest I'm not even sure
> > that BCM2712 is supporting that improved clock source.  Also, from the following lines
> > at the end of cfginit function:
> > 
> > /* Guesstimate the timer frequency (controller base clock) */
> > base_clk_mhz = max_t(u32, clk_get_rate(pltfm_host->clk) / (1000 * 1000), 1);
> > reg = SDIO_CFG_CQ_CAPABILITY_FMUL | base_clk_mhz;
> > writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_CQ_CAPABILITY);
> > 
> > judging from the name of SDIO_CFG_CQ_CAPABILITY register, I'd guess that it relates
> > to some Command Queue (timeout?) setting so it's probably only important if CQE is
> > enabled specifying 'supports-cqe' property, which is not in current devicetree (nor
> > in  downstream one). If this is the case it's mostly a performance improvement, and
> > as such something that we are not necessarily interested in right now since this
> > patchset adds just minimal boot support. I would then drop those lines, as we could
> > just reintroduce them if they need be once we have a better understanding of that
> > specific register and/if the cqe support will be enabled. As a matter of fact those
> > lines are not working as expected in any case since pltfm_host->clk is set at the
> > very end of sdhci_brcmstb_probe() while the cfginit function is invoked much earlier.
> > The result is that right now the value set ito SDIO_CFG_CQ_CAPABILITY register is always
> > equal to 1MHz. Further testing reveals that it is indeed working fine even with those
> > lines dropped, so I would deem that code as unnecessary for this early patchset.
> > Is it a viable solution?
> I don't have any knowledge about this hardware, so my opinion based on
> your good investigations. But i would be fine with this.
> 
> Just to make it clear, this works with and without U-Boot in the bootchain?

Yes, I confirm it works with both.

Thanks,
Andrea

> 
> Thanks
> > 
> > Many thanks,
> > Andrea
> > 
> > > >    	/*
> > > >    	 * Supply the existing CAPS, but clear the UHS modes. This
> > > >    	 * will allow these modes to be specified by device tree
> 
