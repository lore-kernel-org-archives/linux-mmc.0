Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE22199FB0
	for <linux-mmc@vger.kernel.org>; Mon, 16 Feb 2026 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771236105; cv=none; b=H80N3bdPVlws4QEMp+2vb/ke6ukOfd3uD+vuXpHqwKS+knlAXaJRR5JlMcLkIRz4gdFASkxbMwOlpsk+z8AfpevIawsxfnaOCY31f7R6uv/R5aUVMYvm5Zzif3+GXZzFZwGi4/4BfycHxTgY0tKrf3txGWn+DG9L2mSZRziQuWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771236105; c=relaxed/simple;
	bh=qIHY7cCiEnGtwkY7aFFwE/mZ8uiiY18ecDxBJTYhSwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkkIE0JfUh11qQafdpDaCz8/VbywMBkXU5YVk7KxMHkQm194crV/BaGvuNQRhu5JhR72slrl8T0fUK+jNzBb8naDzijemp5tLc6vzFZyi2qZo3guGl/Uh/hO20TQPaC+28mY3z+T232b1WRxvUfwz1pS7Lxtt+m4Lhck0Mxlklg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-94d5f90c8b6so15561241.3
        for <linux-mmc@vger.kernel.org>; Mon, 16 Feb 2026 02:01:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771236103; x=1771840903;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QwpdPffhWm62Ds9NyNo/SaQsJWiUgFomKDnAW7WiSg=;
        b=hoya822Tmab9AOD0AZmAtfVNi9GqWnbGaD17gfxKRnOI5IR9VLVRk8dPZKitgA8ESI
         /IKZgh5hb8qRZjXK6iPMuIj9oPZ8MvSRWxDUzzwu6e9eRV+5aj5cT4xNur5xkwd7omDC
         NnJyiQthnMj4+bGDkNN+Tow2fp+TueEQeLHPxe5IJA4bR2yp7tLbvROfOGU7gxKVUjDe
         Qw4FnncXKVp/LFcbl9szrkl3h4qMiXPaoSy92+AosIdPYlj1e+pLhUce8elmVeH/yE1p
         35gvnLQiLLMJfGOaflRvp4Oe46zv2+7jn3TGXugsI7i4smKkEWxPdcxkZllwMD1ZMo70
         16Zg==
X-Forwarded-Encrypted: i=1; AJvYcCU/bE/OD+eZvRnZZG86LZSHv9QkGj+xlUKGnKWLAFxeerijWjoAOXOYTWtckqHgCf8jI0BTBX1XCf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Fq8tjaTGV4qsg0hdHG3FR+eu7QEld8yXbD9wn3oWGPsJzlqg
	s3/8NYNiwHoeITG/X3DjZhThbDjCoGEc2AzyG16k6EhG+F+pVBdmCebI/5HZMkdf
X-Gm-Gg: AZuq6aJbUe1UQdb1Zb3HWeF2vCrvFA1+MudaMEM89pM3ys2LvDxQC2uAJUaG1MB7+uN
	NfFzHxFMUNJSxRR4/ai2OzM8k94ZIcVybFC9Iinu7lAlCUIlF9bVTKiuFT5lRadCS5VYB9Uq08r
	kg5oxvbdfx28xabXooPArwWqrxIx8xBmJAzHZjw1vN8u2kv+IaEXTMIVUeoUQYfcikgLSz6OxiW
	+F7NWO9FmluBgkIBL5ApRFV5h8DRWbasmN7+aESSNZLSIXcBk2L+0xfnyTluPyCed8qPIkjy+uI
	T0AO7+sBPLNEkOPG7HxLprc1JRzOsINli0fim1iGku3IWneV+VDxxg6+0TCsbY2ZdoMvubxCNES
	OFO82eaW+IjZhaJU2vD5DUIycNGZuVTc22JRUiceSxePw6m/qE/S6Rw9rCQXUPMYqxRyV2b4+Wu
	EI1yAZVg7Q9IBiHcVTH6Nu5HaXE+e1o0u0u+AblT/Kj3F8xnkPn6zAZyAbKdjQ
X-Received: by 2002:a05:6102:c15:b0:5fd:e9f8:b8d8 with SMTP id ada2fe7eead31-5fe1afb3fffmr3578479137.37.1771236102893;
        Mon, 16 Feb 2026 02:01:42 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94afd14e0d3sm7212668241.2.2026.02.16.02.01.40
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 02:01:41 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-948c3ce4d35so1758700241.2
        for <linux-mmc@vger.kernel.org>; Mon, 16 Feb 2026 02:01:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZXQ5nsUup0McqAgMRt95QHItjMA4Oqaz+ipcATQKgTmcmN6qJrt8uSwFnmsvwuAadh7Aj8faYt3A=@vger.kernel.org
X-Received: by 2002:a05:6102:cd1:b0:5fd:f145:b88a with SMTP id
 ada2fe7eead31-5fe1afcd3b7mr3584435137.40.1771236100546; Mon, 16 Feb 2026
 02:01:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <20260208-rz-sdio-mux-v9-1-9a3be13c1280@solid-run.com> <20260212164823.mbeycqwzsy2dfq6e@skbuf>
 <CAMuHMdVOqovkugmCnR4FOfk8VkQyN_dmyKFzbsOSN0mPKQedeQ@mail.gmail.com>
 <f9ede0d3-6a37-449c-b62b-a5c761ece097@solid-run.com> <20260216092914.kmvl7aep7dantcsd@skbuf>
In-Reply-To: <20260216092914.kmvl7aep7dantcsd@skbuf>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Feb 2026 11:01:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUH4W9W2uNknr41AgVQfO7inwZP6BfuMatyEUvJtf+Ueg@mail.gmail.com>
X-Gm-Features: AaiRm50a7dRj7dLKtMGILEQb14-VkaVzM5nFFHi-S8Lj08OYuJXTfF9bVPV6HRk
Message-ID: <CAMuHMdUH4W9W2uNknr41AgVQfO7inwZP6BfuMatyEUvJtf+Ueg@mail.gmail.com>
Subject: Re: [PATCH v9 1/7] phy: can-transceiver: rename temporary helper
 function to avoid conflict
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Josua Mayer <josua@solid-run.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

On Mon, 16 Feb 2026 at 10:29, Vladimir Oltean <olteanv@gmail.com> wrote:
> Then there is the fact that local definitions of devm_mux_state_get_optional()
> keep popping up, possibly in unrelated trees (not the case here). This seems
> to be a bad practice which should be discouraged during review if caught.

This was done on purpose, to (1) avoid having to make too many changes
to the file when a common helper would be introduced later, and (2) make
it easy to find all locations where a future common helper could be used.

The alternative is to use a completely different name (which is thus harder
to find), and having to fix up all the users of that name too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
