Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795425460;
	b=3n8m/PZe7Ht1Z1PJS0jAiOStnV6IbYKpMnBk89tqgwPfk2FzTFo3lYVSks0Jtqmv0mnh
	 ItiF2T77/XYKzXxOmuwWp29hSALJv0s4KmYkNLmv4AENHor+NYG24XKmxG37ikuHdwEYD
	 Gj+Y0j0YLX1Vjkwtx6yxu0NG9qrbqD7R2edvoTQSug3pmOlLvC/nQyOwBowuv4hC+zCxY
	 Q3yDZUdiJBUtfi6ATHgaUcGAVRaEB+Cw4+MGfYtKWuHhoevYKQhTTDpi0lFj0Vy7BlTVV
	 xTIdlfLxIa4dUVE3UkyCwZsDdL3BigJIY56g0CmF/WLqG8ktzlfVEV5kgSRvpG1Ew5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=XivqS2GzXFfLVs4e8GPr3drYgoFDRP+i4GE/VUr/Vsw=;
	b=HtLWAJTSVIwHpaUBTYjPhEZT7Jc87wHxMJTd2iYnRQOH/6OmLteVvBmAeLt3gGMXrAwK
	 U6ZhGmi16U7TKiXk90phnUvL/gGvynGw6F81j9dv6A/k8q1Mi7jAd6EpYgszYgzHYPQ0h
	 6MSrlpwctjzHBpYUzSslC3Lnl4NBbcWvcApgpIL0lkksuhr3rkc1KS9+A0u4syzimF4sh
	 15AmDzuPyHZlaWvK4NxgbMMsvuG+6DytfGWREu4vUa+gzut3T21Sz8Lv5UYwdV26m2zNc
	 Y888uspf5TtiEWEnLWWQGVcRyrdgvIF+RCSAtIy9x1Vb6HIj7AZu/i1IJg4bSeCiGSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MjgPBNgH;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB5160A3823
	for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2026 09:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EB5160A3823
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MjgPBNgH
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so30119015e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2026 01:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795425458; x=1796030258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XivqS2GzXFfLVs4e8GPr3drYgoFDRP+i4GE/VUr/Vsw=;
        b=MjgPBNgH02xQwwlmVT88dEKqXLmkOtxBaiUolaQXrr+yWHJYso0rq5H3V5cMGxLZ4j
         4A2RItLr1Sek84a15jzHonWwk1i+lX6hrm7p24UH3BIVH8u/GLz3xMWZesQ53FDWA+dG
         x2x2jR4ERMEhavazR0qcOByOsQ2qCtCO2KRjD5X4T6FvMjY7zuG6fmRzqAPu/AUqV92V
         3zRAjur90G2sULFJ+iQ/xXtaDgx1eTPqGezZVhpjaWkCUtP1ZjTSJ27EpBZSLQkbdNSp
         w+okTMvneu+NyL6uX2WegqtYxcRuAgKYFanr9LmWTOiEkdkqf5Pi0yPw0QbSbOF/v2lF
         Cgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795425458; x=1796030258;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XivqS2GzXFfLVs4e8GPr3drYgoFDRP+i4GE/VUr/Vsw=;
        b=XQZ7eSfLrBBZpcOm7fnI7b4wOt44F7XVwBmxD7KEpFIZ8ew3q3cQqjpe1hgcXdepta
         UIyP7rnMsp7OX8zlGQm8U/G9jGPsqQjWquk1xKR1ovkPpJwc7T6KMJYAw1NQgjFhU8R6
         HK73MjRzbg591xXP3nahFZRc5xhMQJplEc/Ucu25T9gBVUN0/tFvRGfFlJ5GRphcv5Vs
         bHZ+7lGc8/msx+4jHNb+slmZCVcrqYtVvbiQIbDfHpi5nWCOLt69XqfUpgKTO3R4vbFu
         ckzNKy/WKEu1I4rENTOKYeQyvW3Aj5pviY8eCQ2e7nHarqfOT1fxrN3wOvaH4czWq9qO
         37rg==
X-Forwarded-Encrypted: i=1; AL+hErE395T3twF3mexShiOLf7JJVPi7p+kNOWDtJcGK96bQtGZuN0QoNUYmhhM5D5+Yn+eSHVFg/TEFR30=@vger.kernel.org
X-Gm-Message-State: APuU4Z+S+j3mODj8cgq3RXb9imxfzaSGjv6N7pMJgqxRF34Icopf0DJD
	NJvo+ThGZgGHvY3ApTcOJY3U2Rs+HB1EvTuu4pqkqv2DfYwMDFmbhkOwcg7aejiU8JU=
X-Gm-Gg: AZFdTZc3v3d0QE1S+09/zirUfguVzeIhZWgq+WVJZddJfW7HY7Jfoj87+RTzuzuldIh
	loTr3u7LeRjwzaeJBM6WojgHd6ByJRfPStXRG3ADDKWsRKDDAeFrYtzHLiMlOPN1JVnrxxJICEz
	B87kZtAzS8Pkmul2WZG0FkO6+TOnLxj3o5YYorIXwsU9rakRt1tl+RqIcmSmfs9Y5RCx8r9ZRSc
	sdca07A4oxrJa8xD22LtkLpgeME8Nv9riQYYzldJFckOTHUJ/s45pxqJ6aEs8x0agBScfeuvW7N
	7Gf2lR1WQ+rW5feip8diCX25Ike49p5zeuunvrlb2GvPhnMieU458HzBoiavCVaQa2M/QnKWN0t
	jzcnTecMROc4cUhVvSiDcHxXzz2E1bO1C3tRV25IRY19o9yide0jiJVCVoUMVa/GFsowGyLDy8u
	Kxwh1q1QUt2cafM6yPumV28uqu7dNFeCJTddVOPGltQBtNKVpyovgZJ3wuCwHecB066QiK3uxwl
	wFN62kekN84TYYOd/hQOP+LxKDgYHMNEupEIwCA8C1c2eVPJG4SS1aoJ+FzRManlQnf3O4SFOy7
	QxLDH2vROy4pOKJUNdeKhFr6dDZMgPLJphQNJY1mW51gPS3/EJ1tpa5EbV+Mx89hhnYuoUpjLSj
	scKCaGqBatiARTubIwNwg/AG3i3kF1ezUAIJabQ==
X-Received: by 2002:a05:600c:468b:b0:4ab:cc03:7f60 with SMTP id 5b1f17b1804b1-4bb8881b511mr224342725e9.18.1795425457707;
        Mon, 23 Nov 2026 01:17:37 -0800 (PST)
Received: from localhost (p200300f65f19a90438645cebc2ee104e.dip0.t-ipconnect.de. [2003:f6:5f19:a904:3864:5ceb:c2ee:104e])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb906e4ce6sm162891895e9.4.2026.11.23.01.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 01:17:36 -0800 (PST)
Date: Mon, 23 Nov 2026 10:17:35 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: yogo.0917.sabu@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ulf Hansson <ulfh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Russell King <linux@armlinux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, 
	soc@lists.linux.dev
Subject: Re: [PATCH RFC v2 10/13] mmc: sdhci-at550: add SiRF AT550
 programmed-I/O host driver
Message-ID: <awQEjpz2572Y9wsB@monoceros>
References: <20261121-at550-rfc-v1-v2-0-b0309d0789b2@gmail.com>
 <20261121-at550-rfc-v1-v2-10-b0309d0789b2@gmail.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="53xo6eipu5xw5r7j"
Content-Disposition: inline
In-Reply-To: <20261121-at550-rfc-v1-v2-10-b0309d0789b2@gmail.com>


--53xo6eipu5xw5r7j
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH RFC v2 10/13] mmc: sdhci-at550: add SiRF AT550
 programmed-I/O host driver
MIME-Version: 1.0

Hello,

On Sat, Nov 21, 2026 at 09:43:20PM +0900, Yuugo Yoneda via B4 Relay wrote:
> diff --git a/drivers/mmc/host/sdhci-at550.c b/drivers/mmc/host/sdhci-at550.c
> new file mode 100644
> index 000000000..11c9de0c9
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-at550.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Standard SDHCI PIO only: do not assume CPU/PCI DMA address equivalence. */
> +#include <linux/mmc/host.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>

<linux/platform_device.h> already provides of_device_id without the
implied dependencies you get by including <linux/mod_devicetable.h>. So
please drop the latter.

Best regards
Uwe

--53xo6eipu5xw5r7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsEBK0ACgkQj4D7WH0S
/k7hOgf/csj9IbehNzv7kJ/jSWUzgb6r4/RUEEbwtHDzllOp2mTN98xOQkRXzRr+
kmuM5eb3Prkbs0qQBPQiihfmm0Jo8lnvB2N8uBswWQM42XQ1o5YmtZx2RIs5cp4a
M0FFz9Bz2fH6rmOr5ETS3FRjnZ8CNqQnaFBWD9lGusUfgppfoyqvFwbXBZyQd45Z
KCR1pIqN6sWoDMkalLwcL8/M72VapgfDtPpmNp4qxYjf3m8WbJJZGT7uK2Mk78DG
WWybLbbeuHCv72ICgMdJArlShc5E7A8r/LZSSpXjnNPBCxOU5AeW1Fa/7Ma+TYWI
G0UtaE9KZSsmGdqMVovJUC5O5/MnDA==
=R4EF
-----END PGP SIGNATURE-----

--53xo6eipu5xw5r7j--
