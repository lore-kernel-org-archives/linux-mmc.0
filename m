Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0ED3AE6ED
	for <linux-mmc@vger.kernel.org>; Wed, 25 Feb 2026 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022339; cv=pass; b=YOJdOpkPCibKD49WzG15f1puhS+aBx5bA6+iMiTrrqFKeF4tKrgZts1cngptHAPLOSqSGe+I0yuWPMk393m7TWx7B5BmoCs3KWmi4vLMj/yruCS+f7nQGUjIEOyMb4zAWeML2W5qkkFKz32I+D/tpJU4OL4e/QLIVxdX9M5Gl7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022339; c=relaxed/simple;
	bh=jXjctxlX2mOd4kESSuh+dmt6ufaPRbeKlSyIRNOCp10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QeijLKXl0yO5L1qcL5fej8/Yfn2lw2FjkffNl0iAejtaQblMygr9gVMZeGSMkFXoecMmO5eoEjehx/OfAVfeijg1enjUoUkz5MwjAFgRW4yRGk6INdvinmoA3/DKwJBi8R+LWLdoSrg34bUEM3+uoMXj/w8BkzeOS4C07ZxVppw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sDSkUWOS; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sDSkUWOS"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59e4989dacdso6929848e87.1
        for <linux-mmc@vger.kernel.org>; Wed, 25 Feb 2026 04:25:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772022336; cv=none;
        d=google.com; s=arc-20240605;
        b=FJSPcWg2z+hIv9nvRn1GPRmDl5CWIWSvsnJlFirZKc3OSwO7UsIoKgquPkfXhSAFoM
         jYLYbn+Dpcrty1AYLhoslU/J/h88M5WXGr5xZ9wgYNTXV55WUrtE9vQi4dt8d0ZtZnDA
         7rPJssLQkiQhwvBvA/XaUnwkRRothfF7DucKxVjYy2bP2loVBXzBrNJ/RN2emPiqTqYe
         mo/D8AmyzTxf9q+kBa14BPseFLQs7nkIJQS54XUKZsEJ8pTIVEeQngyTxR6E6kyMovi2
         ejG4Exf6Ia89RTxPxL3uqGUA4q5KePSWBBHvS2L9Uo7lfuWbvkfkWFX1SMMnBWgYRh9A
         2Y/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ySl6ydztfTvafF7H4MeeeCO8Ou666oUNAgwfiGo+Y6c=;
        fh=6wHirfcC2absicr37UTh0mLMPiijUQmO6vwroay27y4=;
        b=d8hx45uexX2MdkKjW+BTQTuBwu+1ukx6EWUFtAULb3DvLPeNclHfdeZfKD6KiOuNQ2
         zDTawtfn5HDzFxcESk1XURnXiugUELttrxvYngblojj33JEx5SywYI8RweG/jSWbrtQi
         4aWjw0a78Lih5kCmElWdMI7iFVOI9HHGEwHELQy6UN7iIRRTIm8oE+Oue/56ukErADCb
         RbuMzbWL1J+4T8Tcz+SCXfiAdXCMGqvAnElPg9J8M9qXpzZUxgVcAP8nhOHuTR8f2Py6
         LkiIZ5Ksp1RXyyLBQQYQN2qSqj7YRxXE0CDIBz/+wG0GKy+pZzt64dR7T+urfkELUVY0
         NiYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772022336; x=1772627136; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ySl6ydztfTvafF7H4MeeeCO8Ou666oUNAgwfiGo+Y6c=;
        b=sDSkUWOSKvxKxjfBRCLCeRWRlaT6myxGf91d+cFmFgdZeVpuujfiENdVsDX7udA6j9
         pq1oYL0Z44XH1uBM1U0j5o6vT/g0VHsuPW7VKOlAh3vAFVAvv4LSR+zBB1m/xA4aZuQP
         i5b4HPUHtjrCPeOGTsRUIZ53UfjBprittrXK7qS+s2NnOcfPo7honzsfS27MXC/InZGi
         RL8Qld4kNmEEetpOF6OzFZMCoqxqAhGutWICH0o8TsfxY/Nn5QlMLG1KV2qjgaR2HxkK
         675I+ZHxJ5EURxmjfCPiXQ6IFhuz/eZzLTmEdkYhokM8Xaw40D5sfnIjoz4pNhP09wFU
         Qwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772022336; x=1772627136;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySl6ydztfTvafF7H4MeeeCO8Ou666oUNAgwfiGo+Y6c=;
        b=Rli2D/IdCgdwBDo1j32sMF3nJPuxNlFcr0TkBPrTFHoUcnUJ8uiYX35uNUzsPM2Svh
         dvWQ7s+6Ad+ffFTp1q2vjlfP5W//2FtoLT+CER/sDO4Kpdh+FsJ389+vq5ISS8uvgACp
         wdIc4cw64VBLeIrJvNSk7HX2n2UGbBpj3jl0lJySSpFz7XMjAWGzPq0Us4sQtzs+F15T
         shZxN75k7OgAMk4huU9l2OeR4sLhNkPOB+5yWK0LJjbeYrEvbrjXQyBTmtpzvb8S/0OQ
         WWUq+ViCFsYoF6UUz9YNMLfVydyqWGEpAOTNXoJTT6fg8M7dznE8DHk+KUnPHDr5Rmf+
         qWzw==
X-Forwarded-Encrypted: i=1; AJvYcCU99YIwvgpWyr8tCI3v0Qqt1rdLQ+NOAhlQiwnT/oEbtuGmVXeZqR6buMBqC5fz7cUjKQXV3WF6C7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV5RWLOYuiv/9a3lzybJHeDCkUhx856Oo3YiUs20U3exSXqvkT
	tcFMAt8bNgYkQdezKuCKp52yc1lBg/lnQ8SixGRWdZ+/XzTeHucU3EPrDHg3qKEHOs+JWmRIaSs
	vn4zY+We9l5LT6jaFigWMXivvec/+fiOVHyJ7aEBuIg==
X-Gm-Gg: ATEYQzw9DmS9aL3le60Dc7DeBgWnioa14muHyMSELzFxpjIM+8bz5R9GiWss3Burwud
	+0i6sFa1Cgubesi+RxKEU0xrd9ucqmyjbg4pgp8tJbPizrIZ+/U0RQT/fJJzi39XXrUuQ2/KXuI
	oC0Slo1DYrIaUgtgLcXurAHnnAWtsqtGmQlPMHCV2W5wLtQZ+m6pngc7rFW+H1psFZgeyXKdZPk
	cMtM+HaRdvlgh3GqUmIp5MmBQOCZqX4CexVJS6LpTCqW56f1yOU32pzJynpUWvBkk464+1oBF+M
	koj62YYj
X-Received: by 2002:a05:6512:32c7:b0:59f:8e98:5dc4 with SMTP id
 2adb3069b0e04-5a0ed8a5ef7mr5479022e87.23.1772022335501; Wed, 25 Feb 2026
 04:25:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com> <20260225-rz-sdio-mux-v10-8-1ee44f2ea112@solid-run.com>
In-Reply-To: <20260225-rz-sdio-mux-v10-8-1ee44f2ea112@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 25 Feb 2026 13:24:59 +0100
X-Gm-Features: AaiRm51lt-nfdrgge9ulVu4LPr2JQVPo_YLU5CXuzn9PVqh2A9E2AaS4fZriRp8
Message-ID: <CAPDyKFoDZr33tQXofsZzPrJbZM=3VhpeeOk1GqvRA1UK=LO5Ww@mail.gmail.com>
Subject: Re: [PATCH v10 8/9] mux: add prompt and help text to
 CONFIG_MULTIPLEXER making it visible
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
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

On Wed, 25 Feb 2026 at 12:35, Josua Mayer <josua@solid-run.com> wrote:
>
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
> ---
>  drivers/mux/Kconfig | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> index c68132e38138..4f7c6bb86fc6 100644
> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -4,7 +4,14 @@
>  #
>
>  config MULTIPLEXER
> -       tristate
> +       tristate "Generic Multiplexer Support"
> +       default m if COMPILE_TEST

Allowing the core being a module makes things/code a bit unnecessarily
complicated, I think.

Similar to other subsystems (like regulators/clk/etc), the core is a
bool and the menu below it for its provider drivers depends on it to
be configurable, allowing them to be tristate.

> +       help
> +         This framework is designed to abstract multiplexer handling for
> +         devices via various GPIO-, MMIO/Regmap or specific multiplexer
> +         controller chips.
> +
> +         If unsure, say no.
>

continuing from the above comment, this would instead be:

if MULTIPLEXER

menu "Multiplexer drivers"


>  menu "Multiplexer drivers"
>         depends on MULTIPLEXER
>
> --
> 2.43.0
>

Kind regards
Uffe
