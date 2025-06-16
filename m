Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBBB2BEC28
	for <linux-mmc@vger.kernel.org>; Mon, 16 Jun 2025 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080171; cv=none; b=qByQ1d4iVRjok95jGczg3KbtYoSspNhiPnZhaSzhsIL4pud4K0oOOhjKCmdV03Ipfw1DO3X+ZsJL1stRWUEsQK2lwiP1XHivrv2YMOgFS6pCneXVNCzVL8FO+zkMKzH9ciw46tV5wufVYfLPDYxx1R4dVTEx3hcRY+4awewYURY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080171; c=relaxed/simple;
	bh=SfDNrgkiyxr1e5rAONZhMJ5nG8Q58jojguyKXEUxd+I=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mVuiu9Z8PjxgUhM9ZhHu2TaBjUSoj0VifzEP/sO3haBeBWr9aYG45HCgdScpIw3JrGQH5S9YeeNY88yZiN93zlRbaZm/bK09uQTrl+lLU9fm7ap5ERJJnszFHiufdLWK4p+FvtqJo27p1eAseZrhuHmMRJ7RT+wPc4ZaJeRsP80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uR9n5-0003xV-Cd; Mon, 16 Jun 2025 15:22:23 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uR9n4-003oWd-0b;
	Mon, 16 Jun 2025 15:22:22 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uR9n4-000VBo-0L;
	Mon, 16 Jun 2025 15:22:22 +0200
Message-ID: <6aeab5e5b616b1e690c2622d6599c5228a391e69.camel@pengutronix.de>
Subject: Re: [PATCH 1/8] mmc: sdhci-of-aspeed: Fix sdhci software reset
 can't be cleared issue.
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Cool Lee <cool_lee@aspeedtech.com>, andrew@codeconstruct.com.au, 
	adrian.hunter@intel.com, ulf.hansson@linaro.org, joel@jms.id.au, 
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 16 Jun 2025 15:22:21 +0200
In-Reply-To: <20250615035803.3752235-2-cool_lee@aspeedtech.com>
References: <20250615035803.3752235-1-cool_lee@aspeedtech.com>
	 <20250615035803.3752235-2-cool_lee@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org

On So, 2025-06-15 at 11:57 +0800, Cool Lee wrote:
> Replace sdhci software reset by scu reset from top.
>=20
> Signed-off-by: Cool Lee <cool_lee@aspeedtech.com>
> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 55 +++++++++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-=
of-aspeed.c
> index d6de010551b9..01bc574272eb 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -13,6 +13,7 @@
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>
>  #include <linux/spinlock.h>
> =20
>  #include "sdhci-pltfm.h"
> @@ -39,6 +40,7 @@
>  struct aspeed_sdc {
>  	struct clk *clk;
>  	struct resource *res;
> +	struct reset_control *rst;
> =20
>  	spinlock_t lock;
>  	void __iomem *regs;
> @@ -328,13 +330,58 @@ static u32 aspeed_sdhci_readl(struct sdhci_host *ho=
st, int reg)
>  	return val;
>  }
> =20
> +static void aspeed_sdhci_reset(struct sdhci_host *host, u8 mask)
> +{
> +	struct sdhci_pltfm_host *pltfm_priv;
> +	struct aspeed_sdhci *aspeed_sdhci;
> +	struct aspeed_sdc *aspeed_sdc;
> +	u32 save_array[7];
> +	u32 reg_array[] =3D {SDHCI_DMA_ADDRESS,
> +			SDHCI_BLOCK_SIZE,
> +			SDHCI_ARGUMENT,
> +			SDHCI_HOST_CONTROL,
> +			SDHCI_CLOCK_CONTROL,
> +			SDHCI_INT_ENABLE,
> +			SDHCI_SIGNAL_ENABLE};
> +	int i;
> +	u16 tran_mode;
> +	u32 mmc8_mode;
> +
> +	pltfm_priv =3D sdhci_priv(host);
> +	aspeed_sdhci =3D sdhci_pltfm_priv(pltfm_priv);
> +	aspeed_sdc =3D aspeed_sdhci->parent;
> +
> +	if (!IS_ERR(aspeed_sdc->rst)) {
> +		for (i =3D 0; i < ARRAY_SIZE(reg_array); i++)
> +			save_array[i] =3D sdhci_readl(host, reg_array[i]);
> +
> +		tran_mode =3D sdhci_readw(host, SDHCI_TRANSFER_MODE);
> +		mmc8_mode =3D readl(aspeed_sdc->regs);
> +
> +		reset_control_assert(aspeed_sdc->rst);
> +		mdelay(1);
> +		reset_control_deassert(aspeed_sdc->rst);
> +		mdelay(1);

Why are there delays here ...

[...]
> @@ -535,6 +582,12 @@ static int aspeed_sdc_probe(struct platform_device *=
pdev)
> =20
>  	spin_lock_init(&sdc->lock);
> =20
> +	sdc->rst =3D devm_reset_control_get(&pdev->dev, NULL);
> +	if (!IS_ERR(sdc->rst)) {
> +		reset_control_assert(sdc->rst);
> +		reset_control_deassert(sdc->rst);

... but not here?

regards
Philipp
