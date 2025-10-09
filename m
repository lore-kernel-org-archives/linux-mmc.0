Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091052D2388
	for <linux-mmc@vger.kernel.org>; Thu,  9 Oct 2025 08:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000233; cv=none; b=di2fmW4t3ccSqGSAlJBYDYlg9t9dzXPh/LpDmXYsvS6SHmgW6JCeBf4gDoQ9La38yR3s4IqOGxRZOKQWkdH45d19pP+YrAvRM5+AihFo2v8YiIsuo4G1Q1EFxvTIW54sdIFNAKi4n+0gKfoG9JDFym/vRWPbdpQiKATYUWeR6zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000233; c=relaxed/simple;
	bh=HiObraWyRHAfPwn43/lMyitENL/dZ7TO4iiibkA0miM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dm7AlOW89sfGOSzPRLaYvEfoSIgHPg8mmyYREtbUIVna2wvcTJl/2yArrx3t6l+Z1tNdCInqMgez032sd8weybKqzqkFAaL+UocVFn2NVypChZ25M33NMlT25hENHHHSNj1P2rLObszgDRerR5tyZzPkitYCSjlnK0z88ltjf9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3XY8CPBK; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3XY8CPBK"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63163a6556bso1432905a12.1
        for <linux-mmc@vger.kernel.org>; Thu, 09 Oct 2025 01:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760000229; x=1760605029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tehd6TigRZIFeKvV43jFxd5P2fyWIrIsVUguA2VauEc=;
        b=3XY8CPBK5DseYyZ1JuEPxj9aQz0KBjKci967HaxaHppELGY8b33YVP5GIGxavv7NxC
         prU0mdVhhTyJxlOoyxDG5xdQ5RVrnZffhxiOXPZAbNNJy8x5IFeU5jy2KwKFqYjh2ZGy
         CK/0Mub/M61BegMLvGJUBMFn3KlcNA+MFJBwpxgpVHUgpDs+yT4JsTNZEgZmTElWoNZz
         usBNYWkDRAP8zvOv8TyhIq38/78m9LbgijPTudjKoya6RBTt2vFRf+n9qrpwLvwwmd5B
         Kkb+4oVXLT1Ll3lVsijtXv9p5cnxXjb2acFvO7Xi5a7y7B0pjKZO+qGKqkV3QiTYVKUp
         EgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760000229; x=1760605029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tehd6TigRZIFeKvV43jFxd5P2fyWIrIsVUguA2VauEc=;
        b=DbTYX3GdOwNjAR9nq+PGA/8ZtRgJEvErrXp8stW+IlBjh3d4cNLLdKnKlHGP6aWO27
         spW2cJ5pxuQBD7u/M2cMlXPWE31PEk6T5S02QbFoLigOhD2Ku+bTwySeLF9jFidCVlW1
         ppynJp+T76UIvrAUb59A7yL8jnCwTXuBYEZ2ZHasWIt9CrC45t1LaLzV8/j6JGuthI4O
         g5fBhehAUuhRgxRNMSQKLPhgDDqXwsuiI+LOF42DyQvkXeaJvxzuMo0l/x261fipJzsL
         XuNgqjqHDLzRDHGBJVHHPjggUkjp45KoQ0UfGqnCe4/1bd6ZqBnTuMsac/WBlrQ0S9J0
         KtbA==
X-Forwarded-Encrypted: i=1; AJvYcCXM1NHQk4Rlang3UxEidYw64mU1487qZQ4NwNSwGD+F8QSM+elhShmcdvaSqPQZ6v8yEbGLl1jXHtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDtthU2q4Su4pldaXDlqI2nutZKMWz9eGHXtdBVO12m06hafWn
	1X5tyvTKZaE3gGo0l3pR/eI7ImRb2Y1UQZCNjjE6eL/z6gtoZ8Xvw5WE7gzoPrX5q7VRPRDQAc6
	EZ5gu
X-Gm-Gg: ASbGncuV/KPdRSqNzKES6vHc3S/FNwqUndFfIhcKCQy4JaCjed69IPc8mmYRnCKZcru
	BH56vQGBk7ExU9J1OnYs6dkkiEdraNKq0aETu26mSq/2G0/FKT04ArdD6Yd2DQhWp9tIdBtI0TZ
	Kl5KXTFxIpYOY8ND0FWvpMRaPWvHohRnYe8XeRpxctheQ78gkUUeDEYuQ1YR7TGvlKkFufUHDmn
	Rf2UidIqTjryx+x1aArjOpHcn2oYFkDaRCS/vv8q9MC5QAaNhSlrAXqh/3DzdLY8r6DmX5Z1LYQ
	M0ojNyfnAFjky8Sk/8zyKgojqTBjlyLMVwo+M/Gli4U8Zd0BJM1YDA//ylgBhXwFzh3rZEoi9uD
	VRgp75MH42yG13Ui2VCc+7NSVxmwv0T6FC+OgHFgTW0NKTl7zRcA=
X-Google-Smtp-Source: AGHT+IHZMQ66dbn0HYqgUWqtOKY+6W/hbvSvLLM0DsnxT0WoK6ke4PDsI9taPpSLoFon0ighiqsLSA==
X-Received: by 2002:a17:907:3d91:b0:b42:f7df:a2ec with SMTP id a640c23a62f3a-b50aa391ec3mr705746666b.9.1760000229110;
        Thu, 09 Oct 2025 01:57:09 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b4869b57f0asm1854008166b.77.2025.10.09.01.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 01:57:08 -0700 (PDT)
Date: Thu, 9 Oct 2025 10:57:06 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: ulf.hansson@linaro.org, zhoubinbin@loongson.cn, chenhuacai@kernel.org, 
	david.hunter.linux@gmail.com, skhan@linuxfoundation.org, khalid@kernel.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, kernel test robot <lkp@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in
 pxamci_probe()
Message-ID: <pe4sz3hamkxhahvwqzdq3p3q5u3yeqpdscl5rvvoo5gdfbbrl7@joiz2oj5y4so>
References: <20251007161948.12442-1-rakuram.e96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="abfyiat56trvwoek"
Content-Disposition: inline
In-Reply-To: <20251007161948.12442-1-rakuram.e96@gmail.com>


--abfyiat56trvwoek
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in
 pxamci_probe()
MIME-Version: 1.0

On Tue, Oct 07, 2025 at 09:47:44PM +0530, Rakuram Eswaran wrote:
> Smatch reported:
> drivers/mmc/host/pxamci.c:709 pxamci_probe() warn: passing zero to 'PTR_E=
RR'
>=20
> Case 1:
> When dma_request_chan() fails, host->dma_chan_rx is an ERR_PTR(),
> but it is reset to NULL before using PTR_ERR(), resulting in PTR_ERR(0).
> This mistakenly returns 0 instead of the real error code.
>=20
> Case 2:
> When devm_clk_get() fails, host->clk is an ERR_PTR() resulting in the sim=
ilar
> issue like case 1.=20
>=20
> Store the error code before nullifying the pointers in both the cases.

Why is the pointer set to NULL at all? This is in both cases memory that
is freed directly afterwards (as `host` is devm managed). So I'd claim

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 26d03352af63..404f78198252 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -652,10 +652,8 @@ static int pxamci_probe(struct platform_device *pdev)
 	host->clkrt =3D CLKRT_OFF;
=20
 	host->clk =3D devm_clk_get(dev, NULL);
-	if (IS_ERR(host->clk)) {
-		host->clk =3D NULL;
+	if (IS_ERR(host->clk))
 		return PTR_ERR(host->clk);
-	}
=20
 	host->clkrate =3D clk_get_rate(host->clk);
=20
@@ -704,11 +702,9 @@ static int pxamci_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, mmc);
=20
 	host->dma_chan_rx =3D dma_request_chan(dev, "rx");
-	if (IS_ERR(host->dma_chan_rx)) {
-		host->dma_chan_rx =3D NULL;
+	if (IS_ERR(host->dma_chan_rx))
 		return dev_err_probe(dev, PTR_ERR(host->dma_chan_rx),
 				     "unable to request rx dma channel\n");
-	}
=20
 	host->dma_chan_tx =3D dma_request_chan(dev, "tx");
 	if (IS_ERR(host->dma_chan_tx)) {

is a superior patch.

Best regards
Uwe

--abfyiat56trvwoek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjneOAACgkQj4D7WH0S
/k4H/Qf/caIHRDrNP2OZZWaTAwpTU4YgeIGVsaqKVOCxJtPIl/kUO2W0PRXb/k7A
KbdrnygmBtHhSZeeDIJEbBPQtdj4vmGvGbVTC0LoOgbJxOG1AUSsqB32JjUC6cCk
QUZbvY1EjoYUCOmZWxsJYxBQA6LcBOeQPR/pXW8wNv/uc5dHwXcYcrVS4ZoddCe2
gfCldJdsaUTqSf5Uk2EC+e54x7buJHigSseQdEP43QLVBx4n6Z3kJpuw+J6djT4y
NYDCNSDp8wSnRqcBoviiHmr7+lT51f+LFhEbDfxvdXtKgGN1flo7py8tEB5JkSDx
pEHwloQTiVr6XIYLRM12qgDvhP5WTg==
=TQg9
-----END PGP SIGNATURE-----

--abfyiat56trvwoek--
