Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCF444C50A;
	Mon, 24 Aug 2026 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586278; cv=none; b=As4vUVVuCIq2pEzZRbfxzVacgC9UmtBQmgJikFoVYx2fy4TDk6LdqnrOL/VhQgk/kDJbzDjHrqnRxnsz6Zvp5AAQ+Gi8Qr9Y8UGyWlPkr7/zhGAnYwyenapCsBwQy8ejgj4HnCWXw06Zkh+DpcgUzfJYcY/a0A+sNzGmcqx1+4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586278; c=relaxed/simple;
	bh=9iHx6FAw7+VntXPaX72ZXc+yZ4757eFeoDhaDU1odnU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ABZJVj19cY9lVy7ICKQMBPd5+OVJ3Bd8Gqo/vpvYfypLyjVLUc7FzL4+fTOgOGjlG2WFszvtrITfjPrbOFlkdUv6GtAQJIocAdpGvVVEILPIwoG8fRt1O+C1fIzc6mm+UfSsjfTsrE0HvWuCM2Lp+q6Mpul4aTxaV2yznGBxbng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EB63A200F4F;
	Mon, 24 Aug 2026 17:44:27 +0200 (CEST)
Message-ID: <246663148696324c7e625a9227faf275ee0730a7.camel@pengutronix.de>
Subject: Re: [PATCH v5 8/8] mmc: sdhci-cadence: add Altera Agilex5 SD6HC
 support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, linux-mmc@vger.kernel.org
Cc: ulfh@kernel.org, adrian.hunter@intel.com, krzk+dt@kernel.org,
 robh@kernel.org, 	conor+dt@kernel.org, dinguyen@kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 24 Aug 2026 17:44:27 +0200
In-Reply-To: <20260820185721.22823-9-tanmay.kathpalia@altera.com>
References: <20260820185721.22823-1-tanmay.kathpalia@altera.com>
	 <20260820185721.22823-9-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Do, 2026-08-20 at 11:57 -0700, Tanmay Kathpalia wrote:
> The Altera Agilex5 SoC integrates a Cadence SD6HC controller that needs
> platform-specific configuration to operate correctly.
>=20
> The SoC requires three named resets: "sdhc-reset", "combophy", and
> "sdmmc-ocp". All three are exclusive and must be asserted together before
> being released, so the SDHCI, SoftPHY, and OCP/AXI clock domains cross th=
e
> reset boundary simultaneously. SoftPHY is shared with NAND at the SoC
> level, but only one of SDMMC or NAND is enabled on a given board.
>=20
> The IOMMU maps DMA addresses within a 40-bit physical address space, so
> the DMA mask is capped at 40 bits to prevent allocation beyond the
> controller's reach.
>=20
> The silicon requires the MULTIBLOCK_READ_ACMD12, CAP_CLOCK_BASE_BROKEN,
> PRESET_VALUE_BROKEN, and ACMD23_BROKEN quirks. Since
> CAP_CLOCK_BASE_BROKEN prevents reading the base clock from the
> capabilities register, the maximum clock is supplied from the platform
> clock instead.
>=20
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci-cadence-core.c | 85 +++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sdhci-cadence-core.c b/drivers/mmc/host/sdh=
ci-cadence-core.c
> index 18a5329f27db..e215f6a4c344 100644
> --- a/drivers/mmc/host/sdhci-cadence-core.c
> +++ b/drivers/mmc/host/sdhci-cadence-core.c
> @@ -7,6 +7,7 @@
> =20
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/mmc/host.h>
> @@ -90,6 +91,7 @@ struct sdhci_cdns4_phy_cfg {
>  struct sdhci_cdns_drv_data {
>  	int (*init)(struct platform_device *pdev);
>  	const struct sdhci_pltfm_data pltfm_data;
> +	u64 dma_mask;
>  };
> =20
>  static const struct sdhci_cdns4_phy_cfg sdhci_cdns4_phy_cfgs[] =3D {
> @@ -196,6 +198,23 @@ static unsigned int sdhci_cdns_get_timeout_clock(str=
uct sdhci_host *host)
>  	return host->max_clk;
>  }
> =20
> +static int sdhci_cdns_set_dma_mask(struct sdhci_host *host)
> +{
> +	const struct sdhci_cdns_drv_data *data;
> +	struct device *dev =3D mmc_dev(host->mmc);
> +	int ret;
> +
> +	data =3D of_device_get_match_data(dev);
> +	if (!data || !data->dma_mask)
> +		return 0;
> +
> +	ret =3D dma_set_mask_and_coherent(dev, data->dma_mask);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to set DMA mask\n");
> +
> +	return 0;
> +}
> +
>  static void sdhci_cdns_set_emmc_mode(struct sdhci_cdns_priv *priv, u32 m=
ode)
>  {
>  	u32 tmp;
> @@ -462,6 +481,44 @@ static int elba_drv_init(struct platform_device *pde=
v)
>  	return 0;
>  }
> =20
> +static int sdhci_cdns6_agilex5_init(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct reset_control_bulk_data resets[] =3D {
> +		{ .id =3D "sdhc-reset" },
> +		{ .id =3D "combophy" },
> +		{ .id =3D "sdmmc-ocp" },
> +	};
> +	int ret;
> +
> +	/*
> +	 * Assert SDHCI, SoftPHY (combophy), and SDMMC OCP/AXI resets together
> +	 * so their active periods overlap before all domains are released.
> +	 * SoftPHY is shared with NAND, but only one of SDMMC
> +	 * or NAND is enabled on a given board.
> +	 */
> +	ret =3D reset_control_bulk_get_exclusive(dev, ARRAY_SIZE(resets), reset=
s);

Why not devm_reset_control_bulk_get_exclusive()?

> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get resets\n");
> +
> +	ret =3D reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "failed to assert resets\n");
> +		goto out_put;
> +	}
> +
> +	/* Hold resets asserted long enough for all clock domains to capture. *=
/
> +	usleep_range(10, 20);
> +
> +	ret =3D reset_control_bulk_deassert(ARRAY_SIZE(resets), resets);
> +	if (ret)
> +		dev_err_probe(dev, ret, "failed to deassert resets\n");
> +
> +out_put:
> +	reset_control_bulk_put(ARRAY_SIZE(resets), resets);

This happens to work as long as nothing else grabs the reset controls
afterwards, but it is technically incorrect. In the ret =3D=3D 0 case the
resets are expected to stay deasserted for the lifetime of the device,
so we shouldn't give up control here.

regards
Philipp
