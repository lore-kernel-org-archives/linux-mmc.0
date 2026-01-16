Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF43330FC03;
	Fri, 16 Jan 2026 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768559300; cv=none; b=V7iWQmBD2YTJj2s/gY2ShTCBxeN3YLTdPIb/LxyZxt4K4mKwtXcTPllijfrCc3plpMm+cnfe8B+Ywk5wlBGwEvqUiZhkpypkDjNdx13UiVF8tHKuNdmpUVBoqfSWb4W36E5Wykvgt+leLtp2pT5VofmIAXelGvGmHbXEgpJremQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768559300; c=relaxed/simple;
	bh=zD8AU6NzHFIIoKcrjXbRgLe+2FtOW9kcD33SDh9vELQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+8viaocHxp+sM2HkiHdKNzUeKLP4b8oa5YQDThloLSgtro8j4ZI6mxoXeWX51eKv1pMr+/s80Q6UYZU7Mep/OMQOxm5IG9Yf788RsdoX+iOSDbnhGxe0zEf37B1IOr8tqt2W5PSVGFCO/au1nT7CgNyLoSBdDaGcwixFAoBDxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=gQAPVs7Z; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="gQAPVs7Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=GVzSHRUEj/E6nV+rHedhrqKBXQLAnvBfWRGUtGolWvE=; b=gQAPVs7ZTCDzkRDgbYPwlnKf8G
	ZrHj01SD5bH3OmUWcRtvx4MtDS7vSh9MMVZT8427Pf7is5diyHDlRx7X0umes/9JE8Nf4t3MSe/wh
	9940jR5s+gSPVXv3oZq1HhqeIIZLf8Ywy+g8Afx+YayqX03VT6kmk2idKk+Fw4VsTh1YXjinSHMYD
	hrTMrqSzF7Y3jR0qQCtZ92gFAeStAfBL11GNujRlvDJ4C3yAWlLLJbBwFVEWYVLY1opUpuqWf3S48
	ECjuGGCNjHX03flsZwBT4drAhqyFgCkMLYJ36PpmQdA5zcXCBjn9l75IA6ZDnYpTQpHFMeDN2qzLk
	vjlNuMCQ==;
Received: from i53875a97.versanet.de ([83.135.90.151] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vgh3t-002brq-Ht; Fri, 16 Jan 2026 11:28:14 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, FUKAUMI Naoki <naoki@radxa.com>,
 Marco Schirrmeister <mschirrmeister@gmail.com>,
 John Clark <inindev@gmail.com>, Tianling Shen <cnsztl@gmail.com>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Shawn Lin <shawn.lin@rock-chips.com>
Subject:
 Re: [PATCH v4 3/5] mmc: dw_mmc-rockchip: Fix runtime PM support for internal
 phase support
Date: Fri, 16 Jan 2026 11:28:13 +0100
Message-ID: <15381717.O6BkTfRZtg@diego>
In-Reply-To: <1768524932-163929-4-git-send-email-shawn.lin@rock-chips.com>
References:
 <1768524932-163929-1-git-send-email-shawn.lin@rock-chips.com>
 <1768524932-163929-4-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Freitag, 16. Januar 2026, 01:55:30 Mitteleurop=C3=A4ische Normalzeit sch=
rieb Shawn Lin:
> RK3576 is the first platform to introduce internal phase support, and
> subsequent platforms are expected to adopt a similar design. In this
> architecture, runtime suspend powers off the attached power domain, which
> resets registers, including vendor-specific ones such as SDMMC_TIMING_CON=
0,
> SDMMC_TIMING_CON1, and SDMMC_MISC_CON. These registers must be saved and
> restored, a requirement that falls outside the scope of the dw_mmc core.
>=20
> Fixes: 59903441f5e4 ("mmc: dw_mmc-rockchip: Add internal phase support")
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Tested-by: Marco Schirrmeister <mschirrmeister@gmail.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>=20
> Changes in v3: None
> Changes in v2: None
>=20
>  drivers/mmc/host/dw_mmc-rockchip.c | 38 ++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc=
=2Drockchip.c
> index 879188f..2fe0896 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -36,6 +36,8 @@ struct dw_mci_rockchip_priv_data {
>  	int			default_sample_phase;
>  	int			num_phases;
>  	bool			internal_phase;
> +	int                     sample_phase;
> +	int                     drv_phase;
>  };
> =20
>  /*
> @@ -573,9 +575,43 @@ static void dw_mci_rockchip_remove(struct platform_d=
evice *pdev)
>  	dw_mci_pltfm_remove(pdev);
>  }
> =20
> +static int dw_mci_rockchip_runtime_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct dw_mci *host =3D platform_get_drvdata(pdev);
> +	struct dw_mci_rockchip_priv_data *priv =3D host->priv;
> +
> +	if (priv->internal_phase) {
> +		priv->sample_phase =3D rockchip_mmc_get_phase(host, true);
> +		priv->drv_phase =3D rockchip_mmc_get_phase(host, false);
> +	}
> +
> +	return dw_mci_runtime_suspend(dev);
> +}
> +
> +static int dw_mci_rockchip_runtime_resume(struct device *dev)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct dw_mci *host =3D platform_get_drvdata(pdev);
> +	struct dw_mci_rockchip_priv_data *priv =3D host->priv;
> +	int ret;
> +
> +	ret =3D dw_mci_runtime_resume(dev);
> +	if (ret)
> +		return ret;
> +
> +	if (priv->internal_phase) {
> +		rockchip_mmc_set_phase(host, true, priv->sample_phase);
> +		rockchip_mmc_set_phase(host, false, priv->drv_phase);
> +		mci_writel(host, MISC_CON, MEM_CLK_AUTOGATE_ENABLE);
> +	}
> +
> +	return ret;
> +}
> +
>  static const struct dev_pm_ops dw_mci_rockchip_dev_pm_ops =3D {
>  	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> -	RUNTIME_PM_OPS(dw_mci_runtime_suspend, dw_mci_runtime_resume, NULL)
> +	RUNTIME_PM_OPS(dw_mci_rockchip_runtime_suspend, dw_mci_rockchip_runtime=
_resume, NULL)
>  };
> =20
>  static struct platform_driver dw_mci_rockchip_pltfm_driver =3D {
>=20




