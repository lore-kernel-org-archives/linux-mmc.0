Received: from mail-ua1-f66.google.com (mail-ua1-f66.google.com [209.85.222.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81833D6477
	for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768902594; cv=none; b=HvFF9nRAC/EgRxhuvldu5lzRF4eP/EKHRxJQ0VlTjpBKAC/tKQri6IPCuuNh0YsmwF1hnD7t6QiczdaN1kou9QZs+rHV6Di+YWy1S7WNDYiVX56+P7tQELuhHHhEkH/C+f6kaRFJQ2QSveF4zedpg1TKlRSPNr44daUcc7yBve8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768902594; c=relaxed/simple;
	bh=PhelJ3YKLy0g5664IUc1xRM3vK2MnAcXyilLWshEZX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSwF7JeZl9bJjE/uhQWRt3OdReUicIz9CUz2vAXnG1aj5QFqjqC6RWjD3wa1aPw1c1/6u/Hy5ciGEMzMaH99SH7uz4NmQKPNmL6U1GqyLgv6uJnk1X8AhYxSZb+ZnJaCCRW0HN8go0AR+A9NJBgDkbRqcqgHJ7s/RCeofkWe9P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f66.google.com with SMTP id a1e0cc1a2514c-93a9f700a8cso1317835241.2
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 01:49:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768902584; x=1769507384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMqHiB2kIqqBrLa59wdqxa2/T5exJBY1xL1A1svqwlE=;
        b=oPLBaYr3XxK8ERRmAjmzryPSFQ8GBhmV/s7/0bp5p8eiD2OD9mnD6wJwKvlScSaV9e
         4alKA9809eVc+SoCq+F+MUyLD3XseHbISX6OlMNy4D5r2rlZRTD4Rw/XbMF7yrPfeW4V
         3zVhpOO3F8CAXRxMgPJKQd5bo6C1MaVSKawFkz+KEZJRqwMYs1sseAuN3uAd4Bm8SLmo
         Q85fKZA6irCWKt7kMPMeXMTL+7jfVj65kj86BJ32Xu0tsiMLgcC5m+0uKTvYP9rbbNVm
         gNsQWpLyBG2vW7ndqWizHniPInu9VwDTMRZhvh1CRVU0inxLqrjHXf6tL9dSGvrMMQWa
         sNGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2Yo5k2uB3XX5+YGS5HzjFpghKa+/ETfHRMhySiHOdWxL9akp5Lst/ZDebxkjbdXlmuzHJcFNGFZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe4KYsDq7RrDk0TIGFE4yg5ZzntuxrV1aNHb88uiJyx/5LIFom
	mMzdhRvXxXLL0uqX3YeQvaQDZkNkZ51jxEJkuVqenUJFg1RmWGKFxCHGJuxp0KRiCc8=
X-Gm-Gg: AZuq6aL8eubLNuWJXhW1eUweYZJiVjy51J5ucqvAcuyh4pfFzj+SiYG+Bvno/msBBl9
	qUx6Pb/TZ7Y8DPhzX7HYRGU2IuDfbOEW5Amvxv2OKs66lf0qyVWO0OPrr1ScOoZums/XkXM6IE0
	OXbgUSeiu1ucEXOuM+G59SbMLpwbWbG9SPhE89ZZ+6a2yoSFrYzXfvYLeZTqRUAMcxDRhQgSW8i
	Uj5GeQy3EG8suCOS5FEEZPK9lI2DqK1chiXvfYWYgEaHholl9Bu+H4SVvmIN/Ow7NrBdhqdcTSu
	23JhsDlk2Y0wfuJAywmR62PG1O6gTJwSPYjK/okwqaMsiNPWT7X4zDxP6PmYbjfbf3eC9g8e0GQ
	XYUpuvKSKarLdpz1KyeSQ4BhBD1w30B+bFZOo1YS6Y9QbqPnpmyRBta1BYG3N19o/2axNZplEoE
	4wQO8/QmrH3wkW/SYdmEh3TLD1lvrlbPaomLPwqE/Bz9QbeDpw4MQs9VQgxjiiwAc=
X-Received: by 2002:a05:6102:c4e:b0:5df:b3ed:2c8b with SMTP id ada2fe7eead31-5f50aea8b17mr285781137.38.1768902584426;
        Tue, 20 Jan 2026 01:49:44 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f1a6925223sm4146363137.4.2026.01.20.01.49.43
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 01:49:43 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5636784884eso1294749e0c.2
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 01:49:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWelJVcdTmqarhg8AU6DfD0w02UJxM/LZUgGLdAYKg+4+7/FGXtF9fJA18iBvomubSL6hC5ci4Rus=@vger.kernel.org
X-Received: by 2002:a05:6102:2928:b0:5db:f6ef:560 with SMTP id
 ada2fe7eead31-5f50ae0a099mr264663137.28.1768902583158; Tue, 20 Jan 2026
 01:49:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118-rz-sdio-mux-v5-0-3c37e8872683@solid-run.com> <20260118-rz-sdio-mux-v5-7-3c37e8872683@solid-run.com>
In-Reply-To: <20260118-rz-sdio-mux-v5-7-3c37e8872683@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Jan 2026 10:49:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU5shzYs27wO2A0SoisGBMo8RHf9DO-ubC6VrhWECEPCw@mail.gmail.com>
X-Gm-Features: AZwV_QjEUqevj8OUxZ5xnP3V3BgNbEzQSiuy0CgomAkdvyQGaaSlv633jCWavtA
Message-ID: <CAMuHMdU5shzYs27wO2A0SoisGBMo8RHf9DO-ubC6VrhWECEPCw@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] mmc: host: renesas_sdhi_core: support selecting an
 optional mux
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 Jan 2026 at 11:29, Josua Mayer <josua@solid-run.com> wrote:
> Some hardware designs route data or control signals through a mux to
> support multiple devices on a single sdhi controller.
>
> In particular SolidRun RZ/G2L/G2LC/V2L System on Module use a mux for
> switching between soldered eMMC and an optional microSD on a carrier
> board, e.g. for development or provisioning.
>
> SD/SDIO/eMMC are not well suited for runtime switching between different
> cards, however boot-time selection is possible and useful - in
> particular considering dt overlays.
>
> Add support for an optional SD/SDIO/eMMC mux defined in dt, and select
> it during probe.
>
> Similar functionality already exists in other places, e.g. i2c-omap.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
