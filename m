Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC6E34F474
	for <linux-mmc@vger.kernel.org>; Thu,  6 Nov 2025 23:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470142; cv=none; b=evbmZTA2qqB5pdjfN2XV7lfUPjgN5XXR9UexPrgeiglv+nhMVi03oM5RV7q8zosFSEc2biwEp/wepo37mI+hd7fL23j8noyPBEJa32IlvKinVG/mHTTBfQ5Cz2AYdukOywzf5ZxbbYaVeHaLO6hbIFJYu74Y67QqnKQImsa3DT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470142; c=relaxed/simple;
	bh=U9qllnNvFiHSnY/vEGx2Q8J7ZpOAQ9P4AGNFjOgVl1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lp4V2A1/IMxgCAQo02kLMMAgwPG15hr64X1gE3jS4ZeyZivVIarRsLo8JUy1kKK7i7tpXGg/BJC3EU+PgLiwkZ2JpBTAiFzx/jmqcnqaMtLjaqAuvjV5oxxDCJgAtQaZxzOtANuIFCAmVdpysxhkVm4pglSPOA1KyZoY69KMQTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ZiNEBZpF; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ZiNEBZpF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=REEIgQSUy6G/4v+A0xbrY164raqMUxEgfkqw+DKyrGI=; b=ZiNEBZpFwOV0OXOI1ZQCpkAfbV
	hTkPXMhpcpQO6aVGpuR0XRQbSw5unj4BYV8Ar3OmKaG4ZE8+3xpMxXdwWnwbk/zTKhs4kpPYsGXY6
	E2MqeJOY/v1eXTDVa98T5nM2ahJh+yhM5UwJHoseGs1quoQV+lrbrpIvCMCiwhIDBmBo3y4XCd5yn
	ZLuKKR0MMQVNiTfPxJBy/ipX3Gf3F4I+lfPhfQf3Ne5GF49me8/DgzoRURYDstQN9mgXfHH9meEm7
	d1sftFivStmQJHQHh1jPaHNN8MHgKvApLvYcVfkc+TGdN1a4zLHZzHwIfGRuSo6PCAEREnmi054Jd
	iPz9CY5w==;
Received: from i53875bac.versanet.de ([83.135.91.172] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vH8zf-0001tg-QN; Fri, 07 Nov 2025 00:02:15 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org,
 Detlev Casanova <detlev.casanova@collabora.com>, linux-mmc@vger.kernel.org,
 Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: dw_mmc-rockchip: Fix wrong internal phase calculate
Date: Fri, 07 Nov 2025 00:02:15 +0100
Message-ID: <3369161.5fSG56mABF@phil>
In-Reply-To: <1762228283-5025-1-git-send-email-shawn.lin@rock-chips.com>
References: <1762228283-5025-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 4. November 2025, 04:51:23 Mitteleurop=C3=A4ische Normalzeit s=
chrieb Shawn Lin:
> ciu clock is 2 times of io clock, but the sample clk used is
> derived from io clock provided to the card. So we should use
> io clock to calculate the phase.
>=20
> Fixes: 59903441f5e4 ("mmc: dw_mmc-rockchip: Add internal phase support")
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Heiko Stuebner <heiko@sntech.de>

> ---
>=20
>  drivers/mmc/host/dw_mmc-rockchip.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc=
=2Drockchip.c
> index 82dd906..6813549 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -42,7 +42,7 @@ struct dw_mci_rockchip_priv_data {
>   */
>  static int rockchip_mmc_get_internal_phase(struct dw_mci *host, bool sam=
ple)
>  {
> -	unsigned long rate =3D clk_get_rate(host->ciu_clk);
> +	unsigned long rate =3D clk_get_rate(host->ciu_clk) / RK3288_CLKGEN_DIV;
>  	u32 raw_value;
>  	u16 degrees;
>  	u32 delay_num =3D 0;
> @@ -85,7 +85,7 @@ static int rockchip_mmc_get_phase(struct dw_mci *host, =
bool sample)
> =20
>  static int rockchip_mmc_set_internal_phase(struct dw_mci *host, bool sam=
ple, int degrees)
>  {
> -	unsigned long rate =3D clk_get_rate(host->ciu_clk);
> +	unsigned long rate =3D clk_get_rate(host->ciu_clk) / RK3288_CLKGEN_DIV;
>  	u8 nineties, remainder;
>  	u8 delay_num;
>  	u32 raw_value;
>=20




