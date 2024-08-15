Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DF31BA863;
	Thu, 15 Aug 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730989; cv=none; b=E0UecINbu4AcS7GyY0EACuNwzc/xAfkiYf8qRVU/lhPnP7PMvLdZAsl4W3cfs0qEN18C6njkJ5u615YQOiFl64RrrCvdoDfBs92ZBfoJulymOt9WYuJ4KctSz1ntYprQ1787AHNbUTzNY3fATV7QFQIsjdI+sPcaHKtuDDPccS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730989; c=relaxed/simple;
	bh=LQLiRQkd2k5AXfRMRm5JQ2We4DWkBlu+RddGsG+qRY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkL0SXiVBhc1hKsgqSLVIVNzZ3wKf6MAOlhKgZgAO/YqC6maNrTAFgXy696pJ9vxD+XgoI0YxpJ6wXbwEiiAGRnX74E0de50d1O5c6xptFTrl6OzPSfG0M+8fj8A0Rg3a3u4pBaiYUwaXSJp5VFlK3I1nv7/5IR6ftUTA2YunoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=npOOkDXN; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="npOOkDXN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3GJHxN14hImGkfcEquuGy6L5t/9fvO8apZfgPwP8Qzs=; b=npOOkDXNtrDTvyhXZ1PxQqxQpf
	J9s2SuKRp5nAkOf8YpkJHhwTM0lNog+gTwjUMgzJjR1OrpQzAIhXEOTWuirCxYffGP3xbGGAQk5yn
	r23Fib9CrOZCCxIlkn6edxJB+/p8ZNx3ZZY+MTO/CjMCUqoLeNmIeGwv2sXNXepIj+/duZsqeijQW
	QbbiLQ1qvWgGsYC+xYLR/nx9wtHKC7eKcP2Gbgyi9wfZHCglovXxcMWfsJVk2wKpla258zPvSumsn
	0/fEZgJcNU/3eAiGdJvMhQ+hk5JJBCEcJ/hbS75Rfz4U/55zap7UX07abYl+4C4xBCgZQ3uH7CbtG
	cnVe1EFw==;
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sebAb-0003Vr-44; Thu, 15 Aug 2024 16:09:41 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 kernel@collabora.com
Subject: Re: [PATCH v3 2/3] mmc: dw_mmc-rockchip: Add v2 tuning support
Date: Thu, 15 Aug 2024 16:09:39 +0200
Message-ID: <3273134.DVCPrJfaZc@diego>
In-Reply-To: <2742918.mvXUDI8C0e@trenzalore>
References:
 <20240814223555.3695-1-detlev.casanova@collabora.com>
 <5dc82aa2-82a0-4778-b598-88775d5f791c@rock-chips.com>
 <2742918.mvXUDI8C0e@trenzalore>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Donnerstag, 15. August 2024, 15:23:40 CEST schrieb Detlev Casanova:
> On Wednesday, 14 August 2024 20:55:37 EDT Shawn Lin wrote:
> > Hi Detlev
> >=20
> > =E5=9C=A8 2024/8/15 6:34, Detlev Casanova =E5=86=99=E9=81=93:
> > > From: Shawn Lin <shawn.lin@rock-chips.com>
> > >=20
> > > v2 tuning will inherit pre-stage loader's phase settings for the first
> > > time, and do re-tune if necessary.
> > > Re-tune will still try the rough degrees, for instance, 90, 180, 270,
> > > 360 but continue to do the fine tuning if sample window isn't good
> > > enough.
> > >=20
> > > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > > ---
> > >=20
> > >   drivers/mmc/host/dw_mmc-rockchip.c | 49 +++++++++++++++++++++++++++=
+++
> > >   1 file changed, 49 insertions(+)
> > >=20
> > > diff --git a/drivers/mmc/host/dw_mmc-rockchip.c
> > > b/drivers/mmc/host/dw_mmc-rockchip.c index b07190ba4b7ac..367633f4e88=
92
> > > 100644
> > > --- a/drivers/mmc/host/dw_mmc-rockchip.c
> > > +++ b/drivers/mmc/host/dw_mmc-rockchip.c
>=20
> [...]
>=20
> > >   	=09
> > >   		priv->default_sample_phase =3D 0;
> > >=20
> > > +	priv->use_v2_tuning =3D
> > > +		of_device_is_compatible(host->dev->of_node,
> > > +					"rockchip,rk3576-dw-
> mshc");
> > > +
> >=20
> > v2 is a kind of software decision instead of hardware dependency.
> > So in theory, any SoC can claim to use it via DT.
>=20
> Yes but from my tests, only rk3576 won't work without it. So it makes sen=
se to=20
> only use v2 for this SoC (and other future ones not supported yet)

Good know and thanks for testing that scenario.

If you go with my suggestion from patch3 and separate the rk3576
from the original rk3288 type, you can even just assume this v2-tuning
for all those types (rk3576 only so far)


> > >   	priv->drv_clk =3D devm_clk_get(host->dev, "ciu-drive");
> > >   	if (IS_ERR(priv->drv_clk))
> > >   =09
> > >   		dev_dbg(host->dev, "ciu-drive not available\n");
>=20
>=20
> Detlev.
>=20
>=20
>=20




