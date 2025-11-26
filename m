Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1404304BAB
	for <linux-mmc@vger.kernel.org>; Wed, 26 Nov 2025 21:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764193355; cv=none; b=i1LjsGvzBYUXhi7oPfKwGhh0vObUzQOUYMd1uvsdbWYjgW6m8yEP3fHCBGOu+EiHbYJC/nWFn8l5lZ52MdXf/hTbRMbVpoXwE7XXrmDR5LkG6CZFrlxdDRb+HzpZ9kh4Qhk8Iz1JbEEVdd3m0t3KcV1KhpwOqmtXyuRMrDcSZqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764193355; c=relaxed/simple;
	bh=Z/cWVeY4EO0d1WPO8oChRnTAPR07FnDjU74OyFdUVhw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PJfgKkt4S1CEpehEYhjah084eqFpYWfwIhfkGIdTW2a1iLiJ+xgV+HvMzoh2PmtvTR61P0/uz3GI1CxUIUkjnkGtRUP7DGKOT5v9Vx4Xx55IIsKFTZwfGuRgRpv68LkMBADd9qXruc0vBM4mfK38RZwOWOnJ/ARUTI9t7swM8os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUdb6U8S; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUdb6U8S"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b2dc17965so241299f8f.3
        for <linux-mmc@vger.kernel.org>; Wed, 26 Nov 2025 13:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764193352; x=1764798152; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62GqJfJXdc2auRqwcd2K803/zaGb+10AHjqIsFHPDVU=;
        b=dUdb6U8SB/M0aoYecWRHhi1laSIxIgS0ssNOhLVHk699b4j2dymv2xAaV0J2JOTlh8
         vMLn0BmBTsdb4WtA9pWHnBzhwuPOrsAlUlf8P8SMRbO8jqv2oFUIP92VeIfc+ehHyzp0
         ctVnhMY1IDXxZOlPBqYULGdr7GLSyRPq1HWAABG22oM4JsNf021j8rUs2BlHp5J1tVuG
         haUiH9LgSmAxfLulnN8IURJw+uQt/NmHDrVLLtkg3COW0PGE4ygp2iiqGGQlYcS+d1qv
         Zr5P7PWzcnKKoWFaHLdN++XV9Hd+a4SuHt3LnvTYJm1SzlLi9MNco2c1rQQsrvFaprF0
         mZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764193352; x=1764798152;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=62GqJfJXdc2auRqwcd2K803/zaGb+10AHjqIsFHPDVU=;
        b=bVMvm3Q419Bi4oGHxUsIeKhJzNTRW+YMF+4e8vsYeMPW1LxaR/WtOYpwSMn0TyES8a
         D3C65qkfE2rG2rWIIm50vLjDdU9D0Ej8xS1sODZLsCwHmZSdfc2EOEEC12dDigaKu55q
         cwgOwLLZfbOgQzXjnW0GuJJ5kCm4/MeGPuvx+knYJmFZgG4RDRMKm9jAtMFzwCTz7Rf4
         ELMje6ySD496BGDFHGIzp7a8Puflx8Mu/3rixalg7dJE05dqzQRbLfXXd58X0Q+Ui/Sn
         B8v2TSa6Zg9BtJ00VQ56v+ig8fyMn2CU2qcpRjZjV3DREca1EWJTWafmcOlGWVVSJ994
         Q7Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUAEnYnhDRyOQUTESI5XjDktx7yAhCfMTKY3drbuJ8n044BVbXymLoaTgsgPVKXuRbAQS7iepvC08Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcdhYDiWuEn7kPYRcIpxUZAxnunuYtlO6wIYr6//ipwK4thCCK
	GO7z49KpqIcVqbQfuDedsJP4MKs6R0ljqPfLv+fGPklj0Zmzup5Cxp56
X-Gm-Gg: ASbGncsgTJInl+5SsaT1ll2Ok2KDPtmtsRe4yt0HSxhTOByEaLDtWN0aG53SYVhtFqE
	qYvJV01UH3BCY2JVt9GahoJJzkFcvU0dxz3aM8s3r4tWXv+HiPk5rx6irJI0SBZhAO1wC7qUYBM
	/qDWHku5HXRHAjUY7huhb6SIEt5QYwX7uDbGaEoMMWswBFVn93h5sHbU98YLR9su7tZjrxyuT//
	DMcWKRa2CszOf6mRKylIMZoUyV71y+Gj3PSYczhSe05AYZ/1XSsLDKoRcFmamY0SjYC3lVRYIKg
	Sv+QiXEgX6vPwN+cdMxLMzuBZs9nPHgCb9cV9JBqBa3TJUXPk1w7xGYkGhrGN/kxoWxgxYOrN3x
	gDeZRIZfSHk+FdgkgEDh1Vr1uKXaUJ6/ZZN0g+8wtYCFJBuMKKWPqMyZvdK7AlA37EWf8Z6uGuG
	s5hmlkmN6mp1wNiy4lua04mLMxaoKeIkwBpJQDqaXA02kUoLzj
X-Google-Smtp-Source: AGHT+IGLIzJTVKFGod+AO4xb84kpn5bphgrlRffZAqoPS2kzsQhTbQa01DQNskvYLIsKkhq1f65O4Q==
X-Received: by 2002:a05:6000:1ac6:b0:42b:3302:f7d0 with SMTP id ffacd0b85a97d-42cc1cbd4c5mr21463073f8f.22.1764193351974;
        Wed, 26 Nov 2025 13:42:31 -0800 (PST)
Received: from [10.188.249.90] (net77-43-118-186.mclink.it. [77.43.118.186])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f34ffesm43761136f8f.10.2025.11.26.13.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 13:42:30 -0800 (PST)
Message-ID: <a05f579671751c47cfafa7ada6ba631261b7c598.camel@gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: Add quirk for broken manufacturing date
From: Bean Huo <huobean@gmail.com>
To: Avri Altman <Avri.Altman@sandisk.com>, Avri Altman
 <avri.altman@gmail.com>,  Ulf Hansson <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Date: Wed, 26 Nov 2025 22:42:29 +0100
In-Reply-To: <DS1PR16MB6753397C1F5EF5804509D39EE5D1A@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20251122070442.111690-1-avri.altman@sandisk.com>
	 <20251122070442.111690-3-avri.altman@sandisk.com>
	 <4a9236e8a4172437874291da221ef8b82d4a1126.camel@gmail.com>
	 <DS1PR16MB6753397C1F5EF5804509D39EE5D1A@DS1PR16MB6753.namprd16.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-25 at 14:22 +0000, Avri Altman wrote:
> > Avri,
> >=20
> > We=E2=80=99re aware of this issue and appreciate your attention to it. =
Here are two
> > comments regarding the change:
> Thanks.
> Can you please comment on Shawn's proposal to elaborate this quirk to ena=
ble
> flavor per vendor?

This quirk only covers 3 years by mapping 2010-2012 to 2026-2028. After 202=
8, if
vendors still refuse to update to EXT_CSD revision 9, they'll need another =
quirk
probably. Maybe just add note for the quirk, this qurik only cover 2026 ~ 2=
028,
for year >=3D 2029, either changing version to 9, or another quirk. I didn'=
t find
out a proper way to let one quirk cover two year ranges with the EXT_CSD ve=
rsion
8. =20

The root cause for this is that the eMMC spec poorly designed the year enco=
ding.
It splits the 16 possible values (0-15) into two non-sequential ranges inst=
ead
of using them sequentially. For rev 8, codes 0-12 map to 2013-2025, leaving
codes 13-15 unused. then  being used for version 9.


Kind regards,
Bean

