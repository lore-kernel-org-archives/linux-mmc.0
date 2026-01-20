Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D6133FE18
	for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768902076; cv=none; b=gT+hbQA77rbnAutP+sxxEUQDm51Ns9PZVulMEavEjhPKkN6lZLeLUu5gs/WS2Hoz/jsYk2yN5HFsfDeKdcG2JKLVC5jYfKndZ2Yw4rJJFb+QMbuOCm+tN6hjtnF3/VoEWBHMakqlOGko6Ux8McSshUO+066H+sHncUNuvzPiuWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768902076; c=relaxed/simple;
	bh=8oF7WvkLTpbnCP6yb2DMCynlFu+13M83ZUzjQuNxXOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3b/RbZpqRiWAYB/jzuQX5tsYZ2fpmXo01ASpehsI52ArqX1XETiqz9Xw9loCTjVMCoBwsIednGxkb6G57Pi4BRXtABhi2NrQmgLUHzXGrujl61OWNProLMq2c3J60oYGWQeSEYZlYtxeWqpgaklcKNpRwc63b3KCLVCPS354HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5eea9f9c29bso3585834137.2
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 01:41:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768902072; x=1769506872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97LNh80TR77S8pwS2e4ZBU/MTmpHjj3Q16znIrdsedk=;
        b=r0PPsI+fhDAygyx7Ut0tYRP58eiH8ovpH7wSViVaorEqBB55L3BenDsAW/lOoW9FAo
         YIbdAFoyT8X7AMMMeM0kcMW2QgzmYG5aLpIIZ+6TGNlT6rp7nA7ioAN/pcSWRAyUKLze
         vZJ0su6TEXwfDdWlCEuK+naX36vWC+MoWa3Ld7y6eWeVAXfq+HQ/MLUuJrJ4T89+nlzP
         Febc6Q7XQ6xKKkya573zv+N7yxEqIBCbXr37uHWqroLWXqbSyjC8WcoDl9AtmF2q8ws4
         w3KN98C0WBlr/pL7ljG2IGG6v7hSb2zdjcqb66wPErYt66N7nPFs1QNQMdURwArruwoc
         5fjg==
X-Forwarded-Encrypted: i=1; AJvYcCU4HCQcilDMlP2wwK8gIuK0PvQ6YVMMi6n8u9AA6A1CdBjZV5NdvkTS6GBDpBZV1q5S8F/jlaI/X6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp7JD5WUWV7E8VDtYy8FMJKgcjJ45x7lwyqfN89bR8+F9zCbzX
	abczoL0UcQtODe/t2wTzkEf8+z8sAEgdycyxol8jAg6obdavGIc31Me9AfaGixth
X-Gm-Gg: AZuq6aINZnAOZwJ3xlXmDvyfKOG5gUBe8dUsV3OyEDJekiAS/9jHenMlqo3787Di9bk
	K0dykT3YSY4yRyck9qYtIyKC9/8hBCk0qd0HrVJUdo+r/KwHbON4hI+MU4HD6UZOW9rUqcA9Gue
	R+wxA2G1SppPKJVv+tfTKL1qQugMlYRIeEAjy8eEDVeXY8P488M5+CYVkaObCAUeJ/6GGIYE9Rd
	RwjXCDuxowBdkARNL0QPzWtvun54W6gZ2wYnSx714DXwXgET02LmCyyYHkmOK+9iAi+wOp2cwyA
	K4UbiZyS3/8Jm4f6Ri14rmwY56lGS69xw/maIbvIywLMZBIJs5ipTtdB/tefm93feLtKCHAOO0z
	hTRs1ysapocg+ITAPCI6t7v89pzfld1rvy4sglTO0BMFWBlfKy6PK9C523iGYjjbTSCVdoDrS6N
	Pxhnlw9qn/njh47HUkCySQLo3/AfIDEd55lvOt+nC9MBbhaUl9
X-Received: by 2002:a05:6102:290c:b0:5ef:2cb6:4287 with SMTP id ada2fe7eead31-5f1a71a672cmr4441066137.35.1768902072176;
        Tue, 20 Jan 2026 01:41:12 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f1a6927ba6sm4143408137.6.2026.01.20.01.41.12
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 01:41:12 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5eb8f9be588so4673099137.3
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 01:41:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXeE4PSi9OcG/yAccbs9Omjee8PUutDWwLw6V9+782n86FjYCEtvma8X2kRHJpFfL574FdIZ19wRqo=@vger.kernel.org
X-Received: by 2002:a05:6102:1610:b0:530:f657:c40 with SMTP id
 ada2fe7eead31-5f1a712440dmr4338759137.22.1768901715766; Tue, 20 Jan 2026
 01:35:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118-rz-sdio-mux-v5-0-3c37e8872683@solid-run.com> <20260118-rz-sdio-mux-v5-1-3c37e8872683@solid-run.com>
In-Reply-To: <20260118-rz-sdio-mux-v5-1-3c37e8872683@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Jan 2026 10:35:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVf7MjEAaTAy3kgaTcfs240UcnL_yFWfYH_eqVfp-6jvA@mail.gmail.com>
X-Gm-Features: AZwV_QifN5dzgWIfmsNWfdw085d37JEd6a5y3M-TObPOlkszfcRmE9SintqdNzo
Message-ID: <CAMuHMdVf7MjEAaTAy3kgaTcfs240UcnL_yFWfYH_eqVfp-6jvA@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] phy: can-transceiver: rename temporary helper
 function to avoid conflict
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

On Sun, 18 Jan 2026 at 11:29, Josua Mayer <josua@solid-run.com> wrote:
> Rename the temporary devm_mux_state_get_optional function to avoid
> conflict with upcoming implementation in multiplexer subsystem.
>
> Acked-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

My
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
on v3 is still valid.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
