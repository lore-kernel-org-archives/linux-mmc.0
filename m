Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A81118027;
	Wed, 18 Jun 2025 02:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750214354; cv=none; b=W/mPQUK351dduooe9eHb9r3MZuLvPJBMat0HV6d9BEoPaFtVbmttkBS8RnhYzrGUIWg9NXMvAjcV29KZwoPJCV60rjtnBpx4czuXjgj+UeqHEmJ5bV6VqkfjkF+r9+TsqdD8gcqKO2TxNVgVSWOOh8fmD982U3l+8OAn8qk0Yq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750214354; c=relaxed/simple;
	bh=ItE5LTzozOsAetn4WQ1Ta5UuaFaBQiatwV/mVr7BE8o=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CUJAdnL9MquEEoAN0chXXTHcGjgLIDvAgA0THVnDN0j7qnsJyUtHn6DREpoudZNT6d3Eell1MS1j3atWAcJJXu3wC/Vqts2+IVRkPuJ+4jwcnDW7hIfrMeYPrsDW5+lZW201CL4v3pRyFM4OUhHjBAx0Xy81CIRxCvK6yy2ToPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ZtGpREki; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ZtGpREki"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750214351;
	bh=ItE5LTzozOsAetn4WQ1Ta5UuaFaBQiatwV/mVr7BE8o=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=ZtGpREkifDbhmwhg2Hx21YfFGNN5FATZloYBSy9QAEOF99qh6fJHo5f403fiT+n8U
	 4FcnEVWY4wrFYt4YRuXe4l7+I7Oo7d+iuOq97XWwkZr/Lfv+Q3sx7PN29en12bv49m
	 ml9ZlQb6WjoHcN7TCUEWWgOcnXNL30c+yLDptTUitxnR54Wq3kI3My3AaVwrsnNC2I
	 nAiIn88vAoz0vjz+LXr27bBzSN5cjwx7OwPUwlB9K8/grSYrQfLCNEmjQ1huFZWa2X
	 dIRzLWpYPaUfcrMMgMHCRq4v79zAPpt5zfGqJ2H3Bf/ICByT3TyLUmE0RP0RqaCLfV
	 YV5lLooh72UKA==
Received: from [192.168.68.112] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 86EA0640A0;
	Wed, 18 Jun 2025 10:39:09 +0800 (AWST)
Message-ID: <4c380a2936fc5c1f37750f231eb48edc17aefa68.camel@codeconstruct.com.au>
Subject: Re: [PATCH 4/8] mmc: sdhci-of-aspeed: Get max clockk by using
 default api
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Cool Lee <cool_lee@aspeedtech.com>, adrian.hunter@intel.com, 
	ulf.hansson@linaro.org, joel@jms.id.au, p.zabel@pengutronix.de, 
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 18 Jun 2025 12:09:09 +0930
In-Reply-To: <20250615035803.3752235-5-cool_lee@aspeedtech.com>
References: <20250615035803.3752235-1-cool_lee@aspeedtech.com>
	 <20250615035803.3752235-5-cool_lee@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-06-15 at 11:57 +0800, Cool Lee wrote:
> Don't limit clock frequency by f_max.
>=20
> Signed-off-by: Cool Lee <cool_lee@aspeedtech.com>
> ---
> =C2=A0drivers/mmc/host/sdhci-of-aspeed.c | 10 +---------
> =C2=A01 file changed, 1 insertion(+), 9 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-=
of-aspeed.c
> index 10160a706334..2bdd93a3f91f 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -288,14 +288,6 @@ static void aspeed_sdhci_set_clock(struct sdhci_host=
 *host, unsigned int clock)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sdhci_enable_clk(host, cl=
k);
> =C2=A0}
> =C2=A0
> -static unsigned int aspeed_sdhci_get_max_clock(struct sdhci_host *host)
> -{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (host->mmc->f_max)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return host->mmc->f_max;
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return sdhci_pltfm_clk_get_max=
_clock(host);
> -}
> -
> =C2=A0static void aspeed_sdhci_set_bus_width(struct sdhci_host *host, int=
 width)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sdhci_pltfm_host *=
pltfm_priv;
> @@ -446,7 +438,7 @@ static int aspeed_sdhci_execute_tuning(struct sdhci_h=
ost *host, u32 opcode)
> =C2=A0static const struct sdhci_ops aspeed_sdhci_ops =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.read_l =3D aspeed_sdhci_=
readl,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.set_clock =3D aspeed_sdh=
ci_set_clock,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.get_max_clock =3D aspeed_sdhc=
i_get_max_clock,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.get_max_clock =3D sdhci_pltfm=
_clk_get_max_clock,

This was used to limit the maximum bus speed via the devicetree. See:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
h=3Dv6.16-rc2&id=3D0a0e8d7501cda79c9b20f6011814e2ec9b473ade

Why remove it? There's no discussion of the motivation in the commit
message.

Andrew
