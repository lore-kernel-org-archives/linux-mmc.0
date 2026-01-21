Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC19136CE04
	for <linux-mmc@vger.kernel.org>; Wed, 21 Jan 2026 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768993213; cv=none; b=ghggHsUV2NTdN1qqL2XxYQ6yrccB/cNt38p1xC5f1bLIqorarpNV7/ge07qt7m/I1RjnsBnu/bQBEjCT9Y1IaLmdmVe+TnkbkI25J5QW1qZ23zmBOK7WagHXfVZZwy9mX67PR8gS7af/rlQ9HUefFp+YWD4MpoBn4rGp7zLynPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768993213; c=relaxed/simple;
	bh=cysOwS5g5dZRSxtVrJ3zv/VB5w+D2iLkyCuaPMhXFP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hi36LnZjmIT0Fg17z+xGaKgN+WLNKR1CJq2a6Ei2sDIfzdOaZOnpwIT8CMqPSPRcJdorcBst5AB5G6xPSC1NVIBclPuXadvkRR4LZwwkdteYdSfALESmvJrC/iKF/GAc6It78sTSw7tbwvGtto+LLUcezwbt5XmpcKIDF24CUNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5eb8f9be588so5580904137.3
        for <linux-mmc@vger.kernel.org>; Wed, 21 Jan 2026 03:00:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768993209; x=1769598009;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSYJm8i9wWqRvGvRTZz6VIsl7/oMewZT8tw/+hAgWzw=;
        b=Fbm8YGFEG2tYCWPliUYHjkHae1vmiLxIZO71BIsGHXEefo/1cDqYvr4OW0erjMJlJx
         ygnaoUZVU9J/i6q0hEIbj8V1HgWmn/OcjOVY2KPYpeYwjqqdRZemUsMTfvgViJO3junh
         jdB+ogtyXkGTcauq2aNtoPMcSQrRhKBNRqlim6MD/ncyK5po28ml47c+lenDP9w+d/Bv
         bUB7eL6S+1msrksqbPfFV98farAqp7/Gx5iY7ibAqCuQ1OjW2Ax/zybPTv4E/iM7MDM6
         XL+jWSpQmEzwbO2uByWzz7zbSnkzu7BlnSFlfrOgun6kDZhyMzQwm3pobcRMHp3sQYF8
         68nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmXaCBZtsAM97hniva4Cuy6nZeUfe3PvHiEEgn8gxuk90D1DtJQaJp2C79ejn9YlZ8vRhTZpchSeY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+GyDocHYmNxkvXi8NkhGYgz1q5Ib3hBggBjcc15yVssYmmZwr
	iIHbevICufjZ/c2+pqPmMj0sy1F+y8p0YTpke2BMtP8hpkUrxP8KGoEIdWXcb134
X-Gm-Gg: AZuq6aLb2RtTjphGKbTXAgMNTahULis4bwNGLFjaR6p0eFp/fqHBwm/iHzX4G2xJect
	tqrf1OpmDTnim+Im21SNuuV/n0A9cnV7wuFhgGzpPmaoHqosxz6t9tf0xVrgxDZJ/BAo7mZAGMi
	s891ureQiYayg66ADI3FrGd2NYoktuvDhR6T/BHmc7YJz4yyyoTimIpQTgoh2vRfRwxuEquJu6S
	L9uuwuenbxU4l6AZqqz82F7NoCg5PM6czuWl8pNGhJEPSGxPovO1Z8fEDqU+wyHyDYXgseL9+GS
	KEzPLN3iS3cD+ZV8FdvipSwdyZGl6pd7KLOOkXewhWrtm+/LyK6PjrJ5Vq/YAeajlEPG3D9fciy
	9mJj2xa93PUgFrdhFk2PZ3D5n+ymwrDqIy6/omDPOFjp/+7LHYhQJP+/GwKp+zo478U10GPecPn
	ElTzpRhNh/OHJlkrmOtSlykGfp36Q5QVD0pzTpul9btUGeRCgZ
X-Received: by 2002:a05:6102:54a8:b0:5dd:c533:1655 with SMTP id ada2fe7eead31-5f1a712884emr6578080137.20.1768993208009;
        Wed, 21 Jan 2026 03:00:08 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-947d03eaf17sm4631000241.8.2026.01.21.03.00.04
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 03:00:04 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-94121102a54so4244262241.1
        for <linux-mmc@vger.kernel.org>; Wed, 21 Jan 2026 03:00:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXsCrFGnZ8S8SJ4T09M2GMy7hMeck8ifRgklXEaZzqf+BZrq2RjEA/IqDllioTQjDWNMNm5SGBrWKk=@vger.kernel.org
X-Received: by 2002:a05:6102:2ad6:b0:5ef:248b:d533 with SMTP id
 ada2fe7eead31-5f1a716fcbcmr6150752137.31.1768993204250; Wed, 21 Jan 2026
 03:00:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121-rz-sdio-mux-v6-0-38aa39527928@solid-run.com> <20260121-rz-sdio-mux-v6-3-38aa39527928@solid-run.com>
In-Reply-To: <20260121-rz-sdio-mux-v6-3-38aa39527928@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Jan 2026 11:59:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX_rKgfusHP5qVny8OZufU6VAiA6sqg1LP3T2jikSz7yQ@mail.gmail.com>
X-Gm-Features: AZwV_QifTISU05sQ0lYySqx5XyPjAzUqa1H8fmOUOfLhWhGN7rzCzfM2UGq26-s
Message-ID: <CAMuHMdX_rKgfusHP5qVny8OZufU6VAiA6sqg1LP3T2jikSz7yQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] mux: add help text for MULTIPLEXER config option
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

On Wed, 21 Jan 2026 at 11:02, Josua Mayer <josua@solid-run.com> wrote:
> Add help text for CONFIG_MULTIPLEXER to allow enabling this option
> through the kernel configuration without explicit "select" driver
> dependencies.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Thanks for your patch!

> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -5,6 +5,14 @@
>
>  config MULTIPLEXER
>         tristate
> +       help
> +         Generic Multiplexer Support.
> +
> +         This framework is designed to abstract multiplexer handling for
> +         devices via various GPIO-, MMIO/Regmap or specific multiplexer
> +         controller chips.
> +
> +         If unsure, say no.
>
>  menu "Multiplexer drivers"
>         depends on MULTIPLEXER
>

Unfortunately it doesn't work like that. As the tristate has no prompt
specified, the user will never be asked about this.
You should use something like below:

--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -4,10 +4,8 @@
 #

 config MULTIPLEXER
-       tristate
+       tristate "Generic Multiplexer Support" if COMPILE_TEST
        help
-         Generic Multiplexer Support.
-
          This framework is designed to abstract multiplexer handling for
          devices via various GPIO-, MMIO/Regmap or specific multiplexer
          controller chips.

Sorry for not noticing before.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
