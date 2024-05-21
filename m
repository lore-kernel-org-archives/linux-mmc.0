Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA5E6CDC0;
	Tue, 21 May 2024 12:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716294392; cv=none; b=udrK7wlecU2KUGlyHUEbCF3jfE9Tc3sVsqfzPNRXWmESSr/aage/7P1WqWBpHN17wFbAWGklS4MrgceldtRbQkVWX6JL3kgnz9k1m8lktLVZd5EKXP0dB+a3bpM97lTFO9PKpvUhPWO3wTVFYNQ9UFBGGStz1umbC5J/jAaDscY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716294392; c=relaxed/simple;
	bh=nubv3Ssyz42cMLMtiiGjL2NthUA/jwxK15fytFgof9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TMds3KUWUUFauRdZYAFUthjHCDE0QcSwJK4OnRXhrUCywhfTOdsgHyWoTRx56yxeap2A3kCOXBJ/k2tj70LSmNAJdNAY2Ankdej2XKolyshIHzi0UpGUOb6oJ1dYR7esncjpuGQGjTaHeVXc60/7WimUws2OEr8PNpFVORH43ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=BCQTuMzs; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="BCQTuMzs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1716294373; x=1716899173; i=wahrenst@gmx.net;
	bh=Ik/83sXmHwQbQMcvXH6krjU366NMUVdg+a6AS/Ux1h8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BCQTuMzsrkI7oT5ZA79xX/UCMnWI027/ijWHJjr1BS9//ZpkVfcHnHpN6Sc/QQ9f
	 q/rbTXdTCNbxZLEZyy0x8zFeV6eDXjxfWBbVWE20ON/LxcPwJTJ2AMHneoiYA3j4y
	 2lz+i3VMgb5fhxucSU3tI/6qD7jEXKKtV0B3qv1ldEwytoQTaFkrRrsL9wmWA3S5X
	 LGX2LeTO2aAzKuV7Zi40olCFnvaa7WrIyYtmGf/JeqA4ktn9DwdkHk8McmGS5qKfx
	 OH3w8lsNZfB/6olfJZtqHqPdcSPRHvSC4OkQ9WmcYv7zNNF6UNZiElf7d59TIvWUj
	 FDmwCffO4V3w5fsl7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.126] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvbG2-1sQNQA3fXy-00sglH; Tue, 21
 May 2024 14:26:12 +0200
Message-ID: <f27aaf92-8109-4cad-94ba-6f72cd9bdabf@gmx.net>
Date: Tue, 21 May 2024 14:26:11 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] mmc: sdhci-brcmstb: Add BCM2712 support
To: Andrea della Porta <andrea.porta@suse.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Marc Zyngier <maz@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <cover.1716277695.git.andrea.porta@suse.com>
 <c413737f538d9bd403c30104a83a7fbb1ea7461d.1716277695.git.andrea.porta@suse.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <c413737f538d9bd403c30104a83a7fbb1ea7461d.1716277695.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iQHoBjHwHK9vT/wN4cVqFD2QZSORuPKXX0FuHBqu25pr76llXa2
 O8GOEnO5F0MH53MC080AU0MtN3A1h71ZIdAuShRnPN66c+tH1TraE1Hs2sn+mUSV904vOhS
 syfUdSHNofm6S94aBYlBAkZ06mbdvr0OoVNj+cTityV/NES2QLuHMmGzR+QwkYE/EpjtXdl
 Td+WA+CHWHFoemtm/RYcg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BZeqmSh2A/o=;W3zIYW4pDntFO7HErWtXhF1nrvS
 4bv94zh6mzR6kOCKPmkzi9izaDlx8hu10JbrihVS/n/WEgOyx0R/7qVE5K5n1gyz7Sti5kv4u
 y5KlfxXbS5tcYqV+jcpcipfzM8xJN5LevHvLncJRIO+OgDR71AxPI8PxWN8s0QBlBLTJ5mvd7
 16O/Boh4bo64r3SenodBInuSbLCeyvljmAsPah7Zxr1vlL2kjzXHl+iwBewaNbEZZlQ0xZdWy
 TxOlVTcI/g6P4MZzZWmhPxbn6SxNLlx8X9JgeHKPbprAo8yEZ1GgfWHsVgrWx2AEAHY/kaPdZ
 qKgrokbwzGhRe76kEp4n3O4qR3NRKSwyktbFb90B0fqCfb3Vt1BiBhwhuo3by3heVH9uUkbm3
 aSmDTWX6i1E4yCoecWF5YjtyuOk2dzOB8aJ4EZeeJd6Zc18aNJXXXL6OzTY+YJtWbErHfMQts
 zLAWDkIN9Iaor91aH+0a80kg+2IMMaN/nplv/0t29aiETrQbqOp+7KbAX4XxODyNGeln9n+sD
 LLfHSTW7zFar72tid8czoPD2WYChUp4RG3QG70VZq8SpWA5+Cq4KURWZQ/KwsZqW94OcYtWmQ
 A80qKr1uQ8wzbws0/Z/dZAYt4DKYuwOEWJn1J5y4GcttHHJIIut6smvuY1zvidyz3YDb/nCeU
 3k1/5yu/KaDEg4f3j1aLf4YFAM3TD6q78uvI5/IAnoFkr91UE6s77ssdAeIxfJY9Q7mFAERJ/
 Hw5v2JxHnfa+88TKWmiWRZP14Z3pBKPa++LL7qHBMaqjGHy8t3dGsHq6Vxl0P+2y5p1QvOxqZ
 0RG5PhAzYu6HjDLSKUykDT0MwA92VqxcP7bc2FrDzYnyY=

Hi Andrea,

Am 21.05.24 um 10:35 schrieb Andrea della Porta:
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
>   drivers/mmc/host/sdhci-brcmstb.c | 65 ++++++++++++++++++++++++++++++++
>   1 file changed, 65 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-b=
rcmstb.c
> index 9053526fa212..b349262da36e 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -30,6 +30,21 @@
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
> +#define MMC_CAP_HSE_MASK	(MMC_CAP2_HSX00_1_2V | MMC_CAP2_HSX00_1_8V)
> +/* Select all SD UHS type I SDR speed above 50MB/s */
> +#define MMC_CAP_UHS_I_SDR_MASK	(MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104)
> +
>   struct sdhci_brcmstb_priv {
>   	void __iomem *cfg_regs;
>   	unsigned int flags;
> @@ -38,6 +53,7 @@ struct sdhci_brcmstb_priv {
>   };
>
>   struct brcmstb_match_priv {
> +	void (*cfginit)(struct sdhci_host *host);
>   	void (*hs400es)(struct mmc_host *mmc, struct mmc_ios *ios);
>   	struct sdhci_ops *ops;
>   	const unsigned int flags;
> @@ -168,6 +184,38 @@ static void sdhci_brcmstb_set_uhs_signaling(struct =
sdhci_host *host,
>   	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>   }
>
> +static void sdhci_brcmstb_cfginit_2712(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +	struct sdhci_brcmstb_priv *brcmstb_priv =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +	u32 reg, base_clk_mhz;
> +
> +	/*
> +	 * If we support a speed that requires tuning,
> +	 * then select the delay line PHY as the clock source.
> +	 */
> +	if ((host->mmc->caps & MMC_CAP_UHS_I_SDR_MASK) || (host->mmc->caps2 & =
MMC_CAP_HSE_MASK)) {
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
This part assumes the clock isn't changed afterwards, see below ...
> +}
> +
>   static void sdhci_brcmstb_dumpregs(struct mmc_host *mmc)
>   {
>   	sdhci_dumpregs(mmc_priv(mmc));
> @@ -200,6 +248,14 @@ static struct sdhci_ops sdhci_brcmstb_ops =3D {
>   	.set_uhs_signaling =3D sdhci_set_uhs_signaling,
>   };
>
> +static struct sdhci_ops sdhci_brcmstb_ops_2712 =3D {
> +	.set_clock =3D sdhci_set_clock,
> +	.set_power =3D sdhci_set_power_and_bus_voltage,
> +	.set_bus_width =3D sdhci_set_bus_width,
> +	.reset =3D sdhci_reset,
> +	.set_uhs_signaling =3D sdhci_set_uhs_signaling,
> +};
> +
>   static struct sdhci_ops sdhci_brcmstb_ops_7216 =3D {
>   	.set_clock =3D sdhci_brcmstb_set_clock,
>   	.set_bus_width =3D sdhci_set_bus_width,
> @@ -214,6 +270,11 @@ static struct sdhci_ops sdhci_brcmstb_ops_74165b0 =
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
> @@ -238,6 +299,7 @@ static struct brcmstb_match_priv match_priv_74165b0 =
=3D {
>   };
>
>   static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] =
=3D {
> +	{ .compatible =3D "brcm,bcm2712-sdhci", .data =3D &match_priv_2712 },
>   	{ .compatible =3D "brcm,bcm7425-sdhci", .data =3D &match_priv_7425 },
>   	{ .compatible =3D "brcm,bcm7445-sdhci", .data =3D &match_priv_7445 },
>   	{ .compatible =3D "brcm,bcm7216-sdhci", .data =3D &match_priv_7216 },
> @@ -370,6 +432,9 @@ static int sdhci_brcmstb_probe(struct platform_devic=
e *pdev)
>   	    (host->mmc->caps2 & MMC_CAP2_HS400_ES))
>   		host->mmc_host_ops.hs400_enhanced_strobe =3D match_priv->hs400es;
>
> +	if (match_priv->cfginit)
> +		match_priv->cfginit(host);
> +
I'm not sure this is the right place to call cfginit.
sdhci_brcmstb_cfginit_2712 retrives the current controller base clock,
but at the end of=C2=A0 sdhci_brcmstb_probe this clock frequency could be
adjusted by the device property "clock-frequency". So i'm not sure this
is intended.
>   	/*
>   	 * Supply the existing CAPS, but clear the UHS modes. This
>   	 * will allow these modes to be specified by device tree

