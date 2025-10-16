Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003463346B2;
	Thu, 16 Oct 2025 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760634616; cv=pass; b=seL79o+OAF97zvXupisS5YxLHBnkPNbC518eP6kO1k/apDdyMsFvalXGYgExJhfu5Crz6xsQe6APyPggWoRzXVPq9TgOpvmWDnmYZLjs7o9UI1OEQTnudSjvXXCARqwDdTBmlnm0Ldv3X4ngWkvmqub5jrdDBz1a+dfNTbnPoME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760634616; c=relaxed/simple;
	bh=IoOOOo99B6oDTSqOk5pWxfk5E3PACZ8LU1gvKyz/9f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fu8Ldc2/NDfJ9BuT60yMtyIlpo8uIHsZd7AX7dpFSeM24nzpHccYGDLaAHj8+8QxgGq0d6un1YdGQerlvAt9BCfzSrkOFQUMTGVNI6tux5EigN9x2iG0Qwbxw+eDhA1SnypKKmuWL1pmBuW2CjCxIKJlUzWxxAoiII27rNpLrmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=UQsNPB5G; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="UQsNPB5G"
ARC-Seal: i=1; a=rsa-sha256; t=1760634588; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gczbO7sKvcCDnqFSCQR1vw53dx1KwJ5W0866fWUOnSzlNftVHnFLj77hgcQUZtYXhY4ar0IDH7bqxBx/6iCFqfl2mqPQH6dsKBEJ9AkGJjyDHneSaj81ertXiYnhnrzH0c9O80Zn4V1KJw79ZGJd7mmXlgT28lr0FBTaCsiadOQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760634588; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hbEVUDEoCtk3RUFUaAcs6tJL6oJ/a4YVjeL1gA2lj0c=; 
	b=YoBbzw8uapRMEd890bLia1G3i2fGbjjsf6WNJmThnnPZhpHq5BO92Bf9SGMz2GamRtF4h1WYTLoGbU9bpLWepgGbVx3Ks8mQQglFWILlhDV4b3SigUq7xntql27Ad1dm1DFHD+6AXpW5tzdEplrhLZj9CYVop0/m/UcwIIfPtiI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760634588;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=hbEVUDEoCtk3RUFUaAcs6tJL6oJ/a4YVjeL1gA2lj0c=;
	b=UQsNPB5Go5CaZbJTq7W5TDuEJTrKB9w9Kk33sLnBncGFqC3D24repvUEoKp49MYr
	NaIT7U2ltqoYff1WLmjb5bzmBzfgIe57idrbASxG6LCiH7O8GXGe2SMPb0ks/ZXG9R3
	H6mgu+d0x3B+3yZ2biXQx7MHasadDM+zICc2J0Rg=
Received: by mx.zohomail.com with SMTPS id 1760634584762197.15433494671288;
	Thu, 16 Oct 2025 10:09:44 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id A00AA180305; Thu, 16 Oct 2025 19:09:37 +0200 (CEST)
Date: Thu, 16 Oct 2025 19:09:37 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, kernel@collabora.com, 
	Yifeng Zhao <yifeng.zhao@rock-chips.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-of-dwcmshc: Add command queue support for
 rockchip SOCs
Message-ID: <7bxs6nw5fnjq22p7gxrmjqjtw3g5nt6cacwpfjihxv5jk765si@ho3odkyxpi7m>
References: <20251014-rockchip-emmc-cqe-support-v1-0-918f03de0cb1@collabora.com>
 <20251014-rockchip-emmc-cqe-support-v1-1-918f03de0cb1@collabora.com>
 <70cca930-29ac-40a9-8e3d-fba1aace9156@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hi7slofuvqrfaiik"
Content-Disposition: inline
In-Reply-To: <70cca930-29ac-40a9-8e3d-fba1aace9156@intel.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/260.576.51
X-ZohoMailClient: External


--hi7slofuvqrfaiik
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] mmc: sdhci-of-dwcmshc: Add command queue support for
 rockchip SOCs
MIME-Version: 1.0

Hi,

I will fix the typo in the commit message in PATCHv2.

On Thu, Oct 16, 2025 at 10:42:29AM +0300, Adrian Hunter wrote:
> > +static void rk35xx_sdhci_cqe_enable(struct mmc_host *mmc)
> > +{
> > +	struct sdhci_host *host =3D mmc_priv(mmc);
> > +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > +	struct dwcmshc_priv *dwc_priv =3D sdhci_pltfm_priv(pltfm_host);
> > +	u32 reg;
> > +
> > +	reg =3D sdhci_readl(host, dwc_priv->vendor_specific_area2 + CQHCI_CFG=
);
> > +	reg |=3D CQHCI_ENABLE;
> > +	sdhci_writel(host, reg, dwc_priv->vendor_specific_area2 + CQHCI_CFG);
> > +
> > +	reg =3D sdhci_readl(host, SDHCI_PRESENT_STATE);
> > +	while (reg & SDHCI_DATA_AVAILABLE) {
> > +		sdhci_readl(host, SDHCI_BUFFER);
> > +		reg =3D sdhci_readl(host, SDHCI_PRESENT_STATE);
> > +	}
> > +
> > +	sdhci_writew(host, DWCMSHC_SDHCI_CQE_TRNS_MODE, SDHCI_TRANSFER_MODE);
> > +
> > +	sdhci_cqe_enable(mmc);
> > +
> > +	sdhci_writew(host, DWCMSHC_SDHCI_CQE_TRNS_MODE, SDHCI_TRANSFER_MODE);
>=20
> Transfer mode was set already 2 lines up

Indeed. I was not sure if this is an intentional quirk from Yifeng
Zhao and thus kept this dual write.

> > +}
> > +
> > +static void rk35xx_sdhci_cqe_disabled(struct mmc_host *mmc, bool recov=
ery)
>=20
> As mentioned elsewhere "disabled" -> "disable"

Ack, will fix in PATCHv2.

> > +{
> > +	struct sdhci_host *host =3D mmc_priv(mmc);
> > +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > +	struct dwcmshc_priv *dwc_priv =3D sdhci_pltfm_priv(pltfm_host);
> > +	unsigned long flags;
> > +	u32 ctrl;
> > +
> > +	mmc->cqe_ops->cqe_wait_for_idle(mmc);
>=20
> Is this necessary?  If so, it seems more like something that should be do=
ne by
> cqhci itself.

The RK3588 TRM says that the software needs to verify that the eMMC
controller is in idle state without any ongoing commands or data
transfers before disabling the CQ_EN bit (CQHCI_ENABLE in the kernel).

Thanks for the review,

-- Sebastian

--hi7slofuvqrfaiik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjxJs4ACgkQ2O7X88g7
+pq51hAAm3CH6Mqi1/tRfS7aU5DQ4CTIPKPwk8OcIi55uSaw6dq9jg7bPBVs4V7n
9HB551tq8Pam5BJ4/rLH7izTRBCzSG/hvChWlKYqsVw1w60Pb/JaTBxoFiYrq9XD
gNfWsQPBo3hwxrkzeIxYNNn2AnLHcEmkzYLWjVRsxNaoalAsOtwgTA/8bY4Yuwvg
Q7zCCqj4XrWrhvYET/c8EIoYkfjOnTkNhvE/ErZRYPb1tJLSjrzJoxU0KjtUtGcm
ac+orwAkqDuMVOpL0CvdjZkDiOhnubYAL9vWcSDXKN++MbeMwaLoqsrl3x9bnw1X
eYzGDQr5pNK7ywYVAcxu6mOTFrQaBFzh7RcoV5f+Gpw2xjF99CYpGI5Nysxyjr/q
1KoaTFjp8FQxVxycZhPCAnbAXrvfWWhKCwU8bbR3tgYHFMTGR/bnQqYQFbTu+5nL
W54NRQir+pMjeAOt8/aKhPCvQ8FPOUdQoqXqUqt7iVBtEdDejfKxVgV+TAC/7ild
xhh+jwafHylVySu8xf7kYUgITtNXIkeDlaU34SvWUs+rZ8fXE+ixQPez4c2QMzy7
mImT+596Tn+3IeRjnZVGaRsFCHRcwZZ95O167gW2IfU6BCFNS3E3a6DULxsbrNmv
aVM8t/FpIjNYIHDNGGTKD2YybwFSNeY1c0F2L7zUBTcY8gir0cM=
=DGaK
-----END PGP SIGNATURE-----

--hi7slofuvqrfaiik--
