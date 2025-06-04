Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EBC1714C6
	for <linux-mmc@vger.kernel.org>; Wed,  4 Jun 2025 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065838; cv=none; b=LaacTwIk90/I2zYYzL6yVkdzjQ7OVWDyRbOqmFiDNtWFaNleCNexGGBfdzn2D/FHoks3sXmWwgeB6Nx+s13783x7gzrYELscg5kc8bhQKruf5+g8MaJ1RL62lox7YpBY5PsIf88fLBahLtTOZ6DrH2Cbtm7L+2bjNVZq4DKCCwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065838; c=relaxed/simple;
	bh=4P7dAaW5I6SIAwfGG6gJAUk9ka4NDXO+QKrE1bbXidg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HhGk30YjT8apwk5Cal13t+a5lJ2Ve6OIKbOpTL7P9BQXxS+w9gXu83Ubh6J1Xo110hBQNnhOz2wl4PzowlOG3iNTtw32A3HBQbttAFN6ov2UvnnvUSNLNPtPmqRmu4eoiAutWeG8Hb8CqatG9uXWtvo8jSuSjq+hijy+w6uuQZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=U9MlrN4k; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="U9MlrN4k"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22c336fcdaaso1755595ad.3
        for <linux-mmc@vger.kernel.org>; Wed, 04 Jun 2025 12:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1749065836; x=1749670636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzTHN9G4S37kMz+moCZu6NRvrTBVp2uwAQXRktRL1Ak=;
        b=U9MlrN4korORwR2YCry6y0ORt9b6m/cjB3x/v+ctKV+aKaCtq4wjTOCe1olcR47yY2
         67/FDR1yVMRXueBPXSADXjeXOudO2m95OJ9sb4skvwUJaajs5aOpWEdQmB/C1F7+vUvx
         Xn31qDYdPqOaf2talSN1lsKM9lk5VrP5BjzACMfk5R/pYd4zXay0/Hrvo6NKVUoULIXz
         Vj+bxwjveSa5VS5heG0iDmSb4EDen/qsiTAJ7fhcOldW9wSqVhHLEVufrDpz4ELbowEU
         l6LML+ZkmR9NJqWilKo96ZU1KFYu0Vm4mIf+HFZo386ySgH313kvVjarFSNLI8HeNgKN
         MYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749065836; x=1749670636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzTHN9G4S37kMz+moCZu6NRvrTBVp2uwAQXRktRL1Ak=;
        b=hxMKBsIsZdPXws92AjBdrhwL3AG2P1ACfcREjdNtYcm+b5aeEiFjdwnuaNdo2d5/EE
         Jc7Kv4dV185P8j7Cv6qM9FLV663V2AG8aGBkIvRwQjd4LPgWfmzwIC6MM135T3xudBhh
         Uf6a4qNlS+19ZkAvzeBZTlAWoDAmDTzWW1iLUWbMLAHK2k+SyTKJ/qdJVwGLYP0PbLmi
         6juWhKsVC6hjEgZPVngGiZ+bzHDez6PHWEz+1Lfpj5MYy+I1t2bOt/WNNQTh/2i5e+Ep
         WQP/Mxp08Dxg2GRVhjiDtqElyZw5zhkwaDcgj1mM7LQR120FJInqVyKTIdR7ElsHE4jT
         7DKw==
X-Forwarded-Encrypted: i=1; AJvYcCXWywDjMd37UJoR12AJhm0d6UkTUO0o4qadzTxv6ZZ3cQikMjpXCw1RacQqigxu5oWBrkAFBbLG5ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQcP9lyi61uMfsE5RKI7ymkaO6CdHC6O5tii7QgUqlzLZmD53v
	Uz9SaJ1plTSZhtwsKo88mULX3xJot1lUpHyEWE0LWsBtKFSBoBhn003iNjOCq7mHEqZCp+VWLK3
	wkhrl+aQWgub/WOYUnjO1pnupVx6TiNARToOw
X-Gm-Gg: ASbGnctV3iQUC53blCHcsuDqe8dIIbcYseSxQvjivp4RDkVyDejCcl+Ia1QX3mTxePZ
	W+4mqnVk7BP7jl1xGAoD3f5OilNmZOuQv2rX/zXfKaMYLUrS5EeKV/+//WVYzwZA8Nzxre/MObp
	6NvXjswNdCVLV5ar/2sjirjwYOscGup3GkXKe4kZNuOPjs8Ow=
X-Google-Smtp-Source: AGHT+IEUmGuVQmLcwyMnV1bOqYxUjgfradWkNpF4Glj3QjYkzZjdSQ8kaY5lGLu+UTnlIxGPlZiy+vmXsefKUPPGOe0=
X-Received: by 2002:a17:902:f54b:b0:234:8c64:7875 with SMTP id
 d9443c01a7336-235e11fbfe9mr61897625ad.38.1749065835514; Wed, 04 Jun 2025
 12:37:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1748933789.git.zhoubinbin@loongson.cn> <68e752931552e95667191c2641076a1bfaea3dc6.1748933789.git.zhoubinbin@loongson.cn>
 <CAFBinCA6f6jJQZEgHTiK8FqXW=v465a5rB0BZutDhct-4yhX_Q@mail.gmail.com> <CAMpQs4LYc76RMJU0JRG9Rcihx8zoOeaJgYHb1CNrgg1GFzA9Hw@mail.gmail.com>
In-Reply-To: <CAMpQs4LYc76RMJU0JRG9Rcihx8zoOeaJgYHb1CNrgg1GFzA9Hw@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 4 Jun 2025 21:37:04 +0200
X-Gm-Features: AX0GCFtYQRcLyxkDVGWPb_uB7leq0w6W0I1zKcTM8pl57bVhbtaLBXQCbV01GfE
Message-ID: <CAFBinCBj-y5_vFDVTSMpZXUcGXReYc41hqGcqt1U43ZR2y6QrQ@mail.gmail.com>
Subject: Re: [PATCH v3 36/36] mmc: meson-mx-sdio: Use devm_mmc_alloc_host() helper
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Huacai Chen <chenhuacai@kernel.org>, 
	linux-mmc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Binbin,

On Wed, Jun 4, 2025 at 5:02=E2=80=AFAM Binbin Zhou <zhoubb.aaron@gmail.com>=
 wrote:
[...]
> > > -       mmc =3D mmc_alloc_host(sizeof(*host), &slot_pdev->dev);
> > > +       mmc =3D devm_mmc_alloc_host(&slot_pdev->dev, sizeof(*host));
> > This change is fine at runtime (on my Odroid-C1 board) but it can lead
> > to a use-after-free issue.
> > meson_mx_mmc_register_clks() devm_ registers two clocks and uses
> > host->controller_dev as device.
> > This leads to the fact that during driver removal struct
> > meson_mx_mmc_host is free'd before host->controller_dev, which means
> > the clocks are also free'd after struct meson_mx_mmc_host is already
> > gone. The problem here: the clocks need the struct clk_divider and
> > struct clk_fixed_factor from struct meson_mx_mmc_host.
>
> Sorry, I have a slightly different opinion, which may not necessarily
> be correct.
>
> meson_mx_mmc_host is kzalloc as `extra` in mmc_alloc_host()[1], but in
> fact, the entire host is released in mmc_host_classdev_release()[2],
> so I don't think it will affect the use of host->controller_dev.
It's well hidden, so it's tricky to spot: we have two "struct device"
in the meson-mx-sdio driver:
1. the "controller_dev" which is belongs to the struct platform_device
of the driver/device-tree node [0]
2. a second struct platform_device and thus a second struct device
whose of_node belongs to the "slot" (which is a child node of the
controller) [1]

Clock controller initialization is the same for all slots, so I chose
to link it with the controller_device.
We want to parse the mmc slot properties (bus-width, cd-gpios, cap-*,
...) from the slot node in device-tree, so we create a second
platform_device for the slot (child) node. This design was chosen
because the controller supports multiple (up to 3) slots while the mmc
core in Linux doesn't. However, it was important for me to at least be
prepared in terms of device-tree bindings in case Linux would ever
support controllers with multiple slots.

So the lifecycle during probe is:
a) controller_device is instantiated by device-tree node with
compatible =3D "amlogic,meson8-sdio"
b) slot device is instantiated using the "mmc-slot" compatible and
using controller_device as parent device
c) devm_mmc_alloc_host() is called
d) clock providers are devm_* registered and attached to controller_device
e) the meson-mx-sdio driver acts as clock consumer for the clock it's provi=
ding

However, if we want to remove the driver the order is:
- remove the device attached to the "mmc-slot" compatible - before
that happens struct mmc is freed (as it's parent is being removed)
which also frees struct meson_mx_mmc_host
- (struct clk_divider and struct clk_fixed_factor are linked with the
clocks which are still registered <- here we have a problem because
those two structs are part of struct meson_mx_mmc_host which has
already been freed)
- controller_device is freed - before that happens the provided clocks
are freed (as their parent is being removed)

I take your questions as feedback on how to make the code easier to
read/understand.
This is very welcome, because it's been 8 years since I introduced the
driver and I also have to think twice about some of its details.

Let me know if things are more clear now - or if you still have any
doubts/questions.


Best regards,
Martin


[0] https://elixir.bootlin.com/linux/v6.15-rc1/source/Documentation/devicet=
ree/bindings/mmc/amlogic,meson-mx-sdio.yaml#L83
[1] https://elixir.bootlin.com/linux/v6.15-rc1/source/Documentation/devicet=
ree/bindings/mmc/amlogic,meson-mx-sdio.yaml#L92
