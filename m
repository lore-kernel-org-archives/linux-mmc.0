Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557EA55783
	for <linux-mmc@vger.kernel.org>; Tue, 21 May 2024 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296402; cv=none; b=Cw/UPEFvJZvRvwrXJQsz7FGa/d9/+UEoRthmhkCJie1T51qMb1yBfeukoDRq5IKryPyjr1VzK4HNLiiCVCGw9f2WquD6FlBRTx7X0ZVgWfs53hz/6rbgFSv/JQmaIqh2bsg/Kiw8fH16AqXKs2e8TDhNYqm2QeC99EnXgoQYyvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296402; c=relaxed/simple;
	bh=DBUyQmvQh7vUb6oN302EO/ct8ueC5mznuotC02B36l0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAPdXrp6DBTS9v2h0Sk35+fZS0hJok40tpvw8SPjD9kiCjdgVQsRsRzTXVUgL2Aa3nG2jQ8OjSWaBY9fg9hRfixF957qVaZBL9/ai+slIHrdXs5a/CpDb0Jw6i1NPvS8KHEd2Nj4/2L9WswoqmjDOu1ROZ0heNYjtVP0Zm5SuVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BAa02ckJ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BAa02ckJ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a5a4bc9578cso816793466b.2
        for <linux-mmc@vger.kernel.org>; Tue, 21 May 2024 06:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716296399; x=1716901199; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YN/7AOVfwDQ9fuglKdggECs2cWRXnj0qk72xVYmNKJg=;
        b=BAa02ckJ1Mz52t3V7mhtzEiRIE+HnoFSUXoFf+jfFKSBjXOAewuoi81ZCvTCuDalBy
         d7L7Kj8vx0w0QzfkAtYVkIkHNbYfBFj4U8L9PuCWDm24DbCEpw7UwJkAfyUpn2LbWdX6
         E8RNpdJyxsw9jlOkUFdwxHyoRtjbgGfxTha5IaSkbnfr0Psv10gYKNx1KzCYANBQD06Q
         47z64ghoSvl/2yZDRt0VUIJD3YdsyAi1xze8W5WNuEnSl7lqIKzTa6KhR5zkidmmxd9V
         GR85krT4jJQugjlW7GhTumoo3x5AyiD6++TMTAbOxekk/JlT4h2xWMsKJgGC2LsPOUzz
         x9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716296399; x=1716901199;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YN/7AOVfwDQ9fuglKdggECs2cWRXnj0qk72xVYmNKJg=;
        b=WCitJjt5DW1EgDoW4HvH1lEP7XSybDSlMXq/Hkn6OWD9rBj7LCaWZcHX3xixPdjP60
         iOQhgTTqWTmuzCSItgY/df1RDJCw9+dbA/vkZB/7lVS43rAwiCoLVttX0bLTnMsVkZyO
         Aryiof9gv4M8TWyI2fahQ97lRmi1sZG14Th8QARSZ/iLwNef43neWQuMG2DC+O8muYLk
         OdRHpk9WscUcd43vIpg/5dBQo8IUOnoNwxKLFX/6q/IE2/L5HrnT01G3xLnujqhYYC+x
         A+G9csG1AcG0YsHIk9rfaJI9bi7Q3k3F5M4DqKz2vxDLSpkMF0Q4h/2hVldOv+bNYW+t
         R5Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVGvN1ml1vmNaKAmlULRe90k53IkqwBlw7HXDsBFHvtNWKllwDgZ9xDMJ//SaQgdbpi7bGH0PrVgOVLC6iQsLUoZt9PBekwfLTl
X-Gm-Message-State: AOJu0YxgJwO7KTtsTsxSYz6c2fMpAAUmpX9HnpkLEFBq7qTNDMVoVsag
	cjQ07pFgkmE5a+mZ/4eSLjs9CJ+DJwsjuhqpG0cP11Py9ZKLw7uJQOOrw+VpXuk=
X-Google-Smtp-Source: AGHT+IFjhxZDVLttBWKH935kkHgsg4zmcHt0zQ1giV2/zPz++FzpgzwbsrswxD91J1qdmWSrgzUpJw==
X-Received: by 2002:a17:906:4882:b0:a59:a727:1e81 with SMTP id a640c23a62f3a-a5a2d57a381mr3123533366b.20.1716296398569;
        Tue, 21 May 2024 05:59:58 -0700 (PDT)
Received: from localhost (host-87-18-209-253.retail.telecomitalia.it. [87.18.209.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7ebcsm1601785066b.117.2024.05.21.05.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 05:59:58 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Tue, 21 May 2024 15:00:08 +0200
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
Message-ID: <Zkya2KXoHSV9ORCk@apocalypse>
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
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f27aaf92-8109-4cad-94ba-6f72cd9bdabf@gmx.net>

On 14:26 Tue 21 May     , Stefan Wahren wrote:
> Hi Andrea,
> 
> Am 21.05.24 um 10:35 schrieb Andrea della Porta:
> > Broadcom BCM2712 SoC has an SDHCI card controller using the SDIO CFG
> > register block present on other STB chips. Add support for BCM2712
> > SD capabilities of this chipset.
> > The silicon is SD Express capable but this driver port does not currently
> > include that feature yet.
> > Based on downstream driver by raspberry foundation maintained kernel.
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >   drivers/mmc/host/sdhci-brcmstb.c | 65 ++++++++++++++++++++++++++++++++
> >   1 file changed, 65 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> > index 9053526fa212..b349262da36e 100644
> > --- a/drivers/mmc/host/sdhci-brcmstb.c
> > +++ b/drivers/mmc/host/sdhci-brcmstb.c
> > @@ -30,6 +30,21 @@
> > 
> >   #define SDHCI_ARASAN_CQE_BASE_ADDR		0x200
> > 
> > +#define SDIO_CFG_CQ_CAPABILITY			0x4c
> > +#define SDIO_CFG_CQ_CAPABILITY_FMUL		GENMASK(13, 12)
> > +
> > +#define SDIO_CFG_CTRL				0x0
> > +#define SDIO_CFG_CTRL_SDCD_N_TEST_EN		BIT(31)
> > +#define SDIO_CFG_CTRL_SDCD_N_TEST_LEV		BIT(30)
> > +
> > +#define SDIO_CFG_MAX_50MHZ_MODE			0x1ac
> > +#define SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE	BIT(31)
> > +#define SDIO_CFG_MAX_50MHZ_MODE_ENABLE		BIT(0)
> > +
> > +#define MMC_CAP_HSE_MASK	(MMC_CAP2_HSX00_1_2V | MMC_CAP2_HSX00_1_8V)
> > +/* Select all SD UHS type I SDR speed above 50MB/s */
> > +#define MMC_CAP_UHS_I_SDR_MASK	(MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104)
> > +
> >   struct sdhci_brcmstb_priv {
> >   	void __iomem *cfg_regs;
> >   	unsigned int flags;
> > @@ -38,6 +53,7 @@ struct sdhci_brcmstb_priv {
> >   };
> > 
> >   struct brcmstb_match_priv {
> > +	void (*cfginit)(struct sdhci_host *host);
> >   	void (*hs400es)(struct mmc_host *mmc, struct mmc_ios *ios);
> >   	struct sdhci_ops *ops;
> >   	const unsigned int flags;
> > @@ -168,6 +184,38 @@ static void sdhci_brcmstb_set_uhs_signaling(struct sdhci_host *host,
> >   	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> >   }
> > 
> > +static void sdhci_brcmstb_cfginit_2712(struct sdhci_host *host)
> > +{
> > +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +	struct sdhci_brcmstb_priv *brcmstb_priv = sdhci_pltfm_priv(pltfm_host);
> > +	u32 reg, base_clk_mhz;
> > +
> > +	/*
> > +	 * If we support a speed that requires tuning,
> > +	 * then select the delay line PHY as the clock source.
> > +	 */
> > +	if ((host->mmc->caps & MMC_CAP_UHS_I_SDR_MASK) || (host->mmc->caps2 & MMC_CAP_HSE_MASK)) {
> > +		reg = readl(brcmstb_priv->cfg_regs + SDIO_CFG_MAX_50MHZ_MODE);
> > +		reg &= ~SDIO_CFG_MAX_50MHZ_MODE_ENABLE;
> > +		reg |= SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE;
> > +		writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_MAX_50MHZ_MODE);
> > +	}
> > +
> > +	if ((host->mmc->caps & MMC_CAP_NONREMOVABLE) ||
> > +	    (host->mmc->caps & MMC_CAP_NEEDS_POLL)) {
> > +		/* Force presence */
> > +		reg = readl(brcmstb_priv->cfg_regs + SDIO_CFG_CTRL);
> > +		reg &= ~SDIO_CFG_CTRL_SDCD_N_TEST_LEV;
> > +		reg |= SDIO_CFG_CTRL_SDCD_N_TEST_EN;
> > +		writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_CTRL);
> > +	}
> > +
> > +	/* Guesstimate the timer frequency (controller base clock) */
> > +	base_clk_mhz = max_t(u32, clk_get_rate(pltfm_host->clk) / (1000 * 1000), 1);
> > +	reg = SDIO_CFG_CQ_CAPABILITY_FMUL | base_clk_mhz;
> > +	writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_CQ_CAPABILITY);
> This part assumes the clock isn't changed afterwards, see below ...
> > +}
> > +
> >   static void sdhci_brcmstb_dumpregs(struct mmc_host *mmc)
> >   {
> >   	sdhci_dumpregs(mmc_priv(mmc));
> > @@ -200,6 +248,14 @@ static struct sdhci_ops sdhci_brcmstb_ops = {
> >   	.set_uhs_signaling = sdhci_set_uhs_signaling,
> >   };
> > 
> > +static struct sdhci_ops sdhci_brcmstb_ops_2712 = {
> > +	.set_clock = sdhci_set_clock,
> > +	.set_power = sdhci_set_power_and_bus_voltage,
> > +	.set_bus_width = sdhci_set_bus_width,
> > +	.reset = sdhci_reset,
> > +	.set_uhs_signaling = sdhci_set_uhs_signaling,
> > +};
> > +
> >   static struct sdhci_ops sdhci_brcmstb_ops_7216 = {
> >   	.set_clock = sdhci_brcmstb_set_clock,
> >   	.set_bus_width = sdhci_set_bus_width,
> > @@ -214,6 +270,11 @@ static struct sdhci_ops sdhci_brcmstb_ops_74165b0 = {
> >   	.set_uhs_signaling = sdhci_brcmstb_set_uhs_signaling,
> >   };
> > 
> > +static const struct brcmstb_match_priv match_priv_2712 = {
> > +	.cfginit = sdhci_brcmstb_cfginit_2712,
> > +	.ops = &sdhci_brcmstb_ops_2712,
> > +};
> > +
> >   static struct brcmstb_match_priv match_priv_7425 = {
> >   	.flags = BRCMSTB_MATCH_FLAGS_NO_64BIT |
> >   	BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
> > @@ -238,6 +299,7 @@ static struct brcmstb_match_priv match_priv_74165b0 = {
> >   };
> > 
> >   static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] = {
> > +	{ .compatible = "brcm,bcm2712-sdhci", .data = &match_priv_2712 },
> >   	{ .compatible = "brcm,bcm7425-sdhci", .data = &match_priv_7425 },
> >   	{ .compatible = "brcm,bcm7445-sdhci", .data = &match_priv_7445 },
> >   	{ .compatible = "brcm,bcm7216-sdhci", .data = &match_priv_7216 },
> > @@ -370,6 +432,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
> >   	    (host->mmc->caps2 & MMC_CAP2_HS400_ES))
> >   		host->mmc_host_ops.hs400_enhanced_strobe = match_priv->hs400es;
> > 
> > +	if (match_priv->cfginit)
> > +		match_priv->cfginit(host);
> > +
> I'm not sure this is the right place to call cfginit.
> sdhci_brcmstb_cfginit_2712 retrives the current controller base clock,
> but at the end of  sdhci_brcmstb_probe this clock frequency could be
> adjusted by the device property "clock-frequency". So i'm not sure this
> is intended.

Some tests reveal that cfginit() must be called for certain type of UHS SD cards, 
otherwise those cards do not work at all. This of course does not mean that the
calling sequence is correctly ordererd and it may just work out of luck.
I'm investigating...

Many thanks,
Andrea

> >   	/*
> >   	 * Supply the existing CAPS, but clear the UHS modes. This
> >   	 * will allow these modes to be specified by device tree
> 
