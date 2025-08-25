Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE93393DCA;
	Mon, 25 Aug 2025 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756124970; cv=none; b=Wpy9qOOhcgZeVwo/USNEwgO05D0b4g2e/EYCuWmcF6Ihv4NW1Bwm3/auVZcrBeEHe/0Km7XZ8zCepntrHQe/qo9g04FYiOp3rKKY2/xSpchgRbmepK1PWgKG0biIhoCYQaYTlkf/EHbfxNv3+C2icY2oRYsR981EihO9nFNqo60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756124970; c=relaxed/simple;
	bh=L0PugiXG3iWIknMYi8/HfZoX3fUPVbPxTWmGSgaDXXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOXo+VhDqqrmKQhG7+koKFveOBRbcyhyGaDbTsCk0DCpfGEe8VOQeuY6CkoRuGePecSUSDWCl78fzxPaS9zmtnagzY6DfPG9GakyvzVocBLr3wEoXf5Ot+fLqu6exb88TuufigfFYwG1Lx0PYnMMBfZVagJaCax2Hz23rA8pLiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Id6NHlYp; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=FHUINlSc reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Id6NHlYp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="FHUINlSc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1756124967; x=1787660967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6IbcGbctO1BIwL0to8KSXSADohcNwcEDGrLnChoXUBI=;
  b=Id6NHlYpkqgE5bbyhQzR+/XK4b1sks1ac1BkDzbq61g10/aExBnHRQoi
   1qPXUEUd5AzAVGlxLxClNdM5OSwl1PGIYudXvySfalCn7Kg2fA7k9Wqkn
   7Rz+xJeQg9RBxSuydaewiQZSodZX2fhuhV2b/0O95fFmhxBKi7VcQrakX
   E55Tohf3pKYfBfoiBowsW6tE0za6g/ysV4lNbEab69Oj5aff31tlqIbUs
   l1SXtQuFwBG/nWGvdxCBDFxxr87p9GyiFyx3UXS/FRuzgxmCtZtTZKzV5
   FvXIIV09+9ZMN3o/v/gpj/U4RyjMBRa+/ZVr611bCFjjhobbo+1m1Yb0o
   A==;
X-CSE-ConnectionGUID: zDRh0Q3jTCGPpNoc1naGtQ==
X-CSE-MsgGUID: bJ1k7ePSS4CygFk6jKou2Q==
X-IronPort-AV: E=Sophos;i="6.18,213,1751234400"; 
   d="scan'208";a="45893510"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Aug 2025 14:29:14 +0200
X-CheckPoint: {68AC571A-19-410E8DD8-CEA8F0F8}
X-MAIL-CPID: 5A18CCD5C2493D1E832E91D9C647DB8B_3
X-Control-Analysis: str=0001.0A002123.68AC56B0.000A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 05515164954;
	Mon, 25 Aug 2025 14:29:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1756124950;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6IbcGbctO1BIwL0to8KSXSADohcNwcEDGrLnChoXUBI=;
	b=FHUINlScd2ZEBWx+VMif5qEft+lHrfy8Ps1m1tpMmgf4M729DFuVue6w+lslbRKaDXi6mZ
	QSEgVDjfbxfKM2HRLAyPWneE4NXwuwR5fz4UF69K6/CFwl4K1OrPRkT3YDwoZMjrl8xECc
	2laNAF14zNiLkytt6cBzPCQhWjYKk/HdJXJci8srgbZXfsHnctcxs/9fgnrzLFIaHRgjOK
	q4DRCb7uxc7QnqFzzt98BmAoHuoNE0e7ykeOzS1PGR89qw3GyUImJ4S7cJQdbujFUIO2n+
	LwCZ8IV3tVvCJmYKeFRFaQAUeHk5xxQmY0ifB1VmlQmUiRu4+B6KMowkFVfuSg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Matthias Schiffer <matthias.schiffer@tq-group.com>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 1/1] mmc: sdhci-omap: use regulator_get_optional() and reuse pbias
 in sdhci_omap_regulator_get_caps()
Date: Mon, 25 Aug 2025 14:29:08 +0200
Message-ID: <2240484.irdbgypaU6@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250825121534.2167270-1-alexander.stein@ew.tq-group.com>
References: <20250825121534.2167270-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Montag, 25. August 2025, 14:15:33 CEST schrieb Alexander Stein:
> From: Matthias Schiffer <matthias.schiffer@tq-group.com>
>=20
> We actually want to get an error return instead of a dummy regulator
> when a supply is not set. Change regulator_get() to
> regulator_get_optional() for the vqmmc supply and reuse omap_host->pbias,
> which is already initialized at this point.
>=20
> This change also avoids warning messages:
>=20
>     sdhci-omap 48060000.mmc: supply pbias not found, using dummy regulator
>     sdhci-omap 48060000.mmc: supply vqmmc not found, using dummy regulator
>=20
> Fixes: de5ccd2af71f ("mmc: sdhci-omap: Handle voltages to add support oma=
p4")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Sorry for the noise. This patch was missing a dependency. Fixed in v2.

Best regards
Alexander

> ---
>  drivers/mmc/host/sdhci-omap.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 08d5a82b7d01b..4623781adba7b 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -939,16 +939,10 @@ static const struct sdhci_ops sdhci_omap_ops =3D {
>  	.set_timeout =3D sdhci_omap_set_timeout,
>  };
> =20
> -static unsigned int sdhci_omap_regulator_get_caps(struct device *dev,
> -						  const char *name)
> +static unsigned int sdhci_omap_regulator_get_caps(struct regulator *reg)
>  {
> -	struct regulator *reg;
>  	unsigned int caps =3D 0;
> =20
> -	reg =3D regulator_get(dev, name);
> -	if (IS_ERR(reg))
> -		return ~0U;
> -
>  	if (regulator_is_supported_voltage(reg, 1700000, 1950000) > 0)
>  		caps |=3D SDHCI_CAN_VDD_180;
>  	if (regulator_is_supported_voltage(reg, 2700000, 3150000) > 0)
> @@ -956,8 +950,6 @@ static unsigned int sdhci_omap_regulator_get_caps(str=
uct device *dev,
>  	if (regulator_is_supported_voltage(reg, 3150000, 3600000) > 0)
>  		caps |=3D SDHCI_CAN_VDD_330;
> =20
> -	regulator_put(reg);
> -
>  	return caps;
>  }
> =20
> @@ -967,11 +959,20 @@ static int sdhci_omap_set_capabilities(struct sdhci=
_host *host)
>  	struct sdhci_omap_host *omap_host =3D sdhci_pltfm_priv(pltfm_host);
>  	struct device *dev =3D omap_host->dev;
>  	const u32 mask =3D SDHCI_CAN_VDD_180 | SDHCI_CAN_VDD_300 | SDHCI_CAN_VD=
D_330;
> -	unsigned int pbias, vqmmc, caps =3D 0;
> +	unsigned int pbias =3D ~0U, vqmmc =3D ~0U, caps =3D 0;
> +	struct	regulator *reg_vqmmc;
>  	u32 reg;
> =20
> -	pbias =3D sdhci_omap_regulator_get_caps(dev, "pbias");
> -	vqmmc =3D sdhci_omap_regulator_get_caps(dev, "vqmmc");
> +	if (!IS_ERR(omap_host->pbias))
> +		pbias =3D sdhci_omap_regulator_get_caps(omap_host->pbias);
> +
> +	/* mmc->supply.vqmmc is not initialized yet */
> +	reg_vqmmc =3D regulator_get_optional(dev, "vqmmc");
> +	if (!IS_ERR(reg_vqmmc)) {
> +		vqmmc =3D sdhci_omap_regulator_get_caps(reg_vqmmc);
> +		regulator_put(reg_vqmmc);
> +	}
> +
>  	caps =3D pbias & vqmmc;
> =20
>  	if (pbias !=3D ~0U && vqmmc =3D=3D ~0U)
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


