Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7751DA61B;
	Mon, 31 Mar 2025 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743413854; cv=none; b=lWuuLutjgVroVqHPd1mWRW7vUjIByXboWLztDQSoYFgd2Q6JeWHVCoBZQLbcVEJ3E5lPqnPHoOwG2oDMb1I8aKQXuHyFkcuQPFJTVYzi9XJWJXJ5/tZBVgRpdI5HVWZEPaiIS5d++DmfD0sAKNHY1fBgxodrcLacUabvznCUQJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743413854; c=relaxed/simple;
	bh=6fcgwOk+8wNUUaFsbSNlxBhyEV6KkpckX5akAmDZO+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKUvGnvZJGO+5NdJMOw/umTHYHWnF/iQ1bmksRlbNJMZiHPfKwIL12cypthcqyXmNeDP7kp0qCQbKn1YeHIJLCTd+X5zMK/XK0qb8wzaMhxuahABY6TJ7IYgmuiaSeXWIP0fwpZFZHQdp0KOxz7S1pfuSp7JkVGqiMVGT0opLis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-523dc366e42so1763977e0c.2;
        Mon, 31 Mar 2025 02:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743413850; x=1744018650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6m7H5ReoZEvaLRIBb3Br+Zs8xyEGgvSo9d0sSfCKoN8=;
        b=XLmbNAvxJeyQ9vI9JZNuEIu9zjr4kf2uygmGoNg6OdF6KPYcQFOav7ArwTvo0nMsIb
         oeBYiPbtBbuJefj0lmtPeqGzOE6fY1q5S6OBTHMrpR+QybwWm3xuHHMjnTKhPlHzog/k
         KzDd36pKzgGLdfqdOi+u2uxsgZ7fLKgncGnmrExVuXfCi2t2t91Vh3SxW1x1XNR28uWE
         VqrW7YqlRM/FjPJ2HKAp0Q/hoOCQnQjcO2WGvn3rNnhfHkxnzNh6n/RZ9nGclMfDz6H6
         VUM4PUZRrmW4wMJcpZ3yrZJegTnEUulmiMfLCfOvt/k1e0zgdfb8fe4pBxorXZZGwJx5
         W3rw==
X-Forwarded-Encrypted: i=1; AJvYcCUdufYCCyNi5cMS5s74BrlW2i3t6Adldn/cGj9QUINqX/9oyukRGriOuviiLVdlVTxNjuGr1+duMbxX9g4=@vger.kernel.org, AJvYcCWhLYRmGsXclOlQbV2tF1ncDwsVmpqRPCQuTHgzCDuPkJV3Vz5W1RytuRbhqPW5jA4Y7T+9V4hMZZ4B@vger.kernel.org
X-Gm-Message-State: AOJu0YyXCas9TLziYtCWVZUP9RcvPxtM+wA0i3/AIyVYKAjauyCRHU/E
	G5pRQNFlSUzuL6p/2xV+v7eM1fWqH/VzVY3o+X+TA9LLhcsOYTy5tyhFx6C7
X-Gm-Gg: ASbGncu9CwscO5oTFo/3xHAYCaVMBll4qOQApERB1Dhz1XalEdvHamxoWr8WhuukBM0
	0+5/vD+6QP6N2WD99BICfw0NtYYFdFgguz7oUyq3tgMVN9YEofN/bz5+N6WT4cd0xT84HphdWIf
	cm/+5XqjRvrIqdoO+kRICTQTztvWgJemilIebfUIUjvhpeCLNoTVUbISJNptmumb5Afy2Ifz17o
	nbLI+UFyIgC2ClGSGtkmjSK9FYJLr8p5B3xuZeBN/T9HLO/uMyYIuRqJLDq3yDRWFoEanauh4c6
	b5SxcGwdxEYu3hwuFcI+OerTP1jFxdYohYF6zxhjT4VQvQlNq3eOdk3c+BWDI8khFmuMhAqgfu5
	XhjZqo9tVqAKZTVzc0g==
X-Google-Smtp-Source: AGHT+IEQIocDEt9LkN5FyKkmTLUdSHE04eAovarsXTIuwlflGRoCLqjYh8LM4eP+RKBj72+w2JXqSA==
X-Received: by 2002:a05:6122:2a4c:b0:50d:a31c:678c with SMTP id 71dfb90a1353d-5261d357a48mr4629567e0c.2.1743413849727;
        Mon, 31 Mar 2025 02:37:29 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5260e6a2cd5sm1472523e0c.2.2025.03.31.02.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 02:37:29 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86d42f08135so1660337241.0;
        Mon, 31 Mar 2025 02:37:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWi6C6lzsQlVxoZfvnPplYKwascKG3JLVoy+bt9Zm0SC1PVufnwJ1oXXUNuSDMGjyxY8ZyXzLIdwjK@vger.kernel.org, AJvYcCWgqLFYWQH7rxKo2Hk0VES5oNyeCw/goWzJrIL8pRRbKzcbXHw/YbUoo0JoCi8fV+jJSuh5ERXHCtHcF0A=@vger.kernel.org
X-Received: by 2002:a05:6102:3f88:b0:4bb:eb4a:f9ec with SMTP id
 ada2fe7eead31-4c6d39af7cdmr4510008137.16.1743413848827; Mon, 31 Mar 2025
 02:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329164145.3194284-1-arnd@kernel.org>
In-Reply-To: <20250329164145.3194284-1-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 31 Mar 2025 11:37:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVY7Ekc1c_CO1g715ht7hPU5Zc9ZoWtaxkeWOahycVNFA@mail.gmail.com>
X-Gm-Features: AQ5f1JpvnZ7nTB6rW3kOMJVkbUBZ7ytnocmYlZrvcPNgRHoBHXHWNow-4n4hiUQ
Message-ID: <CAMuHMdVY7Ekc1c_CO1g715ht7hPU5Zc9ZoWtaxkeWOahycVNFA@mail.gmail.com>
Subject: Re: [PATCH] [v2] mmc: renesas_sdhi: add regulator dependency
To: Arnd Bergmann <arnd@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Arnd Bergmann <arnd@arndb.de>, 
	Adrian Hunter <adrian.hunter@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Sat, 29 Mar 2025 at 17:41, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The driver started using the regulator subsystem and fails to build without
> a dependeny on CONFIG_REGULATOR:
>
> ERROR: modpost: "rdev_get_drvdata" [drivers/mmc/host/renesas_sdhi_core.ko] undefined!
> ERROR: modpost: "devm_regulator_register" [drivers/mmc/host/renesas_sdhi_core.ko] undefined!
>
> The 'select RESET_CONTROLLER' needs to either go away or get changed to a dependency
> in order to avoid Kconfig dependency loops here. It also turns out the the superh
> version needs neither RESET_CONTROLLER nor REGULATOR, and this works because
> CONFIG_OF is not set there.

Both the reset controller and regulator are needed only on a subset
of the supported SoCs.  However, unlike the reset subsystem, the
regulator subsystem does not provide dummies when disabled.

Fortunately most regulator code in the SDHI driver is optimized away
by the compiler when CONFIG_OF is not enabled, and the remaining call
to mmc_regulator_set_vqmmc() is harmless, as the MMC core does provide
a dummy in case regulator support is disabled.

So e.g. an sh7724_generic_defconfig + CONFIG_MMC + CONFIG_MMC_SDHI +
CONFIG_OF build indeed failed because of missing regulator symbols.

Note that it is a bit strange sh7724_generic_defconfig and
ecovec24_defconfig do not enable regulator support, as
arch/sh/boards/mach-ecovec24/setup.c does contain regulators.

> Change both to a 'depends on', but add '|| OF' for the superh case.
>
> Fixes: fae80a99dc03 ("mmc: renesas_sdhi: Add support for RZ/G3E SoC")
> Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

With the typo pointed out by Wolfram fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
