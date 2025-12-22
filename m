Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F73329C6B
	for <linux-mmc@vger.kernel.org>; Mon, 22 Dec 2025 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766398421; cv=none; b=ksw8C/FnGrxvaSSwUmGycz0LEbwNvpYKXEje8alv306su8VDrLkWC90cyKbEYPPCv+MzMBLepzNi0EVEeAj7GooeRDznZFXjBqcTKNYXIehbqDwvBDFXL/rBfkJPxegtL32574Q6Um1TizJaXlZRu6aw8VRup3Dlqq6NAO/pvmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766398421; c=relaxed/simple;
	bh=pYxC0xGJLfaMlKM2nphME9JmmJ1biPNjHd+MZwrmnFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0sJLj1uPfTlv+rAOzXK3hbW+0R6/qPCuaaqYS/bqTA1U7WpguOJ6sail8gQaTrvDM7H59GyxAS8hVgGoPwVwFohX+S+CiUZyEc9py2wcle17kJH5EvgPSHvy229mjbgaX8tQPlurMs5NxT2OnP23NB06AruSlJc0iQHn0EmDww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c701097a75so2056409a34.3
        for <linux-mmc@vger.kernel.org>; Mon, 22 Dec 2025 02:13:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766398418; x=1767003218;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEzlntz/A3Digs4sjukIlKb5qv62LH8yawTgFzZ88fo=;
        b=aPeElJGUOLJjSCF8xKWVSndSeXJndfIKQ8aKWbLlVXZxk/BpKWk6VVxh2nVuC5ghEu
         53/zsnMlsmmZSUFW/KmMyxupYF6EuVyXBONPx4VXW7/E+EKxZkTfYHm4RbsPL5e7I+vv
         XsG1UOFaDijy8j0gElpHUgTxBFGYHqDCaXPb/wnRrrExlcfBVtlWryqEFtKUIMgpPTiU
         hy8vjxWomogeUSep9tztzznK8i5NLCNMDbyvdXusnqbAyTUHupyzRT7uM+yobQzAtopE
         YJ+ZXZenBLFpA19vbQfOaGMwH6zS9ysV7dP2J2RG3sJjvKEunooJTdiAsOd8Za6E//92
         /stw==
X-Forwarded-Encrypted: i=1; AJvYcCUXJPGT1ZQw5yU+1lgLQoIoxb278/l3duECuj0AOmUNnAnUGjxQQGmoh7OTlNgeSEf0MbKI+/rAKSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFrTozqANO/9XCMUTvixb6LW+n0bTBcduQN41UBmpw63DDUT1t
	+LA/Byb4opvP0YpLVACpWXST4Vt1akBPmvhc6/VZmpbDkkwivIl3dMqcB4yso5DP
X-Gm-Gg: AY/fxX6gYlYWKi6YOaehobvGJPJSxaKVQzGjA0LnxoeuS9H6MOUSxbEYra62Hf7fiE+
	HTmgi9Y7ywsGhB5zxtPomXH9WW5SdeTyCeNe7IEJpVbQGrpb2xH11pj6eUFL6m9mSAVhER7Lk46
	/gMe+fAo17IvNB+19EL2Hjl2jLIZUwrbDBIZuj/TugmEsY8Vr2ydvgPQOFocmqFOhsxbrUHyrs/
	ZTbRkJFB7JgCrKwnYfOvPdzIMUxIYJUsiBIJlGFv+tgp/QKs596opViDDFNex/Iqyz/VLfVIShX
	nxaDMVNIziH5rMIifo6r5O+OL5pQUU4Kw+5pSJHkALgsSIi9SclIxbeZ8cmBJ53GOebB0TnlMTd
	KHHkD4w/eNUx8tbGcMYt5cHXk2uKa3R1Tcp6UXO1vEm8HKsLqw67KQEwlkJvg9zl0IGJkFjcIqB
	cfxvAb15loO29pgLSSZaQ60j7WF0n2FklPL7GJv0gx2F3+LF0pG16pOCGSvrE=
X-Google-Smtp-Source: AGHT+IEMd7zFqROmq6/4XvOe81SA9Jw1bjx2V18QWr7WCS78mJWd/eId141h0X0yYrTZ9RqC/jgMVg==
X-Received: by 2002:a05:6830:2645:b0:7c7:59a1:48d7 with SMTP id 46e09a7af769-7cc668ae2a4mr5063141a34.2.1766398418337;
        Mon, 22 Dec 2025 02:13:38 -0800 (PST)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667285f9sm7218688a34.5.2025.12.22.02.13.37
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 02:13:37 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-65d1a094185so956100eaf.1
        for <linux-mmc@vger.kernel.org>; Mon, 22 Dec 2025 02:13:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYmVLZLIWXvW97QKs4Heyj/oL9KlqKOUcydbfw6e8e+RKiTYXgwTM0EomtEYr5XwXh6d8C9ban5ko=@vger.kernel.org
X-Received: by 2002:a05:6102:3a0e:b0:5d7:de89:8dc6 with SMTP id
 ada2fe7eead31-5eb1a616c74mr2760273137.6.1766398102025; Mon, 22 Dec 2025
 02:08:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210-rz-sdio-mux-v3-0-ca628db56d60@solid-run.com> <20251210-rz-sdio-mux-v3-2-ca628db56d60@solid-run.com>
In-Reply-To: <20251210-rz-sdio-mux-v3-2-ca628db56d60@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Dec 2025 11:08:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXjAS6HOYy5=uxcK0RZL5X6agRoHG67QUw4xh5+ovZaJQ@mail.gmail.com>
X-Gm-Features: AQt7F2qgJlv5WWEn-8R7_EQWn45G6An5kBRt8R2C89e3bKVxcY7XZ_y43fEdjFs
Message-ID: <CAMuHMdXjAS6HOYy5=uxcK0RZL5X6agRoHG67QUw4xh5+ovZaJQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] mux: Add helper functions for getting optional and
 selected mux-state
To: Josua Mayer <josua@solid-run.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
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

Hi Josua,

On Wed, 10 Dec 2025 at 18:39, Josua Mayer <josua@solid-run.com> wrote:
> In-tree phy-can-transceiver driver has already implemented a local
> version of devm_mux_state_get_optional.
>
> The omap-i2c driver gets and selects an optional mux in its probe
> function without using any helper.
>
> Add new helper functions covering both aforementioned use-cases:
>
> - devm_mux_state_get_optional:
>   Get a mux-state if specified in dt, return NULL otherwise.
> - devm_mux_state_get_optional_selected:
>   Get and select a mux-state if specified in dt, return error or NULL.
>
> Existing mux_get helper function is changed to return -ENOENT in case dt
> did not specify a mux-state or -control matching given name (if valid).
> This matches of_parse_phandle_with_args semantics which also returns
> -ENOENT if the property does nto exists, or its value is zero.
>
> The new helper functions check for ENOENT to return NULL for optional
> muxes.
>
> Commit e153fdea9db04 ("phy: can-transceiver: Re-instate "mux-states"
> property presence check") noted that "mux_get() always prints an error
> message in case of an error, including when the property is not present,
> confusing the user."
>
> The first error message covers the case that a mux name is not matched
> in dt. This is removed as the returned error code (-ENOENT) is clear.
>
> The second error message is based on of_parse_phandle_with_args return
> value. In case mux description is missing from DT, it returns -ENOENT.
> Print error message only for other error codes.
>
> This ensures that the new helper functions will not confuse the user
> either.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Thanks for your patch!

> --- a/drivers/mux/core.c
> +++ b/drivers/mux/core.c
> @@ -542,11 +542,8 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
>                 else
>                         index = of_property_match_string(np, "mux-control-names",
>                                                          mux_name);
> -               if (index < 0) {
> -                       dev_err(dev, "mux controller '%s' not found\n",
> -                               mux_name);
> -                       return ERR_PTR(index);
> -               }
> +               if (index < 0)
> +                       return ERR_PTR(-ENOENT);
>         }
>
>         if (state)
> @@ -558,8 +555,10 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
>                                                  "mux-controls", "#mux-control-cells",
>                                                  index, &args);
>         if (ret) {
> -               dev_err(dev, "%pOF: failed to get mux-%s %s(%i)\n",
> -                       np, state ? "state" : "control", mux_name ?: "", index);
> +               if (ret != -ENOENT)

I think the non-optional variant should still print an error message in
case of -ENOENT, else this has to be duplicated in all drivers using it.

This is typically handled by having a non-printing core helper function,
and having printing non-optional, and non-printing/ignoring optional wrappers
around the former.

> +                       dev_err(dev, "%pOF: failed to get mux-%s %s(%i)\n",
> +                               np, state ? "state" : "control",
> +                               mux_name ?: "", index);
>                 return ERR_PTR(ret);
>         }
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
