Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337ED21C160
	for <linux-mmc@vger.kernel.org>; Tue, 30 Dec 2025 18:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767121025; cv=none; b=YTl2CEMQTd5Z4afysIN44nGO4pZUNlt5F1g6v3miY9g8X0EBNug3HTipqibeovbFITPwb5Y1k56PAIG3yOEYNEc00qfW2dGD/TJxhpFMgyvRP6XeUJ9FYjyobyReVfLbLpOLjD2QIn2JAYOjcT2RuGpsATLFU3gePExm9JXejeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767121025; c=relaxed/simple;
	bh=iZ4S3Ous4NBoV4+K7EyEggznX/9iE0fhnu2KNtimeZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPHs6nyiFuWjaDr7zfySOkPsPV+6nvfsogM+DbbxwxybcMc4yEhI4QX71bLsUaq01LSqSkhSYcA1zQKHvfONiibsyH9Jsia1GqBVGh8btNQxsmjVQdNnCZu2gHEvLWLZpQssFnN4hRtWwSfrJVrgwTvuI7czAx2xZvX/+3ByGbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NQZbzfZe; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NQZbzfZe"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so12123923a12.2
        for <linux-mmc@vger.kernel.org>; Tue, 30 Dec 2025 10:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767121021; x=1767725821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iZ4S3Ous4NBoV4+K7EyEggznX/9iE0fhnu2KNtimeZ0=;
        b=NQZbzfZezIMvS6dzvJ9kebdxzRmzP+R191jJjRdviyOOaH1d1izXFFEGCx+0GAQx++
         k4pR42T4teujTIuGU/Apag3VA047251H+AHgaberz2IvCdcGXd9A7X9TI0vEGdmFgJkp
         /LVSB6cr6zcgS9QEd09cF/X1erMEwBPJi32EvGx9Q6r6eITFruU4y/Ujv9nKC7kdo88B
         X4T3psYhuCftLepfZHN3fRKG/kEl55m9ATjyLSAvqlHipi7fe98z9b4vEjWYTQbTNVcR
         e4pMfdF+X3vBCdTQlehsxIcmuLxLUPRnGQiFZdSd/Or9SgYqIgcoeajU/OBtVu912DsF
         f7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767121021; x=1767725821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZ4S3Ous4NBoV4+K7EyEggznX/9iE0fhnu2KNtimeZ0=;
        b=uzCl9dq4/c5MRqotautVUYSvhfW78/drQA/X00PRJs1Rabbd8tL5u+XDg7MSJ3b9OV
         P2loDwnNhwVqmgLlMo/p438FqqlHUOxUO/LZr4RbXj2N10hLwq9yIF2VeaWRYkvHRyXl
         j3Q36VvwgZzc9QzRxPXT2Aaz7vcOWj/PLxN7tgM+CpBg5tuihyBH2bOzx2N8Bd2HurRF
         9dgQ0eG/11uFWvOArPs8q2j9ztJKyyJIaIwQkeqQbt5qVi0ilVTioj/I04TM9WoFhBqn
         KrGUdXGJUnrjXvruY04evNhli1WIVUB+FSfJ41m7UXeI+PuzofN/HUMTfBPCCMCwyRfj
         PVTg==
X-Forwarded-Encrypted: i=1; AJvYcCW2M58hgV+5LUhvtWCTM1myCX53Q8yilOO2Cd7AZF2ZoEddI+6QcxEwz3yUoEY9KRUGkqQf3JG3Tug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrLLVzqvhnf7Be6yCCLb2OTF4/nyIVunF/cw+PCGITRDvw+7LI
	1nP0X+92EsMkl9gcAk6Pe6vvQmfDkfpGqBBJ+doEKGQ92Cbd3HKNx75steuoc7wxDImCp058kid
	FAw45
X-Gm-Gg: AY/fxX7Nj+RwMB7o3bsUv3+RI+ZI38cyO8CKVpqndw+UUTJ+heOmfuhIMywERsQaskv
	yGCCPKK9IVyeux37zxonpCahVCEsK7DIRLY+L8cSyXQ6i0C6/lj9IUUmW7cZi16E/WyTc/0gdFD
	uMEJulIHVS2YO5CDBZeQlsXyoeA6DOVGWIFeOJHQvNKNHX2fxRvwgjCC6pW9iwNyPVlZ7cBIavk
	en8DT3M8Mcxj1hGQR5oGVDgXA5GSJAfC0BFEaoKF6KI8OXCeJlCZsIyw45xfd/z5Xwb2SR4inNZ
	E2lZlREw6/4h/wjYJQbPNzDq2q6yfItIKUGDC7rY06ms9/MdzoKgbiQO/NA7q7/gOJsgZV/jJya
	dVOgVki1sCx3a8p1n88AmRScCZsY/eZFwErHo9KoM8xv1xAbDaVHk84SBy+GZDex61Ca4MBb9MQ
	4qjsVZQ7095GYvK9od
X-Google-Smtp-Source: AGHT+IHX59JbGHOKLai3o+izBsjfxrJQN6eH+wJdD9Jv4Vjwu2ACPDyrp7bHX1O9h4VNAtugM0iy+w==
X-Received: by 2002:a05:6402:2706:b0:64d:f39:3fdb with SMTP id 4fb4d7f45d1cf-64d0f3941a6mr28589514a12.13.1767121021539;
        Tue, 30 Dec 2025 10:57:01 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-64b910601c7sm35301468a12.14.2025.12.30.10.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 10:57:00 -0800 (PST)
Date: Tue, 30 Dec 2025 19:56:57 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] wifi: rsi: sdio: Reduce use of #ifdef for
 CONFIG_PM
Message-ID: <7ngbudwaq4rdb6u4r3gn6ub7hqctq3qgienciuylgqsglougnk@ckdj3wrhzyqy>
References: <cover.1765968841.git.ukleinek@kernel.org>
 <f291cca2741f6ac994b2bde1fb9d21194fec4d3e.1765968841.git.ukleinek@kernel.org>
 <21f1759416ae907b8504605cd8a814dc85a99a0c.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="enyljlgs5qxi4kp7"
Content-Disposition: inline
In-Reply-To: <21f1759416ae907b8504605cd8a814dc85a99a0c.camel@sipsolutions.net>


--enyljlgs5qxi4kp7
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/4] wifi: rsi: sdio: Reduce use of #ifdef for
 CONFIG_PM
MIME-Version: 1.0

On Mon, Dec 29, 2025 at 11:36:02AM +0100, Johannes Berg wrote:
> On Wed, 2025-12-17 at 12:09 +0100, Uwe Kleine-K=F6nig wrote:
> > This drops two #ifdefs (which is good because they are ugly) without
> > changing semantics. This also improves compile coverage because all the
> > code in the first #ifdef block is now compiled even for configurations
> > without CONFIG_PM (and then thrown away).
>=20
> This didn't build, and given that we never got 1/4 I'm going to assume
> it wasn't destined to the wireless tree.

Yes, this depends on patch #1, I expected the series to go in via
whatever tree sdio usually goes in and didn't notice that all users are
in the wireless subsystem.

The kernel robot also found an issue[1] that needs addressing (probably
by dropping patch #2 from the series). Will look into that next year.

Best regards
Uwe

[1] https://lore.kernel.org/all/202512210032.6Skz9prt-lkp@intel.com/

--enyljlgs5qxi4kp7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlUIHcACgkQj4D7WH0S
/k7Yvwf/VqVh/xAAdXcu+Daixp3XFFt++ZZUJQnoHxOoVrw0Sn8emGqZ/RvEYROc
dYGec7UrjwBQE2UhIfWFthRv182lSY21ZVk2XHgndhgnZS/wqX19od032Mj47WoO
TlusjIApE1C+HUDxAVFbKlAI1lclkMT509B57gGI+OYC1I8pHPjEUumPCvpnz0uy
CwkQnH5KVqDls5cSG/4NXs4qFas0di/BezeCthbBVv3i3PovRt6m+/mQK0S23qZ9
AcMugtV+zX6S1QbaY7wuP04V0PtK+iuzmKWmYqEME+9KHnZKDtMVrEjOVR3jaTm+
Q/WNsLJrU1PD+g6qr49ztJHhINRV0Q==
=HqsC
-----END PGP SIGNATURE-----

--enyljlgs5qxi4kp7--
