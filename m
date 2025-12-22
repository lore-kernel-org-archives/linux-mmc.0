Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15A21FC0EA
	for <linux-mmc@vger.kernel.org>; Mon, 22 Dec 2025 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766401538; cv=none; b=h8fvyRV3GoR4U4Tdy1sTX+rdjt0o1FsQvOEraX8scqXfla+rG5kRdjIxS8/R3v+av5BmPcyZ9K6O+uvfqCflndyY1rF1G6vjdWqbTRS89n06ziqg2m/lKg9u2XAPcUf6gMrYQLcNpcoXbZS3Wjd6qie/StonKejD0lnEQZlBQg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766401538; c=relaxed/simple;
	bh=hQz8inePYy4z7kE2ZTh8btcX7ZL/LHM5S3zx3idHlV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sN+rq+cjOAbihOFhl2NzqYQfLIzI0q5zIahXJwNoDnZpSIZTmLLpPlok0zXPmiKRz+OaH7Vu+0r4Is82MGOsn2Q8e84DHblBPtTgQ8yWuyHVqBh8KKgOc6h+WV+UFsZ6nWF1OSVaRdz5nmfjeOOohvmDzbtMHIiWQ6404Ga1+O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-55b0d4b560aso3191354e0c.0
        for <linux-mmc@vger.kernel.org>; Mon, 22 Dec 2025 03:05:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766401535; x=1767006335;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVlS5J1HzuVScBDeCBX0VxoypelfY5sXHRtDOTQInFQ=;
        b=ZL/PGlfhjLqmgVdxpZCl22rZoXOWAU0nxV2UlaX+k2actCde7ZurILcWV7iYWkzVXx
         cU8j2RCpfhrfOEw0kgF0qI5+ESXVn7//XXvI3KaJXjr3E/cvPMEus+X8yfvu0mvRg8QU
         EIbPtl2pJFfNOpq81J8AGfErlHbNzbLlPmpUdqGfZr1y0LVIIVjVfj3rRVIMZQniEKXp
         CadTgdIslxL/EOg5KQU5mvhfwJircTNS+D1zo+94iy2XbW7rIHhxaC6iW6ViO9S3f2Rx
         3xRa4nA9Y2qElRSmz0nEUCOF6oxK88tKsyQ0ZzkmYYbBUddCL8OQVpyv0ZAkF+/Qy4sC
         veqg==
X-Forwarded-Encrypted: i=1; AJvYcCXDL0p+FC8XAZlA3ODUWKh9DSDKt1kmsHJtABhMRU5GWoAg4UkwEOX9KGhs7E0T9rP9+nAuS3FALIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd7Bub3Q8VXp4gTdvtxAdiFeBOmHqpAGryL7NPbYh5aCQk7vl2
	TOLDP+Dhl3g5VsGp0+0cseZOcdgCjGQAQMt9GYaT0pXTOQ+nS2bbWgPgbjcYF7K9
X-Gm-Gg: AY/fxX5uBxWm8GWlmybjMUjIZeRz486BRgfDIuhOsozBO7TDXQsHfmKadP6hsHklnNA
	6Zt5NKceUZRtPgV5Fu6by1X/uQt2KyTfcMwbEr8ZEvDVsiiLS8skfY/xjdp4eLpnKtWWwfEkoEf
	rMn6Oywhq0r/L6kc6qeP9KLXMDpPMiVChYfMWwlzC5HutgNWxe5qxhRu7fSRdM6XHlzAUhPPLgf
	bq3OE/wn1zAj/kRGhzY+6jxSI8DoO6GjSddwraBlyxrjcSSq9uz+vYLzv92mj2AY6EXSPo4tLY+
	ikWG6yT76eGJKMFHGwibeF3jiUYpYEzUgS/90bW4He2LNGGQ/s3R50C9KHowjyYUVNtL1aUtNKK
	4dWFLlc9ZUwu/AFhnncEQKpYIZnpwJXQuVwHVgi4mEx4NdhU29wunY4k7yKhoO1SazCO7Fn5agi
	8g0IFmOjXeHraACn+7beYjdc4kTg5JD39+mqOmFKGCRdPcI9Zm
X-Google-Smtp-Source: AGHT+IFDNTUWVJwZJFBS0sGnnXsT/ohNVADCw3dUASQkgDwggmVolA0ETBW7LGR6cK3k6Weh7/9pGQ==
X-Received: by 2002:a05:6102:5681:b0:5db:f031:84e5 with SMTP id ada2fe7eead31-5eb1874196cmr3807160137.21.1766401535616;
        Mon, 22 Dec 2025 03:05:35 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5eb1aad0b7bsm3280169137.8.2025.12.22.03.05.35
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 03:05:35 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-93f523bba52so2259672241.1
        for <linux-mmc@vger.kernel.org>; Mon, 22 Dec 2025 03:05:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUzoWIM0HaPw9WHIqEE/MhW0ypRQg07fWCnQuWuyupulgU7acmCGiisplTZRxGDIPUqbdg4TTkL7j4=@vger.kernel.org
X-Received: by 2002:a05:6122:6790:b0:559:7faf:a276 with SMTP id
 71dfb90a1353d-5614f7ae2d0mr3069797e0c.7.1766401194470; Mon, 22 Dec 2025
 02:59:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210-rz-sdio-mux-v3-0-ca628db56d60@solid-run.com> <20251210-rz-sdio-mux-v3-1-ca628db56d60@solid-run.com>
In-Reply-To: <20251210-rz-sdio-mux-v3-1-ca628db56d60@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Dec 2025 11:59:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVqSPQ_rCY1mPxyAw1=WwK2VX9bxMKQQuVEe75u5hTvsg@mail.gmail.com>
X-Gm-Features: AQt7F2qvtAFJTZWBdh_71wFZZJPHL2v6ti7TTVpa1qQd7XzzszUS-LtvxMifYms
Message-ID: <CAMuHMdVqSPQ_rCY1mPxyAw1=WwK2VX9bxMKQQuVEe75u5hTvsg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] phy: can-transceiver: rename temporary helper
 function to avoid conflict
To: Josua Mayer <josua@solid-run.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Peter Rosin <peda@axentia.se>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, Yazan Shhady <yazan.shhady@solid-run.com>, 
	Jon Nettleton <jon@solid-run.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Dec 2025 at 18:39, Josua Mayer <josua@solid-run.com> wrote:
> Rename the temporary devm_mux_state_get_optional function to avoid
> conflict with upcoming implementation in multiplexer subsystem.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
