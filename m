Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE821FC11F;
	Tue, 10 Jun 2025 11:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749554142; cv=none; b=o5dBZzFcH/pEEr84wMdiB39Jx982YnA0+3+v3vPqMlI1QtbTtCozoA/t1r6H2pjNlOefV2UdpE7SJtX6WAOKANADKv+XN2RXpOyBoofLQXTwMSdUCB8MS+byzNqqBIeFAp2rIEw+TrIAHrcfCEsaQn8aF0+9STL7fC2502W5ThA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749554142; c=relaxed/simple;
	bh=kixFWX+byclEyz7YAnHZb47/51TtOQ7bpoYAftt4bro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAW7RahBIEh1LNryNxkFIFZKq9leNgzG4oCEpfV8ZJFA6C7YCYQnBaFnGIMXnKSkApiefdoF/ijYDw6f4teQzAqk1XTliL6wE+ZAcgnIwSk40ApSfZIbEvELFi4r9KNx7FX7lkrpBDB7mAaM++6r9CZfI97EnNRcPWfaykLgPAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2GgXdCI; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2GgXdCI"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a53ee6fcd5so1643602f8f.1;
        Tue, 10 Jun 2025 04:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749554139; x=1750158939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UxiKx3fQ2UN0TdQSGe7J2LZQJpdb1R/YSkx1+hJ6ixs=;
        b=g2GgXdCIMIh7LYz2wFmp7dtSg5gEfPtCTwUE6+rQHcj/qcaDHltbECiKRfJih3QIio
         EDH9DlT2NUmLregWMLNk3Kp3GaJHoVLVwAhyFSrLTb/Njeesr2ilBWdchVRZvTFwAaBp
         ZEnw8yU6NipPr5sk/chyBPHpmOO9L6VbCO5veGXfGOliIscbeosk5xdeqOKgUN/MprPf
         x4TdQDiqk3/yeVYat9ikxGG+MDCclusok81XAWde0FuMbT9UirmU/A4JOUq9eC7DEegC
         IXHU8IOUkbHIRbv5He3LBm47LZfuynDYZvG2Klw/pFr6l17h2L7BcZtrCfUxB2BbrzLb
         mFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749554139; x=1750158939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxiKx3fQ2UN0TdQSGe7J2LZQJpdb1R/YSkx1+hJ6ixs=;
        b=Psi46a8Jx8V6zO3kdF3RQ+9/Ac06mOrZd5m4Nx8rt7UJHEIHhRp3o3NUHILezzgMxz
         /jyOCiT1XTW9NZ/HaJ7ws+jEfLlkw8VQfmvj3xbzyyR1NpbxFrX500PSOQNPNGgEEII5
         X6Ui+0BfFL3esr1oZkrJa+P+HKv0Qr4aGrlJpHWsbaaRZiP/PUF/EHJ/IUJ9uEoDFDaB
         Gn7y3uSyE+L+FAprYa4YGPrdZc1vdd8G714GQUzw5jDnd5AX0m3ttlbZDS6sFNTG5yAM
         R8QOaE31encbCfhB3p4BmIG6OeBGjU5vDCLbJeNHiKpWmBula/WI4FaBS3nHV1n3UE3S
         /Lew==
X-Forwarded-Encrypted: i=1; AJvYcCUIVhmFHNHg7Xvu045D9GMUJwcGG+5fValuWZSkMK8uZ0UPCfClpZuZ5Y923iYYMkx6uGYFBh0EWbY=@vger.kernel.org, AJvYcCX489Q/C4dNpz1qc7V+DBylDf4jGvenYvfaU3zm9T8Sog7F4BI5B8XE9ugijyHqNyzlP0WhI2KLPazW7Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfmt0nLSY3k+a5FR9rpPYygcpi+WGm18H6P6InUBD7Jn58/cuY
	O0mgZBfeJa0kdU/tJrlKMILMqfec6akPBhkn6Ut89t/yQpdi1S39HWDe
X-Gm-Gg: ASbGncvBu4v23i7AgcVayjfAQpupUgs6WOYPHuV39IQjr6oOFxmw2NBC9l6jRPkjq3r
	2wpcsoGJM2Mr/MKAFixJUQpzYiRiubuh/jaD9eGnadTB8mduuZsLDRYTZAeJRt08Hv0Rb0I7olu
	dIsgKPah5C/y70oaNTbvn9C2/a5zLeW8vV0bHqsv58fCAw91PykaYMHx/QX0eFxjdDA3r/cnnjj
	KwgNbdbqnRPdvSUKkfHbYIFMZxiSjM/ah9faDWGUJE9dlkgRmcUBRR+Fk9ATin1aQx1dSo6Notw
	NdcsEJphp0rhTQh4RYCedC7e3i9uQZn3AbtqXWNCvmazWTCelh5FQsrDAmK8LreafJ9gusWEPF0
	UsFMZrPsh9w6h4YVHe1tPU4gswpNCZeprOzqJJBiCE/ht2i4g
X-Google-Smtp-Source: AGHT+IEq5h6QpOWbOPcXEokI/1kkApz0WSZPNMsqb+qTO25Obu6S4fRERowIAa6crf+gSKsbxpYBWg==
X-Received: by 2002:a05:6000:2891:b0:3a5:2b75:56cc with SMTP id ffacd0b85a97d-3a531cac39cmr14409541f8f.23.1749554139143;
        Tue, 10 Jun 2025 04:15:39 -0700 (PDT)
Received: from orome (p200300e41f281b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5323ad414sm12186802f8f.31.2025.06.10.04.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 04:15:37 -0700 (PDT)
Date: Tue, 10 Jun 2025 13:15:35 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Huacai Chen <chenhuacai@kernel.org>, linux-mmc@vger.kernel.org, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Taichi Sugaya <sugaya.taichi@socionext.com>, 
	Takao Orito <orito.takao@socionext.com>, Ben Dooks <ben-linux@fluff.org>, 
	Jaehoon Chung <jh80.chung@samsung.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Kamal Dasu <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev, Avi Fishman <avifishman70@gmail.com>, 
	Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>, 
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>, 
	Benjamin Fair <benjaminfair@google.com>, openbmc@lists.ozlabs.org, Michal Simek <michal.simek@amd.com>, 
	Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org, 
	Aubin Constans <aubin.constans@microchip.com>, Eugen Hristev <eugen.hristev@linaro.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Yixun Lan <dlan@gentoo.org>, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-tegra@vger.kernel.org, Hu Ziji <huziji@marvell.com>
Subject: Re: [PATCH v3 01/35] mmc: sdhci: Use devm_mmc_alloc_host() helper
Message-ID: <72va4ohv5djerrqe6jwtas6j2yg5f4xkcfxpsmadclh25mhjlh@2zwl3d52ubvy>
References: <cover.1749127796.git.zhoubinbin@loongson.cn>
 <dcfce3ddf980563c590f82c1b4e8840c29497887.1749127796.git.zhoubinbin@loongson.cn>
 <t5caqkvguurw2dwzn7wkbjo5ryv3jp3eppjzhdwgx6q6vro2q2@onqqr6v3whdo>
 <6ab83033-1349-4d5e-8d1f-8a13d851abf4@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k45u4zwumvcsy4c2"
Content-Disposition: inline
In-Reply-To: <6ab83033-1349-4d5e-8d1f-8a13d851abf4@loongson.cn>


--k45u4zwumvcsy4c2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 01/35] mmc: sdhci: Use devm_mmc_alloc_host() helper
MIME-Version: 1.0

On Tue, Jun 10, 2025 at 06:21:27PM +0800, Binbin Zhou wrote:
> Hi Thierry:
>=20
> On 2025/6/10 17:42, Thierry Reding wrote:
> > On Sat, Jun 07, 2025 at 03:33:34PM +0800, Binbin Zhou wrote:
> > > Use new function devm_mmc_alloc_host() to simplify the code.
> > >=20
> > > Although sdhci_free_host() is no longer needed, to avoid drivers that=
 still
> > > use this function from failing to compile, sdhci_free_host() is tempo=
rarily
> > > set to empty. Finally, it will be removed when there are no more call=
ers.
> > >=20
> > > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > ---
> > >   drivers/mmc/host/sdhci.c | 3 +--
> > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > > index 32fa0b2bb912..ee5a5ae4db31 100644
> > > --- a/drivers/mmc/host/sdhci.c
> > > +++ b/drivers/mmc/host/sdhci.c
> > > @@ -4076,7 +4076,7 @@ struct sdhci_host *sdhci_alloc_host(struct devi=
ce *dev,
> > >   	WARN_ON(dev =3D=3D NULL);
> > > -	mmc =3D mmc_alloc_host(sizeof(struct sdhci_host) + priv_size, dev);
> > > +	mmc =3D devm_mmc_alloc_host(dev, sizeof(struct sdhci_host) + priv_s=
ize);
> > >   	if (!mmc)
> > >   		return ERR_PTR(-ENOMEM);
> > > @@ -5002,7 +5002,6 @@ EXPORT_SYMBOL_GPL(sdhci_remove_host);
> > >   void sdhci_free_host(struct sdhci_host *host)
> > >   {
> > > -	mmc_free_host(host->mmc);
> > >   }
> > Is there any point in keeping the sdhci_free_host() function around now?
> > I only see patches 1 and 31, so not sure if anything happens in between.
>=20
> To minimize email delivery failures, I handle each driver patch by sending
> it to the relevant person, while sending patches 0 and 1 to everyone.
>=20
> Keeping sdhci_free_host() as suggested by Adrian[1] is to minimize
> disruption to the compilation process. We first set sdhci_free_host() to
> empty, and once all callers have been cleaned up, we will remove it[2].
>=20
> Of course, perhaps I should also CC the final patch[2] to everyone, which
> would make the entire process clearer.

Makes sense, and no worries. There's no great solution to this. Either
you send to everyone and you get complaints, or you send to too few
people and you get complaints.

Thanks for clarifying.

Thierry

--k45u4zwumvcsy4c2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmhIE9cACgkQ3SOs138+
s6GQBA//Uwo2UNmg6Kz2FmjupP6jInce88oeU0wuRA2eXLJxily+e6i9k6VcnYrB
FwkVmYo7qNRUixAA6TkZuDe74mN5rUrDAgMaF8pLMvQ2tFXS8BO+02jTedHffhet
v6GXZJ4hARWlGL6EY5jGfWa7PIMtlXGyPiRmCH8gXSW3qoo6O5mfLLdWi6brHhts
lX3z6DxsSVN52Pa/95zoQQQ8eyQtdcYDWHqeTivi5Y82gDy6P24+1BLWiTfCTzEw
D2Cl3DgKUu1qKrMwG9V0gQyc6bmNFdJuS3BLA37hKPFOMrD0zS7SQsX2pt+yoMxO
zKjO5P3kkQFTJJhP6gDoXscax9d80EsHUgKOOdkLVp+3SmGLZ039rI94BGhHc1by
78S5I+HpQKr3B+WlwRBQqoQtTDDFB8lP2D0LRClGyW50bIDHwHU087JYcoCck13W
xHDXXMIsVCU3NKmXT8bI5GFF4WVlI8oAcHEtRTZRJy8IcSZa7fn8QYdIDwOmTjM7
Y5SY2/GHPYmcfHeUaGACsFGB8vCCdVi9qVCQtw9M3OjORZ3Hu6wCQ3BpQesJsJO+
CHX7XcTnKxG/o9LGeeimJMjqHK/oA4HU9/HXoqJgmlIDDr0nI3N6EVOPDL3CNATV
L81QfkNDQ+ORICzcQsgi8Q5Rbi5P7fOsmRpdcEck9u4NZGbgD4M=
=tny8
-----END PGP SIGNATURE-----

--k45u4zwumvcsy4c2--
