Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0489130DED4;
	Mon,  8 Sep 2025 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339410; cv=none; b=MXfiLYmCKpnq7tpPaCBu/uyvP63AXA3fi06F7oKbPyCD71lXXTSlTNXf4WgbmUdomDNDP/XKDzIePAUQpRMJSYn1F8hXiGZACjYtdTbZVoeg4p3MISgju4gIS3ICPy4piQfGWez9HVLp7IwLYARGKq7z0oFa4Qx+hkx5Er1zzqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339410; c=relaxed/simple;
	bh=NE9xksFOdVcKp/dgIaAUqQMJQQJUL7f/VO008GPiXck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldbo6aW+fk4hs6arIHNEO6Yncx/ttol7/2aiu25fxhc1cUul68qUytEy7npDjJKZWR6Wg+EeShh2Wjk3Fo+RPTJdxxCIKDS9m6TWmdD0i4yH+EdBFzHSHt1uV/DTfosEBAyPmwJdI/flyYFBnQ8zb48IDiUOyHGiwTIq6VZgHYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANemtJZz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANemtJZz"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dec268f2aso1060165e9.3;
        Mon, 08 Sep 2025 06:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757339407; x=1757944207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7veukEnVp6GrvfVjkMK+b/oGtMaJi6sCw0gsjNd6Qs=;
        b=ANemtJZz1IvVDuYpee2GU1KXvayqPuxn36JTROVJ4RVZY/CTPGcvzj555A+D6LEUmu
         Z7UxhDj3zKVKiYGcXU4F5qDSmh8+FJUN9qTVKqVamCAKOeoIJ7N6fSP4k0jetcv06Uyg
         cXd/KOsjSoVGFhvcLJh4uPDoIpq29FjTeDwTrxes1E6nqO7Wv89NGDER/iK8cFk2K0bZ
         DppjCniOVz+1K1khmS9y+Ve9ivXbveYO0CmyltggTYoJhQuositF2HASvJhKsaZ4W6Yg
         638nLydH8ml7CXSH2ZRpPVa0ui6KQE3RwQizU/TiODpGP/faOpCBiEogaspYj0KRY7ce
         dgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757339407; x=1757944207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7veukEnVp6GrvfVjkMK+b/oGtMaJi6sCw0gsjNd6Qs=;
        b=dQ9vUanInGRBn76QS16yWd07S2eQyNHFlfYez0Vzd68t0v+a4i0mlrmSRUHKeyplQk
         MxVtjQNt5mY6Egr1JApZuWAHFXDhQ17NIFA/ts3yFDga9ebjSlGWOi7Qprex+pYKan+q
         eYgpoQw7xvzyLL5OnaVv5hr9lyXg0TKaU34Tv9beMoSO+LHVajVTbhvfDrECcnEF8z+O
         2/O5r8SrTB6Y0Bb8ZpWtJG1ROCHl4OpW1YsJIl6qmCMEx8fEY7XMhp+WYuChFFNuabGD
         vFytWncIrP3Xt/aOo0Og0v27cJVBao7XvTxmyDbnNMl0cAOVKKY+5DhTdCaJeOyaGggD
         C2VA==
X-Forwarded-Encrypted: i=1; AJvYcCULC/jeLKMqBom7yTQSfCqKzuigHr4w11J0chlRSMBidz2DumgoOwqbyTI5KEqynilM2QAU4sm4hGGYWwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxicWbYE7LIPo7MtMtP5YzutQzJpXtOoYxc+Jb+44PZUDhDrIas
	Du0TAtAmbRGpW0JRksWGxXsfFhtg/sZGELp+ST76Wryerx9U+0ulL2ut
X-Gm-Gg: ASbGncvU8JaBLAM6JF9w1Op/YF1MIZHDcGowWhAwrqbFUZlNzvem0xPTwIoyG91YrSm
	cCDriY6RiFIS2miExE/my0qd/BMWoXl0BU7m0CE1F44lGpsUwFKKaO4IJer09NP3dqRGFnOIREn
	ncYPmNzorTHZ5HbAuLwV3oCcWokGzzGhOBNWSNp0ZUrftTg1o0h5fi+tJciGLpe0VDN7D7HuCcV
	LbAZN0xDfO/6l1sVeI2nFU3ZGW8LfIJpaw3GTgQHBIRxZcDPf1l5jYOqpnjBWP/0GUk3F+nUGGG
	v4tTbcm248CED2aAVPO1fJYgxR33OSPiMm14r3MYmeR0wak7Y8hBBSwAKMlRqy8Ktrpg/0N1Th2
	/87XGBu18Fa0oZIbTe9dQM9/Dq5T6/3JFqc1BkS2FEZvoWsOyjbmiG0EUIXgO9C2tmEph5L8ff3
	VLEA05eY+5
X-Google-Smtp-Source: AGHT+IFnQTfMAEk7b1oBy07c3ZuOKtJCPSX+KHHl8137PXEZ2FG0x48RG9TfY60Fk0nPHOU7Rhd8EA==
X-Received: by 2002:a05:600c:1e21:b0:459:d5d1:d602 with SMTP id 5b1f17b1804b1-45dddf7762dmr77422515e9.3.1757339407154;
        Mon, 08 Sep 2025 06:50:07 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd8c09fe6sm63715885e9.9.2025.09.08.06.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 06:50:06 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: ulf.hansson@linaro.org, wens@csie.org, samuel@sholland.org,
 Xichao Zhao <zhao.xichao@vivo.com>
Cc: linux-mmc@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Xichao Zhao <zhao.xichao@vivo.com>
Subject: Re: [PATCH] mmc: sunxi: Remove dev_err_probe() if error is -ENOMEM
Date: Mon, 08 Sep 2025 15:50:05 +0200
Message-ID: <5918619.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20250821091721.546580-1-zhao.xichao@vivo.com>
References: <20250821091721.546580-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne =C4=8Detrtek, 21. avgust 2025 ob 11:17:21 Srednjeevropski poletni =C4=
=8Das je Xichao Zhao napisal(a):
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> Therefore, remove the useless call to dev_err_probe(), and just
> return the value instead.

It would be better to print error message rather than dismiss them.

Best regards,
Jernej

>=20
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index ee4a65b0a22d..8dd1d2409a26 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1371,8 +1371,8 @@ static int sunxi_mmc_probe(struct platform_device *=
pdev)
> =20
>  	mmc =3D devm_mmc_alloc_host(&pdev->dev, sizeof(*host));
>  	if (!mmc)
> -		return dev_err_probe(&pdev->dev, -ENOMEM,
> -				     "mmc alloc host failed\n");
> +		return -ENOMEM;
> +
>  	platform_set_drvdata(pdev, mmc);
> =20
>  	host =3D mmc_priv(mmc);
> @@ -1387,8 +1387,7 @@ static int sunxi_mmc_probe(struct platform_device *=
pdev)
>  	host->sg_cpu =3D dma_alloc_coherent(&pdev->dev, PAGE_SIZE,
>  					  &host->sg_dma, GFP_KERNEL);
>  	if (!host->sg_cpu)
> -		return dev_err_probe(&pdev->dev, -ENOMEM,
> -				     "Failed to allocate DMA descriptor mem\n");
> +		return -ENOMEM;
> =20
>  	if (host->cfg->ccu_has_timings_switch) {
>  		/*
>=20




