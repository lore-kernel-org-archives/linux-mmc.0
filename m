Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330E13C09F4;
	Mon, 27 Jul 2026 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785136788; cv=none; b=X9Dt5VCrBqV90PRKPVMxdcsZq9+NxV3UjFY7uVcPTYJUX2EKCGVlYsa6Au4DrozBbTtySDkV9UqeUL0/egAZutLBxe/zBGDJB1XU2Z3L2Myaml6pCQcXuv2o18mdAuFoX/0sNXtS8k+T/WMnRRWVUVcUUKeGgAuWxt4yzpDkezY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785136788; c=relaxed/simple;
	bh=2jYssiDmKJebD0apzeuRPI6i36t6AiL/lJfzDfdsX8A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GQF2zc+uORc85NgkDMgrJpI7XfU6Odqhwqxo51sdNmO+BGd6TVVDdhGjP8dOuD5miGSW4P8rMMNXoNEq9IPvmo92ubi+jOBIurDzJIWfQEk1Y/pPVq2G8QztdsE+8gjsO3OhtGO9cIpaltTk6BHx/MPrV5YbIcrp8K+lNan0Pdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E61E0202054;
	Mon, 27 Jul 2026 09:19:42 +0200 (CEST)
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1woFck-001VGv-2h;
	Mon, 27 Jul 2026 09:19:42 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1woFck-000000006TH-3EDo;
	Mon, 27 Jul 2026 09:19:42 +0200
Message-ID: <ff8b32095ad014ae1dff98443d3ac72aa4f274bc.camel@pengutronix.de>
Subject: Re: [PATCH v3 8/8] mmc: sdhci-cadence: add Altera Agilex5 SD6HC
 support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, linux-mmc@vger.kernel.org
Cc: ulfh@kernel.org, adrian.hunter@intel.com, krzk+dt@kernel.org,
 robh@kernel.org, 	conor+dt@kernel.org, dinguyen@kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 27 Jul 2026 09:19:42 +0200
In-Reply-To: <20260724145009.7456-8-tanmay.kathpalia@altera.com>
References: <20260724145009.7456-1-tanmay.kathpalia@altera.com>
	 <20260724145009.7456-8-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fr, 2026-07-24 at 07:50 -0700, Tanmay Kathpalia wrote:
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
> ---
>  drivers/mmc/host/sdhci-cadence-core.c | 113 ++++++++++++++++++++++++++
>  1 file changed, 113 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sdhci-cadence-core.c b/drivers/mmc/host/sdh=
ci-cadence-core.c
> index 18846acc0b11..24130655a385 100644
> --- a/drivers/mmc/host/sdhci-cadence-core.c
> +++ b/drivers/mmc/host/sdhci-cadence-core.c
[...]
> @@ -462,6 +481,72 @@ static int elba_drv_init(struct platform_device *pde=
v)
>  	return 0;
>  }
> =20
> +static int sdhci_cdns6_agilex5_init(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct reset_control *rst_sdhc;
> +	struct reset_control *rst_combophy;
> +	struct reset_control *rst_ocp;
> +	int ret;
> +
> +	/*
> +	 * Assert SDHCI, SoftPHY (combophy), and SDMMC OCP/AXI resets together
> +	 * so their active periods overlap before all domains are released.
> +	 * SoftPHY is shared with NAND, but only one of SDMMC
> +	 * or NAND is enabled on a given board.
> +	 */
> +	rst_sdhc =3D devm_reset_control_get_exclusive(dev, "sdhc-reset");
> +	if (IS_ERR(rst_sdhc))
> +		return dev_err_probe(dev, PTR_ERR(rst_sdhc), "failed to get sdhc-reset=
\n");
> +
> +	rst_combophy =3D devm_reset_control_get_exclusive(dev, "combophy");
> +	if (IS_ERR(rst_combophy))
> +		return dev_err_probe(dev, PTR_ERR(rst_combophy), "failed to get combop=
hy reset\n");
> +
> +	rst_ocp =3D devm_reset_control_get_exclusive(dev, "sdmmc-ocp");
> +	if (IS_ERR(rst_ocp))
> +		return dev_err_probe(dev, PTR_ERR(rst_ocp), "failed to get sdmmc-ocp r=
eset\n");

This looks like it could be simplified with
devm_reset_control_bulk_get_exclusive().

regards
Philipp
