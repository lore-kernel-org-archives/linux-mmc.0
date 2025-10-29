Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A122E2DEF
	for <linux-mmc@vger.kernel.org>; Wed, 29 Oct 2025 10:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761732412; cv=none; b=od4/MDkx9YfXwilKh2fR7PPUSGpJzHOns4+DRZqPPFDOQXedMCAz6LaoKr8JHOLDJuJbFvusZ/vO8R72L320Ynx16WjoJJYc9s+ZqCbtGzyiFehjA1ZItO1JxgkZuhIpW+3WV+tJptSIMlx+LM52T2EUJ0xqoxLB20nuu6DPpKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761732412; c=relaxed/simple;
	bh=R7TNYAS5wBwGQKOT7kKYUnlsZDdYhtWGEcAM+aRVqRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wo+8W6WTmRc4F63D2KpA7+R+0PMR84mvwju9QvPiwKgGWQW+UPuOiYchJD8V6mfXkkCjh4FLB4vOkbFUbXtby4UDDxyHBMadm8fN0DmktNhsOGlqujCpwKxudikh6Uld0sfxCxwnU/HxKwbFwCuZphcdyWazbX/ef3Ww215gQJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MghdHRNC; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MghdHRNC"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63bdfd73e6eso1484686a12.0
        for <linux-mmc@vger.kernel.org>; Wed, 29 Oct 2025 03:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761732406; x=1762337206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R7TNYAS5wBwGQKOT7kKYUnlsZDdYhtWGEcAM+aRVqRs=;
        b=MghdHRNCd+DKHOnRbuU5zj+pF+HeLdOZHYujzL4sKLfedPzWAvqy6e/HmuIJHI0ye3
         5QyhQis8kNOeUBkilNaLVbKPQxS5l+qWu8ZP4rMi4Pjt8aI7BVi297eigUYDaS6nnPiO
         XMMmJgX+4HbGYhWr0+ZqaqJlR5QHuKBXrvyw9WUGeR8Zw50vcj1ok1etrN54XkUH1BxC
         J6bQ7S5Awi93aTbe1mfkuv9roacYEOsiWLfaiK1JvFyQfun6bNe+JSwPxJs4JIYWBTum
         eiUuSWl/j7XZEbcJhE057zxBBqEejEa7rQ3KXuLvPV+4QuyASRBy4sdDUmvz5oj2v92g
         r8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761732406; x=1762337206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7TNYAS5wBwGQKOT7kKYUnlsZDdYhtWGEcAM+aRVqRs=;
        b=v1XTkp9x6o2i8hkxyOKSo8XIyLpE+gIGMlvxmrZGvCljNbqRSArMk7Sayy6LZKp3uH
         U9Be4j/c0mQADXOwqIFdIgxP79KWQT7tY3E2L9XmM8jVBTXCtUTJKx+oSsh7MKT9HmfG
         O6Dk32EgVV2eDdJZaYF02euGi0MQk/YroX/ERdhYi+ChU1huP5D3xbi5Qudw6bXQxZQO
         3mazPsjRAe9lywcYROpn74NH8QsuiRPijQzmpG24tbbXsuvJFGOUbZI7ecUt6HIJ51Dz
         1BmCIRWMrHxDv4Bu46g34rwg7l9Jx0bb1XsLD3TuCBdWi7l+ntF5eHFmllKEmlLDr+EV
         r8qw==
X-Forwarded-Encrypted: i=1; AJvYcCUlBP3Kzc4qDzv2IOcptWvOLlGcnzOaZsSJHIbiu6UeUjziAuvHflyWeMCQmlQkXHshdyDrDSYDkY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkRfyDrfYSxgeVukhRiQEd0vsKeVjL+BGDRIt8jBikd983Csn/
	4eXd1xG1uKskR4kOu2HhBB/MG158ofKpByvAZcGXVsO4FRUMzEbQtjMynzWxkDAMOD8=
X-Gm-Gg: ASbGnct5YcFY0vTpn5MnDDLWzFI9RKeBuYGXHdv9mLDPlPra4guhVdGyDuEiMrwTJ0K
	4Pzs1moIkMMXF8j/AGsGx+whhxyrZF1C1flKNTnLDXRQ9uaS66PzBKUcFgyB17sIpB+m8EJSqgq
	mo/O4hEUQqIc9bIVxbJcVPXQkUIsJS9h29hwHzNmDHSnsCvIOm2f3tZIGZDhSqDgRBTtz9X32fu
	dfx6p6CCJXVlndTiEi824DsRTUo47DPz9MpDCXVCrlmfkvLeRvBWeBtVrYNsGjAuS9wMFHMyHRg
	WtqCTUFxQOR9VwsMxGiu0P2aYZpLsUqDg8Fd+JtESCxoRb+I6d9UaN68O4eWsxNksutR52zM8xt
	ZOB3Y6bam1/vQje8qt8SAgc3V1nHQaqCh65+vjoQheQjCWOsNInqPiPYlVKJwkUuT6XCwDI3VxO
	sIoP2kOA==
X-Google-Smtp-Source: AGHT+IHRXJzy9yzlM8DWiE1VUER2udZQSYyk7sKg644Ac4f1zGydRVzswmr3CWYbQFSp2yb5bFrm8A==
X-Received: by 2002:a05:6402:2750:b0:634:c377:e1ae with SMTP id 4fb4d7f45d1cf-64043325c9emr2072388a12.14.1761732406260;
        Wed, 29 Oct 2025 03:06:46 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6402a6be2eesm4054053a12.16.2025.10.29.03.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:06:45 -0700 (PDT)
Date: Wed, 29 Oct 2025 11:06:44 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: ulf.hansson@linaro.org, chenhuacai@kernel.org, 
	dan.carpenter@linaro.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
	zhoubinbin@loongson.cn, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, lkp@intel.com, 
	skhan@linuxfoundation.org
Subject: Re: [PATCH v3] mmc: pxamci: Simplify pxamci_probe() error handling
 using devm APIs
Message-ID: <xeocbqo4zmdshchzmwvpyv6spch547cwjdqimmfrwtgs5wahbe@ym75aj6663zr>
References: <20251023145432.164696-1-rakuram.e96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="if34ak3qbo6hovkh"
Content-Disposition: inline
In-Reply-To: <20251023145432.164696-1-rakuram.e96@gmail.com>


--if34ak3qbo6hovkh
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] mmc: pxamci: Simplify pxamci_probe() error handling
 using devm APIs
MIME-Version: 1.0

Hello,

On Thu, Oct 23, 2025 at 08:24:32PM +0530, Rakuram Eswaran wrote:
> This patch refactors pxamci_probe() to use devm-managed resource
> allocation (e.g. devm_dma_request_chan) and dev_err_probe() for
> improved readability and automatic cleanup on probe failure.
>=20
> It also removes redundant NULL assignments and manual resource release
> logic from pxamci_probe(), and eliminates the corresponding release
> calls from pxamci_remove().
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202510041841.pRlunIfl-lkp@intel.com/
> Fixes: 58c40f3faf742c ("mmc: pxamci: Use devm_mmc_alloc_host() helper")
> Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>

LGTM, thanks

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Best regards
Uwe

--if34ak3qbo6hovkh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkB5zIACgkQj4D7WH0S
/k5MFwgAmXg8LU+2YUmlwv6EhqtvdIyYkH0TWb0g80d+RImXaQuI/g9tqNzydx5p
zOvoRLskbQadH5duJ+TPeuatZkdWDXjKnxKeAa3UqkLICWtSrOhImwbC6HlzqclO
JKBZYdKDThmikKFx/znRMIi+hLAFAjzUmMO6ebIjb/L4j85nUD3jUtopmYd7Wv5q
KSDIn8Fb+XxejoeuFqtS88QXyJ72r2PUeX2PhGAKc6/8eDZUbNnYBxWHc1bncCHP
5qkKOauJPOLKzWFLmM/Dnbsc8dwiYYXJ61vqxS8urCGdE57hb3w1w9pUY7EDioZE
TlzrXUjdzPd/fNmb1WcpXXkU/WLJJA==
=Vlt7
-----END PGP SIGNATURE-----

--if34ak3qbo6hovkh--
