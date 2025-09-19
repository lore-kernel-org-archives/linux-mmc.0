Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F247D2FBDF1;
	Fri, 19 Sep 2025 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758281278; cv=none; b=ZONLbwPNSUDj0RuOQCcEBkh/2vId7FO4uEjE2k3EeDGXF14ZklPz/0aHXY9rMcXuiRjPKsD71tmnczjn4GGmo6EYPBgGLQQK3Q2djkp7u2S1bsENIuDziaWtIU/RjEE031mXPEk4UVYWZUkEsxkfSyigIfCkkB6sSWb+uTs3LRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758281278; c=relaxed/simple;
	bh=B5acGq/XIs4ommlIH4Ue47dpac3CUDXkhaEuwBngiJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r2TWgiRaP3qSAFsPUa0346uNlE76RIG7N9BKj5C+yrMoYpZ4sn97/8hKtrwHgiAVizWqMJ5Askb1vwshQAwR/sexJ8Fgh+Ro84E0tmfoY8l0kZa6t/Zdj0+902u29PfZlGwYYApWsUkVYcniUvV7hHgSRkp+4ZfqGDzwUm3bPO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=riE2/z/C; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="riE2/z/C"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=N1wmRqJSG709kxkzkvs6/x40cypYnOxZQd81A+2200w=; b=riE2/z/CZTzWzuVs0bd36PSDi8
	F4ltg3ZjG9LFDIzcy34Q1+GZG/3KW1hk2D1VERvv2GUXLqrpwCqzjcuVyxA2qcdjRu/M8Lm4UM+Mt
	PdPIgmky5MmSivWP/rZ+aCYZJeVLh5g44XQ5mxjAro7FMjlmLUmogaqjxhkKLHB/UGYVNylyZJyGA
	z2vhnGAmFX0bKzzY/68m8OOibrr8oPfkPnV2+zQHkyDd2RPz2dt4Hf4+o0SW/BYYyCXVb8W661t6Z
	hQtvfqyTQtpek/c3124xQ3A/3j89VPf1nYwj8fw5xDU5mRRDOptkejH5pZ3CuiC5XJCrW06w2QWsB
	zKRvcs0A==;
Received: from i53875b0f.versanet.de ([83.135.91.15] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uzZHK-0008AG-Q4; Fri, 19 Sep 2025 13:27:50 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Mikko Rapeli <mikko.rapeli@linaro.org>,
 linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
 victor.shih@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
 geert+renesas@glider.be, angelogioacchino.delregno@collabora.com,
 dlan@gentoo.org, arnd@arndb.de, zhoubinbin@loongson.cn
Subject:
 Re: [PATCH v2 1/2] arm64: select ROCKCHIP_PM_DOMAINS with ARCH_ROCKCHIP
Date: Fri, 19 Sep 2025 13:27:49 +0200
Message-ID: <2703847.9Mp67QZiUf@diego>
In-Reply-To:
 <CAPDyKFogz=nym2CGh0LJpVad5hmycdfeoYta4DPfY4b4ozDMVA@mail.gmail.com>
References:
 <20250912084112.2795848-1-mikko.rapeli@linaro.org>
 <175822973684.1568500.2874531983654815490.b4-ty@sntech.de>
 <CAPDyKFogz=nym2CGh0LJpVad5hmycdfeoYta4DPfY4b4ozDMVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Ulf,

Am Freitag, 19. September 2025, 12:51:51 Mitteleurop=C3=A4ische Sommerzeit =
schrieb Ulf Hansson:
> On Thu, 18 Sept 2025 at 23:09, Heiko Stuebner <heiko@sntech.de> wrote:
> >
> >
> > On Fri, 12 Sep 2025 11:41:11 +0300, Mikko Rapeli wrote:
> > > On rk3399 based rockpi4b, mounting rootfs from mmc fails unless
> > > ROCKCHIP_PM_DOMAINS is enabled. Accoriding to
> > > Heiko St=C3=BCbner <heiko@sntech.de> all SoCs since 2012 have power
> > > domains so the support should be enabled by default.
> > >
> > > Failing boot without CONFIG_ROCKCHIP_PM_DOMAINS=3Dy:
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/2] arm64: select ROCKCHIP_PM_DOMAINS with ARCH_ROCKCHIP
> >       commit: aff3de3b9a597763bec5d1c56c11b56fb2613085
> > [2/2] ARM: rockchip: select ROCKCHIP_PM_DOMAINS
> >       commit: 47c9bfdf7376e8b1842699b064ae3b052e2c3c1b
>=20
> Looks like you picked the old version of the patches. Did you intend
> to pick the v4? Then it's the one below you want.
> https://lore.kernel.org/all/20250915083317.2885761-5-mikko.rapeli@linaro.=
org/
>=20
> Note, I have picked the other patches from the v4 via my pmdomain/mmc tre=
es.

oh ... you're right ... these patches from here are superseeded,
because we don't want to depend on on them in the arch part, but
instead to the default=3Dy if Rockchip from that v4 .

I did pick up the patch4 from over there too. I'll drop these 2 from here.

Thank you sooo much for noticing this.
Heiko


