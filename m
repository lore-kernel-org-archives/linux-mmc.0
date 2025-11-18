Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCF0377E87
	for <linux-mmc@vger.kernel.org>; Tue, 18 Nov 2025 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482486; cv=none; b=XqRzGdH3RjKFzCpON57prxmYtZ64XbvVeHRsRqEkU8WpzxFt23u+OO5qLbfpfUuuMQx3vGy2Fivf2i2AMy0AUa0CDBVdaSlS/xeioHYK3YvpalbkgOE0EV0OYb9u50uOLeW6Qjd3XWh7l0lLobOKG7FR4+FZpKZrfBK2fjT/uUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482486; c=relaxed/simple;
	bh=r34v7Chf23CjeqxCGh6jBGLpEJIxJ6vqN9qGWv4CVbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuPaW2AD3HA3I+ZL1TSeQCmBDGlb1hkEM2RtMTaUnlWSy51InMBbzCjyKXAtXZH1RrgkyIdtwLCXKGFIQyhR0DQ6LUXCtBjMud1+nz09qmq7y8Bqy2inxfTh7fc5MQs3rXtCk/DLBe/yzGssITMfrDkKHGBT4MauK5sqiB0hsSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HHnhW2ev; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HHnhW2ev"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4775638d819so33070255e9.1
        for <linux-mmc@vger.kernel.org>; Tue, 18 Nov 2025 08:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763482482; x=1764087282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r34v7Chf23CjeqxCGh6jBGLpEJIxJ6vqN9qGWv4CVbc=;
        b=HHnhW2evVTbt7wphvjm05GfiweuIUcXtv9rCiIsZZd0NKBK6FZlrrLSejziMK8Upgt
         Ej+JzxoIURAZAX67hh9R1XfU7Cc5R8xueFBCaSqkUs8s9FuLfb0Gr0ZJyAA0ajCLS7bs
         7rjf9KxgaM7uCCWKsRnNjzwnWbaFriVJbmP+ZcU9+khKpRvNfdeXwLLDUOLJKx0q+ue6
         4vWSMLlpd+eXrO+uDZMj9xFSYWj6ceWnsF8mxi9ah8Z+nXmoRs5MbLYIVYUTdg9jHrV7
         O8Z3nk8bIPHemm6jVhONBAVWwOnowxfsAKNPa2wMdL3/OQdW9kwQKSAMEPjd7OMqaPCJ
         o9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763482482; x=1764087282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r34v7Chf23CjeqxCGh6jBGLpEJIxJ6vqN9qGWv4CVbc=;
        b=wWHLKo6AyHd5O9FEKfaUrpf2l1TEahtO/T6SxLwhayuxICpMjnNF1vWZRwCnqiz8RA
         XN4nVTSJuW5OLnjPtNdSnYcOOellD7WsA7pv9J5SCY7SCYVePCdpQoYuwG61WY8wXjKV
         u5gTHQX7HS37tsuS9uws6F+c36rNzi8j6Agd8tYuf+9uzGw0qE8cemGL81nkjACV9lK7
         VNS/dSlvnBJGT1utEX0GNTtZL1YEDCgReTNrh2OAMG7TOaNKRnaSRadKxd6F1qJZVw0W
         mFmEHYUtMFtG0sqO8WsmTRo+sF79UiryHEWvuNIJccESPYh+J+4MRXSGKR5h0b7glel8
         N8JA==
X-Forwarded-Encrypted: i=1; AJvYcCWyoj4wfv7ffgGQJL/i6vLQ6KNyXvUEr4BnCe1tAgcrrNa+LXEDx4TawvWHc4LgZFadxhGXy2QSXAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB/mVQPLQyjD9nUw663UQi/AtasG/kYF08NHW9ao3qOzvqmuur
	gSWShZ/cRIxBlyGmRarMIK6c49rhjhffVF0PBoBPz/Y543f4n9tY2/dAV3iEtNCbqUY=
X-Gm-Gg: ASbGncvl0aJBpWBCD9YK23bgIXZ7vkgrgOjEAYGaaOO1wfeOylnTv7d0zHg7cs9+QSp
	Px7hVTgects/R18oqdOU1B8F4Z1/fA1q7DFwRAmOWhaWnE5zUAOmDsDd1KMjIroELdmpZQaPNRo
	Nw3v96EUqKBuH0UwRplFr7hG4Gz445DcHknvOyW4rFY8ZhS6r3I8/ADlSduyzoKAKGmu+tHUuk5
	NA7EnsiLuZy2XGqEB/QHfwY0rYnbGknIwrFyZAv5cDtOg2JZzcAobNOXf6nGZWpqwUu4WvAhPIP
	GlrPqK/Imw8r/j5GqFNc7bLMTwMW4SwuQ6HuTJ9MvZzAax6Fi1XHJmT7RFWg5GZnHRIxU8S1A7B
	cb3F++DjmeWOIWpQoOGvf86W/vGAfxFeuxNmZ3S79pz3kGnYnSd/wuODrKVdSDIVDea2sEMLqp3
	uNbBWosiN6Mhxur7z23W4q5v8RMLZ64bfp8lBnQ+V1UI+/i7QlwFrK6V90F2D8OzI4H2Pavdlke
	jry18AYPROUDw==
X-Google-Smtp-Source: AGHT+IGABqHzMfvrkH8LxagAZ79PiCTyK0sWiTlho7XR0w0fdDe+kwEcDbDmDQrjqn2XXZR43BkeFQ==
X-Received: by 2002:a05:600c:4f54:b0:471:803:6a26 with SMTP id 5b1f17b1804b1-4778feba6a4mr162060395e9.37.1763482482061;
        Tue, 18 Nov 2025 08:14:42 -0800 (PST)
Received: from localhost (p200300f65f0267081cfc29f03d015de2.dip0.t-ipconnect.de. [2003:f6:5f02:6708:1cfc:29f0:3d01:5de2])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-477a9de4765sm19497645e9.10.2025.11.18.08.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 08:14:41 -0800 (PST)
Date: Tue, 18 Nov 2025 17:14:40 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: ulf.hansson@linaro.org, chenhuacai@kernel.org, 
	dan.carpenter@linaro.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	lkp@intel.com, skhan@linuxfoundation.org, zhoubinbin@loongson.cn
Subject: Re: [PATCH v3] mmc: pxamci: Simplify pxamci_probe() error handling
 using devm APIs
Message-ID: <gp4ju4m3ypaijxnll4e5246e6qu2zk7towstua3exfazdvqj5n@5zorhuwucugk>
References: <CAPDyKFoSX7QZGv78dL10C38wY0Sg5QC1qxvhyGXJ+VUYHihP3A@mail.gmail.com>
 <20251118142317.12921-1-rakuram.e96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tvdndur6ruxolqvj"
Content-Disposition: inline
In-Reply-To: <20251118142317.12921-1-rakuram.e96@gmail.com>


--tvdndur6ruxolqvj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] mmc: pxamci: Simplify pxamci_probe() error handling
 using devm APIs
MIME-Version: 1.0

Hello Rakuram,

On Tue, Nov 18, 2025 at 07:53:11PM +0530, Rakuram Eswaran wrote:
> Shall I start to send the patch to remove the redundant if condition
> check from pxamic_remove() function?
> [...]
> I can pull Uffe fixes branch to send the above patch? Any inputs will be
> really helpful to start working on this.

It's sensible to build on top of your previous patch, yes. If you do
that by using next as development tree once Ulf's commit made it into
there, or if you apply it yourself (and then use `git format-patch
--base` correctly) doesn't matter much.

> Another point, I would like to ask is about the below discussion. You have
> mentioned about WIP suggestion for clk_get_rate().=20
>=20
> Link to that discussion:
> https://lore.kernel.org/linux-mmc/20251020183209.11040-1-rakuram.e96@gmai=
l.com/
>=20
> Was my understanding is correct?

I think so. In my understanding clk_get_rate() must only called for an
enabled clock. (Though the wording in include/linux/clk.h is a bit
ambigous. It says: "[the returned clock rate] is only valid once the
clock source has been enabled." That can mean "The return value doesn't
mean anything when called for a disabled clock." or "The returned rate
is the real one once the clock is enabled." Some time ago I tried to
improve the wording, but IIRC I didn't get relevant feedback on my
patch. Assuming the former semantic is safe for sure.

Best regards
Uwe

--tvdndur6ruxolqvj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkcm20ACgkQj4D7WH0S
/k4GJAf+KrHQ+u3psNlWiXUPnf+rL6rUAvcOCBRGqjCu3WVQK4DaA+NQ50Di9Sqe
0FuaHc80e0+7aAT94gkuHBxu4Q8nuBo5zyDxd56+paZZ+ffvdLu7qVupWPM0Gn3Q
BsxYETC7CRK9aMdD99qoCh0KNdQkvArM+jBPmV1sW60193vub2a2TvMjl+KtI72q
YY9QsYOAHXfV6jsyRiAT4LLXGajisGC6YgnVWysClscOANepHPJDAHssxVMvLpGk
cKy99GqMShp51vD4QwljNqZsxCLIapYDZMPNozddXLrrgQYDp1HKCOdl53KBWWAA
Lg3jqexMXcZd8gy9dCdrb57GM9RRVg==
=p+mr
-----END PGP SIGNATURE-----

--tvdndur6ruxolqvj--
