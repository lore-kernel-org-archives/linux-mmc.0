Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D9335C6BF
	for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2026 03:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788406048; cv=none; b=fg5TlSlB+movpwtg4E4gr/wOn2qhoocKksw/utRwFm7ECPyvEBlAcyhhe2LxPdkg5BrKx9QOGnNk8TgtHXUqi2k7qksg91+5fWSElJNJFxe++eTwj8bZ1lsAIFO1c3DEtcSflc5CrO0bfwEtRy769+iOCg/4B4w3UsYxulIrm+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788406048; c=relaxed/simple;
	bh=XvWZ03+GsN6hbJUdXOuLVgvI5fJ6nBROZidaRvP+/Uw=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:Mime-Version:
	 References:In-Reply-To; b=O6ofBYFI0608cKw4qM5c+XXenfCbtOAVCd9yMZN8E3dDWtqQ0vRCeGfr9ed680BSkyQQmLAVxd5Ety0Do7j4TYqK1QC5wlhiVm3S0JPPxnWe1xb/l7RuwfO8QVt7AGG7W9hRlwK0kWkCgf3EkB/QUX8Vq7LTUSbedw4+vK8NSYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=WyN8/eV2; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="WyN8/eV2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1788406039;
	bh=CU9yYjTzKY1VsHC9/0QdF7bv7zZl0qEhUjyz4zc3BfQ=;
	h=Date:Message-Id:Subject:From:To:Mime-Version;
	b=WyN8/eV2o7skOneHbj5eaxXVPwHt4viAiJXc0YrOTiDOroGkxyXR19s1iF8kdKsTK
	 T/WBRhZXeMns9+sRbTzTdPdgVOthFjBAW52vHt13VxG5e9MJuRIK+fbKgqvtiXxVGC
	 ydFSOArUnViplmp3KxQq7AZjNvJWlSOQ3AoK9Pac=
X-QQ-mid: zesmtpsz3t1788406037tf5a349cd
X-QQ-Originating-IP: 5N9PseJ/ksZBYF+OSvPGGOF2iNG6oUp2CyC6AZbzup8=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Sep 2026 11:27:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18144085702036501475
EX-QQ-RecipientCnt: 13
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 11:27:14 +0800
Message-Id: <DL5D12BKMIWN.QUCX18JF8GDU@linux.spacemit.com>
Subject: Re: [PATCH 4/4] mmc: sdhci-of-k1: Add TX tuning parameter
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Yixun Lan" <dlan@kernel.org>, "Ulf Hansson" <ulfh@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Adrian Hunter"
 <adrian.hunter@intel.com>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>
Cc: "Long Wan" <long.wan@linux.spacemit.com>, <linux-mmc@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260902-07-k3-sdhci-dts-v1-0-4e7909cf4233@kernel.org>
 <20260902-07-k3-sdhci-dts-v1-4-4e7909cf4233@kernel.org>
In-Reply-To: <20260902-07-k3-sdhci-dts-v1-4-4e7909cf4233@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OXn54RrYiVgP6lrq6tey4FqhYAN3epsiAukOomyIcJwJHLP/AqFMAlw5
	HfebT/TyH/Le9ccaHAAAekoQY9f1/Il5SYP4IL/P5DyF3Qs41/tocO+lYe+C5IGkBErf1Sn
	r4F+u8x8avu1CIGM8zswMTKy2IWkTOJ2c+6T1RxA5r37vIIQ3I57fTkHPuEXyZh9wssxKKi
	GKgaiTkg+452xhIo75XtZG6754aHvMUt0s5hxkP6O5qvnFYZBIrQkqU0pPLvbctsfurMF55
	4Pl2D/nEY0eZ+3AF0LI6bEOdPZV80hPSlzVIWJFreXWaM/V6xSejwBwlT/AaA8IM6GYuVRn
	vGPDDf2YhnOBHoDQ5GZCmx9ANKXc/XbsuFv88buyWD/Uz0fHYMMQoYiS32UV1ZV7hd+3sGN
	44PfODESWnstvgHqtPcjcXyWTlG4Q7/qWMQn9pWxVAfopyQ4Pm3VB/NP9E8jIdDxEUumOWU
	YyQW3gO8C+3pSLCu0QYZR2Udd0e/UeHn5vcKmN9L01wBGR+6aXRudBlO/0XVAhPYO0MQZwV
	xeKtfs8o8+9KXNezd1dD+hk/F/sc1mY3nfji7zmWoDRAZJe8Q/q6ScAeVDA2x/43yO8MmSP
	ugyfzHN3Js6J4SNMWtK55XJvZ9L/awRdVBqL16CqAgZciJxMaqhHc7jJLr6J7dG5kkPfrVW
	WjhveZvVvpEYJStDouj51eTh2RtyJhO1kxXvlidzlAjFAXNxZjLjZIXpDvF+beVpDFZm3aN
	HhImqL/eSl35Fc8ujQxHN+VBjZ1dGbajVGo8O3DjTm994AkQUP/zBEfR42chA++rFHgIzgg
	Fg2r7T7GHKVIE/C44GleOkIhM3jgQymqssCNdtyOoTXFZSnEo49Ju7uixzsAQk+SLjtDq8O
	Vqdnr7UgLk7iSUbnExduscjYCJDdxGnPk7DfGifFVFKE/XbLs95JTdXQDmMgPULJkyuwpNG
	X5YLMmqZpX6sIqgnb96ATBJmZKAIgNjOKMPZaylU0xRp7NN/y3bGnKpnnqeH5PPn2EOjZR2
	6waqMtT3f1ZNHSoSZtrF0tNzokEwJYMZ2MIafiFwNuEnpy+lUX6Hg+x6aK85hhTCfM/iwV1
	3wMKvUhhYpMQmGtXXIIKZ0GXhXiqJp3EzYIHJyCVxv78z7egekTcLALxf+tOFWwt4kxtdr7
	yiAmJPrienaMS0Rj0de3dK/dxg==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

On Wed Sep 2, 2026 at 3:03 PM +08, Yixun Lan wrote:
> From: Long Wan <long.wan@linux.spacemit.com>
>
> Instead of setting the TX delay code via hardcoded parameter, configuring
> it via device tree property, which make it able to adapt according to
> board specific tuning requirement.
>
> Signed-off-by: Long Wan <long.wan@linux.spacemit.com>
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
>  drivers/mmc/host/sdhci-of-k1.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k=
1.c
> index e6ab40c9a555..6cab06332747 100644
> --- a/drivers/mmc/host/sdhci-of-k1.c
> +++ b/drivers/mmc/host/sdhci-of-k1.c
> @@ -97,6 +97,7 @@ struct spacemit_sdhci_host {
>  	struct pinctrl *pinctrl;
>  	struct pinctrl_state *pinctrl_default;
>  	struct pinctrl_state *pinctrl_uhs;
> +	u8 tx_delaycode;
>  };
> =20
>  /* All helper functions will update clr/set while preserve rest bits */
> @@ -263,6 +264,7 @@ static int spacemit_sdhci_execute_tuning(struct sdhci=
_host *host, u32 opcode)
>  	int max_pass_len =3D 0, max_pass_start =3D 0;
>  	struct mmc_host *mmc =3D host->mmc;
>  	struct mmc_ios ios =3D mmc->ios;
> +	struct spacemit_sdhci_host *sdhst =3D sdhci_pltfm_priv(sdhci_priv(host)=
);
This is only a minor style suggestion, not a requirement. Would it be
clearer to make `sdhst` the first local declaration? That would make the
declaration block easier to scan.
>  	u8 final_delay;
>  	int ret =3D 0;
>  	int i;
> @@ -279,11 +281,11 @@ static int spacemit_sdhci_execute_tuning(struct sdh=
ci_host *host, u32 opcode)
> =20
>  	if (mmc->caps2 & MMC_CAP2_NO_MMC) {
>  		spacemit_sdhci_set_tx_dline_reg(host, SPACEMIT_TX_TUNING_DLINE_REG);
> -		spacemit_sdhci_set_tx_delay(host, SPACEMIT_TX_TUNING_DELAYCODE);
> +		spacemit_sdhci_set_tx_delay(host, sdhst->tx_delaycode);
>  		spacemit_sdhci_tx_tuning_prepare(host);
> =20
>  		dev_dbg(mmc_dev(host->mmc), "TX tuning: dline_reg=3D%d, delaycode=3D%d=
\n",
> -			SPACEMIT_TX_TUNING_DLINE_REG, SPACEMIT_TX_TUNING_DELAYCODE);
> +			SPACEMIT_TX_TUNING_DLINE_REG, sdhst->tx_delaycode);
>  	}
> =20
>  	spacemit_sdhci_prepare_tuning(host);
> @@ -496,6 +498,23 @@ static inline void spacemit_sdhci_get_pins(struct de=
vice *dev,
>  		sdhst->pinctrl_default, sdhst->pinctrl_uhs);
>  }
> =20
> +static void spacemit_sdhci_get_tuning_params(struct device *dev,
> +					     struct sdhci_pltfm_host *pltfm_host)
> +{
> +	struct spacemit_sdhci_host *sdhst =3D sdhci_pltfm_priv(pltfm_host);
> +	u32 val;
> +
> +	sdhst->tx_delaycode =3D SPACEMIT_TX_TUNING_DELAYCODE;
> +
> +	/* Override from DT property */
> +	if (!device_property_read_u32(dev, "spacemit,tx-delay", &val)) {
> +		if (val <=3D U8_MAX)
> +			sdhst->tx_delaycode =3D val;
> +		else
> +			dev_warn(dev, "ignoring invalid tx delay: %u\n", val);
Should this warning also report the default delay code that will be used
instead?

                                        - Troy
