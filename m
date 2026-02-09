Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E214233B6DD
	for <linux-mmc@vger.kernel.org>; Mon,  9 Feb 2026 08:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770624625; cv=none; b=D6oxL6ypdhsEVVZ59k8XOuhjvxVTED+S0ikOvH2bOhHe2BiyLKiE9gml+oM2ZibZkNECYKbUGyZSYo7HYH3a+v3Q6GbenZu8BpeAK0cyG66CIkuNLZkz6afze3V7qt8bP6wLCnqd25MkGQ6R7+JgCGvRPAExM9YKetCOCBMMxrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770624625; c=relaxed/simple;
	bh=/zYgLPOAHXK4/exWmt8hOWg3cIDWG24Bmk4iX8O5iZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2Kdg6wKdr8CFiV3UPRZ2w48kuKikMsj4H1iSvoc3WZxp8uzXhhJUNGTgfPl1C0ZrbkVcP9rpOzMOUZ1aiLLsXEgCGNYJm9LOUEABccERfs4vmdXFywHU/mnUBo5cnuiWrIzRKhvrnaTcrUdzW1N3y6MR9hzhROaEaln37mYYw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-566474a6e10so2266416e0c.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Feb 2026 00:10:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770624624; x=1771229424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bAsoauLtymOFaOmBSRU1sXzH6MyMCHQePcHPtAadtM=;
        b=hT96yHBRlbiEfZr4NcZ0pQ6AmGeW6Hzz6U1oX9n4Z0FZewyTQhKoSf9sq7U1L3zbdY
         XLBOEs/ByIltYa6U6Trcc0s+HzTuVJJnaiS4gHt5t2qzabZMZmQkxfLFrwUU/DkWxipt
         RgYzUTCiLrx24I2sWJ/0kggryjLsLJWnw78E+oblzu5naPXV4O8hvJ1j0Nc/5owIt+20
         LRMR0UAiVSsU4qMHeqNgZbQCG26XtHZbWwN9Qk9za91+rijaKNs0GKYnjWeurlAzvFUg
         KHBNw49TdG59SC0PGtNa7u1cJHeb9J3wKyUJT4BghGict/HR6+jOSZKTjFMiZrbrI1aH
         Vdqw==
X-Forwarded-Encrypted: i=1; AJvYcCUMmo/RJ/5O3SKf3AKq+8tYGUsFBp2sZKmtCqdUCAL9YG93AYiE4H5zsHxy2xxOdXl/fd4VDA87GXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWFBH4EfmoJCteL9xMf9tktXYv/nsQD3vH5a+sqey+FXkSDrhc
	Qfobpa5r3n8rAdXvRLEJWTVdZAf/I7ypCu00bl7+7CERlZpto5h7DrjeJp9b/ngE
X-Gm-Gg: AZuq6aJCPEViO/h/RCJCMvIWDDXpMQ3xwUZfLf1ueCyEqlPbCfl9eYI03QtDT0ohatJ
	DcGC96LxfogDFvkKRF21k7+P3PHvNabVpExlbStDDeYt8bC2IfGNrThHIwvlmKr2aGKYTocXE6t
	fZhxQpaaY++jIazIljy5yn4Xt7oz6arkESMp5Ib6OuCApZ8xJqSu8f2sAmKAT5KA7t1XoW+bquZ
	26OtCMWgbimYMvJJDgCr5OWP6hVLn9jl2c8RCVRBhZiYpD0UGBcf+up/XY/PqAyTAws3I2yFEsu
	iDZEYMH5nXgDtMzMW8kN9fhQyV0CXCVPPre1ffNbMD1napOV6Sz4N2rHQ/mFlP0xfHZ7Tb0qoQZ
	+BiPCcfdZaCee4qIYZQhRlTb5HQdYTz/O3nQama2sli9gnx8HJ0HYt5aDlMpsmB6BQeOP6UD/7x
	ReNv5rmsbV3KMvAj2yI+sIX5Jd0vUAtTnY/U+V4kHePH2FRdHB
X-Received: by 2002:a05:6122:17a9:b0:566:35ea:7cff with SMTP id 71dfb90a1353d-56705e96b4emr3451227e0c.4.1770624623916;
        Mon, 09 Feb 2026 00:10:23 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56707429e37sm3273983e0c.16.2026.02.09.00.10.19
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 00:10:21 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-94aaa5d3bfcso1161479241.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Feb 2026 00:10:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV3qWjm9zrr22wGIutMxMeEvapXdtFnwYcE0DpGdMmfdP7fojmBzIG1iirS0uuBXlG5pGll6fRM9QE=@vger.kernel.org
X-Received: by 2002:a05:6102:5092:b0:5f5:3c96:983f with SMTP id
 ada2fe7eead31-5fae8a3ad9cmr3362584137.1.1770624619183; Mon, 09 Feb 2026
 00:10:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com> <20260208-rz-sdio-mux-v9-3-9a3be13c1280@solid-run.com>
In-Reply-To: <20260208-rz-sdio-mux-v9-3-9a3be13c1280@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Feb 2026 09:10:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV2a7uvtrJpSprU3YbgFSTmtKkMi+Z6j0m9-4vVXWK4=A@mail.gmail.com>
X-Gm-Features: AZwV_QhXlEX6D1abbrehjsrn3uf8WxyCcirF_ZvMoX3URB-GFlRdZjQEEn6kewA
Message-ID: <CAMuHMdV2a7uvtrJpSprU3YbgFSTmtKkMi+Z6j0m9-4vVXWK4=A@mail.gmail.com>
Subject: Re: [PATCH v9 3/7] mux: add help text for MULTIPLEXER config option
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Josua,

On Sun, 8 Feb 2026 at 16:39, Josua Mayer <josua@solid-run.com> wrote:
> Add prompt and help text for CONFIG_MULTIPLEXER to allow enabling this
> option thorugh the kernel configuration without explicit "select" driver
> dependencies.
>
> Select it by default when COMPILE_TEST is set for better coverage.

Merely enabling COMPILE_TEST must not enable additional functionality.

> Signed-off-by: Josua Mayer <josua@solid-run.com>

Nacked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
