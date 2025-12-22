Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F384D311940
	for <linux-mmc@vger.kernel.org>; Mon, 22 Dec 2025 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766401645; cv=none; b=QzG0DFQXG8tqrOtpE/t7g1j5hxYoVoGwan4SfhEToNTZcYdZYEQhNPP6K3qT2izkPEnPLUgA4QYYFJHqRwNdfVt1ttUeUiKnEpr8FqkcgN+veTpBcBZ7OSo4VQY1RcptN2WckrYUhDf4DzpPB3vQWWUp/ONsoNDuUeP4bSTtgw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766401645; c=relaxed/simple;
	bh=Sa6vRFp+J8CzdQeFDX4yWNCdRt01fLLpAObxTP7lVIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UinNrTgo8ART+RXxrintf++sKAv0M/VJRK8L+wojbf/3+3AhlvYRv8jVBDOkf8npXB8+qoadkGy7Vn9Bvco7VOCbLEoAHPgKpOTHzeuc8wPGCPHsDs6aa4pzUhTSKdsoHOmuS2sGh/mZtktw4BL1WGVoMhUbH57xuhNEhCHMZgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-65d0441b6feso2206566eaf.1
        for <linux-mmc@vger.kernel.org>; Mon, 22 Dec 2025 03:07:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766401643; x=1767006443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Er9fT5sSTO9v6Ol7FhPUI+D4OHHff+0Re947MEjlztA=;
        b=YQyPOcj6XsHrW3EalrK1Hzub/24bfvPBdLXR27qhy3gmx1WSAC6FQKzIxePf8qva/I
         QV9DKWPsKe9K083sKWc7fP6XoOLE0G3BeVxuJYd5XmaiTX6yO0lPSS1+GqO46D91p9ef
         PciVd5dx93jUhDbE0FxVK0OdpgjKFjfOqWHFdVuH0O3NhI0Th98U4kQAbeqnC8Z6l+a+
         xy47Ntk5hbSJ8IxZoER/jMGWOpj1wxe0wPzDAz6HI/XAYvfJ6rs8xwj3ldPDJSy/dSTo
         +DOwZ+IC5l53rggCK6xdX+CdPK9T1v5WbgIQenXfA86b7rHbpad7YuOWm88m6oGokENQ
         ekqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuzsgvNgjszP4CIfg65T8Jf6hP2BSTBoFl9o3RHVOwJgUKllaviraZ1/s+puGk7f4JzWpa7YIkiVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJboaHN/wQZLSN+8Uu+K8VIJYs1A0OuJtvmRJDOC8pNkB6hf9+
	4kumiwxr3rcpFidEEil3z27cG0h5KuEsnMBzBqRm8mtGBxg5Xr4AGsMop1sW5nLB
X-Gm-Gg: AY/fxX7QhCLFXfiLz3VdPcyn7xsVsAclM5cj9mMWkyXol+C8060gz2CXz0V4eY4WR3x
	CpEREFPO8WK6FEWqMwlQEdATAy3tOG1N0Rf0eFbSJ9dzUFAQ+wD6umSbY+zkJ6NC6MthnE5Y5mE
	bJgq3v1esqKAqoavnt4/GDbLjDCht0Z1EUlaj29qoDE6wFMh/DGu+fHONpN5y3/QqneW84AOt/v
	jmL9HB5dD+W+u9qkUBIHFP48WHFgHWFt3NfNSasdcGXet8F2/1RRWTXHgI1USZYykjwUkqZgBz3
	YzYprme/6EXgOTcolC/rsjlAN/NWKEyTClw4SUM/JVDauh4G6pGKSZcFpWx8SYwm7DrcPXss3kQ
	RU8ZtF1QIFpnnFvUfXi5YHBLGNJCm2wH1pV4lmebdhvyzPiRFR8OmOkbLJkzu+P8TW05WBUZf+t
	yP/n5O7WqX0s3elbONGQd9NkQA8Okya9onPvg5I806A3c2iOIy032xLp3re7s=
X-Google-Smtp-Source: AGHT+IE75Y+n0W45rB4ZjjW1IzaPygTv8647BSBPzgY/uSJrYQRbPOov7LrD3iS3MGkU/TOdIXizFQ==
X-Received: by 2002:a05:6820:7808:b0:659:9a49:8f01 with SMTP id 006d021491bc7-65d0e98796dmr2957350eaf.18.1766401642657;
        Mon, 22 Dec 2025 03:07:22 -0800 (PST)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com. [209.85.210.44])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65d0f1f1caesm6566208eaf.0.2025.12.22.03.07.21
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 03:07:22 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c7bfba3996so2255153a34.0
        for <linux-mmc@vger.kernel.org>; Mon, 22 Dec 2025 03:07:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVYh3exZ7xHLbFzcqJw4JcKSo0pcs/6jddx7nX0CAfLQfQtYklOdiv7dI3FEcsHFC5tqHw4a2+6qQA=@vger.kernel.org
X-Received: by 2002:a05:6102:e0e:b0:5e5:5ed7:60ae with SMTP id
 ada2fe7eead31-5eb1a817635mr3544923137.31.1766401227460; Mon, 22 Dec 2025
 03:00:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210-rz-sdio-mux-v3-0-ca628db56d60@solid-run.com> <20251210-rz-sdio-mux-v3-3-ca628db56d60@solid-run.com>
In-Reply-To: <20251210-rz-sdio-mux-v3-3-ca628db56d60@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Dec 2025 12:00:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXmKPe6AyfAeD9nObqVhofZ4a5559_=DbDZzJ57A7=k9g@mail.gmail.com>
X-Gm-Features: AQt7F2qYMU-2Y0vKWd5gUo3SltdOK-02OVX3vIl9B9fuc7xPsFnO8gx3yQGyGmE
Message-ID: <CAMuHMdXmKPe6AyfAeD9nObqVhofZ4a5559_=DbDZzJ57A7=k9g@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] phy: can-transceiver: drop temporary helper
 getting optional mux-state
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
> Multiplexer subsystem has now added helpers for getting managed optional
> mux-state.
>
> Switch to the new devm_mux_state_get_optional helper.
>
> This change is only compile-tested.
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
