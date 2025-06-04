Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A343386337
	for <linux-mmc@vger.kernel.org>; Wed,  4 Jun 2025 03:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749006139; cv=none; b=V2nl7RdmA9uv+AzPrz6otxB2zQEkIf9KsUIrez+eVHg8SEDawYuWqPV0sX1vyqjYFYEA6Nmp1g2lIjq2nIlsUmp4+emhrv2f2zKIJMdm/v8753pxaML8b6A7tB3y6UAqxfoe4FfnrjTB60wOJfKhuyL8q1gk2BSO7km/PZ27Up4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749006139; c=relaxed/simple;
	bh=H+HZOgzJ3Uqq8F6QS/Cj5+iwbhXoIg3qGaW7oyugyrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0in/GzFTe1PpHrIZfHE/n3ajGiJxfIv0THFasgglk3Itr/bCfr4s4x6/TquxYfWbdpxA4Bi/rAAM9GLLpY9gvGOM3IoUgxuFFd38lZHGRBB78lVV6IDrboBSNUZQA8OPVyAYhOV8opRjYosX+o8xdaAOmcDMvc7Ou6USx3GpPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=actDMgfE; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="actDMgfE"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-adb2e9fd208so1080054666b.3
        for <linux-mmc@vger.kernel.org>; Tue, 03 Jun 2025 20:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749006135; x=1749610935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93NPImeHgH3phz/ybs8XeZoxvn1O5tzhuznryRfg/TE=;
        b=actDMgfE8I4LIYGb5qQiQ+Q753nEkQvkk0Ijolrx4bNH3+fwuuLvzni8Le7FoJdi70
         HCuuvikwmEa8LBsLpc7pT50lZ/2+vttQOuAcRGRDvh52KSzNw3X2bk8G2bH2kK3xRRyC
         T7pezFXxrL2Msy9xsy06uN5JN8q8KdYwnist8YNjSOvSiFioNv8fxpilCcqvSSAYB5wP
         LCgC+xZJf7r96MAP0eyO/tEXFYfgY4pMycBChiBtirSDuG+mQbQYp9rx0tYJg64BmfmM
         6rQ2P1a59rUn1eZwhueO6LHkDqclVBc+UoRL7uksGckYF32lHVOW0UatULYQLrT2ndJd
         vfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749006135; x=1749610935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93NPImeHgH3phz/ybs8XeZoxvn1O5tzhuznryRfg/TE=;
        b=nNupgaa4Ex3Csnz2ItBETufBAxSqMRLbOKrteYm0Hq1eAIGiTroYbSjjvdi8/YU/t1
         aNg2QHQcN+xjZaoGin+TIvB6PWYXMbC+HqvfJ1+5U5KFLr+dkrvy48L85ucZ03LPfRpW
         RE7Kl4rU7nsrdR0T5WtilH+e2qSJFxPxjnLIXzT9QUaZcFTUaLFfZZoJwaAGkw1blXv1
         skOLCJkem62vT5k6y7wbnmY7SQbZeA1X/O9VcoGlKwupLZMrryrup5g5c+vcWz4KYgtd
         XQfe92ZLYClo/9fMduVwi1JS2WGYCg2nNE4KabQPU5/BCc8+8II74YBOTDV/kRxzzn/q
         KdVA==
X-Forwarded-Encrypted: i=1; AJvYcCXLmQLuHLVYmXkOav9C/5ywx/w2dSQtZ+pOySOPSBe1EP6E5dX6PZmuO/i82w2dil/6Dbv6UykDP7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYYcPnXyVp97QvbS8kU4yFEJ5SdAu97hb1879CLMWyBjn3oy/I
	XE026GxSghyP0Jf5t0108PokOcRFBUk8v4I+96qfifi7ulEREiqHNHsbuBdO8c+ZlKCzzxz5ug3
	oyr9gWfDBa7xOIZftm7eZ0Dl/Mv8v2/I=
X-Gm-Gg: ASbGncsL1gF+3bLGt8DnJGVdJUXTlwFc0NmkLUGzA5sQ1l19vyQJuXwsuF6k85y9ONb
	nz0ZsMuZteXZt79uwZqX6Kx5hmiQlc32TTIiPUjuVwMZkvEBhio3X9o0CMAU5TAIO88YTInjLWS
	bQ1VeNqiCNdZ1IcTf5gRrLw81AHy2Sp7kA
X-Google-Smtp-Source: AGHT+IFrLk1sPD8RHDy3ppQFwO93B09ttmuuSOKZ4IFaVZNSRV2Df/8audvBQwCbwFybmCILd8dYq+ORQKrff6N3LDQ=
X-Received: by 2002:a17:906:6a16:b0:ad8:af1f:938d with SMTP id
 a640c23a62f3a-addf8e3e0f5mr81959866b.37.1749006134673; Tue, 03 Jun 2025
 20:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1748933789.git.zhoubinbin@loongson.cn> <68e752931552e95667191c2641076a1bfaea3dc6.1748933789.git.zhoubinbin@loongson.cn>
 <CAFBinCA6f6jJQZEgHTiK8FqXW=v465a5rB0BZutDhct-4yhX_Q@mail.gmail.com>
In-Reply-To: <CAFBinCA6f6jJQZEgHTiK8FqXW=v465a5rB0BZutDhct-4yhX_Q@mail.gmail.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Wed, 4 Jun 2025 11:02:02 +0800
X-Gm-Features: AX0GCFtNQ6tHAbcqFzIRYEwd8arzq_HkNvot9pjUSmTfSnaQtZaam0vScKyUZzk
Message-ID: <CAMpQs4LYc76RMJU0JRG9Rcihx8zoOeaJgYHb1CNrgg1GFzA9Hw@mail.gmail.com>
Subject: Re: [PATCH v3 36/36] mmc: meson-mx-sdio: Use devm_mmc_alloc_host() helper
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Huacai Chen <chenhuacai@kernel.org>, 
	linux-mmc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Martin:

Thanks for your testing and reply.

On Wed, Jun 4, 2025 at 4:49=E2=80=AFAM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hello,
>
> On Tue, Jun 3, 2025 at 2:28=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.c=
n> wrote:
> >
> > Use new function devm_mmc_alloc_host() to simplify the code.
> >
> > Cc: Neil Armstrong <neil.armstrong@linaro.org>
> > Cc: Kevin Hilman <khilman@baylibre.com>
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Cc: linux-amlogic@lists.infradead.org
> > Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  drivers/mmc/host/meson-mx-sdio.c | 20 ++++++++------------
> >  1 file changed, 8 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-=
mx-sdio.c
> > index e0ae5a0c9670..b6cb475f1a5f 100644
> > --- a/drivers/mmc/host/meson-mx-sdio.c
> > +++ b/drivers/mmc/host/meson-mx-sdio.c
> > @@ -640,7 +640,7 @@ static int meson_mx_mmc_probe(struct platform_devic=
e *pdev)
> >         else if (IS_ERR(slot_pdev))
> >                 return PTR_ERR(slot_pdev);
> >
> > -       mmc =3D mmc_alloc_host(sizeof(*host), &slot_pdev->dev);
> > +       mmc =3D devm_mmc_alloc_host(&slot_pdev->dev, sizeof(*host));
> This change is fine at runtime (on my Odroid-C1 board) but it can lead
> to a use-after-free issue.
> meson_mx_mmc_register_clks() devm_ registers two clocks and uses
> host->controller_dev as device.
> This leads to the fact that during driver removal struct
> meson_mx_mmc_host is free'd before host->controller_dev, which means
> the clocks are also free'd after struct meson_mx_mmc_host is already
> gone. The problem here: the clocks need the struct clk_divider and
> struct clk_fixed_factor from struct meson_mx_mmc_host.

Sorry, I have a slightly different opinion, which may not necessarily
be correct.

meson_mx_mmc_host is kzalloc as `extra` in mmc_alloc_host()[1], but in
fact, the entire host is released in mmc_host_classdev_release()[2],
so I don't think it will affect the use of host->controller_dev.

[1]: https://elixir.bootlin.com/linux/v6.15-rc1/source/drivers/mmc/core/hos=
t.c#L523
[2]: https://elixir.bootlin.com/linux/v6.15-rc1/source/drivers/mmc/core/hos=
t.c#L78
>
> I don't understand why I'm not seeing any problems with this patch at
> runtime - maybe what I'm describing is just a theoretical issue
> (because it would only it if something would access the clocks between
> freeing struct meson_mx_mmc_host and removal of the clocks a few
> milliseconds later).
>
> What are your thoughts on this?
> If we're concerned about the potential UAF then I can refactor
> meson_mx_mmc_register_clks() first and then apply this patch
> afterwards.
>
>
> Best regards,
> Martin


--=20
Thanks.
Binbin
