Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FF226158B
	for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768902346; cv=none; b=G8SAMRJqLKRzMfA8D0SNujaGlwN7rgKlx8tEndWn/2yA3UUCWBbef7Yiqg5QZFY3QljRG1D1Srp5GzDHK51zEmB0riw4Na9za7kSDfO6R/D3AOrQsqjqATapUloSAqUtW2RFp4KpvWLGZEnQjoFcfsOVbfBaofShHRmlz3Ea+9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768902346; c=relaxed/simple;
	bh=Y2e+JbZ5geFsLrIwdXvR6J7aoCBZ+QeMG1PGfBHkwC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBMQaM1Rj+cjoy1CgFvbMvWgCtxIgs1nQ7svqRj58BQ/TYuGOmGNQPyMKHmk2K/xSt+uAnyVwsHtjhvfcYtAxzVokh9a8mceTHzqFcvtdiglYmwCHycd2NymEY9V09jIUNPx2qtXJPgp9IBe+DGV6PVT28VRlkaXG1RCwS1UwFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5eea75115ceso4430448137.1
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 01:45:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768902343; x=1769507143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l18hDtqu7l45yo1vlmek39RB1c0Zv/I56SgfcgBEbBk=;
        b=pv6QjpIU1B/Ggh8QkamfdkydTbej83cCo9ClutMdvuhzOvCx41DZpye8m1W6qkbU9j
         0V80Uk8/YYcBQnXzg1iJ9YLRwYIKekcRQuZBup4kVj/+GJPyU8g6/cK5o8CbBY3pkyzS
         QKePsC+dhtZsogiXWZz6U56ySUaMKPRRDJ51YrCqJUNekTvaQ2nxJ02B/8WkqUcTFCid
         3omzTpX5DE+j868JGP20yRxxzEufZp92SQhM5rH7Kclj1Q5g3GjYLZZBW+dr+2KacdgK
         CUiP8rnO1gsOIrgTe63rm0c6RBzfv6fisBiq/3uUO59C3oSxm4IypmM7pM/7ix3ZBXXa
         lZEw==
X-Forwarded-Encrypted: i=1; AJvYcCVml6RwQO9uJ1CoCZ30JD6oCiDd1HC4zWWfDixBTNZpcJpbwnVcE+zSJa413RYUcQ1IwojCwbqqcO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNHcWFlZGnNz0OBKPZKBlbjVUFn4fr4BUA9pccWdAnj2cXHDnP
	2gS+jSEm6dtLny9VqnWhmpiEIi2rnMZ6qZo8/JUJ/KMycZeZJRi+AY9+XOAzFiHE
X-Gm-Gg: AZuq6aJ1xIDNcZevzTXmSxSUz9IqisfBxpJavTIZL7TY5Hr8NxcJ20Uwtvrr6xs5gj/
	pwXbtrNLzazMU9RzmR72KeeCxQRWM1CVgRJRLOwj9ihcm/KgzOanbAS09KaN8jySvRFay6evbX5
	rTiqIEG4K3fYMjKCnea0h+wk4ZxHSfLw1UDjRom74cYyxoq0tceqOscoW+hvwvVc4jOubakskua
	MuJTaL2EQSuzxd4h4XzoEs2JahKf6zHAZr6QDJ0iu3NV3Wu6QzSnhd7fkFGuqdkq1+rscnL4Wbq
	b4oGm+ffg/AYvIxd4iugzZShcjkAiliQuJJ8VVYShkavEchEmQBQAOzxoc7lbWeZYrSnnZOpYxs
	TAJDbgPQbQa3LqjUJhpT4EX1ONGam0lHfzWSY3K1w6HGnMl+Lo5qHPqbXWLlyTBo+X5V+Xs3H5p
	GQx2kVkFQKz71S7kdHWGM06Vr6zcDpa82eOFoCB7X4DhhzkBUY
X-Received: by 2002:a05:6102:d92:b0:5ed:ab0:e5d1 with SMTP id ada2fe7eead31-5f192539f6amr6246381137.15.1768902343089;
        Tue, 20 Jan 2026 01:45:43 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-947d04377bfsm4046971241.10.2026.01.20.01.45.42
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 01:45:42 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-93f523bba52so3322814241.1
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 01:45:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXq5WcV33S67J5f+zwyTwa4gFZCMOROh7M/XbtmqTWupFsVTxV9uOURnmu1MurTCoi09H1F78+3xTM=@vger.kernel.org
X-Received: by 2002:a05:6102:cd1:b0:5ef:233e:6b25 with SMTP id
 ada2fe7eead31-5f192508654mr6479996137.13.1768902342092; Tue, 20 Jan 2026
 01:45:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118-rz-sdio-mux-v5-0-3c37e8872683@solid-run.com> <20260118-rz-sdio-mux-v5-2-3c37e8872683@solid-run.com>
In-Reply-To: <20260118-rz-sdio-mux-v5-2-3c37e8872683@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Jan 2026 10:45:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWnpci1v1oQb34_QRtU-P3S8TSormmNudajT0e34EO14w@mail.gmail.com>
X-Gm-Features: AZwV_Qh1sWLkk903wC1dLdg8mLxjiEBVkYZdOb9H2O-Zh60PCWOHx0RPYuQB8LA
Message-ID: <CAMuHMdWnpci1v1oQb34_QRtU-P3S8TSormmNudajT0e34EO14w@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] mux: Add helper functions for getting optional and
 selected mux-state
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
> In-tree phy-can-transceiver driver has already implemented a local
> version of devm_mux_state_get_optional.
>
> The omap-i2c driver gets and selects an optional mux in its probe
> function without using any helper.
>
> Add new helper functions covering both aforementioned use-cases:
>
> - mux_control_get_optional:
>   Get a mux-control if specified in dt, return NULL otherwise.
> - devm_mux_state_get_optional:
>   Get a mux-state if specified in dt, return NULL otherwise.
> - devm_mux_state_get_selected:
>   Get and select a mux-state specified in dt, return error otherwise.
> - devm_mux_state_get_optional_selected:
>   Get and select a mux-state if specified in dt, return error or NULL.
>
> Existing mux_get helper function is changed to take an extra argument
> indicating whether the mux is optional.
> In this case no error is printed, and NULL returned in case of ENOENT.
>
> Calling code is adapted to handle NULL return case, and to pass optional
> argument as required.
>
> To support automatic deselect for _selected helper, a new structure is
> created storing an exit pointer similar to clock core which is called on
> release.
>
> To facilitate code sharing between optional/mandatory/selected helpers,
> a new internal helper function is added to handle quiet (optional) and
> verbose (mandatory) errors, as well as storing the correct callback for
> devm release: __devm_mux_state_get
>
> Due to this structure devm_mux_state_get_*_selected can no longer print
> a useful error message when select fails. Instead callers should print
> errors where needed.
>
> Commit e153fdea9db04 ("phy: can-transceiver: Re-instate "mux-states"
> property presence check") noted that "mux_get() always prints an error
> message in case of an error, including when the property is not present,
> confusing the user."
>
> The first error message covers the case that a mux name is not matched
> in dt. The second error message is based on of_parse_phandle_with_args
> return value.
>
> In optional case no error is printed and NULL is returned.
> This ensures that the new helper functions will not confuse the user
> either.
>
> With the addition of optional helper functions it became clear that
> drivers should compile and link even if CONFIG_MULTIPLEXER was not enabled.
> Add stubs for all symbols exported by mux core.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Thanks for your patch!

> --- a/drivers/mux/core.c
> +++ b/drivers/mux/core.c

> @@ -677,7 +707,7 @@ EXPORT_SYMBOL_GPL(devm_mux_control_get);
>   *
>   * Return: A pointer to the mux-state, or an ERR_PTR with a negative errno.
>   */
> -static struct mux_state *mux_state_get(struct device *dev, const char *mux_name)
> +static struct mux_state *mux_state_get(struct device *dev, const char *mux_name, bool optional)
>  {
>         struct mux_state *mstate;
>
> @@ -685,12 +715,10 @@ static struct mux_state *mux_state_get(struct device *dev, const char *mux_name)
>         if (!mstate)
>                 return ERR_PTR(-ENOMEM);
>
> -       mstate->mux = mux_get(dev, mux_name, &mstate->state);
> -       if (IS_ERR(mstate->mux)) {
> -               int err = PTR_ERR(mstate->mux);
> -
> +       mstate->mux = mux_get(dev, mux_name, &mstate->state, optional);
> +       if (IS_ERR_OR_NULL(mstate->mux)) {
>                 kfree(mstate);

mstate is freed here...

> -               return ERR_PTR(err);
> +               return ERR_CAST(mstate->mux);

... and dereferenced here, leading to a use after free.

>         }
>
>         return mstate;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
