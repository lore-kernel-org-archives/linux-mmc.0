Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5DF1E521;
	Thu, 15 Aug 2024 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728159; cv=pass; b=CAqljBHR6b2a5Rq09swRKS0aSRB6ctwQxKSvUFpvGJlxt+/Y3ByjVxAKxiTgfucZ77tXj6AeBdARSJ/MbgX/YU/R267kpnp0H7qb7MHj5XUUYv18wa6l2tvofw2z0Cn6TrbdK8QY+q+H83r7LDlR90ubN8Ck99/co0m4j1NCE6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728159; c=relaxed/simple;
	bh=Am6Um6GarnKWNvcoMt+2lU97JRuYlvLwxAb0jhKGrmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMNQM0k/q7+kXcLTGPsS7hEIeMmTbwKP/jYRD1T2tAVcwHBPEwj5sZTShY1q5J/KQ3n/nvRTE9gSEagL8G/iAc79yAnkSIe7oPI+qZF3cN44GzDFSb0loQWQr+6bHc5zaCMy0wl/pcagJskkf4IG4hT6yqcj0MU85VvM1eZq/Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=DcfGVhQ3; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="DcfGVhQ3"
ARC-Seal: i=1; a=rsa-sha256; t=1723728133; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=F+f+/m+3yoalyK2PJzkFo+Tupgp9cPh4Tjb5I8Bo0B6JwGSNH+RspfAWYBAghyJaMwqpBfsB4CnaGXyBqoxqnDA/CThDVeVg+N3jpbQVUeLCUEGFAhuylTw4CXyyu41AT5PyLxxM6mHCL05d/8DAPfVdEd45nI3x06XdYoTk+kg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723728133; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3jD5WsZNkgzCPHbwdRHU3z7HY4AhHudi/075H3onC+g=; 
	b=d5pNEIS5M++TnFvZssINEBI2Pz69a8A2BJ374wxLHQMc662ocw1uH38KUAktY/pp2aWSEj3LvtaqCOn7vPTvth5uS7XoMtvscJT6JMVvuiKL/20BxLOTWR7K5Rlx9pxJULjDBPeLPKwghq7tOswavlAPBx6MEtDg0ZXU1NuE1AQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723728133;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=3jD5WsZNkgzCPHbwdRHU3z7HY4AhHudi/075H3onC+g=;
	b=DcfGVhQ3UnLTLR5cZ/XXIxZUpgSGP0lCd/ysHHzVPav0BueYScAUr7i3Z6d8ekh/
	6znr1w2Xwj3l+aAyO9IKfWTO7REENho7qdz5Af/GKWDohudjhr+c+pdxtLdqv3dB7FL
	mCndEleBPQAQUdaG3ZwYigYbNwrJHmDaDqEk0Es0=
Received: by mx.zohomail.com with SMTPS id 1723728131107663.2447060327355;
	Thu, 15 Aug 2024 06:22:11 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v3 2/3] mmc: dw_mmc-rockchip: Add v2 tuning support
Date: Thu, 15 Aug 2024 09:23:40 -0400
Message-ID: <2742918.mvXUDI8C0e@trenzalore>
In-Reply-To: <5dc82aa2-82a0-4778-b598-88775d5f791c@rock-chips.com>
References:
 <20240814223555.3695-1-detlev.casanova@collabora.com>
 <20240814223555.3695-3-detlev.casanova@collabora.com>
 <5dc82aa2-82a0-4778-b598-88775d5f791c@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

On Wednesday, 14 August 2024 20:55:37 EDT Shawn Lin wrote:
> Hi Detlev
>=20
> =E5=9C=A8 2024/8/15 6:34, Detlev Casanova =E5=86=99=E9=81=93:
> > From: Shawn Lin <shawn.lin@rock-chips.com>
> >=20
> > v2 tuning will inherit pre-stage loader's phase settings for the first
> > time, and do re-tune if necessary.
> > Re-tune will still try the rough degrees, for instance, 90, 180, 270,
> > 360 but continue to do the fine tuning if sample window isn't good
> > enough.
> >=20
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > ---
> >=20
> >   drivers/mmc/host/dw_mmc-rockchip.c | 49 ++++++++++++++++++++++++++++++
> >   1 file changed, 49 insertions(+)
> >=20
> > diff --git a/drivers/mmc/host/dw_mmc-rockchip.c
> > b/drivers/mmc/host/dw_mmc-rockchip.c index b07190ba4b7ac..367633f4e8892
> > 100644
> > --- a/drivers/mmc/host/dw_mmc-rockchip.c
> > +++ b/drivers/mmc/host/dw_mmc-rockchip.c

[...]

> >   	=09
> >   		priv->default_sample_phase =3D 0;
> >=20
> > +	priv->use_v2_tuning =3D
> > +		of_device_is_compatible(host->dev->of_node,
> > +					"rockchip,rk3576-dw-
mshc");
> > +
>=20
> v2 is a kind of software decision instead of hardware dependency.
> So in theory, any SoC can claim to use it via DT.

Yes but from my tests, only rk3576 won't work without it. So it makes sense=
 to=20
only use v2 for this SoC (and other future ones not supported yet)

>=20
> >   	priv->drv_clk =3D devm_clk_get(host->dev, "ciu-drive");
> >   	if (IS_ERR(priv->drv_clk))
> >   =09
> >   		dev_dbg(host->dev, "ciu-drive not available\n");


Detlev.


