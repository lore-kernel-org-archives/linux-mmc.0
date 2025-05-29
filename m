Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAEC2F37
	for <linux-mmc@vger.kernel.org>; Thu, 29 May 2025 00:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748479573; cv=none; b=DM683dIeYddGM+oa2NaXkhRahVbIyDe+yrecVU9Xnlyyd5IrmzYMdSu1lbtHztsE3mw6wmEGRrZo9UmR6SUu2huN31wsOyw77JfpqdqdsKMetsS0Au29TzzIF0UUFx363wECPFN/ORcT4HGBFLTJBztT+50C0cvMopkwvN3y7uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748479573; c=relaxed/simple;
	bh=ChtR6vldW7n0kPdmm4PxNhSE5dAjqDgKMbH0IiDBJWY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nX/ifUgp1jyytdUn9OcrYTl3SFcj4m2RLFE2i5/O8RRIK8qNMwHhpG1Py/tNNsxGxR4qu/v9Q2fHF/r2J6wKuEQfETvatYQ6qWYITBNSWwEvX3U/rYElIBs4beYh90caJNP/3EV1fPsQ0Oh5LbY3bEJxc4iTAYRMhCdOaAdnXS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ZDPoG7DM; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ZDPoG7DM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1748479564;
	bh=ChtR6vldW7n0kPdmm4PxNhSE5dAjqDgKMbH0IiDBJWY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZDPoG7DM6ortjve7wa02tcCHWgv97Kz3jOBMVdB5dCRbPKksvmzwPLHLIE7uY16Eu
	 4i5aKSOt3r32b8o8PHr8vYdMe7ChSrgmUZoD9WrFNQJahCmq4Le+zg5Mu2AWbpxaB6
	 VzEsm+W2DqrlIA0Jkhc4GVSgh0QziMn6rMmZCnJKHT8kDDETBSlpeVq6eSxi38qtl4
	 KfE5e4cl2LDcPDcudiAwRLtPIgcDSRmvq9uQifm9HLTVX0DvX2srJo4zcgX3u/p0jD
	 hvgM20xBVUGLjcunlCmuOU2f7rEigiO7PeterXeLQs7t9up2dZXMvY2qnEoz/1Yozg
	 sZp0Pnvv4Cw0A==
Received: from [192.168.68.112] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A8D75833B4;
	Thu, 29 May 2025 08:46:02 +0800 (AWST)
Message-ID: <5ae04cc843d85f862e906319803b80ffa58b6947.camel@codeconstruct.com.au>
Subject: Re: [PATCH 18/34] mmc: sdhci-of-aspeed: Drop the use of
 sdhci_pltfm_free()
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen
 <chenhuacai@loongson.cn>,  Ulf Hansson <ulf.hansson@linaro.org>, Adrian
 Hunter <adrian.hunter@intel.com>, Huacai Chen <chenhuacai@kernel.org>,
 linux-mmc@vger.kernel.org, Joel Stanley <joel@jms.id.au>, 
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org
Date: Thu, 29 May 2025 10:16:02 +0930
In-Reply-To: <CAMpQs4LchvbX5-1Gr_epq42DSdfj0uegdqaG2Vh=X2DULSbaWA@mail.gmail.com>
References: <cover.1747792905.git.zhoubinbin@loongson.cn>
	 <dfc7e01a6134e421ae3aa8da3221f67d59706d0d.1747792905.git.zhoubinbin@loongson.cn>
	 <753cd65ebf659972c8a33e5f8e579b9fa8738682.camel@codeconstruct.com.au>
	 <CAMpQs4LchvbX5-1Gr_epq42DSdfj0uegdqaG2Vh=X2DULSbaWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-05-28 at 12:42 +0800, Binbin Zhou wrote:
> Hi Andrew:
>=20
> Thanks for your reply.
>=20
> On Wed, May 28, 2025 at 8:44=E2=80=AFAM Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
> >=20
> > On Mon, 2025-05-26 at 14:06 +0800, Binbin Zhou wrote:
> > > Since the devm_mmc_alloc_host() helper is already in
> > > use,
> >=20
> > This doesn't appear to be true? aspeed_sdhci_probe() calls
> > sdhci_pltfm_init(), and following that through eventually we call
> > mmc_alloc_host() (the non-devm_ variant).
> >=20
> > That said, there are some error paths in aspeed_sdhci_probe() where we
> > leak the object. Improving the code would be helpful, but my
> > understanding is this patch isn't right.
>=20
> Sorry, I have a different thought.
> In the original code, there does seem to be a leakage of objects, for exa=
mple:
>=20
> pltfm_host->clk =3D devm_clk_get(&pdev->dev, NULL);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(pltfm_host->clk))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return PTR_ERR(pltfm_host->clk);
>=20
> With this error path, we should goto err_pltfm_free;
>=20
> Now, I have replaced mmc_alloc_host() with devm_mmc_alloc_host() in
> Patch-1[1], so I don't think there will be any error path leakage of
> objects.
>=20
> [1]: https://lore.kernel.org/all/6fd5afb003982bb5edbf95f76b605686223730e0=
.1747792905.git.zhoubinbin@loongson.cn/

Okay, I didn't track down the rest of the series on lore. I don't
personally mind if you send me the whole series, that would certainly
have helped with the context in this case.

Andrew
