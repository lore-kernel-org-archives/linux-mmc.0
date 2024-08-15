Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DCB17C984;
	Thu, 15 Aug 2024 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723727866; cv=none; b=CYt6dhKzXI0rg7uOU5yVI3RGMeQDNVnozq0EfDCMN6apjfgizeVvgZi8yWPqA5Li+Rsj4cS5zWK2M4RD3j9//bTxFZAv/bqrv009VKvcEqEUOLDiINkNi7TG5cEyz1+Ds13z8uODectZgX5o6+WzpwM/zwRHCE8UVXO2DCxsMp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723727866; c=relaxed/simple;
	bh=V7xyR5Otglxn7/LvCe4REzcqk+t+gv+muKlGMGR+P6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OrnnGAIZq0ik/CzcLoJYpe8Zh6dKHRcfgz+NKuf88VSZo0nFzCG5VcIwgxTmy/Aj1pRIkTEiD2nMDhLwHMxuyWrnrCs+WJ+/ukKadmXUjxdKlwYWNHnCi+tP/NehERV6WRR6pXGnfENkxMmurwKBKC1C3ZKCrbB/nPpkvG6haCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=d0kGjN51; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="d0kGjN51"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6Sh4JlvtilfgHZ8AKzPSFBYOVcq2ODGvw9XQUWeQAJY=; b=d0kGjN51Zg2xvCf4LcSmivsDFy
	Vyu8uZDt6/w5bnI95Le5DUbLclvga9RNjik+4gBS+K8sjQZ6CDJvWAVbVVLRO8zed3/4TPmkh3KA3
	UrX9ac8sj0lT0XNuD1dLWUa7C/5k2QG1Tfbzzd0441wanLIZ/hP2cJjNWfHZCg9wEBeycBUUMCPj1
	I5xOpgUb3GSx98InpSaE+JDkfBwKKPUX1tym2sR5povzL3e4jvnzKv1jevzGmALLGEx4w1Zx9YHis
	3IW3T49HC28EC6Hv/PPQVGbFvLsNCzRCwGfjIWOvGcqsYkNGvmxuIPEvfQiqhxn+w1mQmE/E8HeAs
	dB56TZcg==;
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1seaM1-0002nJ-Fa; Thu, 15 Aug 2024 15:17:25 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Detlev Casanova <detlev.casanova@collabora.com>,
 linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 kernel@collabora.com
Subject: Re: [PATCH v3 2/3] mmc: dw_mmc-rockchip: Add v2 tuning support
Date: Thu, 15 Aug 2024 15:17:24 +0200
Message-ID: <18146801.MNNF8PUAaN@diego>
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
Content-Type: text/plain; charset="UTF-8"

Am Donnerstag, 15. August 2024, 02:55:37 CEST schrieb Shawn Lin:
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

> > @@ -277,6 +322,10 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci *h=
ost)
> >   					&priv->default_sample_phase))
> >   		priv->default_sample_phase =3D 0;
> >  =20
> > +	priv->use_v2_tuning =3D
> > +		of_device_is_compatible(host->dev->of_node,
> > +					"rockchip,rk3576-dw-mshc");
> > +
>=20
> v2 is a kind of software decision instead of hardware dependency.
> So in theory, any SoC can claim to use it via DT.

which actually makes it unsuitable for dt.

Devicetree describes hardware-properties and should _not_ be used for
software configuration.

=46rom the comment above, I assume the rk3576 does not need that feature
and can just work with the regular tuning?

So there are two routes for the immediate future:
(1) rk3576 _needs_ that feature, then going with the compatible is fine

(2) rk3576 does not need absolutely need that feature, then I'd expect
the basic rk3576 to first come without, as I'd expect a lot more explanation
on why it is actually needed, and which cases it does improve.
The commit message does not really explain that much about why this
is a great/needed feature and which areas it does improve.


Heiko


