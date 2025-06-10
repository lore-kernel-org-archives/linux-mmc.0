Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9468E1FC11F;
	Tue, 10 Jun 2025 11:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749554171; cv=none; b=s2hUPOt9DNG1qwATmSkp6lxZkFHN3kf7KQ3k2/N++JD+wyujjjBBABU/h5pkdqFyrSiDOVMOKKSDQE3byoR/1gszl2LyuPpXU8s7klOmuUmkTILjtAzLRkYtkND+QaWbz0fwQ7INSzdS2NGj0RxJ5Seae0/NDuQ/M7Kb+8hjflY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749554171; c=relaxed/simple;
	bh=D7KyxkcZSxzGKy1V/faBVg7FuKmcilDq6PoMewqvjTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IW/Y7wWrh28Puj0I0blcqni4gic+p1Z58mynKhIyMDHj0uCLj3oCnbYEufIrX8Sw9xUxLiVC7GiT9lKs+dacJzgTJG3+inLNJnNNGOyAasi4mmJryqlYCVj6w0ZlfuPzTb+30+ogs4HhaH9wGFcp1G5zWIL+BguFubyg4w3n1ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLEnMIqx; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLEnMIqx"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4531e146a24so4116955e9.0;
        Tue, 10 Jun 2025 04:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749554168; x=1750158968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3hI2dqT0ewY2kzj7s0/ei/Swu1TBfaU4ijVd9GNzdrs=;
        b=YLEnMIqx67NR4FmzsF9iNxvEAvnCvmIOTWhwePBUg9NmY/zAkvnx/A7p0dnMFeYNQb
         c4J60PQ20QH9kDL7jZGnTszXt5YuYEzAphbPcnB0e7K10N2hQaC3h6r4uE9mz94o2R5V
         hDd5d+LE72ommKtTJaEII0l8z84H96aklxQdDtduLxwR5b5/Gt22xj7MgMm6Z3JGce2t
         +nDgMcVvaq/EFOINcnjC6TjgrWwxjbTH3wVatbuXLkEDj6Dhe4AFpfSUyoZFNSa5W/gn
         9hbWvUfuypflWbWD2P068y/mWEqGOaA9wr/3w1wlRPrErLdiIZQGD/gSHIXCCDtvRQqf
         mPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749554168; x=1750158968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hI2dqT0ewY2kzj7s0/ei/Swu1TBfaU4ijVd9GNzdrs=;
        b=PeZ4+7qyVdgkPeTSMoEqvtqWO4nx6090lgktG5uqZCk02aoKr09BBtG8ZzPZ5o08lc
         2fMc5CY6MhBCLQCw5UWmpQ80nO7/JkV2ZGUbq1YPqAXmZneLEMank0T54HarFnkx8sjE
         B4SK+wNODmF1tcBwFThcb8ulhgQtiAX+BvAzpsmJTIAa9l3qANsFo/KczHMmCz9xLUyE
         z7a4186mIF2kxq94SElmhBDm1B7W7cChiPqVBqobJhNe/s1haqYLwLuDi0chciLr56Ak
         SYRrBluV1dsfaCQa7lfG36jrRwJjR5pjHVMA94lSDQ0c7COGr8j9XfCS+NtDeJvZqNmu
         OOZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpvF8VSQvkO+gykhH9k9aDS8ix03qUuoINLHlInYqeOt8yEvsbET0eFsAsltdvYMEFX5OKwfz3fW3JgjM=@vger.kernel.org, AJvYcCWQ77FZ05pW/Z4CK0Ne85/dXIQpGjOa0SAW8gCbc4M1ipVgmNXK3M3ig3Pb5eYpKOD0PuFZlxfjk6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9St9FMk8BLSOnF/4dY88Mrxd4D2XIQ4GGCFjI57GyHkmDZjk2
	+N3vkyj3Lg0P5/hCzpCxGyx4r2cYPMKBwOKYKZvRmREjbXLqQ7n5wUNLQpt+GQ==
X-Gm-Gg: ASbGncvTmRBb+ud0CofiZQ3BY8xsfYU6+Zo9v12alilAdbedrU7loZ7QRUgQrjyer9N
	pFHG5qTWH8eqmKQHi+MZf6wWG5SzPo+HP1+xqG3EZECkzvNcu9hMRYw/AcFVMp//fd4VaDFyw2c
	O9vUIEwD3nb/sWRn7Kh//Uq39XN27V6ecaxlQiHOYABP3BsrWHpkfxVcZZV3BNuOExjE+cSEc5X
	9pkv2tkxEwFNm7I4rfdFY86obnryHBe1Q4TQLOKeTtGh1VabuqjkHMdyVgNOewxX2dbMXwEkKG0
	TvRQEXYu4xEYtJa50zG7Mo+sU7CwTi+61F1SlMuS3TGEGrDT/v1UEf7zFKGm2cnTrCqnC8CdKHZ
	R6gRg1NJ4zqTnuifQDcnjBHMLNUSyPp7EGV3wEVWOMxdfkqsaYic6qnRgMUQ=
X-Google-Smtp-Source: AGHT+IF7BT5QXh90tRkhK/zLFoIo4VFwt5P5v8wbGtOKAd7GULY1I0tpQRrSQASSWp974nOdOyRAlA==
X-Received: by 2002:a05:600c:310c:b0:44a:ac77:26d5 with SMTP id 5b1f17b1804b1-4531de049ddmr22202205e9.14.1749554167813;
        Tue, 10 Jun 2025 04:16:07 -0700 (PDT)
Received: from orome (p200300e41f281b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53229da18sm12214459f8f.19.2025.06.10.04.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 04:16:06 -0700 (PDT)
Date: Tue, 10 Jun 2025 13:16:04 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Huacai Chen <chenhuacai@kernel.org>, linux-mmc@vger.kernel.org, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 31/35] mmc: sdhci-tegra: Drop the use of
 sdhci_pltfm_free()
Message-ID: <sucetdedqorwjsnw4k3vvzhq2ewd4tg7buv3hzi5basap3pr6n@d3xb6zdf3ijy>
References: <cover.1749127796.git.zhoubinbin@loongson.cn>
 <cee82eaad0392838fbe1fab8e2301e680d34c0c5.1749127796.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g4ed2hcukbwej34k"
Content-Disposition: inline
In-Reply-To: <cee82eaad0392838fbe1fab8e2301e680d34c0c5.1749127796.git.zhoubinbin@loongson.cn>


--g4ed2hcukbwej34k
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 31/35] mmc: sdhci-tegra: Drop the use of
 sdhci_pltfm_free()
MIME-Version: 1.0

On Sat, Jun 07, 2025 at 03:52:16PM +0800, Binbin Zhou wrote:
> Since the devm_mmc_alloc_host() helper is already in use,
> sdhci_pltfm_free() is no longer needed.
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: linux-tegra@vger.kernel.org
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--g4ed2hcukbwej34k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmhIE/QACgkQ3SOs138+
s6Fx9g/7BEbpJzW5xpWSwKNz+BLaVfI+Wvz5lpMJmfeYFiH/FDRZbGNtETzt/OFw
TVMEZQCwivNU804x2Qh6hg0mwkXJW1rNGZtV5IDdufZ2FMlkF08FWDqrQxVfHFqr
RtmybUjQex5+xcgWTwlf2uycx4DM/GrHmrez0cTdGSKjonUtKss6djdWpq1mwZ/F
BOnS8WsSwtbt/+gQaeMInP2OrRcPorTyIUndBUvu0iNbxrEIpCguU1FZ/Js1LDM3
ZBZWTh4viryODYS1SbjBmNJx/t1vir4B7q1E93nu9p3y9u+O6IqDVTUFwsGXgC/2
7Bzn/AD9SD7TXp6sP9wI+Fy56TRjRbur20vUydKkbeEA5iy/jarlG/wQCqfCM1hk
YFkAKey+s9XtrXKTYFFD7F4ZA0fyJiAZG5onU4M7AUI7/CWlUezdm820AY7rsMiF
hSpb/WSe4nKN7AvfCuAuW4srIdkI1dYLm3Bk6TWoZz4wFwC4t5ThBmNdLaYOZGJD
gDnEW1TfLHogjwnTdS0tlF4QQygMi5vcWnyGewDpC2xYFAlw70OL9vF2KhYhMRt2
jvlCbH9/ySj53t2FcgqqAE5sjBrxK9eeb37GZMb9ZSJMFU0uStDk98gJ6d1ENiJk
DM9ZzNFZWxhtmjuJBXd/yMGIM6w1XSV63G2Eo3dzuRwczP/Y4KM=
=U/5m
-----END PGP SIGNATURE-----

--g4ed2hcukbwej34k--
