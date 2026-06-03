Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27873FE663
	for <linux-mmc@vger.kernel.org>; Wed,  3 Jun 2026 07:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472836; cv=none; b=s/nasalGWWykJgumSvb4yBwXzGDqkHmUbQmqpYgU1D2vK6omxhl9oNm5SPktJFT8bsQSde76DjWnVSullaVsKZAHAUlfdtKTkxNjClwmXrW90cpuEhzmmpfBzQqhf95Zd55GVWMKOh2fSp1mvGQn6+WPD+cuUCOihU/oSAy1u5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472836; c=relaxed/simple;
	bh=4Y3fXeafbeS3Zolb5NCU7KGx43PbNhwM3vPBz/W9Fl0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vxh4TNqOU3FFlM2WWqUs+xSXLt3C5zpZDDyJRtbw1SfbJ30ei6+a1Vu+9HSsOgDvmO0iXLGDpA9lBLmnuUr4iJeJB8xIi0q/3JoUMn8i+dibDxz74ZPxqg8/Z1t2p0kAijiI5xdQqzhnV3MFwzlV0hZ0W08xV+BPlK864pD8MnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wUgJh-00055Z-2x; Wed, 03 Jun 2026 09:47:09 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wUgJg-000sVR-2Z;
	Wed, 03 Jun 2026 09:47:08 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wUgJg-000000001v0-2z60;
	Wed, 03 Jun 2026 09:47:08 +0200
Message-ID: <75e754c3c9ffdc19b4bd953d54c4f65255d96829.camel@pengutronix.de>
Subject: Re: [PATCH v17 10/17] mmc: renesas_sdhi: Add optional axis/axim
 reset controls
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Biju <biju.das.au@gmail.com>, Wolfram Sang
	 <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulfh@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
Date: Wed, 03 Jun 2026 09:47:08 +0200
In-Reply-To: <20260603065731.93243-11-biju.das.jz@bp.renesas.com>
References: <20260603065731.93243-1-biju.das.jz@bp.renesas.com>
	 <20260603065731.93243-11-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

On Mi, 2026-06-03 at 07:57 +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> The RZ/G3L SoC has axis/axim resets compared to other SoCs.
>=20
> Add two optional reset controls, rstc_axis and rstc_axim, to the
> renesas_sdhi struct. Both are acquired at probe time using
> devm_reset_control_get_optional_exclusive_deasserted() with the
> "axis" and "axim" reset names respectively.
>=20
> Include them alongside the existing rstc in bulk reset/assert/deassert
> operations: triggered together in renesas_sdhi_reset(), and managed
> via reset_control_bulk_assert/deassert() in the suspend and resume
> paths, replacing the previous single-control calls.
>=20
> Being optional, these resets are a no-op on platforms that do not
> provide them, so existing behaviour is preserved.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * No change.
> ---
>  drivers/mmc/host/renesas_sdhi.h      |  2 ++
>  drivers/mmc/host/renesas_sdhi_core.c | 26 +++++++++++++++++++++++---
>  2 files changed, 25 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_s=
dhi.h
> index 0ca8ec27c320..6c024e7f69e1 100644
> --- a/drivers/mmc/host/renesas_sdhi.h
> +++ b/drivers/mmc/host/renesas_sdhi.h
> @@ -111,6 +111,8 @@ struct renesas_sdhi {
>  	unsigned int tap_set;
> =20
>  	struct reset_control *rstc;
> +	struct reset_control *rstc_axis;
> +	struct reset_control *rstc_axim;
>  	struct tmio_mmc_host *host;
>  	struct regulator_dev *rdev;
> =20
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/rene=
sas_sdhi_core.c
> index 8e2fb19b994b..699872766f88 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -615,6 +615,8 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *=
host, bool preserve)
>  				sd_status =3D sd_ctrl_read32(host, CTL_SD_STATUS);
> =20
>  			reset_control_reset(priv->rstc);
> +			reset_control_reset(priv->rstc_axis);
> +			reset_control_reset(priv->rstc_axim);

Is this order (rstc, axis, axim) ...

>  			/* Unknown why but without polling reset status, it will hang */
>  			read_poll_timeout(reset_control_status, ret, ret =3D=3D 0, 1, 100,
>  					  false, priv->rstc);
[...]
> @@ -1351,13 +1361,18 @@ int renesas_sdhi_suspend(struct device *dev)
>  {
>  	struct tmio_mmc_host *host =3D dev_get_drvdata(dev);
>  	struct renesas_sdhi *priv =3D host_to_priv(host);
> +	struct reset_control_bulk_data resets[] =3D {
> +		{ .rstc =3D priv->rstc },
> +		{ .rstc =3D priv->rstc_axim },
> +		{ .rstc =3D priv->rstc_axis },

... different from this one (rstc, axim, axis) on purpose?


regards
Philipp
