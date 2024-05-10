Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB356175A6;
	Fri, 10 May 2024 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715368958; cv=none; b=DMGui8NkLloBKCXHw8ANsAi1HYSTAF/S+Swy4ru1fXndJdxggWHMkWOjlhfiA1f7yi5Ru5qJFn2UguTpx/n21c2E5JgwyUx9je45djr8izqH+rJjqSpYUG2NuwREiwMBrGP0N8Q5msLodDu0HNttvGQZaDI0OZNQSe/+t27gyfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715368958; c=relaxed/simple;
	bh=hHfw6+FfM+FJoWttq3IAd3qjpuSvtWZD+WQGzlFtigM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fy5Mkwity2xnT6WiKUjostX28bavy2VMfJF29X7e4C4P/ius7k6R28XtgdW/MMQOxsChWm6lAFaGtiMyaDPU2S16R5QPN6ZlrUBHmeDXnfpaC0MThhl+KS9UkaTW1BIFIl4pMzkDDK/SXTxhfE/TAyg/7ddz70Q3L6swki2y44E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=VWX1yrLc; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="VWX1yrLc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1715368940; x=1715973740; i=wahrenst@gmx.net;
	bh=uK9i6zNaKZRdzVKamUHfDYAKNplYdgfITOHWaldjtqs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VWX1yrLcOhoQQPA4UVAAwr+V7ILT5R0QeNZ7Yn9rSL7I211Z6BUSwEIMXm+Teur5
	 7aUwshBXlXw6C7RH0ytc6WcPobY6Cc3dyAYNS4w82edBmhfw8DTfHHmHttpmattn3
	 ++n2Xwvjh3uFSNkdSikP9H88z9SgDIUJrN24T60pOel9/4N703nj0jMb8j7mAe9Z1
	 ZLSmoUmGdDUJKQOxGM7T3+E6rEoZPCmmTKQ3yO0pQ7HcbvC7zmgOkfnZHpHHDUfah
	 DNVshR+36xiifmwUgqCf2KmXcvp/m5hSMzAU/3kNM146T6xn9VEDwcpsdDCM88aZE
	 zI0wXrLkGd6wAqJhEQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.126] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpDNl-1sO1zA3oCd-00nSgv; Fri, 10
 May 2024 21:22:20 +0200
Message-ID: <7bbc6ffa-6add-4b67-9bc9-533d79af942a@gmx.net>
Date: Fri, 10 May 2024 21:22:18 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] mmc: sdhci-brcmstb: Add BCM2712 support
To: Andrea della Porta <andrea.porta@suse.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 Eric Anholt <eric@anholt.net>, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <cover.1715332922.git.andrea.porta@suse.com>
 <c2f8d42a5bd8e1b6acc38d6c24eee4dcb9948bfd.1715332922.git.andrea.porta@suse.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <c2f8d42a5bd8e1b6acc38d6c24eee4dcb9948bfd.1715332922.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EDAqNoupMj8PZU93izjaJWsV3R8Yv9ZXWj41fjdniNz050HpUDI
 LHp8K55djB2WFBEmUtrALXMvRKqK4u9jNgFZgOOEmWn9Aq5fwZeY+Qvd4vvwNb1uqEWL+v/
 HN254NR1RNLpeJO0naZ+kabGIw7w+UzM/q21VNPy3CJMEA+4sUDWHAT2UgWgoP5mWMzIWdJ
 u5C0jSAmoL+rV4RnnP25g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AnkaS8D+Qks=;MV2XiHI26w/AQfIb8e7NXMVQ6O5
 5Nbl05q5cy76pPU0qBHunBSkkTasaWDGj6/pjJDxO3DeyV/3G4uS8Yqg8FzlkPzgIPOecx249
 kiMQd0PwaJJk7y4mmKv8XvGujKfKzQIX23KHxaxZwcF7FXKPgT+XgKCWwlOpCcMGY8c9pWMMK
 Azsi8JifQNV6RcOHwsxIS/BA9v4g6UEvQbCAfSlwU4d4RDgwYRq5OwQa2lCZiF3mvBulaZ0wt
 2yjItBLpPN3k18x3FqZE84woVASNXaYsKktvvjGsRaraumui6LthqoJH8ZkLOx4Qa9VgUib1m
 YU5qZ7PB1s5Dqwdz2JcX3boAk6wohgG2z/GkfPCJMP+NwiV/U4FES2tTGrXf+BeDwsRGYbV1V
 L9Xyt3uiwycxT2tRw6Z5rLCHw/PLVp3Uh1wpYaIgaRUMQlfT7RmnJRUXMXAcq/PZQA8mS+Bom
 UQOr1kYNlUbfOJ29HnduqpOgVogep7WwPW4nXw1xo8eezhIjOj3lh3N7Jn89JWlItLMiQDNYs
 aXRnh/XoiA01EI8N4RETdi0hl11aHmrWgoLKksJtu2/14ATj+yXjJS46+IzghxoA3EVHjtNWK
 /3k3Qe1cM7wtc4HoDLgBcY1VQZF/U2kVj6xv6W6YuakSSvHomHIFSOSxC9UrgEmhA07heN8FX
 bO7tAl0zcoOrrhE9XS/+h56pDkeE0fF0mUZ3YmNV6/mdm7Ftb3+8syOJTTvZhYC2v6fdugCof
 Zvv6waG0GGqYaGyzynPJVEP3pJyhq7UCthORxA2Mjf5DlwQaaCupzVIz5EU3g2KjUnVomJeNM
 KN7RZYHXgmJn5B8VjkbWHo/RZkkNITtSGnL+QEHz+LekY=

Hi Andrea,

Am 10.05.24 um 16:35 schrieb Andrea della Porta:
> Broadcom BCM2712 SoC has an SDHCI card controller using the SDIO CFG
> register block present on other STB chips. Add support for BCM2712
> SD capabilities of this chipset.
> The silicon is SD Express capable but this driver port does not currentl=
y
> include that feature yet.
> Based on downstream driver by raspberry foundation maintained kernel.
>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>   drivers/mmc/host/sdhci-brcmstb.c | 81 ++++++++++++++++++++++++++++++++
>   1 file changed, 81 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-b=
rcmstb.c
> index 9053526fa212..13a1017d53c5 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -30,6 +30,24 @@
>
>   #define SDHCI_ARASAN_CQE_BASE_ADDR		0x200
>
> +#define SDIO_CFG_CQ_CAPABILITY			0x4c
> +#define SDIO_CFG_CQ_CAPABILITY_FMUL		GENMASK(13, 12)
> +
> +#define SDIO_CFG_CTRL				0x0
> +#define SDIO_CFG_CTRL_SDCD_N_TEST_EN		BIT(31)
> +#define SDIO_CFG_CTRL_SDCD_N_TEST_LEV		BIT(30)
> +
> +#define SDIO_CFG_MAX_50MHZ_MODE			0x1ac
> +#define SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE	BIT(31)
> +#define SDIO_CFG_MAX_50MHZ_MODE_ENABLE		BIT(0)
> +
> +#define MMC_CAP_HSE_MASK	(MMC_CAP2_HS200_1_8V_SDR | \
> +				 MMC_CAP2_HS200_1_2V_SDR | \
> +				 MMC_CAP2_HS400_1_8V     | \
> +				 MMC_CAP2_HS400_1_2V)
This could be simplified either with MMC_CAP2_HSX00_1_2V |
MMC_CAP2_HSX00_1_8V or MMC_CAP2_HS200 | MMC_CAP2_HS400
> +
> +#define MMC_CAP_UHS_MASK	(MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104)
There is already a MMC_CAP_UHS define, but according to the code this is
not intended. It looks more like a mask of all UHS modes equal and above
50 MHz. The name or at least a comment should reflect this.
> +
>   struct sdhci_brcmstb_priv {
>   	void __iomem *cfg_regs;
>   	unsigned int flags;
> @@ -38,6 +56,7 @@ struct sdhci_brcmstb_priv {
>   };
>
>   struct brcmstb_match_priv {
> +	void (*cfginit)(struct sdhci_host *host);
>   	void (*hs400es)(struct mmc_host *mmc, struct mmc_ios *ios);
>   	struct sdhci_ops *ops;
>   	const unsigned int flags;
> @@ -139,6 +158,17 @@ static void sdhci_brcmstb_set_clock(struct sdhci_ho=
st *host, unsigned int clock)
>   	sdhci_enable_clk(host, clk);
>   }
>
> +static void sdhci_brcmstb_set_power(struct sdhci_host *host, unsigned c=
har mode,
> +				    unsigned short vdd)
> +{
> +	struct mmc_host *mmc =3D host->mmc;
> +
> +	if (!IS_ERR(mmc->supply.vmmc))
> +		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> +
> +	sdhci_set_power_noreg(host, mode, vdd);
> +}
> +
>   static void sdhci_brcmstb_set_uhs_signaling(struct sdhci_host *host,
>   					    unsigned int timing)
>   {
> @@ -168,6 +198,40 @@ static void sdhci_brcmstb_set_uhs_signaling(struct =
sdhci_host *host,
>   	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>   }
>
> +static void sdhci_brcmstb_cfginit_2712(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +	struct sdhci_brcmstb_priv *brcmstb_priv =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +	u32 hsemmc_mask =3D MMC_CAP_HSE_MASK;
> +	u32 uhs_mask =3D MMC_CAP_UHS_MASK;
> +	u32 reg, base_clk_mhz;
> +
> +	/*
> +	 * If we support a speed that requires tuning,
> +	 * then select the delay line PHY as the clock source.
> +	 */
> +	if ((host->mmc->caps & uhs_mask) || (host->mmc->caps2 & hsemmc_mask)) =
{
> +		reg =3D readl(brcmstb_priv->cfg_regs + SDIO_CFG_MAX_50MHZ_MODE);
> +		reg &=3D ~SDIO_CFG_MAX_50MHZ_MODE_ENABLE;
> +		reg |=3D SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE;
> +		writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_MAX_50MHZ_MODE);
> +	}
> +
> +	if ((host->mmc->caps & MMC_CAP_NONREMOVABLE) ||
> +	    (host->mmc->caps & MMC_CAP_NEEDS_POLL)) {
> +		/* Force presence */
> +		reg =3D readl(brcmstb_priv->cfg_regs + SDIO_CFG_CTRL);
> +		reg &=3D ~SDIO_CFG_CTRL_SDCD_N_TEST_LEV;
> +		reg |=3D SDIO_CFG_CTRL_SDCD_N_TEST_EN;
> +		writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_CTRL);
> +	}
> +
> +	/* Guesstimate the timer frequency (controller base clock) */
> +	base_clk_mhz =3D max_t(u32, clk_get_rate(pltfm_host->clk) / (1000 * 10=
00), 1);
> +	reg =3D SDIO_CFG_CQ_CAPABILITY_FMUL | base_clk_mhz;
> +	writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_CQ_CAPABILITY);
> +}
> +
>   static void sdhci_brcmstb_dumpregs(struct mmc_host *mmc)
>   {
>   	sdhci_dumpregs(mmc_priv(mmc));
> @@ -200,6 +264,14 @@ static struct sdhci_ops sdhci_brcmstb_ops =3D {
>   	.set_uhs_signaling =3D sdhci_set_uhs_signaling,
>   };
>
> +static struct sdhci_ops sdhci_brcmstb_ops_2712 =3D {
> +	.set_clock =3D sdhci_set_clock,
> +	.set_power =3D sdhci_brcmstb_set_power,
> +	.set_bus_width =3D sdhci_set_bus_width,
> +	.reset =3D sdhci_reset,
> +	.set_uhs_signaling =3D sdhci_set_uhs_signaling,
> +};
> +
>   static struct sdhci_ops sdhci_brcmstb_ops_7216 =3D {
>   	.set_clock =3D sdhci_brcmstb_set_clock,
>   	.set_bus_width =3D sdhci_set_bus_width,
> @@ -214,6 +286,11 @@ static struct sdhci_ops sdhci_brcmstb_ops_74165b0 =
=3D {
>   	.set_uhs_signaling =3D sdhci_brcmstb_set_uhs_signaling,
>   };
>
> +static const struct brcmstb_match_priv match_priv_2712 =3D {
> +	.cfginit =3D sdhci_brcmstb_cfginit_2712,
> +	.ops =3D &sdhci_brcmstb_ops_2712,
> +};
> +
>   static struct brcmstb_match_priv match_priv_7425 =3D {
>   	.flags =3D BRCMSTB_MATCH_FLAGS_NO_64BIT |
>   	BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
> @@ -238,6 +315,7 @@ static struct brcmstb_match_priv match_priv_74165b0 =
=3D {
>   };
>
>   static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] =
=3D {
> +	{ .compatible =3D "brcm,bcm2712-sdhci", .data =3D &match_priv_2712 },
>   	{ .compatible =3D "brcm,bcm7425-sdhci", .data =3D &match_priv_7425 },
>   	{ .compatible =3D "brcm,bcm7445-sdhci", .data =3D &match_priv_7445 },
>   	{ .compatible =3D "brcm,bcm7216-sdhci", .data =3D &match_priv_7216 },
> @@ -370,6 +448,9 @@ static int sdhci_brcmstb_probe(struct platform_devic=
e *pdev)
>   	    (host->mmc->caps2 & MMC_CAP2_HS400_ES))
>   		host->mmc_host_ops.hs400_enhanced_strobe =3D match_priv->hs400es;
>
> +	if (match_priv->cfginit)
> +		match_priv->cfginit(host);
> +
>   	/*
>   	 * Supply the existing CAPS, but clear the UHS modes. This
>   	 * will allow these modes to be specified by device tree

