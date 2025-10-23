Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7767C306B02
	for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761224309; cv=none; b=bARgoJeGndiZUbh2B13ep0edDQ5isU69Zxz6Y6Rpx14BDsgQSsrs689w9x+zxNtCXWWm3K0ex6f8CevIlVVc7U9yw/MkyOLTcghsw/YTlH3VXZAoZ7/LJ2GpHT4NIRgYQUPE87HyprmpnbHC2IY7BjBXuZRzxp7OV0QwEVAcR5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761224309; c=relaxed/simple;
	bh=xjeehlY0ayWZ3bhz/kWBr2+l/5odZE4178lrQkJI3IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSZ47tZFwSsv8ThdO+DTfKYBwG475+dQ3WKI+Fnlq2d6531iiOMDtdIeO9u8OmTserfdE7oj9e9ZmVqs8kiYvScMe+VHvoC+XSBgOLOTAmiUfXMVSQV64zAI01dq6zGTJjp+R6wb4pYSeGXwP28w3wKmE7irU4otR2nBBpybdK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=f6yIZXKu; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="f6yIZXKu"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b6d3effe106so190941066b.2
        for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 05:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761224306; x=1761829106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xjeehlY0ayWZ3bhz/kWBr2+l/5odZE4178lrQkJI3IY=;
        b=f6yIZXKuOJEWRW81QXwDzxPRtSUgK2O3Dq48iDRNZ2098e5Yd7PsPoXHoTk8r6hj/H
         msU7FG9vGt3rG6/EYfn7ZlPopXpbw+/9/9q8GPkANeB8EGJFhDaR6DgPVQOPUPjI0QOp
         CXFayOUmIxrkE0FQb3hn/KJh/yPL+SUnKNf63tWkgR3BN6uEFdNoKCZyq764Vw5XW6i6
         tgcrw1jlGTzaJbcpuT1b+BXyZUg+sTDdPhNGII2fZn2LxRBYuBNAVpGv5ZT5naRf8cdA
         luLvA7bMae9nYU85kIg/IiN+SGrDNMw9IK7j3T1WASg34ZsZt51hkNgmuHzxn/Z3QHes
         rcrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761224306; x=1761829106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjeehlY0ayWZ3bhz/kWBr2+l/5odZE4178lrQkJI3IY=;
        b=QZy+93XSZEMnx1cTLCfqDas9fpUF5/jUBbrPkx5ROHDiAZ4kJm7oGev5knqjzbkqX8
         tXPHh/9/OoFMG64vJzoNBuJsueRKZXIV8SofRZufjfrDne/mMMau9UKfX7p2fCr6G05E
         5WNEuKM8HKI2CtROYEI4X1MIwV4+8nvOcSQmajxWx+M9MeascFdtWG2Q52M0CHWT4Nid
         Y/daTdXbKWanI45GmUBSsLuWtklRECePPovTCmfJLdRv7ut5wXnnQumPU32GsrXzTCA+
         dS2xUm2THXGKvckByH5wU0y+DgWJPw4ffPMP2eX3D0cJQAugPseyHmUJfB8KO9x7gw12
         +vNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO59vIlVkKNLF/gMXGBNpEzW30EakXCIZLs+Ve3wrxilATrXCHq6dODlAvfUX8CMcwFU1qGfd7Y7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKUFpkIJYDxckQdcT4EGw/ZpypGaQTSJItfkl9Ge1fFcT7N+ay
	PZkkcf2Q3bKjUOiZUfdztJa62jtsDlm0Nk7wxtuMNA26EbPPK9FwB3i/HkRhki35GEc=
X-Gm-Gg: ASbGncu8xFqG+TyqaEfpJrZyagw1Akv+j6Ekay0vr81tSqP1FbVCAAhY3FUL49b4YW7
	mh+8ZTlB1rkAZWOx/ePrxB80By+UoX11FPgCTx82wGtVmspVxfRfluAyHV20Ntp6h5xY04uYk5P
	+4OImuxSPL8bLVvjEberEPX9AlPwwmyw29vZQrOgc5fAevVnD49VfmdZWu5rsePbjoTbeynnPBn
	y1sdADmw5qEDsZ81guN8BTfhtwlmutVhRcToIwdfCunfbp9ueEK2OJI8vxw9w+9888B7GGpjDlW
	R9rraVq2E2qOvN95sjq5f9oBpkufiaAkHCkYA/D0yhr4uVzNkHNCa3JU1C3wWiQ6BDcJDBlN967
	rIBS4iLX6IIVIjjHWBKKMVRDRe8RtejFs1fV0ecNEF2xLeB4cUiWUsXIxoPEZbQ72EVo8EKaM73
	tGqNePGwzvxMu0Lsc=
X-Google-Smtp-Source: AGHT+IH8+w2hScL952t99dlA5WzytVfJZrsnO3QY3tAYI5JKTW4feC+qQ/6KlSZu1F3zvRjTIGTR4w==
X-Received: by 2002:a17:907:5c8:b0:b40:2873:a60c with SMTP id a640c23a62f3a-b6472c5c6ddmr2987323466b.3.1761224305719;
        Thu, 23 Oct 2025 05:58:25 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b6d511d11eesm227985566b.12.2025.10.23.05.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:58:25 -0700 (PDT)
Date: Thu, 23 Oct 2025 14:58:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: chenhuacai@kernel.org, dan.carpenter@linaro.org, 
	david.hunter.linux@gmail.com, khalid@kernel.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, lkp@intel.com, 
	skhan@linuxfoundation.org, ulf.hansson@linaro.org, zhoubinbin@loongson.cn
Subject: Re: [PATCH v2] mmc: pxamci: Simplify pxamci_probe() error handling
 using devm APIs
Message-ID: <itxfh366j3yhshvp5abji6xussdk2fc7zrtvc3zzk27y5ouwpb@fvvxnpg3keus>
References: <pvid2ycmgbkbmegnnzwl4hyev6e2smusxk5olkuqxfwxzykz2e@jlvolirolrxl>
 <20251023115819.11094-1-rakuram.e96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wntpsxgdxjl2stru"
Content-Disposition: inline
In-Reply-To: <20251023115819.11094-1-rakuram.e96@gmail.com>


--wntpsxgdxjl2stru
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] mmc: pxamci: Simplify pxamci_probe() error handling
 using devm APIs
MIME-Version: 1.0

Hello Rakuram,

On Thu, Oct 23, 2025 at 05:28:17PM +0530, Rakuram Eswaran wrote:
> On Tue, 21 Oct 2025 at 14:01, Uwe Kleine-K=F6nig <u.kleine-koenig@baylibr=
e.com> wrote:
> > Yes, I suggest to make restructuring .remote a separate patch. (But
> > removing dma_release_channel belongs into the patch that introduces devm
> > to allocate the dma channels.)
>=20
> I believe ".remote" is a typo and you're referring to the _remove() funct=
ion.=20
> Removing if(mmc) condition check from pxamci_remove() can be handled in a=
=20
> separate cleanup patch, while removing redundant dma_release_channel()
> will be included in v3.=20
>=20
> Is my above understanding correct?

ack. remote vs. remove is one of my most-committed typos :-D

Best regards
Uwe

--wntpsxgdxjl2stru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmj6JmwACgkQj4D7WH0S
/k7lgggAtXPs8vnFmq/fg2Ty175E+kYXR84uN5u6308vPn6bCdVgHaU62FeL4JO1
uCQWviLkqvGqfNYKlurKsn4vSdeRK1katvsYi6BTqanuYAMcZljEO8ht0vuTYJqr
KoFx/M7XEQun2GqDJvDr4weHJ2WgdFg4gCFuFnFxEpW2fZAaQ+MC0U0Ya69Dwf5B
dH5fBXIdpV/9HQSceLe62tE9h5Rv3Dn7tU9FcYS5dI7vS883B1BZkrOb4e7oUary
ED+3wJXueKXHod0aF0agKQSVyrJ/9d7XYfpQIIdYpnsLyZFAERarM+6OtWl3f0Zt
KM5dl0uekQzPkWrWcGV2Ig06F6bDlg==
=frsd
-----END PGP SIGNATURE-----

--wntpsxgdxjl2stru--
