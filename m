Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B1A3ACF1B
	for <linux-mmc@vger.kernel.org>; Wed, 25 Feb 2026 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772021733; cv=none; b=uE/oTTIWN6Ou/8i9bhWMNe3fM4f2e1XRGv79IaS47ML9a32IaWP33MXF05RzfSisKE29JSwGIMvElmVKPbwSv0S4n+JzHhNcFg+tScJfEPy01G0D7+2gZgJECYsJ5MoaUeVw2aAuMDjY7FRlmqHiHfh7lX7eZnnknL+eLcP1ScY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772021733; c=relaxed/simple;
	bh=b7bATi+E9HIWEWXTAIwNa4451ABKjWAafWaU1v8UUAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h15AGqwRpOuOefw9/TiKaPzYpQioykoEc9txxyktZyFj9SHLvMe9nvZ4aVJ2Snyjk4SfcOUHN/9UeM2LWm+5a0xQ45u2AlBSChzc/yt24jeojx8SwdyYNVRgPDQ1IcYkb0SFZ+aUqCyWgXMjdsrowow7Mnnep2+TLL5JqSgek7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4648448e387so1369106b6e.1
        for <linux-mmc@vger.kernel.org>; Wed, 25 Feb 2026 04:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772021731; x=1772626531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TQ9plTAtoqFGycuAV6Q4VO2kslCQXeQ3NGwgtKeiuo=;
        b=DKJ9s18/yO464eZQlRqZwGZ4jlxxhPCDOAucYDbiHdBvuioXfGJqgJ+cRyXpLQtOKY
         WRH7MZg7p8uKN+aulLnIWPJzQfGuUsDvFTCome61QNKcWb6kBQGRVU0PRYrPCJZlNYbk
         2UxovdvHL5o3w4qSvAsTaT0qwaYrN5QeVaaY9c+n4C/PNm6wlCjOT8vPfptoNo06BYg2
         mbvYH/2e/pbF62dK0ecqhkZCcWD9oRPRsjDRdVZ+JHhWPJhckV3YzbZBynXegCv7Dndk
         i0Oh2n9w9stjcqfZURxQ0ywpeG3uXllu9KcDc1I+SEA6cpvU763JYJyflPDXhYiBe6KN
         JJrg==
X-Forwarded-Encrypted: i=1; AJvYcCXwUhfh5TL+7JIiTsVpggjL9WJnK58kkdVfoNWflnmcf2EcKbAyO3XdNGZXPBAQED1+DTFCnguPCfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvoN9yMcJ1bvIOYh9dtqJqPXslInRcbGYmkeQVoA+58ivLviFl
	UpMAL9sPtD/deArGdSWkbea343cFgr0t86wlBrHImgn+z4wUXzHzTCaocyPpGa24
X-Gm-Gg: ATEYQzwzBiSuNqftj+qFNPIv5I9T3DeGfXTu1SmBLGhK/AYmTMEzPU0hy6jxXI4rIXx
	BLdDZxrKqgDD/paP878+GmVp98gmkPxlZXLjeYVkJfJilJdu75ib/e0ZVd7VBj9OIHvnPdv9kem
	wl0SavaNRdAZ5S3MJrfzTV0j90RvIAu903B3WRh7uR6RS4WCEBN/sPNaPrRfhMLwpF2ZP+5d6C+
	iOxaozsZjbEck5FETbBOHfXhpTlYaCgxHMfL3bGiocSMFqLWKTH8dAHlCMYrE2gMjIu0/sb/Y3c
	SyXbrA8MUwtbN3K+jwxMjpqZdVB2SvaceAyBYXBYL/cJqZZs6PL0qkNevYF9yhLyMa+pF4zix7f
	9HMpRL7OWR6m7k8nLlDVV2+aLXFMbSdQWmAj6hN3z0yHXrmnezBAizgkuBqzUYghANh7BQv6xOv
	LQKeTAhtJxBAQywNex6RK/eK2ZsscTJPT7DqIOXU/yJs/3nfSsiMFgb7PshAn8/ToSVCqpvqp/n
	v0=
X-Received: by 2002:a05:6871:4e45:b0:40e:d975:3ce7 with SMTP id 586e51a60fabf-415ffca676fmr56601fac.2.1772021730755;
        Wed, 25 Feb 2026 04:15:30 -0800 (PST)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com. [209.85.167.175])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-415f93e0c78sm613029fac.18.2026.02.25.04.15.30
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 04:15:30 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-463960df4f9so4432685b6e.0
        for <linux-mmc@vger.kernel.org>; Wed, 25 Feb 2026 04:15:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXNnIKJ1T6QxELzcyJlJqYiCeDA47k0zQF/WLR/u0pDX7JsCUM6FFXFaLsCTGtUsDb4ac8xHERvZ44=@vger.kernel.org
X-Received: by 2002:a05:6122:8c27:b0:563:702b:e2a7 with SMTP id
 71dfb90a1353d-56a8bcb7a04mr108622e0c.19.1772021289726; Wed, 25 Feb 2026
 04:08:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com> <20260225-rz-sdio-mux-v10-8-1ee44f2ea112@solid-run.com>
In-Reply-To: <20260225-rz-sdio-mux-v10-8-1ee44f2ea112@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Feb 2026 13:07:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUSU8Y9gj5qJ7qNE1UVhp7=HTjAxEsL6uZXPXFgwTd+7Q@mail.gmail.com>
X-Gm-Features: AaiRm538QW2lNPSmHsPdoAK0GxPwumP2I07aJZ0lsRKIlDak2p-vOeVkZ133ww0
Message-ID: <CAMuHMdUSU8Y9gj5qJ7qNE1UVhp7=HTjAxEsL6uZXPXFgwTd+7Q@mail.gmail.com>
Subject: Re: [PATCH v10 8/9] mux: add prompt and help text to
 CONFIG_MULTIPLEXER making it visible
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
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Mikhail Anikin <mikhail.anikin@solid-run.com>, 
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Josua,

On Wed, 25 Feb 2026 at 12:35, Josua Mayer <josua@solid-run.com> wrote:
> The multiplexer subsystem was initially designed only for use by drivers
> that require muxes, and did in particular not consider optional muxes or
> to compile as a module.
>
> Over time several drivers have added a "select MULTIPLEXER" dependency,
> some of which require a mux and some consider it optional. v7.0-rc1
> shows 15 such occurrences in Kconfig files, in a variety of subsystems.
>
> Further some drivers such as gpio-mux are useful on their own (e.g.
> through device-tree idle-state property), but can not currently be
> selected through menuconfig unless another driver selecting MULTIPLEXER
> symbol was enabled first.
>
> The natural step forward to allow enabling mux core and drivers would be
> adding prompt and help text to the existing symbol.
>
> This violates the general kbuild advice to avoid selecting visible
> symbols.
>
> Alternatively addition of a wrapper symbol MUX_CORE was considered,
> which in turn would "select MULTIPLEXER". This however creates new
> issues and confusion as MULTIPLEXER and MUX_CORE need to share the same
> state, i.e. MUX_CORE in menuconfig must not be set to m while
> MULTIPLEXER was selected builtin. Further confusion occurs with Kconfig
> "depends on" relationships that could reference either MUX_CORE or
> MULTIPLEXER.
>
> It is common across the tree for subsystem symbols to be both visible
> and selected, e.g. I2C & SPI. In the same spirit multiplexer needs to
> ignore this particular kbuild rule.
>
> Add prompt and help text to the existing MULTIPLEXER symbol, making it
> visible in (menu)config without breaking existing "select MULTIPLEXER"
> occurrences in the tree.
>
> Select it by default when COMPILE_TEST is set for better coverage.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Thanks for your patch!

> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -4,7 +4,14 @@
>  #
>
>  config MULTIPLEXER
> -       tristate
> +       tristate "Generic Multiplexer Support"
> +       default m if COMPILE_TEST

Please drop this line.  Merely enabling COMPILE_TEST should not
enable extra functionality.

> +       help
> +         This framework is designed to abstract multiplexer handling for
> +         devices via various GPIO-, MMIO/Regmap or specific multiplexer
> +         controller chips.
> +
> +         If unsure, say no.
>
>  menu "Multiplexer drivers"
>         depends on MULTIPLEXER

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
