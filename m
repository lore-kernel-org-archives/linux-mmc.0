Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066C8427A1A
	for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932230; cv=none; b=W4UeGubclIaNbsQM+/cHyTMMw3bZAJgoCPAc9AU0l8su3zUi3XuBgI5wTVIFJzIgZnraDGRYOcvVJ9iD2AVvJwNvwy3oggRVtGBZPT/8D/HF7qJUemQly7YI8MmqQNCxpe4G14mTBFZT9POqALd5td7wCQzKtFPijAlLTNnLNnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932230; c=relaxed/simple;
	bh=3/JP3tCIvtYedAAyMYL0a51zMnc14SZU20ikWY9BXqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjcINPOw93Qr+08V3ZKSf2ktxN9lwb5F+BqZYj5Sx0wBpsLkAvjsTwcGUqoZPTar/NSCyhKZDiILN37o/L9Wy9KocNwGF8FAHl9eJDzrjHW9qSQJb8CeeXzYyG2Dm0Qsy2OodxRM0Oj7/XAede1piPw0nmu37Bdk+qe6LpQ7CI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6611c3b147eso2783246eaf.2
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 10:03:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768932227; x=1769537027;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcPNSr1vco6+E9e0XJi5xyBPxmbRiBl/7/yDisLqrnI=;
        b=kKv+EBoBOjJQyVMnyPysNChxVoBdzFsdPEq8hmj+yYLm6V9TShq5T+NdCZpOO+NNec
         h+ZbKvrawkBllEV6jPLERHBoLBEf1RSzAuFonRRVMkQhJkYLgYJOMiLhNlMtXmopcPCL
         RV856Nr/Wje6F0qGD+OXkUKiewasKc6lZBreB7z8xFMawuLqReuvqLjaI1lDL4eBP/W5
         Y0YMPO/lQTwCjrwWMY2C0CJeHj1BccwNhgHmC5rpBTmA5aXvq8JTY6uQOI87dg/1Cmx7
         Qgh7B5LnyCRyJ6O+gL6OV5jK19zijZsTi+RzW4sEv8DG9m2YedqA2FheZGE/kEVpikxu
         ZfbA==
X-Forwarded-Encrypted: i=1; AJvYcCXzzXEebVqNFYbEr81fJ5QW1aCSt7uXcDDndxlGafm5tc5aTLNdh8ZPxncd7Pzo4Ars3LOTDD47Hks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQIPmSG1JF3qioXZyHV3KntkyS6OO9HqoUrugm7frf9x4W10O8
	4XL87XGcu2eBji4ysJZqQ2j8otr0mjV/792TNQbMhhoMKLe84ib6HuzqXed1TiID
X-Gm-Gg: AY/fxX4aG9hJHwFZXSj0CP/Rvh2dk9w/BFs4yu/Ng98oJcN0q7Jyy9kXbOZ73xi0ICY
	o7iHy6axgDiE44/qyMwyG0/d/veBtky3Telv5eXBVZ2d0+GzeeuC2PiVkCXJegHmeHeItHkh+6I
	5PcJStbG4uN0qhiBubj8GqrMPTnOHwEU7yW+S91NdQdzGB7izdeJcYQ1Q6b658/q9eD/uwkG+lJ
	yJwbB3FAtgdkULwDSY5PNu02y13pOCoFEH7SI0srCQ1JAAuIQBVZNsaJxkJlHnzoi+h4bBLHL0p
	2TBDRLLQ6EW89HBS0oKLSZqZ9V2fJbR3CjN+ngpSNBnCOniBIWvu2/bSNf3z7Oi9R0u45ioLrqy
	XMGBXCo4+e3jbD/e6GS3GLNQzy3C1J318SWm6jqLrk3czn3pdXxrI81MilTibg7z7CcmlLYcKWw
	8SU0//TO3UuZzBMjHf1680VAmh8+fsvBUv0VUZalF6Os43O5pEB/E=
X-Received: by 2002:a17:903:983:b0:2a7:952f:97c3 with SMTP id d9443c01a7336-2a7952f9cd4mr679845ad.21.1768924975987;
        Tue, 20 Jan 2026 08:02:55 -0800 (PST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com. [74.125.82.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352d57a56f2sm1687061a91.15.2026.01.20.08.02.55
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 08:02:55 -0800 (PST)
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so10213196eec.0
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 08:02:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLLz97cdZsWkdXBhfVKJ4djjhIAFvNv5anyGcZ3GrD6MmBQo0AHQgO/R9TApTXR/S87IEsaT3Y3v0=@vger.kernel.org
X-Received: by 2002:a05:6102:b15:b0:5df:c094:628d with SMTP id
 ada2fe7eead31-5f1a6fa3ca2mr4116825137.3.1768924652088; Tue, 20 Jan 2026
 07:57:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118-rz-sdio-mux-v5-0-3c37e8872683@solid-run.com> <20260118-rz-sdio-mux-v5-2-3c37e8872683@solid-run.com>
In-Reply-To: <20260118-rz-sdio-mux-v5-2-3c37e8872683@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Jan 2026 16:57:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU=wDmDJFYvtzxptAkkOQ8r7sPGUxp9u71e64ikY85+Zw@mail.gmail.com>
X-Gm-Features: AZwV_QgiDRrYV1BByFjO2lg9vbxQpf_lMefb8OE6E5E-nZ3iF4svsU32o-Zkiz4
Message-ID: <CAMuHMdU=wDmDJFYvtzxptAkkOQ8r7sPGUxp9u71e64ikY85+Zw@mail.gmail.com>
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
> @@ -46,6 +46,16 @@ static const struct class mux_class = {
>         .name = "mux",
>  };
>
> +/*
> + * struct devm_mux_state_state -       Tracks managed resources for mux-state objects.

Please run scripts/checkpatch.pl:

    WARNING: please, no space before tabs
    #80: FILE: drivers/mux/core.c:50:
    + * struct devm_mux_state_state - ^ITracks managed resources for
mux-state objects.$

> + * @mux:                               Pointer to a mux state.
> + * @exit:                              An optional callback to execte before free.
> + */
> +struct devm_mux_state_state {
> +       struct mux_state *mstate;
> +       int (*exit)(struct mux_state *mstate);
> +};
> +
>  static DEFINE_IDA(mux_ida);
>
>  static int __init mux_init(void)

> --- a/include/linux/mux/consumer.h
> +++ b/include/linux/mux/consumer.h

> +static inline void mux_control_put(struct mux_control *mux)
> +{
> +       return;
> +}

    WARNING: void function return statements are not generally useful
    #441: FILE: include/linux/mux/consumer.h:139:
    + return;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
