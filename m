Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48F834EEE0
	for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 13:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765978983; cv=none; b=lUrt1laqOwhqBu3xPiH1/6NavJpuoGsX599y+lgj76zZbtqkLEPIOg0yNfCQCQC51xU4OLlHeNQUV6K4mlmu8NOZ8U2Vdx5AA7O8S/CPM7aDHDxl/dnozCu+jyPyp6jfKgTsAwpvgpQbyo4PUekuqq1Le5cTadqP8MIj2J7SCMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765978983; c=relaxed/simple;
	bh=nre4+f/1qweJxFoeeHsRIflrATunEW5LWrhj6Pv/YRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ki9zisAFByHynU1EgFSbBT5NJ8fyhW3loLWzPsenL8oQkzP3CKWokdMfDg4HJ4Xzte750IY1VEL4MLjw1TpHiTilrerkoal9F8TH1qlI3p6a0dFhGYRNWTtlSsylDBMKWhXBLBhXcON9Ft+syCLPs9ytEUihuNNJb+XJIgtVwCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p3Rlr0+T; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p3Rlr0+T"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-597c83bb5c2so5118992e87.3
        for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 05:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765978979; x=1766583779; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i+2rCMNUHkZI89lP4N4BumifdRKTsaBf6MC8t3850FA=;
        b=p3Rlr0+T95LKZQayrzXYTvbUvv6N3iakcHQxpWx65eUd8+lUCwS9f/6Vq8MUTJdvlz
         7HBLv9cPHp0cj23HbmJUS2Dh4U+l0qYdvF3aaPSH5JhrZ7YwOrobUVipOLHpwW7ccrIf
         zJ+8xK/8D5t6y3s2jCWDJHgv/e+jJdAWR8rd3sUGUxoNuroOChb1flv7wxO4rM6o3+YN
         9bffZEShBR52yarjv9mW5IuaDnM93Nl2nAyIZVXA1W7zJbGNr+KOAczd0O2ufav4PF0J
         Zz8oMvmmVmyPwHwvBQtuaBJquDvPpGmglAzCfZ8Kc7HPVa437NOe0NjK+mIGVYzE6vk0
         B10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765978979; x=1766583779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+2rCMNUHkZI89lP4N4BumifdRKTsaBf6MC8t3850FA=;
        b=u1ehSaeFFeBol+E4uf41Br109IhTMkI5bJBQlKSb3nXUtl/rER5t6eScE6qfsi+8ig
         pPDekJSCzhTbYSpxd/TNdGpl6TRtQDwjp8QKb5Vp+VajLoN8jIlAH3BzKytFEqjbDjA+
         dWODB8lY4SaDSCEYykJY1PIEdIvRJ8aos6FEp2pDxU2BKWVFD+mnyg4W1fQxgvc4Fl3W
         TEXNk1ms4t64I62T4pr6/eXRRyjB8OtqZAwt3xRGZA7NGjbuutu1th9hMvy+XMKHJ2xU
         GwxWnf0lcuuwMJ4GyvjzoS8mnf2+BTpZMbGV4kuJUOPaA0Dr1YES7am29vajTMgmD7jD
         ujXw==
X-Forwarded-Encrypted: i=1; AJvYcCVJV/h3PG+uzOf9ABRSnXsxMBTjrgFMs6XYiXF+AAEQrcT4k5SwcnWzoJsElbDJfU4vrnVFy45hSAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHZAGYRz9Uo1Nrk7nnCaVwxjAsIgKj2jPCB0fn0PsZ4KTvAl3c
	77y1eYKHGxciYkMMLiHd9h7SYKnqwSCRAPtDEMjyehoa2ibRPka4WMDDNxM/zKQ1URoL+LZi8R3
	qauEPGkMj7/gg0ldaRhsa3yLnmaAQWq8V+oQXZkjuYQ==
X-Gm-Gg: AY/fxX5cit/Aime0IETuosXLcKbYJkvPKSIEzlipmHjIMRaPbpWsN05ytEOE4ZhMrvP
	ifKZcnwZ4gHIE7iyz9HTgJ6l6IiE7JDb6Yob3uwuFAfyWy1Nh0kN6EJeFngEy7XJoQGX9MW/cwE
	69i3WghqK4A25X/qZZFktIiQazSA8kFe84WUfAhT1Sv2iHZuQlv87N9GIjXGjBebE/0YzQAzn+N
	tM6RjuejVUFN+yCeHKdgiMGkrqtaxLyHFHyISu8Z3aquIj3YSgCAHFLOZHZQorSszi95aM=
X-Google-Smtp-Source: AGHT+IFQ7RFU2XYjhNpz4zPlGBfxB8IQy25jb9NHzoC5kJ0seGo5jh0pCCbvJquopiBKgSSVm6gg0z6EMwvFTEugGus=
X-Received: by 2002:a05:6512:3a89:b0:598:f262:15c7 with SMTP id
 2adb3069b0e04-598faa4d4c4mr4998838e87.25.1765978978821; Wed, 17 Dec 2025
 05:42:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210-rz-sdio-mux-v3-0-ca628db56d60@solid-run.com>
In-Reply-To: <20251210-rz-sdio-mux-v3-0-ca628db56d60@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 17 Dec 2025 14:42:21 +0100
X-Gm-Features: AQt7F2rn4fUAIJmNzeBvaDU3HopJ0wrtd_f0H7TRKpgHGGrU8bW-ugZfTBQ1TVc
Message-ID: <CAPDyKFr7DCRs_E4VfrY9-NY8-bStT9oAZaYhUZDg_y3KEW9DWQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
To: Josua Mayer <josua@solid-run.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
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
>
> Some Renesas SoC based boards mux SD and eMMC on a single sdio
> controller, exposing user control by dip switch and software control by
> gpio.
>
> Purpose is to simplify development and provisioning by selecting boot
> media at power-on, and again before starting linux.
>
> Add binding and driver support for linking a (gpio) mux to renesas sdio
> controller.
>
> Introduce generic helper functions for getting managed and selected
> mux-state objects, and switch i2c-omap and phy-can-transceiver drivers.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
> Changes in v3:
> - updated omap-i2c and phy-can-transceiver to use new helpers.
> - created generic helper functions for getting managed optional mux-state.
>   (Reported-by: Rob Herring <robh@kernel.org>)
> - picked up binding ack by Rob Herring.
> - replaced use of "SDIO" with "SD/SDIO/eMMC" in binding document and
>   commit descriptions.
>   (Reported-by: Ulf Hansson <ulf.hansson@linaro.org>)
> - Link to v2: https://lore.kernel.org/r/20251201-rz-sdio-mux-v2-0-bcb581b88dd7@solid-run.com
>
> Changes in v2:
> - dropped mux-controller node from dt binding example
>   (Reported-by: Conor Dooley <conor@kernel.org>
>    Reported-by: Krzysztof Kozlowski <krzk@kernel.org>)
> - Link to v1: https://lore.kernel.org/r/20251128-rz-sdio-mux-v1-0-1ede318d160f@solid-run.com
>
> ---
> Josua Mayer (6):
>       phy: can-transceiver: rename temporary helper function to avoid conflict
>       mux: Add helper functions for getting optional and selected mux-state
>       phy: can-transceiver: drop temporary helper getting optional mux-state
>       i2c: omap: switch to new generic helper for getting selected mux-state
>       dt-bindings: mmc: renesas,sdhi: Add mux-states property
>       mmc: host: renesas_sdhi_core: support selecting an optional mux
>
>  .../devicetree/bindings/mmc/renesas,sdhi.yaml      |  6 ++
>  drivers/i2c/busses/i2c-omap.c                      | 19 ++----
>  drivers/mmc/host/Kconfig                           |  1 +
>  drivers/mmc/host/renesas_sdhi.h                    |  1 +
>  drivers/mmc/host/renesas_sdhi_core.c               | 16 +++++-
>  drivers/mux/core.c                                 | 67 +++++++++++++++++++---
>  drivers/phy/phy-can-transceiver.c                  | 10 ----
>  include/linux/mux/consumer.h                       |  4 ++
>  8 files changed, 89 insertions(+), 35 deletions(-)
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251128-rz-sdio-mux-acc5137f1618
>
> Best regards,
> --
> Josua Mayer <josua@solid-run.com>

Looks like this needs to go together or if someone can host the common
parts via an immutable branch.

Anyway, I am expecting some discussion or update for patch2 first.

Kind regards
Uffe
