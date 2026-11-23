Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795425420;
	b=p5S1dzdHNnQbfTyr+sWHUUBlRnMU3NwWYFuZHG9m98TZREEzbZhb/UzWbrT/f5OmUrNt
	 Gm7Psw2aPmMlYs9ZELwZKHhISvKKFG1eYi9Ef2al/AlpZC2mwxX5cxDmv5lIO7NuUPXOU
	 6sNOBROYiESepKMpQOWQ8/7H8b5iRYMHxlRx3XZqsXL84my1eeevRH6mmFMcOfj0GU/NH
	 Tcf4dCwege8ZoGcLZ80y1Ixm1aj+mPaujIWvrOB2GTZXO1eOZXySBy9ThnF0R6XDY1Ug6
	 FoqnL+LadF+5H8D+Oiomq0MiJOGm0Q923kD5M1aqvlFukVhQyqPHp5932o2fSqIUD/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=KntknVNj068zKgAq+zdLaDv094kaGVDF9/OJXVQRtwA=;
	b=x00sGQ2pX3Aljy4MdTx7d6nxflziWoaGEHQdo5aftvq/B4Z8sC6mCvjo1ybR0UYuuA/g
	 pya8/YCDNrzQCPxju4tzre7W3DL0niWEtimLPe6PdLxh6TOIAr/LBmdOAel1AjFopMm2L
	 yRKMOJcaB+iZzhuk5oeDX3FNobuk6gW0bbLfqWohDOEzb7HYXTRqjU9nxJLxAkMoFD9Zp
	 fSvXP32IT9JaerRwFL/I27EeSyPqJIrvHb+M0rbQIz/fVxJ8xRV+hwr2fDep8yUZLPbsA
	 0uueJtJhWnBMHP16J2rKTGPCDTGkkeKxu5j93wqTbFw1c7pfc+iRAe5Y+MrEw+eSFpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=SujOSC3b;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623CC606A31F
	for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2026 09:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 623CC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=SujOSC3b
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4a9be758734so1788682f8f.1
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2026 01:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795425419; x=1796030219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KntknVNj068zKgAq+zdLaDv094kaGVDF9/OJXVQRtwA=;
        b=SujOSC3bJ6T5qZYnGcOUlGfGb/XPzEz/mcEywcTIoGYC/v/096w5zQui8EIrk/p2Cv
         cKCrDJV3hNKyi4Q+XaH1MbeqOl2FjAJPbqvclju5ti9weuviulXhw7yJ6g9cD8SnB+EY
         NiRHE6rL1xTY7zHCjnfM8vjPsa+ffWVQI+MXLuMxh6zoIGTMDPrOFTgpO0ErILuJt+pE
         Eq2bhuFgPdWjpQq+YtoYvEh8QCknNuwPr/4YslboIRW6Tb6Q0WlwOiizJDnAwN30eCzO
         yJ09eoWNrpIrDwPh1vIqEcRloBzHouFWuo6mGf1X0BK+tC7e3DB6KWGRuwLm+GgwrSnW
         o16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795425419; x=1796030219;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KntknVNj068zKgAq+zdLaDv094kaGVDF9/OJXVQRtwA=;
        b=a7Xs6ZqL7/IcaeQxJk7n5zdTJRGg0LOSl4iPtN5/zy6V5HxCwXRZp3yreASV1yFugh
         SMkrURkvHwapfwJkO1wrRxm2PpHbDqQNKaZtkW6QiTfW20tPvFDBGoNYD7FS7y9u3BY3
         5y003fJaRQ9NALgc+d1RfvreNshMitYDy47FOpAJ4FJKwGfLm40gzN4V+4eNRnD0YwZa
         E1FZEs4i+Guyj+FJa66/QGRQGHDMlCf3z34lAxoBaQJy0vyCluFE9VfZo7Pars2MSnXU
         DDyHCxEIOxAZ9CX9Cp+BfHeFhOIFT1MNlJyih35JgJ7/zBsCR1/FmDS9lvoEoE/NOsXr
         JTsA==
X-Forwarded-Encrypted: i=1; AL+hErHUIJbWxiOw4uWzDE6AK/LMXQiIMq6LGrCfbXlv7d9Y2zCbLcggcYLNFUCa1NfYh4O1kTIbloY4TuI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+td2f0+6pm0HmbzFClNsc6yj0RSmbP8Jhlf2iRnCLBPSKaSph
	HWkv93+adt4x+T4DOFXebZUr1HNemrYyw4zMIBF/8gm99yuiR4iJ3ugdcF+hZynfqmc=
X-Gm-Gg: AZFdTZeVAQtPake2daGSLMw4J2uA4hcsrZwqhPkJwz/TS6LHSjSfkMPEPjUh3Y7uhOT
	EUt8P0ZeejdpmvFfWK9QGcdwceYqBXAj5lCTb3Kyopdzwvv3foi+GVfwQk3CjCwLG0HSS0wTDT/
	37gG8dn35lGgZdQQTRFFSGllfaFSIXuuMy9ZyPi08IuPQ8IErDxsKz+gUwm5BTOBrSzAgVhM2v6
	vN7wJGgSq4gpBC8ui5FK8o9X9/bRwXVobdEfZnaSJmdaV0ww0JurMGXF5kb6AJFEYqUem7O7rB0
	wSww6SRoN7Z7vp6WCuqxVyogo5NFEKMkO3j/JyF0wtf4/AY2E+s7EHPwjTI2tGzh8k2x3PU55oW
	sHn/kkQoGjkNoL1igysllYXyDD3JmfiTEtboPNyKidUQanM7tLILnDnzVb5jnqcezDCMlzfsc0y
	aPsSmpYoDR/T6OhjJZ7drxP2+5CzyeTuk+S3+kM/uWIpuqNCIvPAfptJPIPSmiOqtDKl+2lahcD
	mc08vFtYM+Yt3efV23nlI45NJCGv7U34zJVVAWqAHDPGcBsQkbYxFdRW0f01QWq+U51ZmARHxdt
	BNjNu4Q7dwqIoe43IgA25Sen5RSzwpC0zp9Yc0ifXA8GJkmGWHd7/dJqOAVGuMokmRoQYOy6+Z7
	nmbtngTohJs1HiGYX+z9Yi3pw77MsaYUmCNhz2w==
X-Received: by 2002:a5d:64c9:0:b0:4a7:69c3:94d5 with SMTP id ffacd0b85a97d-4abb0e469cfmr20062459f8f.28.1795425418389;
        Mon, 23 Nov 2026 01:16:58 -0800 (PST)
Received: from localhost (p200300f65f19a90438645cebc2ee104e.dip0.t-ipconnect.de. [2003:f6:5f19:a904:3864:5ceb:c2ee:104e])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab69bf61e8sm22313933f8f.11.2026.11.23.01.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 01:16:57 -0800 (PST)
Date: Mon, 23 Nov 2026 10:16:56 +0100
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
Subject: Re: [PATCH RFC v2 08/13] Input: add polled SiRF AT550 resistive
 touchscreen driver
Message-ID: <awQEP9bHA0RPfRUA@monoceros>
References: <20261121-at550-rfc-v1-v2-0-b0309d0789b2@gmail.com>
 <20261121-at550-rfc-v1-v2-8-b0309d0789b2@gmail.com>
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
	protocol="application/pgp-signature"; boundary="o4xfpqjjox3khpoi"
Content-Disposition: inline
In-Reply-To: <20261121-at550-rfc-v1-v2-8-b0309d0789b2@gmail.com>


--o4xfpqjjox3khpoi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH RFC v2 08/13] Input: add polled SiRF AT550 resistive
 touchscreen driver
MIME-Version: 1.0

Hello,

On Sat, Nov 21, 2026 at 09:43:18PM +0900, Yuugo Yoneda via B4 Relay wrote:
> diff --git a/drivers/input/touchscreen/at550-ts.c b/drivers/input/touchscreen/at550-ts.c
> new file mode 100644
> index 000000000..89c2d2701
> --- /dev/null
> +++ b/drivers/input/touchscreen/at550-ts.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* SiRF AT550 coordinate acquisition. Layout cross-checked with AT551 draft. */
> +#include <linux/bits.h>
> +#include <linux/input.h>
> +#include <linux/input/touchscreen.h>
> +#include <linux/io.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>

<linux/platform_device.h> already provides of_device_id without the
implied dependencies you get by including <linux/mod_devicetable.h>. So
please drop the latter.

Best regards
Uwe

--o4xfpqjjox3khpoi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsEBIYACgkQj4D7WH0S
/k6Mogf+I4t6gj7ob8tkta5kHm+YP96+f6rsROw+nYQ5NXBDBTwdaHgtuxTw/3u3
9TSFi59BI6mt1CJkV2ldOhel8Do0lFyFlVyx1+tlaLGNAjrt3f8m2IWJcvQU4hQK
qCxr790Ac2+n+6M13QHVHO8E7+V5Kxu109uuNUNUWIsrjawNdIUx+lqOywM9o/JT
s7dUkwPF41vgxb8gPn3Hr9uAImmkTspc70TUfxqNtGVNmQlizkBCtSCoABv5QCdW
mXZx4sl+NJUJpqZ/jj0ehbdZ1DT8xVBRF1ZDrDU0AdqO6EAWVEnOx3tb5+7JsaKI
HSj3Bm7869/tgf+jXQ3QF1Uu7I1vmA==
=UpFb
-----END PGP SIGNATURE-----

--o4xfpqjjox3khpoi--
