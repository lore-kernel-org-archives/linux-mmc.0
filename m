Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A0C339B45
	for <linux-mmc@vger.kernel.org>; Tue, 18 Nov 2025 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763479928; cv=none; b=TmFVMurv+tinMWrYRFuJrggAdSxcNAXvTMWmAcfzl59WKJvXJXCGT0kDSXl7NHCEAtTFzkDjBPXOza0Fq0uOEbtvCx1mBsoxLdC9IFcF6VEQCYW7Ki+hPgUCgDkC8Ek6JyVAuA2tDrr+Xcu/WiyJgRiIcgipOUL2nMJMLGYzjio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763479928; c=relaxed/simple;
	bh=T5Tk+j5NNvvXEZaB10WvqpFhFTW1RxZwkW+Hn6ykgRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgRKayxk1hwikwOvtbu6NXlBfGyhIQeEi7iRoEUGoYMnVrPppOGj8qkaBkOG7ge2HKBB4sZB3N+3YZPA+QGGGteqWvhTTg0CF88ePE/rVwUAZMpil2NOTVR+nhvCCDe0bb4Y/eoecJWa3NLWKk077NJK+6ucGfE+S0+DGkP0POY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vrNw6WTI; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vrNw6WTI"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-787c9f90eccso60279707b3.3
        for <linux-mmc@vger.kernel.org>; Tue, 18 Nov 2025 07:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763479923; x=1764084723; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sa6na3P/P/GNM8Iujs64ZSVR7QHzowjsSYVDRpzcN3E=;
        b=vrNw6WTI9QIMUS36UJOAs1YLtFur6IZRKaZVaf0+T1vu6E/mpE72gflHb+GlVd5zN5
         NqWyrlZePj4/zFcmm8p/F+55sAWdDMGxydj0JiK9E5jlOgqHemHXoBekTHLJxuuHH+V7
         0lRPxOxui4sryOFqiir/RlosRjQUTTW9GXLbV/mhezgLCy5oLgeJiQ8XaHBlVJrW5vUp
         cdjzHQNhZswMduLT8cjk6gw1wrHMKr0iSQiAeT4xmOuhbTwQH0HaVyTc1K/1GnHrHa1u
         EQbd1uV80O79Ik8mTraSat+2tVRTOFpN1dS0XAnSHSYmRl1YeNzmUwTMFJvgUg3DDn88
         1gAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763479923; x=1764084723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sa6na3P/P/GNM8Iujs64ZSVR7QHzowjsSYVDRpzcN3E=;
        b=TFNb/jcFj5qbyFFldWgI41sFxD08iBRez0sOuL3RC1dGbBV/kjZ7H2TnFkZyjX2ynl
         mDKThp6Rr3exA64/rkn9lvRef1J9NdWd6hseJqekmsktEoPBbQkiJo4U9qnx+tyFMzik
         +OL7dmJCZ2gC8H1WaVIhwOQ0gzkZ8j+U30BL+R+9HmOG0/8olMgYws7bz/KdyfB6dTTu
         Goddx9aREi4vjc6oH0SJO1u2bYHLngGjfN4f7F8osEoKa6rHGOWWXt80xIHO+f8fLnEB
         a/wibVC2HriDMBs1K9FMWBEkPkETORSnlFXRLYVq7gIb7t7oZzSuR7JSl+T7GURYyYzs
         v2MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk5vNyl+TS7ekGQPJgfc5ysi5RAQvt6wDKCqvHKzLGP0dWoJ36YC+wgsAITWfuuNQkPNgWO40HGWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxedmaSJPyTh6Jqid4c38SF49XtWjMs5ioAVQzb36Sl85oXdmXg
	HHcdDgA0igajmXtDLsP4Rv/xy7po8mKV+aslzBj058VYoWJKvgKitUIkuJDy9/1y2Oycv1h3Ybg
	m3l2+etmMKUF68XwwVZUtIc4TAeFYGASuzdnzLzRC2A==
X-Gm-Gg: ASbGncuoZqYAHxBd3HMEd7B8/OX8STLArJoh63mJGnXC6LIcwwZPwyErAqyiL0G3P/P
	0D1xwGDsxqwz8cFtCAEaiON3fIyDpOrRMbPpsZrsVMhgOTpAhBNJcldGbOBe9hf3SPhYza5GwbF
	L3kNqDK4DVWHx8A7f11H1R0XOLikFiRHgC3gcmfNoFBRZZVXUOgVEGKphP46FmPGNkLFj0RmpMM
	v9W/0UDQqEmJ23d/lI3uqCGpwoqRF6Pgv7j2yoJdjwmhvIjf5yIFOMuo6OlVHGIrm+/jssWtS/w
	bub46w4=
X-Google-Smtp-Source: AGHT+IEfuIFqkRCXfZDQ1m2D7snzbjj18Mf6UeMcI+k5jw5cpI8JySnnaOmrmzg5DmorahHQyDmg0Mg7N8R6Vf/3bcQ=
X-Received: by 2002:a05:690c:4b09:b0:786:56ec:e3cf with SMTP id
 00721157ae682-78929f13f18mr148209687b3.61.1763479923209; Tue, 18 Nov 2025
 07:32:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 18 Nov 2025 16:31:27 +0100
X-Gm-Features: AWmQ_bnsDQPC1FPCE55p78otrm27YbzfdllVOUQUin0JOvD-o9IddmtmqNNalEc
Message-ID: <CAPDyKFqF+yh0X6f5YZ0yePGqCpPWQOauQTZaeE88Fgv2HAxv-g@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] mmc: meson-mx-sdio: Various driver improvements
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Nov 2025 at 00:13, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> This series contains patches to improve / simplify the code of the
> meson-mx-sdio driver by:
> - using regmap for simplifying register access (patch 1)
> - switching to modern clock functions/helpers (patches 2, 3) and
>   make the clock code not interfere when switching to
>   devm_mmc_alloc_host() (patch 3)
> - making use of the devm_mmc_alloc_host (patch 4)
> - using modern dev_err_probe() for better error handling (patch 5)
> - indentation fix (patch 6)
> - ignoring disabled mmc-slot device-tree nodes to allow describing
>   all slots in device-tree, even though the driver only uses the
>   first enabled slot (patch 7)
>
>
> Binbin Zhou (1):
>   mmc: meson-mx-sdio: Use devm_mmc_alloc_host() helper
>
> Martin Blumenstingl (6):
>   mmc: meson-mx-sdio: Switch to regmap for register access
>   mmc: meson-mx-sdio: Use devm_clk_get_enabled()
>   mmc: meson-mx-sdio: Refactor internal clock initialization
>   mmc: meson-mx-sdio: Use dev_err_probe() where appropriate
>   mmc: meson-mx-sdio: Fix indentation in meson_mx_mmc_irq_thread()
>   mmc: meson-mx-sdio: Ignore disabled "mmc-slot" child-nodes
>
>  drivers/mmc/host/Kconfig         |   1 +
>  drivers/mmc/host/meson-mx-sdio.c | 339 +++++++++++++++----------------
>  2 files changed, 170 insertions(+), 170 deletions(-)
>
> --
> 2.51.2
>

The series applied for next, thanks!

Kind regards
Uffe
